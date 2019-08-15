open Cil
open Ctoputil
module E = Errormsg
module H = Hashtbl
module IH = Inthash

class expandStmtVisitor (fd: fundec) = 
  object(self)
    inherit nopCilVisitor

    method private splitExp (e: exp) (loc: location) : stmt * exp = 
      let tempType = typeOf e in
      let tempVarinfo = makeTempVar fd tempType in
      let tempLval = (Var(tempVarinfo), NoOffset) in
      let instr = Set(tempLval, e, loc) in
      let setTemp = mkStmtOneInstr(instr) in
      (setTemp, Lval(tempLval))

    method private expandReturn (e: exp) (loc: location): stmt = 
      let (setTemp, tempVar) = (self#splitExp e loc) in
      mkStmt(Block(mkBlock([setTemp; mkStmt(Return(Some(tempVar), loc))])))

    method private expandIf (e: exp) (tb: block) (fb: block) (loc: location) : stmt = 
      let (setTemp, tempVar) = (self#splitExp e loc) in
      mkStmt(Block(mkBlock([setTemp; mkStmt(If(tempVar, tb, fb, loc))])))

    method private expandSwitch (e: exp) (sb: block) 
                        (sl : stmt list) (loc: location) : stmt =
      let (setTemp, tempVar) = (self#splitExp e loc) in
      mkStmt(Block(mkBlock([setTemp; mkStmt(Switch(tempVar, sb, sl, loc))])))

    method private expandComputedGoto (e: exp) (loc: location) : stmt = 
      let (setTemp, tempVar) = (self#splitExp e loc) in
      mkStmt(Block(mkBlock([setTemp; mkStmt(ComputedGoto(tempVar, loc))])))

    method vstmt (s : stmt) : stmt visitAction = 
      let id = fun x -> x in
      match s.skind with
      | Return(Some retExp, loc) -> 
          if isAtomicExp(retExp) then 
            DoChildren 
          else
            ChangeDoChildrenPost((self#expandReturn retExp loc), id)
      | If(ifExp, tb, fb, loc) ->
          if isAtomicExp(ifExp) then 
            DoChildren
          else  
            ChangeDoChildrenPost((self#expandIf ifExp tb fb loc), id)
      | Switch(switchExp, sb, sl, loc) ->
          if isAtomicExp(switchExp) then
            DoChildren 
          else
            ChangeDoChildrenPost((self#expandSwitch switchExp sb sl loc), id)
      | ComputedGoto(gotoExp, loc) ->
          if isAtomicExp(gotoExp) then 
            DoChildren
          else
            ChangeTo (self#expandComputedGoto gotoExp loc)
      | _ -> DoChildren

  end

class expandExpVisitor (fd: fundec) = 
  object(self)
    inherit nopCilVisitor

    method private expandLval (lv: lval) (loc: location) 
        : instr list * lval =
      match lv with
      | Var(v), NoOffset -> [], (Var(v), NoOffset)
      | Mem(e), NoOffset -> 
          let ia = isAtomicExp(e) in
          if ia then [], lv else
          let el, ee = self#expandExp e loc in
          let ty1 = typeOf ee in
          let tv1 = makeTempVar fd ty1 in 
          let nlv1 = Var(tv1), NoOffset in
          let set1 = Set(nlv1, ee, loc) in
          el @ [set1], (Mem(Lval(nlv1)), NoOffset)
      | _ ->
          raise(Invalid_argument("By the time of making three tuples, \
                                  no memory operators should remain"))

    method private expandExp (e: exp) ?(foldMem : bool = false) (loc: location) 
        : instr list * exp =
      if isAtomicExp(e) then [], e else
      match e with 
      (* Expand lvalues *)
      | Lval(lv)                ->
          let el, nlv = self#expandLval lv loc in
          el, Lval(nlv)
      | StartOf(lv)             -> 
          let el, nlv = self#expandLval lv loc in
          el, StartOf(nlv)
      | AddrOf(lv)              -> 
          let el, nlv = self#expandLval lv loc in
          el, AddrOf(nlv)
      | CastE(t, ee)            -> 
          let ia = isAtomicExp(ee) in
          if ia then [], e else
              let el, eee = self#expandExp ee loc in
              let ty = typeOf eee in
              let tv = makeTempVar fd ty in
              let lv = Var(tv), NoOffset in
              let set = Set(lv, eee, loc) in
              el @ [set], CastE(t, Lval(lv))
      | UnOp(op, ee, ty)        ->
          let ia = isAtomicExp(ee) in
          if ia then [], e else
              let el, eee = self#expandExp ee loc in
              let ty = typeOf eee in
              let tv = makeTempVar fd ty in
              let lv = Var(tv), NoOffset in
              let set = Set(lv, eee, loc) in
              el @ [set], UnOp(op, Lval(lv), ty)
      | BinOp(op, ee1, ee2, ty) -> (* All binops in C are left associative *)
          let ia1 = isAtomicExp(ee1) and
              ia2 = isAtomicExp(ee2) in
          (
          match ia1, ia2 with
          | true, true   -> [], e
          | false, true  ->
              let el1, eee1 = self#expandExp ee1 loc in
              let ty1 = typeOf eee1 in
              let tv1 = makeTempVar fd ty1 in
              let lv1 = Var(tv1), NoOffset in
              let set1 = Set(lv1, eee1, loc) in
              el1 @ [set1], BinOp(op, Lval(lv1), ee2, ty)
          | true, false  -> 
              let el2, eee2 = self#expandExp ee2 loc in
              let ty2 = typeOf eee2 in
              let tv2 = makeTempVar fd ty2 in
              let lv2 = Var(tv2), NoOffset in
              let set2 = Set(lv2, eee2, loc) in
              el2 @ [set2], BinOp(op, ee1, Lval(lv2), ty)
          | false, false ->
              let el1, eee1 = self#expandExp ee1 loc and
                  el2, eee2 = self#expandExp ee2 loc in
              let ty1 = typeOf eee1 and
                  ty2 = typeOf eee2 in
              let tv1 = makeTempVar fd ty1 and
                  tv2 = makeTempVar fd ty2 in
              let lv1 = Var(tv1), NoOffset and
                  lv2 = Var(tv2), NoOffset in
              let set1 = Set(lv1, eee1, loc) and
                  set2 = Set(lv2, eee2, loc) in
              List.concat [el1; el2; [set1; set2]], BinOp(op, Lval(lv1), Lval(lv2), ty)
          )
      | AddrOfLabel(_)          -> [], e  (* Keep. Can't deal with for now *)
      | Question(_, _, _, _)    -> [], e  (*
                                            It seems that CIL has already transformed
                                            ternary conditionals into if-else statments
                                           *)
      | _                       -> [], e  (* 
                                             The wildcard here matches Const and
                                             all the sizeof and alignof operations. 
                                             We rely on the Partial Evaluation & 
                                             Constant Folding pass to eliminate all 
                                             sizeof and alignof operations applying
                                             our passes.
                                           *)

    method vinst (i: instr) : instr list visitAction = 
      match i with 
      | Call(lvOpt, e, el, loc) -> 
          let nl1, ne = self#expandExp e loc and
              nlel = List.map (fun x -> self#expandExp x loc) el in
          let nel = List.map snd nlel and
              nll = List.map fst nlel in
          let nl2 = List.concat nll in
          let getATmp = fun e -> 
            if isAtomicExp e then e, None 
            else
              let tv = makeTempVar fd (typeOf e) in
              let lv = Var(tv), NoOffset in
              Lval(lv), Some lv
          in let elvl = List.map getATmp nel in
          let nel' = List.map fst elvl and
              lvl = List.map snd elvl in
          let lvepair = List.combine lvl nel in
          let nll2 = List.map (function Some lv, e -> [Set(lv, e, loc)] | _ -> []) lvepair in
          let nl3 = List.concat nll2 in
          ChangeTo(nl1 @ nl2 @ nl3 @ [Call(lvOpt, ne, nel', loc)])
      | Set(lv, e, loc) ->
          let foldMem = isPtrDref e in
          let nl1, ne = self#expandExp e loc ~foldMem:foldMem and
              nl2, nv = self#expandLval lv loc in
          ChangeTo(nl1 @ nl2 @ [Set(nv, ne, loc)])
      | _ -> SkipChildren

  end

let makeZeroInitForLocals (fd: fundec) : unit =
  let zeroInitIfNoInit vi = 
    match vi.vtype with
    | TVoid(_) -> ()
    | TArray(_) -> ()
    | TFun(_) -> ()
    | TNamed(_) -> ()
    | TComp(_) -> ()
    | TEnum(_) -> ()
    | TBuiltin_va_list(_) -> ()
    | _ -> (
        match vi.vinit.init with
        | None -> vi.vinit.init <- Some (makeZeroInit vi.vtype)
        | Some _ -> ()
       ) in
  ignore(List.iter zeroInitIfNoInit fd.slocals)


let doit (input: file * StrSet.t) : file * StrSet.t =
  let f, blacklist = input in
  let svis = new expandStmtVisitor and 
      evis = new expandExpVisitor in
  let threeTuple fn =
    if ((StrSet.mem fn.svar.vname blacklist) || 
        (fn.svar.vdecl.file <> f.fileName)) then
      ()
    else (
      ignore(visitCilFunction ((svis fn) :> cilVisitor) fn); 
      ignore(visitCilFunction ((evis fn) :> cilVisitor) fn); 
(*      makeZeroInitForLocals fn *)
     )
  in
  iterFunctions f threeTuple;
  f, blacklist
