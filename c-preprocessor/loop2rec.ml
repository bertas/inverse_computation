open Cil
open Ctoputil
module E = Errormsg
module H = Hashtbl
module IH = Inthash
module VM = Map.Make(String)
module VS = Usedef.VS

(* Functions provided by this file transform the loops in a c C file into
   tail recursive functions. We have to assume that there are no goto 
   statments which go to the outside of the loop body.
 *)

let cilArgPrefix = "__cil_ap_"
let cilArgRegexp = Str.regexp ("^" ^ cilArgPrefix ^ ".+") 
let cilArgPrefixLen = String.length cilArgPrefix
let getArgSuffix = fun vname -> 
  let len = String.length vname in
  let subLen = len - cilArgPrefixLen in
  String.sub vname cilArgPrefixLen subLen

let isVarCilArg = fun (v: varinfo) -> 
  match v.vtype with
  | TPtr(ty, attrs) ->
      let len = String.length v.vname in
      if len > cilArgPrefixLen then
        let prefix = String.sub v.vname 0 cilArgPrefixLen in
        if prefix = cilArgPrefix then 
          true
        else
          false
      else
        false
  | _ -> false

class detectReturnVisitor =
  object(self)
    inherit nopCilVisitor

    val ifHasReturn = ref false

    method hasReturn (s: stmt) : bool =
      ifHasReturn := false;
      ignore(visitCilStmt (self :> cilVisitor) s);
      !ifHasReturn

    method vstmt (s: stmt) : stmt visitAction =
      if !ifHasReturn then
        SkipChildren
      else
        match s.skind with
        | Return(_, _) -> ifHasReturn := true; SkipChildren
        | _ -> DoChildren

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

let returnDetector = new detectReturnVisitor

class inspectVarUseVisitor =
  object(self)
    inherit nopCilVisitor

    val arrayVars = ref VS.empty

    val allVars = ref VS.empty

    method getAllArrayVars = !arrayVars

    method getAllVars = !allVars

    method vvrbl (vi: varinfo) : varinfo visitAction =
      (
      if isArrayType vi.vtype then
        (
        arrayVars := VS.add vi !arrayVars;
        allVars := VS.add vi !allVars
        )
      else
        allVars := VS.add vi !allVars
      );
      DoChildren

  end

class newFunctionCleaner (fd: fundec) (map: varinfo VM.t) (hasReturn: bool) = 
  object(self)
    inherit nopCilVisitor
    
    val smaxsid = ref 0;

    val inloop = ref 0;
      
    val mutable vMap = map;

    method incMaxsid = smaxsid := !smaxsid + 1; !smaxsid

    method vstmt (s: stmt) : stmt visitAction =
      s.sid <- self#incMaxsid;
      s.succs <- [];
      s.preds <- [];
      match s.skind with
      | Loop(_) ->
          inloop := !inloop + 1;
          ChangeDoChildrenPost(s, fun x-> inloop := !inloop - 1; x)
      | Break(_) ->
          if !inloop = 0 then
            let retStmt =
              if hasReturn then
                mkStmt(Return(Some (integer 0), locUnknown)) 
              else
                mkStmt(Return(None, locUnknown))
            in
            ChangeTo retStmt
          else
            SkipChildren
      | Return(_) -> 
          if !inloop = 0 then
            let retStmt = mkStmt(Return(Some (integer 1), locUnknown)) in
            ChangeTo retStmt
          else
            SkipChildren
      | _ -> DoChildren

    method vlval (lv: lval) : lval visitAction =
      let host, off = lv in
      match host with
      | Var(v)-> (
          if (isVarCilArg v) || (v.vglob) then DoChildren else
          try 
            let nv = VM.find v.vname vMap in
            if isVarCilArg nv then 
              ChangeDoChildrenPost((Mem(Lval(Var(nv), NoOffset)), off), fun x->x)
            else
              ChangeDoChildrenPost((Var(nv), off), fun x->x)
          with 
            Not_found ->
              let ty = v.vtype in
              let nv = makeLocalVar fd v.vname ty in
              nv.vaddrof <- v.vaddrof;
              vMap <- VM.add v.vname nv vMap;
              ChangeDoChildrenPost((Var(nv), off), fun x->x)
         )
      | _         -> DoChildren
  end

let cleaner = new newFunctionCleaner

