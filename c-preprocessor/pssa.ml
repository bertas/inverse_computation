open Cil
open Ctoputil
module E = Errormsg
module H = Hashtbl
module VM = Map.Make(String)

(* In this pass we assume that the source code has been simplified 
   by another pass from us and all loops have been transformed into 
   tail recursive function calls. With these assumptions, the pass 
   transforms the source code into a "partial SSA form", which is 
   necessary for us to further translate the code into Prolog. 
*)

let varSSAName vname sn = 
  if sn = 0 then vname else vname ^ "_ssa_" ^ (string_of_int sn)

class paddingVisitor =
  object(self)
    inherit nopCilVisitor

    method vstmt (s: stmt) : stmt visitAction = 
      match s.skind with
      | If(cond, ib, eb, loc) ->
          if 0 = (List.length eb.bstmts) then
            let padStmt = mkStmtOneInstr dummyInstr in
            let eb' = { eb with bstmts = [ padStmt ] } in
            ChangeDoChildrenPost(mkStmt(If(cond, ib, eb', loc)), fun x -> x)
          else 
            DoChildren
      | _ -> DoChildren
  end

class renameVarVisitor (fd: fundec) (map: int VM.t) =
  object(self)
    inherit nopCilVisitor

    val localsAndParams = fd.slocals @ fd.sformals

    method private isNonSSAVar (vi: varinfo) : bool =
      isFunctionType vi.vtype || isArrayType vi.vtype || vi.vglob

    method vvrbl (vi: varinfo) : varinfo visitAction =
      if self#isNonSSAVar vi then
        SkipChildren
      else
        let sn = VM.find vi.vname map in
        let nvname = varSSAName vi.vname sn in
        let nv =
          try
            List.find (fun vi -> vi.vname = nvname) localsAndParams
          with
            Not_found -> makeLocalVar fd nvname vi.vtype
        in
	ChangeTo nv
  end

let maxMap (k: string) (x: int option) (y: int option) =
  match x, y with
  | Some e1, Some e2 -> Some (max e1 e2)
  | _ -> raise(Not_found)

let mkStmtWithMetadata (s: stmt) (sk: stmtkind) : stmt =
  { s with skind = sk }

class doSSATVisitor (fd: fundec) = 
  object(self)
    inherit nopCilVisitor
    
    val ssaCntIn = H.create 64
    val ssaCntOut = H.create 64

    val initMap = 
      let m = VM.empty and
          addVar = fun map vi -> VM.add vi.vname 0 map in
      let m' = List.fold_left addVar m fd.sformals in
      List.fold_left addVar m' fd.slocals

    method getSSAInfo = ssaCntIn, ssaCntOut

    method private batchInstr (pre: instr list * int VM.t) (i: instr)
        : instr list * int VM.t =
      let il, m = pre in
      match i with
      | Set(lv, se, loc) -> (
          match lv with
          | Var(vi), NoOffset ->
              if vi.vglob then 
                (* global variables should always be accessed via memory r/w *)
                let rvis = new renameVarVisitor fd m in
                let i' = visitCilInstr (rvis :> cilVisitor) i in
                (il @ i'), m
              else
                let count = VM.find vi.vname m in
                let count' = count + 1 in
                let m' = VM.add vi.vname count' m in
                let rvis = new renameVarVisitor fd m in
                let rvis' = new renameVarVisitor fd m' in
                let se' = visitCilExpr (rvis :> cilVisitor) se in
                let lv' = visitCilLval (rvis' :> cilVisitor) lv in
                let i' = [Set(lv', se', loc)] in
                (il @ i'), m'
          | _ ->
              let rvis = new renameVarVisitor fd m in
              let i' = visitCilInstr (rvis :> cilVisitor) i in
              (il @ i'), m
         )
      | Call((Some lv), fe, ael, loc) -> (
          match lv with
          | Var(vi), NoOffset ->
              if vi.vglob then 
                (* global variables should always be accessed via memory r/w *)
                let rvis = new renameVarVisitor fd m in
                let i' = visitCilInstr (rvis :> cilVisitor) i in
                (il @ i'), m
              else
                let count = VM.find vi.vname m in
                let count' = count + 1 in
                let m' = VM.add vi.vname count' m in
                let rvis = new renameVarVisitor fd m in
                let rvis' = new renameVarVisitor fd m' in
                let fe' = visitCilExpr (rvis :> cilVisitor) fe in
                let ael' = List.map (visitCilExpr (rvis :> cilVisitor)) ael in
                let lv' = visitCilLval (rvis' :> cilVisitor) lv in
                let i' = [Call((Some lv'), fe', ael', loc)] in
                (il @ i'), m'
          | _ ->
              let rvis = new renameVarVisitor fd m in
              let i' = visitCilInstr (rvis :> cilVisitor) i in
              (il @ i'), m
         )
      | _ ->
          let rvis = new renameVarVisitor fd m in
          let i' = visitCilInstr (rvis :> cilVisitor) i in
          (il @ i'), m

    method vstmt (s: stmt) : stmt visitAction = 
      let find = fun ss -> H.find ssaCntOut ss.sid in
      let predMaps = List.map find s.preds in
      let mIn = List.fold_left (VM.merge maxMap) initMap predMaps in
      H.add ssaCntIn s.sid mIn;
      H.add ssaCntOut s.sid mIn;
      match s.skind with
      | Instr(il) -> 
          let il', mOut = List.fold_left self#batchInstr ([], mIn) il in
          H.add ssaCntOut s.sid mOut;
          ChangeTo(mkStmtWithMetadata s (Instr(il')))
      | If(cond, ib, eb, loc) ->
          let rvis = new renameVarVisitor fd mIn in
          let cond' = visitCilExpr (rvis :> cilVisitor) cond in
          ChangeDoChildrenPost((mkStmtWithMetadata s (If(cond', ib, eb, loc))), fun x -> x)
      | Return(expO, loc) -> (
          match expO with
          | Some exp -> 
              let rvis = new renameVarVisitor fd mIn in
              let exp' = visitCilExpr (rvis :> cilVisitor) exp in
              ChangeTo(mkStmtWithMetadata s (Return(Some exp', loc)))
          | None -> SkipChildren
         )
      | _ -> DoChildren

  end

type ssaMapHash = (int, (int VM.t)) H.t

class backfillVisitor (fd: fundec) (ssaCntIn: ssaMapHash) (ssaCntOut: ssaMapHash) =
  object(self)
    inherit nopCilVisitor

    val localsLookUpTbl = 
      let addOne = fun (m: varinfo VM.t) (v: varinfo) -> VM.add v.vname v m in
      List.fold_left addOne VM.empty (fd.slocals @ fd.sformals)

    method private patchAssignment (vname: string) (cnt1: int) (cnt2: int) : instr =
      let lv = VM.find (varSSAName vname cnt2) localsLookUpTbl in
      let rv = VM.find (varSSAName vname cnt1) localsLookUpTbl in
      Set((Var(lv), NoOffset), Lval(Var(rv), NoOffset), locUnknown)
            
    method private backfill (b1: string * int) (b2: string * int)
        : instr list =
      let vname1, cnt1 = b1 and
          vname2, cnt2 = b2 in
      if vname1 = vname2 then
        if cnt1 < cnt2 then
          [ (self#patchAssignment vname1 cnt1 cnt2) ]
        else
          []
      else
        raise(Invalid_argument("Unmached SSA bindgs"))

    method vstmt (s: stmt) : stmt visitAction =
      match s.skind with
      | Instr(il) ->
          let il' = if (List.length il) = 1 && isDummyInstr (List.hd il) then [] else il in
          if List.length s.succs = 1 then
            let succ = List.hd s.succs in
            let mOut = H.find ssaCntOut s.sid and
                mSIn = H.find ssaCntIn succ.sid in
            let lOut = VM.bindings mOut and
                lSIn = VM.bindings mSIn in
            let extraAssignment = List.map2 self#backfill lOut lSIn in
            let nil = List.concat ([il'] @ extraAssignment) in
            let ns = mkStmt(Instr(nil)) in
            ChangeTo ns
          else
            SkipChildren
      | _ -> DoChildren
  end

let transToSSA (fd: fundec) : unit =
  let svisCtr = new doSSATVisitor and
      bvisCtr = new backfillVisitor in
  let si = svisCtr fd in
  ignore(Cfg.cfgFun fd);
  ignore(visitCilFunction (si :> cilVisitor) fd);
  let ssaCntIn, ssaCntOut = si#getSSAInfo in
  let bi = bvisCtr fd ssaCntIn ssaCntOut in
  ignore(visitCilFunction (bi :> cilVisitor) fd)

let doit (input: file * StrSet.t) : file * StrSet.t =
  let f, blacklist = input in
  let pvis = new paddingVisitor in
  let pSSA fn = 
    if ((StrSet.mem fn.svar.vname blacklist) || 
        (fn.svar.vdecl.file <> f.fileName)) then
      ()
    else (
      ignore(visitCilFunction (pvis :> cilVisitor) fn);
      transToSSA fn
     )
  in
  iterFunctions f pSSA;
  f, blacklist
