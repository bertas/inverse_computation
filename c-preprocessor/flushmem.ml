open Cil
open Ctoputil
module E = Errormsg
module H = Hashtbl
module IH = Inthash
module VS = Usedef.VS

let cilFlushPrefix = "__cil_fp_"
let cilFlushRegexp = Str.regexp ("^" ^ cilFlushPrefix ^ ".+")
let cilFlushPrefixLen = String.length cilFlushPrefix
let getFlushSuffix = fun vname ->
  let len = String.length vname in
  let subLen = len - cilFlushPrefixLen in
  String.sub vname cilFlushPrefixLen subLen

let isVarCilFlush (v: varinfo) =
  match v.vtype with
  | TPtr(ty, attrs) ->
      let len = String.length v.vname in
      if len > cilFlushPrefixLen then
        let prefix = String.sub v.vname 0 cilFlushPrefixLen in
        if prefix = cilFlushPrefix then
          true
        else
          false
      else
        false
  | _ -> false

(* We need to put every single instr in a statement beacuse
   variable liveness can only be computed at the scale of
   statments.
 *)
class singleInstrVisitor = 
  object(self)
    inherit nopCilVisitor

    method vstmt (s: stmt) : stmt visitAction = 
      match s.skind with
      | Instr(il) ->
          let instrToStmt = fun i -> mkStmtOneInstr i in
          let stmtList = List.map instrToStmt il in
          let blk = mkBlock(stmtList) in
          ChangeTo(mkStmt(Block(blk)))
      | _ -> DoChildren

  end

let resolveExp (whitelist: varinfo list) (e: exp) : varinfo list =
  if isPointerType (typeOf e) then
    let inWhitelist (v: varinfo) : bool =
      try
        ignore(List.find (fun x -> x == v) whitelist);
        true
      with
        Not_found -> false
    in
    try
      List.filter inWhitelist (Ptranal.resolve_exp e)
    with
      Not_found -> whitelist
  else
    []

let shouldFlush (vi: varinfo) : bool =
  let ty = vi.vtype in
  vi.vaddrof && 
  (not ((isArrayType ty) || 
       (isFunctionType ty) ||
       (isCompType ty) ||
       vi.vglob))

class getRvalAliasVisitor (localsAndParams: varinfo list) =
  object(self)
    inherit nopCilVisitor

    val mutable aliasSet = VS.empty

    method getAliasSet = aliasSet

    method resolveExp = resolveExp localsAndParams

    method vlval (lv: lval) : lval visitAction = 
      match lv with 
      | Mem(e), NoOffset ->
          let aliasList = self#resolveExp e in
          let newAliasSet = List.fold_left (fun s v -> VS.add v s) aliasSet aliasList in
          aliasSet <- newAliasSet;
          DoChildren
      | _ -> DoChildren

    method vexpr (e: exp) : exp visitAction =
      let aliasList = self#resolveExp e in
      let newAliasSet = List.fold_left (fun s v -> VS.add v s) aliasSet aliasList in
      aliasSet <- newAliasSet;
      DoChildren
      
  end

