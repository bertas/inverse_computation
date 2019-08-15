open Cil
open Ctoputil
module E = Errormsg
module IH = Inthash
module IS = Set.Make(
  struct
    let compare = Pervasives.compare
    type t = int
  end
)

class detectReturnVisitor = 
  object(self)
    inherit nopCilVisitor

    val mutable ifHasReturn = false

    method hasReturn (s: stmt) : bool =
      ifHasReturn <- false;
      ignore(visitCilStmt (self :> cilVisitor) s);
      ifHasReturn

    method vstmt (s: stmt) : stmt visitAction =
      if ifHasReturn then
        SkipChildren
      else
        match s.skind with
        | Return(_, _) -> ifHasReturn <- true; SkipChildren
        | _ -> DoChildren

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

class copyStmtVisitor =
  object(self)
    inherit nopCilVisitor

    method vstmt (s: stmt) : stmt visitAction =
      let s' = { s with sid = s.sid } in
      ChangeDoChildrenPost(s', fun x -> x)

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

let copyVis = new copyStmtVisitor

let copyStmt s = visitCilStmt (copyVis :> cilVisitor) s

(* Before applying this to a function, the CFG must be computed *)
class patchBranchVisitor =
  object(self)
    inherit nopCilVisitor

    val rd = new detectReturnVisitor

    method private needReplicate (ib: block) (eb: block) : bool * bool =
      let hasReturnBlock b =
        List.fold_left (||) false (List.map rd#hasReturn b.bstmts)
      in
      let rec ifLastNonBlkStmtNotReturn blk = 
        let len = List.length blk.bstmts in
        if len = 0 then
          true
        else
          let lastStmt = List.nth blk.bstmts (len - 1) in
          match lastStmt.skind with
          | Return(_, _) -> false
          | Block(blk') -> ifLastNonBlkStmtNotReturn blk'
          | If(_, ib, eb, _) ->
              ((ifLastNonBlkStmtNotReturn ib) && (ifLastNonBlkStmtNotReturn eb))
          | Loop(_, _, _, _) ->
              raise(Invalid_argument "stmtReplicator cannot process loop statements")
          | Switch(_, _, _, _) ->
              raise(Invalid_argument "stmtReplicator cannot process switch statements")
          | _ -> true
      in
      let hasRet = (hasReturnBlock ib) || (hasReturnBlock eb) in
      if hasRet then
        (ifLastNonBlkStmtNotReturn ib), (ifLastNonBlkStmtNotReturn eb)
      else
        false, false
              
    method vstmt (s: stmt) : stmt visitAction =
      match s.skind with
      | If(cond, ib, eb, loc) ->
          let iNeedRep, eNeedRep = self#needReplicate ib eb in
          if iNeedRep || eNeedRep then
            let stmtsToRep = getSameLevelSuccTrans s in
            let iRepStmts = List.map copyStmt stmtsToRep in
            let eRepStmts = List.map copyStmt stmtsToRep in
            let ib' = if iNeedRep then mkBlock (ib.bstmts @ iRepStmts) else ib in
            let eb' = if eNeedRep then mkBlock (eb.bstmts @ eRepStmts) else eb in
            ChangeDoChildrenPost(mkStmt(If(cond, ib', eb', loc)), fun x -> x)
          else
            DoChildren
      | _ -> 
          DoChildren

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

class cleanDeadStmtsVisitor (fd: fundec) =
  object(self)
    inherit cleanEmptyBlockVisitor

    val initId = 
      match fd.sbody.bstmts with
      | [] -> 0xdeadbeaf;
      | hd::tl -> hd.sid;

    method vstmt (s: stmt) : stmt visitAction =
      let removePred succ =
        succ.preds <- List.filter (fun x -> x.sid != s.sid) succ.preds
      in
      if s.sid = initId then
        DoChildren
      else
        match s.preds with
        | [] ->
            List.iter removePred s.succs;
            ChangeTo(mkEmptyStmt ())
        | _ -> DoChildren

  end

let doit (input: file * StrSet.t) : file * StrSet.t =
  let f, blacklist = input in
  let pvis = new patchBranchVisitor in
  let splitPath fn =
    if ((StrSet.mem fn.svar.vname blacklist) || 
        (fn.svar.vdecl.file <> f.fileName)) then
      ()
    else (
      ignore(Cfg.cfgFun fn);
      ignore(visitCilFunction (pvis :> cilVisitor) fn);
      Cfg.clearCFGinfo fn;
      ignore(Cfg.cfgFun fn);
      let cvis = new cleanDeadStmtsVisitor fn in
      ignore(visitCilFunction (cvis :> cilVisitor) fn);
     )
  in
  iterFunctions f splitPath;
  Cfg.clearFileCFG f;
  f, blacklist