(* This visitor should be only used to visit a loop statement*)
class transNestedLoopVisitor (fd: fundec) (hasReturn: bool) =
  object(self)
    inherit nopCilVisitor

    val mutable retVal : varinfo option = 
      if hasReturn then
        let retTy = getFunctionReturnType fd in
        if isVoidType retTy then
          None
        else
          let var = makeTempVar fd ~name:"__cil_ret" retTy in
          Some var
      else
        None

    method getRetVar = 
      match retVal with
      | Some var -> var
      | None -> raise(Not_found)

    method getRetVarAsExp = 
      match retVal with
      | Some var -> Lval(Var(var), NoOffset)
      | None -> raise(Not_found)

    method encapReturn (e: exp) (loc: location) : stmt =
      let retLval = Var(self#getRetVar), NoOffset in
      let retStmt = mkStmt (Return(Some(Lval(retLval)), loc)) in
      let si = Set(retLval, e, loc) in
      let setStmt = mkStmtOneInstr(si) in
      let block = mkBlock([setStmt; retStmt]) in
      mkStmt(Block(block))

    val inloop = ref 0

    method vstmt (s: stmt) : stmt visitAction =
      match s.skind with
      | Loop(_) ->
          inloop := !inloop + 1;
          ChangeDoChildrenPost(s, fun x-> inloop := !inloop - 1; x)
      | Return(Some e, loc) ->
          if !inloop = 1 then (* only search the first-level loop *)
            ChangeTo(self#encapReturn e loc)
          else
            SkipChildren
      | _ ->
          DoChildren
  end

class loopToRecVisitor (fd: fundec) = 
  object(self)
    inherit nopCilVisitor

    val mutable slooprecs : fundec list = []
    val smaxlrid = ref 0

    method getLooprecs = slooprecs
        
    method incMaxlrid = smaxlrid := !smaxlrid + 1; !smaxlrid

    method private getAllVarsTouched (s: stmt) : VS.t =
      let gavvis = new inspectVarUseVisitor in
      ignore(visitCilStmt (gavvis :> cilVisitor) s);
      let allArrays = gavvis#getAllArrayVars in
      let allVars = gavvis#getAllVars in
      let allAlive = Liveness.getLiveness s in
      VS.inter (VS.union allAlive allArrays) allVars

    method private getAllArrays (s: stmt) : VS.t =
      let gavvis = new inspectVarUseVisitor in
      ignore(visitCilStmt (gavvis :> cilVisitor) s);
      gavvis#getAllArrayVars

    method private mkEmptyRec (name: string) : fundec =
      let emptystmt = mkEmptyStmt () in
      let newFun = makeGlobalVar name (TFun(voidType, Some[], false, [])) in
      { svar = { newFun with vdecl = fd.svar.vdecl };
        smaxid = 0;
        slocals = [];
        sformals = [];
        sbody = mkBlock [ emptystmt ];
        smaxstmtid = None;
        sallstmts = []
      };

    method private getRecFunctionType (params: varinfo list)
        (locals: varinfo list) (hasReturn: bool)
        : typ =
      let vi2ParamTypeList = fun vi -> 
        let vname = cilArgPrefix ^ vi.vname and
            vtype = TPtr(vi.vtype, []) in
        vname, vtype, vi.vattr
      and vi2LocalTypeList = fun vi -> 
        vi.vname, vi.vtype, vi.vattr in
      let paramTypeList = List.map vi2ParamTypeList params and
          localTypeList = List.map vi2LocalTypeList locals in
      let typeList = paramTypeList @ localTypeList in
      if hasReturn then
        TFun(intType, Some typeList, false, [])
      else
        TFun(voidType, Some typeList, false, [])

    method private mkVarMapping (vlist: varinfo list) : varinfo VM.t = 
      let m = VM.empty in
      let addVar = fun var map -> 
        let fromName = 
          if isVarCilArg var then getArgSuffix var.vname 
          else var.vname
        in
        VM.add fromName var map in
      List.fold_right addVar vlist m
      
    method private setFunctionBody (fd: fundec) (body: block) (hasReturn: bool)
        : unit =
      let varinfo2Exp = fun v -> Lval(Var(v), NoOffset) in
      let argList = List.map varinfo2Exp fd.sformals in
      let m = self#mkVarMapping fd.sformals in
      let nbody = visitCilBlock ((cleaner fd m hasReturn):> cilVisitor) body in
      let tailStmts = 
        if hasReturn then
          let retFlag = makeTempVar fd ~name:"retflag" intType in
          let retFlagLval = Var(retFlag), NoOffset in
          let funLval = Lval(Var(fd.svar), NoOffset) in
          let call = Call(Some(retFlagLval), funLval, argList, locUnknown) in
          let callStmt = mkStmtOneInstr call in
          let retStmt = mkStmt(Return(Some(Lval(retFlagLval)), locUnknown)) in
          [callStmt; retStmt]
        else
          let call = Call(None, Lval(Var(fd.svar), NoOffset), argList, locUnknown) in
          let callStmt = mkStmtOneInstr call in
          let retStmt = mkStmt(Return(None, locUnknown)) in
          [callStmt; retStmt]
      in
      fd.sbody <- { nbody with bstmts = nbody.bstmts @ tailStmts };
   
    method vstmt (s: stmt) : stmt visitAction =
      match s.skind with
      | Loop(_) ->
          let hasReturn = returnDetector#hasReturn s in
          let ld = new transNestedLoopVisitor fd hasReturn in
          let newLoop = visitCilStmt (ld :> cilVisitor) s in
          let blk, loc, contOpt, breakOpt = (
            match newLoop.skind with 
            | Loop(a, b, c, d) -> a, b, c, d 
            | _ -> 
                raise(Invalid_argument("Visiting loops with transNestedLoopVisitor should always return loops"))
           ) in
          let beSure = function Some x -> x | None -> raise(Not_found) in
          let breakStmt = beSure breakOpt in
          (* We must decide which variables should be passed by reference *)
          let all = self#getAllVarsTouched s in
          let params = Liveness.getLiveness breakStmt in
          let filterAll = fun vi -> not vi.vglob in
              (* function filterParams decides which variables should be passed by 
                 reference. There are 4 conditions:
                 1. Not a global                             (done)
                 2. Not a refernece from higher-level loops  (done)
                 3. Not a constant                           (done)
                 4. There are new defs in the loop body      (this one is hard to decide)
                 5. Not a flush/reload pointer               (done)
               *)
          let filterParams vi = not ((isVarCilArg vi) ||
                                     (Flushmem.isVarCilFlush vi) ||
                                     (isFunctionType vi.vtype) ||
                                     (isArrayType vi.vtype) ||
                                     (isConstType vi.vtype)) in
          let params' = VS.filter filterParams params in
          let all' = VS.filter filterAll (VS.union all params') in
          let locals = VS.diff all' params' in
          let paramList =
            if hasReturn then
              if isVoidType (getFunctionReturnType fd) then
                VS.elements params'
              else
                VS.elements params' @ [(ld#getRetVar)]
            else
              VS.elements params'
          in
          let localList = VS.elements locals in
          let recType = self#getRecFunctionType paramList localList hasReturn in
          let idstr = string_of_int self#incMaxlrid in
          let recfunname = fd.svar.vname ^ "_cil_lr_" ^ idstr in
          let recfun = self#mkEmptyRec recfunname in
          setFunctionTypeMakeFormals recfun recType;
          self#setFunctionBody recfun blk hasReturn;
          slooprecs <- slooprecs @ [recfun];
          let argOfParam v = v.vaddrof <- true; AddrOf(Var(v), NoOffset) in
          let argOfLocal v = Lval(Var(v), NoOffset) in
          let argOfParamList = List.map argOfParam paramList in
          let argOfLocalList = List.map argOfLocal localList in
          let argList = argOfParamList @ argOfLocalList in
          let funcLval = Lval(Var(recfun.svar), NoOffset) in
          if hasReturn then
            let retFlag = makeTempVar fd ~name:"retflag" intType in
            let retFlagLval = Var(retFlag), NoOffset in
            let callInstr = Call(Some retFlagLval, funcLval, argList, loc) in
            let callStmt = mkStmtOneInstr callInstr in
            let retStmt = 
              if isVoidType (getFunctionReturnType fd) then
                mkStmt(Return(None, loc))
              else
                mkStmt(Return(Some(ld#getRetVarAsExp), loc))
            in
            let ifSkind = If(Lval(retFlagLval), (mkBlock [retStmt]), (mkBlock []), loc) in
            ChangeTo(mkStmt (Block(mkBlock [callStmt; (mkStmt ifSkind)])))
          else
            let call = Call(None, funcLval, argList,loc) in 
            let callStmt = mkStmtOneInstr call in 
            ChangeTo callStmt
      | _ -> DoChildren

  end

let loop2rec (cf: file) (blacklist: StrSet.t): unit = 
  let rec loop2recWorklist (iList: fundec list) (fList: fundec list) = 
    let l2rvCont = new loopToRecVisitor in
    match iList with
    | [] -> fList
    | f::fl ->
        Cfg.clearCFGinfo f;
        ignore(Cfg.cfgFun f);
        ignore(Liveness.computeLiveness f);
        let l2rv = l2rvCont f in
        ignore(visitCilFunction (l2rv :> nopCilVisitor) f);
        let newRecs = l2rv#getLooprecs in
        loop2recWorklist (fl @ newRecs) (newRecs @ fList)
  in
  let whitelistFilter = function
    | GFun(f, _) when not ((StrSet.mem f.svar.vname blacklist) || 
                           (cf.fileName <> f.svar.vdecl.file))
        -> [f]
    | _ -> []
  in
  let globFilter getFun glob =
    match glob with
    | GFun(_, _) -> false <> getFun
    | _ -> true <> getFun
  in
  let funFilter = globFilter true in
  let notFunFilter = globFilter false in
  let newLoc = { locUnknown with file = cf.fileName } in
  let f2g = fun f -> GFun(f, newLoc) in
  let f2d = fun f -> GVarDecl(f.svar, newLoc) in
  let funLL = List.map whitelistFilter cf.globals in
  let funL = List.concat funLL in
  let allRecFun = loop2recWorklist funL [] in
  let allRecGlob = List.map f2g allRecFun in
  let allRecDecl = List.map f2d allRecFun in
  let allFun = List.filter funFilter cf.globals in
  let allOther = List.filter notFunFilter cf.globals in
  cf.globals <- allOther @ allRecDecl @ allFun @ allRecGlob

let doit (input: file * StrSet.t) : file * StrSet.t=
  let f, blacklist = input in
  loop2rec f blacklist;
  Cfg.clearFileCFG f;
  f, blacklist
