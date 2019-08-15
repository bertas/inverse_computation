open Cil
open Ctoputil
open Filename

module E = Errormsg

class blockingVisitor =
  object(self)
    inherit nopCilVisitor

    val shouldBlockFlag = ref false

    method reset = shouldBlockFlag := false

    method shouldBlock = !shouldBlockFlag

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

    method vstmt (s: stmt) : stmt visitAction =
      if !shouldBlockFlag then
        SkipChildren
      else
        match s.skind with
        | Switch(_, _, _, _) -> shouldBlockFlag := true; SkipChildren
        | Goto(_, _) -> shouldBlockFlag := true; SkipChildren
        | ComputedGoto(_, _) -> shouldBlockFlag := true; SkipChildren
              (* TODO: We actually can support continue; but for now
                 let's just ignore it.
               *)
        | Continue(_) -> shouldBlockFlag := true; SkipChildren
        | _ -> DoChildren

    method vinst (i: instr) : instr list visitAction =
      if !shouldBlockFlag then
        SkipChildren
      else
        match i with
        | Asm(_) -> shouldBlockFlag := true; SkipChildren
        | _ -> DoChildren

  end

let doit (input: file * StrSet.t) : file * StrSet.t =
  let f, blacklist = input in
  let filename = basename f.fileName in
  let blref = ref blacklist in
  let bvis = new blockingVisitor in
  let getBlacklist cilFun =
    if cilFun.svar.vdecl.file <> filename then
      ()
    else (
      bvis#reset;
      ignore(visitCilFunction (bvis :> cilVisitor) cilFun);
      let blacklist' = 
        if bvis#shouldBlock || (isVarArgFunctionType cilFun.svar.vtype) then
          StrSet.add cilFun.svar.vname !blref
        else
          !blref
      in
      blref := blacklist'
     )
  in
  iterFunctions f getBlacklist;
  f, !blref