class flushMemVisitor (fd: fundec) = 
  object(self)
    inherit nopCilVisitor

    val flushHash = IH.create 16

    val localsAndParams =
      List.filter (fun x -> isSimpleType x.vtype) (fd.slocals @ fd.sformals)

    method resolveExp = resolveExp localsAndParams

    method private mkFlushReadInstr (v: varinfo) : instr =
      let vp =
        try
          IH.find flushHash v.vid
        with
          Not_found -> 
            let init = SingleInit(AddrOf(Var(v), NoOffset)) in
            let ty = TPtr(v.vtype, [Attr("const", [])]) in
            v.vaddrof <- true;
            let vp' = makeLocalVar fd (cilFlushPrefix ^ v.vname) ~init:init ty in
            IH.add flushHash v.vid vp';
            vp'
      in
      let mem = Mem(Lval(Var(vp), NoOffset)) in
      Set((Var(v), NoOffset), Lval(mem, NoOffset), locUnknown)

    method private mkFlushWriteInstr (v: varinfo) : instr =    
      let vp = 
        try
          IH.find flushHash v.vid
        with
          Not_found -> 
            let init = SingleInit(AddrOf(Var(v), NoOffset)) and
                ty = TPtr(v.vtype, [Attr("const", [])]) in
            v.vaddrof <- true;
            let vp' = makeLocalVar fd (cilFlushPrefix ^ v.vname) ~init:init ty in
            IH.add flushHash v.vid vp';
            vp'
      in
      let mem = Mem(Lval(Var(vp), NoOffset)) in
      Set((mem, NoOffset), Lval(Var(v), NoOffset), locUnknown)

    method private getLvalAliasLval (lv: lval) : VS.t =
      let lh, off = lv in
      match lh with
      | Mem(e) ->
          let aliasList = self#resolveExp e in
          List.fold_left (fun s v -> VS.add v s) VS.empty aliasList
      | _ -> VS.empty

    method private getLvalAliasExp (el: exp list) : VS.t =
      let isPtr e =
        let ty = typeOf e in
        match ty with
        | TPtr(_) -> true
        | _ -> false
      in let ptrExpList = List.filter isPtr el in
      let aliasListList = List.map self#resolveExp ptrExpList in
      let aliasList = List.concat aliasListList in
      List.fold_left (fun s v -> VS.add v s) VS.empty aliasList 


    method private getRvalAliasLval (lv: lval) : VS.t =
      let ravis = new getRvalAliasVisitor localsAndParams in
      ignore(visitCilLval (ravis :> cilVisitor) lv);
      ravis#getAliasSet

    method private getRvalAliasExp (el: exp list) : VS.t =
      let getRvalAliasExp e = 
        let ravis = new getRvalAliasVisitor localsAndParams in
        ignore(visitCilExpr (ravis :> cilVisitor) e);
        ravis#getAliasSet
      in let aliasSetList = List.map getRvalAliasExp el in 
      List.fold_left (fun x y -> VS.union x y) VS.empty aliasSetList

    method private processInstr (s: stmt) (i: instr) : instr list =
      match i with
      | Set(lv, e, loc) -> 
          let rightRvalAlias = self#getRvalAliasExp [e] in
          let leftRvalAlias = self#getRvalAliasLval lv in
          let setRvalAlias = VS.union rightRvalAlias leftRvalAlias in
          let liveVar = Liveness.getPostLiveness s in
          let flushReadVar = self#getLvalAliasLval lv in
          let flushWriteVar = VS.inter setRvalAlias liveVar in
          let flushWriteVarList = List.filter shouldFlush (VS.elements flushWriteVar) in
          let flushReadVarList = List.filter shouldFlush (VS.elements flushReadVar) in
          let ilw = List.map self#mkFlushWriteInstr flushWriteVarList in
          let ilr = List.map self#mkFlushReadInstr flushReadVarList in
          ilw @ [i] @ ilr
      | Call(lvO, e, el, loc) ->
          let lvalAlias = self#getLvalAliasExp ([e] @ el) in
          let liveVar = Liveness.getPostLiveness s in
          let flushReadVar = VS.inter lvalAlias liveVar in
          let flushWriteVar = self#getRvalAliasExp ([e] @ el) in
          let flushReadVarList = List.filter shouldFlush (VS.elements flushReadVar) in
          let flushWriteVarList = List.filter shouldFlush (VS.elements flushWriteVar) in
          let ilw = List.map self#mkFlushWriteInstr flushWriteVarList in
          let ilr = List.map self#mkFlushReadInstr flushReadVarList in
          ilw @ [i] @ ilr
      | Asm(_) -> raise(Invalid_argument("Cannot transform inline asm"))

    method vstmt (s: stmt) : stmt visitAction =
      match s.skind with
      | Instr(il) ->
          if List.length il = 1 then
            let i = List.hd il in
            let il' = self#processInstr s i in
            let s' = mkStmt(Instr(il')) in
            ChangeTo s'
          else
            raise(Invalid_argument("Multiple instructions found in a single statmement"))
      | _ -> DoChildren
      
  end

let doit (input: file * StrSet.t) : file * StrSet.t=
  let f, blacklist = input in
  let sivis = new singleInstrVisitor in
  let singleInstrStmt (fn: fundec) : unit =
    if ((StrSet.mem fn.svar.vname blacklist) ||
        (fn.svar.vdecl.file <> f.fileName)) then
      ()
    else
      ignore(visitCilFunction sivis fn)
  in
  iterFunctions f singleInstrStmt;
  Cfg.computeFileCFG f;
  Ptranal.analyze_file f;
  Ptranal.compute_results false;
  let cvis = new cleanEmptyBlockVisitor in
  let flushMem (fn: fundec) : unit =
    if ((StrSet.mem fn.svar.vname blacklist) ||
        (fn.svar.vdecl.file <> f.fileName)) then
      ()
    else
      let fvis = new flushMemVisitor fn in
      ignore(Liveness.computeLiveness fn);
      ignore(visitCilFunction (fvis :> cilVisitor) fn);
      ignore(visitCilFunction (cvis :> cilVisitor) fn)
  in
  iterFunctions f flushMem;
  Cfg.clearFileCFG f;
  f, blacklist
