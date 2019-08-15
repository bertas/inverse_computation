open Cil
module H = Hashtbl
module M = Machdep
module E = Errormsg
module VS = Usedef.VS
module StmtSet = Set.Make( 
  struct
    let compare = fun s1 s2 -> s1.sid - s2.sid
    type t = stmt
  end
)
module StrSet = Set.Make(String)

exception Todo of string

let (|>) x f = f x

let isDummyInstr (i: instr) =
  match i with
  | Asm(_, tmpl, _, _, _, _) -> tmpl = ["dummy statement!!"]
  | _ -> false

let isPtrDref (e: exp) : bool =
  match e with
  | Lval(Mem(_), _) -> true
  | _ -> false

let isConstZero (e: exp) : bool =
  match e with
  | Const(CInt64(v, _, _)) -> v = Int64.zero
  | _ -> false

let rec isVarArgFunctionType (t: typ) : bool =
  match t with
  | TFun(_, _, isvararg, _) ->
      isvararg
  | TNamed(ti, _) ->
      isVarArgFunctionType ti.ttype
  | _ -> false

let isConstType (t: typ) : bool =
  let t' = unrollType t in
  hasAttribute "const" (typeAttrs t')

let rec isCompType (t: typ) : bool =
  match t with
  | TComp(_) -> true
  | TNamed(ti, _) -> isCompType ti.ttype
  | _ -> false

let rec isSimpleType (t: typ) : bool =
  match t with
  | TInt(_, _) -> true
  | TFloat(_, _) -> true
  | TPtr(_, _) -> true
  | TEnum(_, _) -> true
  | TNamed(ti, _) -> isSimpleType ti.ttype
  | _ -> false

let rec isAtomicExp (e: exp) : bool =
  let testHost = function Var(_) -> true | _ -> false and
      testOff  = function NoOffset -> true | _ -> false in
  let testLval = fun (h: lhost) (o: offset) -> testHost h && testOff o in
  match e with
  | CastE(_, ee)      -> isAtomicExp(ee)
  | UnOp(_, ee, _)    -> isAtomicExp(ee)
  | AddrOf(host, off) -> testLval host off
  | Lval(host, off)   -> testLval host off
  | AddrOfLabel(_)    -> true
  | Const(_)          -> true
  | SizeOf(_)         -> true
  | SizeOfE(_)        -> true
  | SizeOfStr(_)      -> true
  | _                 -> false

let getAllPostLiveness (s:stmt) = 
  let foldLiveness live s = VS.union live (Liveness.getLiveness s) in
  let rec allPostLiveness live sl visited = 
    match sl with
    | [] -> live
    | _ ->
        let unvisitedSucc s = List.filter (fun x->not (StmtSet.mem x visited)) s.succs in
        let sl' = List.concat (List.map unvisitedSucc sl) in
        let live' = List.fold_left foldLiveness live sl in
        let visited' = List.fold_right StmtSet.add sl' visited in
        allPostLiveness live' sl' visited'
  in
  allPostLiveness VS.empty s.succs StmtSet.empty

let makeTempVar fdec ?(insert = true) ?(name = "__cil_tmp") typ : varinfo =
  let typ' =
    let typUnroll = unrollType typ in
    match typUnroll with
    | TArray(ty, _, attrs) -> TPtr(ty, attrs)
    | _ -> typ
  in
  Cil.makeTempVar fdec ~insert:insert ~name:name typ'

let getFunctionReturnType (fd: fundec) =
  let var = fd.svar in
  let typUnroll = unrollType var.vtype in
  match typUnroll with
  | TFun(retTy, _, _, _) -> retTy
  | _ -> 
      raise(Invalid_argument("getFunctionReturnType: not a valid function type"))

let rec bytesSizeAlignOfType (ty: typ) : int * int =
  match ty with
  | TVoid(_) -> let size = !M.theMachine.M.sizeof_void in size, size
  | TPtr(_) -> let size = !M.theMachine.M.sizeof_ptr in size, size
  | TFloat(FFloat, _) -> let size = !M.theMachine.M.sizeof_float in size, size
  | TFloat(FDouble, _) -> let size = !M.theMachine.M.sizeof_double in size, size
  | TFloat(FLongDouble, _) -> let size = !M.theMachine.M.sizeof_longdouble in size, size
  | TFun(_) -> let size = !M.theMachine.M.sizeof_fun in size, size
  | TInt(ik, _) -> let size = bytesSizeOfInt ik in size, size
    (* The size of an enum depends on many factors. 
       We have to simplify the situation for now.
     *)
  | TEnum(_) -> let size = !M.theMachine.M.sizeof_int in size, size
  | TArray(ty, Some(Const(CInt64(l, _, _))), _) -> 
      let baseSize, baseAlign = bytesSizeAlignOfType ty in
      (Int64.to_int l) * baseSize, baseAlign
  | TArray(ty, Some e, _) -> (
      let baseSize, baseAlign = bytesSizeAlignOfType ty in
      try
        let arrayLen = constFold true e in
        match arrayLen with
        | Const(CInt64(l, _, _)) ->
            (Int64.to_int l) * baseSize, baseAlign
        | _ -> raise Not_found
      with
        Not_found ->
          raise(Todo("Size of unfixed-length array cannot be computed"))
     )
  | TArray(_, None, _) ->
      raise(Todo("Size of unfixed-length array cannot be computed"))
  | TBuiltin_va_list(_) ->
      raise(Todo("Size of varg list cannot be computed"))
  | TNamed(ti, _) ->
      bytesSizeAlignOfType ti.ttype
  | TComp(ci, _) ->
      let rec getFieldSizeAlign field = 
        match field.fbitfield with 
        | Some _ -> raise(Todo("Size of bitfields cannot be computed"))
        | None -> bytesSizeAlignOfType field.ftype
       and foldStruct baseSizeAlign sizeAlign =
        let baseSize, baseAlign = baseSizeAlign and
            size, align = sizeAlign in
        let padding = (align - (baseSize mod align)) mod align in
        let nsize = baseSize + padding + size and
            nalign = if align > baseAlign then align else baseAlign in
        nsize, nalign
      and foldUnion baseSizeAlign sizeAlign =
        let baseSize, baseAlign = baseSizeAlign and
            size, align = sizeAlign in
        let nalign = if align > baseAlign then align else baseAlign in
        let nsize = if size > baseSize then size else baseSize in
        nsize, nalign
      in let fieldsSizeAlign = List.map getFieldSizeAlign ci.cfields in
      let folder = if ci.cstruct then foldStruct else foldUnion in
      let size, align = List.fold_left folder (0, 0) fieldsSizeAlign in
      let padding = (align - (size mod align)) mod align in
      size + padding, align

let bytesDisplacementOfField (field: fieldinfo) : int =
  let rec getPredSizeAlign fname fields prev =
    match fields with
    | [] -> prev
    | hd::tl ->
        let size, align = bytesSizeAlignOfType hd.ftype in
        let padding = (align - (prev mod align)) mod align in
        if hd.fname = fname then prev + padding
        else
          let next = prev + padding + size in
          getPredSizeAlign fname tl next
  in
  if field.fcomp.cstruct then
    getPredSizeAlign field.fname field.fcomp.cfields 0
  else
    0

let rec getSameLevelSucc (s: stmt) : stmt list =
  let listLast l =
    match l with
    | [] -> []
    | _ ->
        let len = List.length l in
        let last = List.nth l (len - 1) in
        [last]
  in
  let listHead l =
    match l with
    | [] -> []
    | hd::tl -> [hd]
  in
  match s.skind with
  | If(cond, ib, eb, loc) ->
      let bstmts = [ib.bstmts; eb.bstmts] in
      let nextLevelSucc = List.concat (List.map listHead bstmts) in
      let ret1 = List.filter (fun x -> not (List.mem x nextLevelSucc)) s.succs in
      if List.length ret1 = 0 then
        let nextLevelEnd = List.concat (List.map listLast bstmts) in
        let search prev next =
          match prev with
          | [] ->
              getSameLevelSucc next
          | _ -> prev
        in
        List.fold_left search [] nextLevelEnd
      else
        ret1
  | Switch(_, _, _, _) ->
      raise(Invalid_argument "getSameLevelSucc cannot process switch statements")
  | Loop(_, _, _, _) ->
      raise(Invalid_argument "getSameLevelSucc cannot process loop statements")
  | _ ->
      s.succs

let getSameLevelSuccTrans (s: stmt) : stmt list =
  let nl = getSameLevelSucc s in
  let rec getSLSLoop prev next =
    match next with
    | [] -> prev
    | _ -> 
        let next' = List.concat (List.map getSameLevelSucc next) in
        getSLSLoop (prev @ next) next'
  in
  getSLSLoop [] nl

(* Most part of this function was directly copied from CIL source 
   code. The only modification is that this version of visitCilFunction
   does NOT visit local and static variable initializers.
*)
let myVisitCilFunction (vis : cilVisitor) (f : fundec) : fundec =
  let childrenFunction (vis : cilVisitor) (f : fundec) : fundec = (
    f.svar <- visitCilVarDecl vis f.svar;
    let toPrepend = vis#unqueueInstr () in
    f.sbody <- visitCilBlock vis f.sbody;
    if toPrepend <> [] then 
      f.sbody.bstmts <- mkStmt (Instr toPrepend) :: f.sbody.bstmts;
    f
  ) and doVisit (vis: cilVisitor) (action: 'a visitAction)
            (children: cilVisitor -> 'a -> 'a) (node: 'a) : 'a = 
  match action with
    SkipChildren -> node
  | ChangeTo node' -> node'
  | DoChildren -> children vis node
  | ChangeDoChildrenPost(node', f) -> f (children vis node')
  in
  let f = doVisit vis (vis#vfunc f) childrenFunction f in
  let toPrepend = vis#unqueueInstr () in
  if toPrepend <> [] then 
    f.sbody.bstmts <- mkStmt (Instr toPrepend) :: f.sbody.bstmts;
  f

let processFunWithVisitorCntr (vis: fundec -> cilVisitor) 
                    (fd : fundec): unit =
    ignore(myVisitCilFunction (vis fd) fd)

let processFunWithVisitor (vis: cilVisitor) 
                    (fd : fundec): unit =
    ignore(myVisitCilFunction vis fd)

let onlyFunctions (fn: fundec -> unit) (g: global) : unit = 
  match g with
  | GFun(f, loc) -> fn f
  | _ -> ()

let applyVisitorCntr (f: file) (vis: fundec -> cilVisitor) : unit =
  vis |> processFunWithVisitorCntr |> onlyFunctions |> iterGlobals f

let applyVisitor (f: file) (vis: cilVisitor) : unit =
  vis |> processFunWithVisitor |> onlyFunctions |> iterGlobals f

let iterFunctions (f: file) (fn: fundec -> unit) : unit =
  fn |> onlyFunctions |> iterGlobals f

class printCfgInfoVisitor =
  object(self)
    inherit nopCilVisitor

    method vstmt (s: stmt) : stmt visitAction =
      E.log "%a\n" d_stmt s;
      E.log "%d -> " s.sid;
      List.iter (fun x -> E.log "%d, " x.sid) s.succs;
      E.log "\n%d <- " s.sid;
      List.iter (fun x -> E.log "%d, " x.sid) s.preds;
      E.log "\n\n";
      DoChildren
  end

class cleanEmptyBlockVisitor =
  object(self)
    inherit nopCilVisitor

    method vblock (b: block) : block visitAction =
      let isNotEmptyBlock s = 
	match s.skind with
	| Block(blk) -> List.length blk.bstmts <> 0
	| _ -> true
      in
      let cleanEmptyBlock blk =
	blk.bstmts <- List.filter isNotEmptyBlock blk.bstmts;
	blk
      in
      ignore(cleanEmptyBlock b);
      ChangeDoChildrenPost(b, cleanEmptyBlock)

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

class leafFunctionIdentifier (fd: fundec) =
  object(self)
    inherit nopCilVisitor

    val notLeaf = ref false

    method isLeaf = not !notLeaf

    method vinst (i: instr) : instr list visitAction =
      if !notLeaf then
        SkipChildren
      else
        match i with
        | Call(_, Lval(Var(vi), NoOffset), _, _) ->
            if vi.vname == fd.svar.vname then
              SkipChildren
            else (
              notLeaf := true;
              SkipChildren
             )
        | Call(_, _, _, _) ->
            notLeaf := true;
            SkipChildren
        | _ -> SkipChildren

  end
