open Cil
open Ctoputil
module E = Errormsg
module IH = Inthash

let cilArgPtrPrefix = "__cil_pp_"

class killMemOpVisitor (fd: fundec) =
  object(self)
    inherit nopCilVisitor

    val varPtrHash = IH.create 16

    val ucharPtrTy = TPtr(TInt(IUChar, []), [])

    method private lookupVarPtr (v: varinfo) : varinfo = 
      try
        IH.find varPtrHash v.vid
      with
        Not_found ->
          let init = SingleInit(AddrOf(Var(v), NoOffset)) and
              ty = TPtr(v.vtype, []) in
          v.vaddrof <- true;
          let vp' = makeLocalVar fd (cilArgPtrPrefix ^ v.vname) ~init:init ty in
          IH.add varPtrHash v.vid vp';
          vp'

    method private accuDisplacement (pDis: int) (pTy: typ) (off: offset)
        : int * typ * offset =
      match off with
      | NoOffset -> pDis, pTy, NoOffset
      | Index(exp, noff) -> pDis, pTy, off
      | Field(fi, noff) ->
          let dis = bytesDisplacementOfField fi in
          self#accuDisplacement (pDis + dis) fi.ftype noff

    method private expandOff (base: lhost) (off: offset) : lval =
      match off with
      | NoOffset -> base, NoOffset
      | Index(e, noff) ->
          let baseExp = Lval(base, NoOffset) in
          if isConstZero e then
            let baseExp' =
              let baseTy = typeOf baseExp in
              match baseTy with
              | TArray(ty, _, attrs) -> CastE(TPtr(ty, attrs), baseExp)
              | _ -> baseExp
            in
            self#expandOff (Mem(baseExp')) noff
          else
            let baseTy = typeOf baseExp in
            let basePtrTy, elemTy = 
              match baseTy with
              | TArray(ty, _, attr) -> TPtr(ty, attr), ty
              | TPtr(ty, _) -> baseTy, ty
              | _ -> raise(Invalid_argument("Only arrays can have Index offset"))
            in
            let e' = visitCilExpr (self :> cilVisitor) e in
            let targetPtr = BinOp(PlusPI, baseExp, e', basePtrTy) in
            self#expandOff (Mem(targetPtr)) noff
      | Field(fi, noff) ->
          match fi.fbitfield with
          | Some _ -> raise(Todo("Cannot unfold bitfield access"))
          | None ->
              match base with 
              | Var(v) ->
                  let varPtr = self#lookupVarPtr v in
                  self#expandOff (Mem(Lval(Var(varPtr), NoOffset))) off
              | Mem(e) ->
                  let e' = visitCilExpr (self :> cilVisitor) e and
                      dis, targetTy, nnoff = self#accuDisplacement 0 voidType off in
                  let charPtr = CastE(ucharPtrTy, e') and
                      disConst = integer(dis) and
                      targetPtrTy = TPtr(targetTy, []) in
                  let charPtr' = 
                    if dis = 0 then
                      charPtr
                    else
                      BinOp(PlusPI, charPtr, disConst, ucharPtrTy) in
                  let targetPtr = CastE(targetPtrTy, charPtr') in
                  self#expandOff (Mem(targetPtr)) nnoff

    method vlval (lv: lval) : lval visitAction =
      let base, off = lv in
      let newLv = self#expandOff base off in
      ChangeDoChildrenPost(newLv, fun x -> x)

    method vexpr (e: exp) : exp visitAction =
      match e with
      | AddrOf(lv) ->
          let lv' = visitCilLval (self :> cilVisitor) lv in
          let e' = (
            match lv' with
            | Mem(e), NoOffset -> e
            | Var(v), NoOffset -> 
                let v' = self#lookupVarPtr v in
                Lval(Var(v'), NoOffset)
            | _ -> raise(Todo("There are AddrOfs that cannot be eliminated"))
           ) in 
          ChangeTo e'
      | _ -> DoChildren

  end

class cleanerVisitor =
  object(self)
    inherit nopCilVisitor

    method vexpr (e: exp) : exp visitAction =
      match e with
      | CastE(ty1, CastE(ty2, e')) ->
          if isPointerType ty1 && isPointerType ty2 then
            ChangeDoChildrenPost(CastE(ty1, e'), fun x->x)
          else
            DoChildren
      | _ -> DoChildren
  end

let doit (input: file * StrSet.t) : file * StrSet.t=
  let f, blacklist = input in
  let kvis = new killMemOpVisitor and
      cvis = new cleanerVisitor in
  let killMemop fn =
    if ((StrSet.mem fn.svar.vname blacklist) || 
        (fn.svar.vdecl.file <> f.fileName)) then
      ()
    else (
      ignore(myVisitCilFunction ((kvis fn) :> cilVisitor) fn);
      ignore(visitCilFunction (cvis :> cilVisitor) fn);
     )
  in
  iterFunctions f killMemop;
  f, blacklist
