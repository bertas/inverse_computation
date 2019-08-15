open Cil
open Ctoputil
module E = Errormsg
module IH = Inthash

let cilGlobPtrPrefix = "__cil_gp_"

class killGlobVisitor (fd: fundec) = 
  object(self)
    inherit nopCilVisitor

    val globPtrHash = IH.create 16

    method private lookupGlobPtr (v: varinfo) : varinfo = 
      try
        IH.find globPtrHash v.vid
      with
        Not_found ->
          let init = SingleInit(AddrOf(Var(v), NoOffset)) and
              ty = TPtr(v.vtype, []) in
          let vp' = makeLocalVar fd (cilGlobPtrPrefix ^ v.vname) ~init:init ty in
          IH.add globPtrHash v.vid vp';
          vp'

    method needKill (vi: varinfo) : bool =
      vi.vglob && not (isFunctionType vi.vtype || isArrayType vi.vtype)

    method vlval (lv: lval) : lval visitAction =
      match lv with
      | Var(vi), off ->
          if self#needKill vi then
            let ptr = self#lookupGlobPtr vi in 
            let nlv = (Mem(Lval(Var(ptr), NoOffset)), off) in
            ChangeDoChildrenPost(nlv, fun x -> x)
          else
            DoChildren
      | _ -> DoChildren

  end

let doit (input: file * StrSet.t) : file * StrSet.t =
  let f, blacklist = input in
  let kvis = new killGlobVisitor in
  let killGlob fn =
    if ((StrSet.mem fn.svar.vname blacklist) || 
        (fn.svar.vdecl.file <> f.fileName)) then
      ()
    else
      ignore(myVisitCilFunction ((kvis fn) :> cilVisitor) fn);
  in
  iterFunctions f killGlob;
  f, blacklist
