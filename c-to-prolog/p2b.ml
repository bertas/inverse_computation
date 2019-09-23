open Cil
open Cilint
open Str

module E = Errormsg
module M = Machdep

exception Todo of string

let isSome o =
  match o with
    | Some _ -> true
    | None   -> false


let curFundec : fundec ref = ref dummyFunDec
let idCount = ref 0
let stmtCount = Cfg.start_id
let funCount = ref 0
let getNewId () = ((idCount := !idCount + 1); !idCount)

let readCounter fname =
  try
    let f = open_in fname in
      Scanf.fscanf f "%d" (fun x -> x)
  with x -> 0

let writeCounter fname (cnt : int) =
  try
    let f = open_out fname in
      Printf.fprintf f "%d\n" cnt ;
      close_out f
  with x ->
    failwith ("Failed to write counter to: " ^ fname ^ "\n")



let rec bytesSizeAlignOfType (ty: typ) : int * int =
  match ty with
  | TVoid(_) -> let size = !M.theMachine.M.sizeof_void in size, size
  | TPtr(_) -> let size = !M.theMachine.M.sizeof_ptr in size, size
  | TFloat(FFloat, _) -> let size = !M.theMachine.M.sizeof_float in size, size
  | TFloat(FDouble, _) -> let size = !M.theMachine.M.sizeof_double in size, size
  | TFloat(FLongDouble, _) -> let size = !M.theMachine.M.sizeof_longdouble in size, size
  | TFun(_) -> let size = !M.theMachine.M.sizeof_fun in size, size
  | TInt(ik, _) -> let size = bytesSizeOfInt ik in size, size
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

let noAddr = zero

let prependToBlock (is : instr list) (b : block) =
  b.bstmts <- mkStmt (Instr is) :: b.bstmts

let isPtr t =
  match unrollType t with
  | TInt (ikind, _) -> (
                       match ikind with
                      |  IULong -> false
                      | _ -> false
                      )
  | TPtr(_, _) -> true
  | _ -> false

  let isIntegral32Type t =
  match unrollType t with
  | TInt (ikind, _) -> (
                       match ikind with
                      |  IULongLong -> false
                      | _ -> true
                      )
  | _ -> false

let isSymbolicType ty = isIntegral32Type (unrollType ty)



let idType   = intType
let bidType  = intType
let fidType  = uintType
let valType  = TInt (ILongLong, [])
let addrType = TInt (IULong, [])
let boolType = TInt (IUChar, [])
let opType   = intType  (* enum *)
let argcType = intType
let argvType = TPtr(TPtr(charType, []),[])


class normalizeConditionalsVisitor =

  let isCompareOp op =
    match op with
      | Eq -> true  | Ne -> true  | Lt -> true
      | Gt -> true  | Le -> true  | Ge -> true
      | _ -> false
  in

  let negateCompareOp op =
    match op with
      | Eq -> Ne  | Ne -> Eq
      | Lt -> Ge  | Ge -> Lt
      | Le -> Gt  | Gt -> Le
      | _ ->
          invalid_arg "negateCompareOp"
  in

  let rec mkPredicate e negated =
    match e with
      | UnOp (LNot, e, _) -> mkPredicate e (not negated)

      | BinOp (op, e1, e2, ty) when isCompareOp op ->
          if negated then
            BinOp (negateCompareOp op, e1, e2, ty)
          else
            e

      | _ ->
          let op = if negated then Eq else Ne in
            BinOp (op, e, zero, intType)
  in

object (self)
  inherit nopCilVisitor

  method vstmt(s) =
    match s.skind with
      | If (e, b1, b2, loc) ->
          if (b1.bstmts == []) then b1.bstmts <- [mkEmptyStmt ()] ;
          if (b2.bstmts == []) then b2.bstmts <- [mkEmptyStmt ()] ;
          s.skind <- If (mkPredicate e false, b1, b2, loc) ;
          DoChildren

      | _ -> DoChildren

end

let addressOf : lval -> exp = mkAddrOrStartOf

let hasAddress (_, off) =
  let rec containsBitField off =
    match off with
    | NoOffset         -> false
    | Field (fi, off) -> (isSome fi.fbitfield) || (containsBitField off)
    | Index (_, off)  -> containsBitField off
  in
  not (containsBitField off)

class stack_of_str =
    object (self)
      val mutable the_list = ( [] : string list )
      method push x =
        the_list <- x :: the_list
      method pop =
        let result = List.hd the_list in
        the_list <- List.tl the_list;
        result
      method peek =
        List.hd the_list
      method size =
        List.length the_list
      method str =
        let res = String.concat "\n" the_list in
        the_list <- []; res
end

class babelAssign f =

  let returnName = ref "Void"
  and funRet = Hashtbl.create 10
  and arrayTb = Hashtbl.create 5
  and prologWhiles = new stack_of_str
  and whileCounts = Array.make 2 0
  and pl_c_count = ref 0
  and exp_count = ref 0
  and f_unique_name = "_implicit_"
  in

  let idArg   = ("id",   idType,   []) in
  let bidArg  = ("bid",  bidType,  []) in
  let fidArg  = ("fid",  fidType,  []) in
  let valArg  = ("val",  valType,  []) in
  let lvalArg  = ("lval",  valType,  []) in
  let rvalArg  = ("rval",  valType,  []) in
  let addrArg = ("addr", addrType, []) in
  let opArg   = ("op",   opType,   []) in
  let boolArg = ("b",    boolType, []) in
  let argcArg = ("argc", argcType, []) in
  let argvArg = ("argv", argvType, []) in

  let unaryOpCode op =
    let c =
      match op with
        | Neg -> 19  | BNot -> 20  |  LNot -> 21
    in
      integer c
  in

  let binaryOpCode op =
      match op with
        | PlusA   ->  0  | MinusA  ->  1  | Mult  ->  2  | Div   ->  3
        | Mod     ->  4  | BAnd    ->  5  | BOr   ->  6  | BXor  ->  7
        | Shiftlt ->  8  | Shiftrt ->  9  | LAnd  -> 10  | LOr   -> 11
        | Eq      -> 12  | Ne      -> 13  | Gt    -> 14  | Le    -> 15
        | Lt      -> 16  | Ge      -> 17
        | _ -> 18
  in

  let toAddr e = CastE (addrType, e) in

  let toValue e =
      if isPointerType (typeOf e) then
        CastE (valType, CastE (addrType, e))
      else
        CastE (valType, e)
  in

 let isCompareOp op =
    match op with
      | Eq -> true  | Ne -> true  | Lt -> true
      | Gt -> true  | Le -> true  | Ge -> true
      | _ -> false
  in

   let jcc2Const e  =
     match e with
     | BinOp (op, e1, e2, ty) when isCompareOp op -> Const(CStr "Here is a comparision")
     | _ -> e
   in

   let remove_cast_on_exp e =
     let rec aux e =
       match e with
       | CastE (t, e') ->
          aux e'
       | _ ->  e
     in
     aux e
   in


  let t_str t =
      Pretty.sprint max_int (Cil.d_type () t) in

  let has1 s1 s2 =
    let re = Str.regexp_string s2 in
    try ignore (Str.search_forward re s1 0); true
    with Not_found -> false
  in

  let e_size e =
    let rec size_v t =
        match unrollType t with
        | TInt (ik, _) ->
          bytesSizeOfInt ik
        | TPtr (t, _) ->
         !M.theMachine.M.sizeof_ptr
        | TComp _ ->  8 
        | TEnum _ ->  4
        | TFloat (fk, _) ->
          begin
            match fk with
            | FDouble -> 8
            | FFloat -> 4
          end
        | _ -> (print_string (t_str t); failwith "type not supported 3") in
    let rec size_m t =
        match unrollType t with
        | TInt (ik, _) ->
          bytesSizeOfInt ik
        | TPtr (t, _) ->
          size_m t
        | TComp _ ->  8 
        | TEnum _ ->  4
        | TFloat (fk, _) ->
          begin
            match fk with
            | FDouble -> 8
            | FFloat -> 4
          end
        | TArray (bt, Some len, _) ->
           begin
             let r =
             match constFold true len with
             | Const(CInt64(l,lk,_)) ->
	            let sz = mul_cilint (mkCilint lk l) (cilint_of_int  (bitsSizeOf bt)) in
                cilint_to_int sz
             | _ -> failwith "undefined length"
             in
             r / 8
           end
        | _ ->
           (print_endline (t_str t); failwith "type not supported 4")
    in
    let is_onelevel_ptr v =
      let ts = t_str v.vtype in
        print_endline ts;
        if has1 ts "**" then false
        else true in
      match e with
      | Lval (Var v, _) -> size_v v.vtype
      | Lval (Mem e, _) ->
         begin
           match e with
           | Lval (lh', _) ->
              begin
                match lh' with
                | Var v' ->
                   if is_onelevel_ptr v' = true then
                     size_m v'.vtype
                   else
                     !M.theMachine.M.sizeof_ptr
                | _ -> failwith " ** type not supported 5"
              end
           | _ -> failwith "type not supported 2"
         end
      | _ ->
         failwith "undefined size of exp"
  in





  let p_sizeof e =
    let rec size t =
      match unrollType t with
      | TVoid _ -> 1
      | TInt (ik, _) -> bytesSizeOfInt ik
      | TPtr (t, _) -> size t
      | TComp _ -> fst (bytesSizeAlignOfType t)
      | TArray _ -> failwith "undefined array size"
      | TFun _ -> 1
      | TFloat (fk, _) ->
          begin
            match fk with
            | FDouble -> 8
            | FFloat -> 4
          end
      | _ -> failwith ((t_str t)^"type not supported in ptr_arith")
    in
    let rec aux e =
      match e with
      | SizeOf(t) -> size t
      | SizeOfE(e) ->
         e_size e
      | _ -> failwith "undefined sizeof expression"
    in
    aux e
  in


  let e_str e =
    let rec aux e =
      (* get rid of type cast *)
    match e with
    | CastE (t, e') ->
       aux e'
    | Const c ->
       begin
         match c with
         | CInt64 (i, k, l) ->
            begin
              match k with
                | IULong -> Const (CInt64 (i, IInt, l))
                | IUInt -> Const (CInt64 (i, IInt, l))
                | ILong -> Const (CInt64 (i, IInt, l))
                | _ -> e
            end
         | _ -> e
       end
    (* for pointer arithmetic *)
    | BinOp (op, e1, e2, t) when op == PlusPI ->
       BinOp (op, aux e1, aux e2, t)
    | BinOp (op, e1, e2, t) ->
       BinOp (op, aux e1, aux e2, t)
    | _ -> e
    in
    match e with
    | SizeOf _ | SizeOfE _ -> string_of_int (p_sizeof e)
    | _ ->
       begin
         aux e
         |> (fun e ->
             Pretty.sprint max_int (Cil.d_exp () e)
            )
       end
  in

  let lv_str lv =
      Pretty.sprint max_int (Cil.d_lval () lv) in

  let op_str op =
      Pretty.sprint max_int (Pretty.num (binaryOpCode op)) in

  let loc_str loc =
      Pretty.sprint max_int (Cil.d_loc () loc) in


  let c_str t =
      Pretty.sprint max_int (Cil.d_const () t) in

object (self)
  val mutable has_mem_instrs : bool = false
  val mutable func_name : string = ""
  val mutable white_list : string list = []
  val mutable plinter_list: string list = [] (* unify pl interface*)
  val mutable cur_ret_type : string = ""
  inherit nopCilVisitor


  method update_whitelist =
    let aux s1 s2 =
      let re = Str.regexp_string s2 in
      try ignore (Str.search_forward re s1 0); true
      with Not_found -> false
    in
    let read_file filename =
      let lines = ref [] in
      let chan = open_in filename in
      try
        while true; do
          lines := input_line chan :: !lines
        done; []
      with End_of_file ->
        close_in chan;
        List.rev !lines in
    let il = read_file "babel_funclist.txt" in
    List.filter (fun l -> (aux l "#") == false) il

  method mkAssign lv e =
    let lv_str i =
      Pretty.sprint max_int (Cil.d_lval () i)
    and e_str i =
      Pretty.sprint max_int (Cil.d_exp () i)
    in
      (String.uppercase (lv_str lv))^" is "^( String.uppercase (e_str e))^","

  method mkPtrGet lv e =
    let lv_str i =
      Pretty.sprint max_int (Cil.d_lval () i)
    and e_str i =
      Pretty.sprint max_int (Cil.d_exp () i)
    in
      "babelPtrGet("^(String.uppercase (lv_str lv))^", "^(String.uppercase (e_str e))^"),"

  method mkPtrSet lv e =
    let lv_str i =
      Pretty.sprint max_int (Cil.d_lval () i)
    and e_str i =
      Pretty.sprint max_int (Cil.d_exp () i)
    in
      "babelPtrSet("^(String.uppercase (lv_str lv))^", "^(String.uppercase (e_str e))^"),"

  method mkPtrInit lv rv =
    let lv_str i =
      Pretty.sprint max_int (Cil.d_lval () i) in
        "babelPtrInit("^(String.uppercase (lv_str lv))^", "^(String.uppercase (rv.vname))^"),"

  method babel_getaddr lv =
    let lv_str i =
      Pretty.sprint max_int (Cil.d_lval () i) in
        "babel_getaddr("^(lv_str lv)^", Addr),"

  method babel_setvalue lv =
    let lv_str i =
      Pretty.sprint max_int (Cil.d_lval () i) in
        "babel_setvalue("^(lv_str lv)^", Val),"

  method babel_getvalue e =
    let e_str i =
      Pretty.sprint max_int (Cil.d_exp () i) in
        match e with
        (*
        | Const ->
         *)
        | _ ->
        "babel_getvalue("^(e_str e)^", Val),"

  method has s1 s2 =
    let re = Str.regexp_string s2 in
    try ignore (Str.search_forward re s1 0); true
    with Not_found -> false

  method singleArg count arg =
      let name = "arg_"^(string_of_int !count) in
        count := !count + 1;
        arg^" "^name

    method singleArg1 arg =
      let name = arg.vname in
      let t = t_str arg.vtype in
        t^" "^name

  method cargList (elist : exp list) =
      let tl = self#expl_to_ctypel elist
      and c = ref 0 in
      let args = List.map (self#singleArg c) tl in
        String.concat ", " args

  method ret lv =
     let t_str t =
       Pretty.sprint max_int (Cil.d_type () t) in
     let ty = self#getTypefromLval lv in
     match ty with
     | TVoid _ -> ""
     |  _ -> t_str ty

  method createRet lv =
    let aux =
      match cur_ret_type with
        | "float" -> "double "
        | "string" -> "char* "
        | _ -> "PlLong "
    in
  let rt = self#ret lv in
      if rt = "" then ""
      else
        let rname = "* babel_ret" in
        aux^rname

  method varList elist =
      let count = ref (-1) in
      let names = List.map (
                        fun v -> (count := !count + 1; "arg_"^(string_of_int !count))
                        ) elist in
        String.concat ", " names

  method createCall fexp elist =
    let is_fp fn =
      if self#has fn "__cil_" && self#has fn "_ssa_" then
        true
      else false in
    let fn = e_str fexp in
      match is_fp fn with
      | false ->
        begin
          let vars = self#varList elist in
          if vars = "" then "*babel_ret = "^fn^"();\nreturn PL_TRUE;"
          else
            let vars1 = self#removeLastChar vars in
            "*babel_ret = "^fn^"("^vars1^");\nreturn PL_TRUE;"
        end
      | true ->
        begin
          let vars = self#varList elist in
          let len = List.length elist in
          let fn' = "arg_"^(string_of_int len) in
          if vars = "" then "*babel_ret = "^fn'^"();\nreturn PL_TRUE;"
          else
            let vars1 = self#removeLastChar vars in
            "*babel_ret = "^fn'^"("^vars1^");\nreturn PL_TRUE;"
        end



 method createCallNoRet fexp elist =
      let fname = e_str fexp in
      let vars = self#varList elist in
        fname^"("^vars^");\nreturn PL_TRUE;"

  method createCInterface lv fexp elist =
    let is_fp fn =
      if self#has fn "__cil_" && self#has fn "_ssa_" then
        true
      else false in
    let cn fexp =
      let fname = "c_"^(string_of_int !pl_c_count) in
        "PlBool babel_"^f_unique_name^""^func_name^""^fname in
    let elist' =
      match is_fp (e_str fexp) with
      | false -> elist
      | true -> elist@[fexp] in
    let args = self#cargList elist'
    and ret = self#createRet lv
    and name = cn fexp
    and call = self#createCall fexp elist in
      if args <> "" && ret <> "" then
        name^"("^args^", "^ret^") \n{\n"^call^"\n}"
      else if args = "" && ret = "" then
        name^"(int dumy) \n{\n"^call^"\n}"
      else
        name^"("^args^ret^") \n{\n"^call^"\n}"

  method createCInterfaceNoRet fexp elist =
    let cn fexp =
      let fname = "c_"^(string_of_int !pl_c_count) in
        "PlBool babel_"^f_unique_name^""^func_name^""^fname in
    let args = self#cargList elist
    and name = cn fexp
    and call = self#createCallNoRet fexp elist in
      if args = "" then
        name^"(int dumy) \n{\n"^call^"\n}"
      else
        name^"("^args^") \n{\n"^call^"\n}"

  method cTypeToPlType t =
    let rec helper t =
      match t with
      | TFun _ -> "integer"
      | TVoid _ -> "integer"
      | TInt (ik, _) ->
        begin match ik with
        | IChar -> "integer"
        | ISChar -> "integer"
        | IUChar -> "integer"
        | IBool -> "boolean"
        | IInt -> "integer"
        | IUInt -> "positive"
        | IShort -> "short"
        | IUShort -> "integer"
        | ILong -> "integer"
        | IULong -> "positive"
        | ILongLong -> "integer"
        | IULongLong -> "integer"
        | _ -> (print_string (t_str t); failwith "Errormsg")
        end
      | TFloat (fk, _) ->
        begin match fk with
        | FFloat | FDouble -> "float"
        | FLongDouble -> "float"
        end
      | TPtr (t',_)  ->
          begin
              match helper t' with
              (* | "char" | "string" -> "string" *)
              | s -> "integer"
          end
      | TNamed (t', _) -> self#cTypeToPlType t'.ttype
      | TComp _ -> "struct"
      | TEnum _ -> "integer"
      | _ ->
        let s =  t_str t in
          failwith ("CTypeToPType failed "^s) in
        helper t

  method pp_print elist =
      let estrs = List.map e_str elist in
        List.iter print_string estrs

  method expl_to_pltypel elist =
    (* let () = self#pp_print elist in *)
    let p = object
      val mutable vl = []
      method setter e =
        let rec helper e =
          match e with
           | Lval(Var v, _) -> (
                                vl <- (self#cTypeToPlType v.vtype)::vl; ()
                               )
           | Lval(Mem e, _) -> helper e
           | Const c ->
                      (
                        match c with
                        | CInt64 _ -> (vl <- "integer"::vl; ())
                        | CStr _ -> (vl <- "string"::vl; ())
                        | CReal _ -> (vl <- "float"::vl; ())
                        | CChr _ -> (vl <- "integer"::vl; ())
                        | _ -> failwith "unsupported constant type in expl to typel"
                      )
           | CastE (t,_) -> (
                                vl <- (self#cTypeToPlType t)::vl; ()
                            )
           | _ -> (print_string ((e_str e)^" in the exp to varinfo"); ())
          in helper e
      method getter = List.rev vl
    end in
      List.iter p#setter elist;
      p#getter


  method expl_to_ctypel elist =
    let p = object
      val mutable vl = []
      method setter e =
        let rec helper e =
          match e with
           | Lval(Var v, _) -> (
                                vl <- (t_str v.vtype)::vl; ()
                               )
           | Lval(Mem e, _) -> helper e
           | Const c ->
                      (
                        match c with
                        | CInt64 _ -> (vl <- "int"::vl; ())
                        | CStr _ -> (vl <- "char*"::vl; ())
                        | CReal _ -> (vl <- "float"::vl; ())
                        | CChr _ -> (vl <- "char"::vl; ())
                        | _ -> failwith "unsupported constant type in expl to typel"
                      )
           | CastE (t,_) ->
                            (
                              vl <- (t_str t)::vl; ()
                            )
            | SizeOf _   -> (vl <- "int"::vl; ())
            | SizeOfE _  -> (vl <- "int"::vl; ())
            | SizeOfStr _ -> (vl <- "int"::vl; ())
            | _ -> (failwith ((e_str e)^" in the exp to varinfo"); ())
          in helper e
      method getter = List.rev vl
    end in
      List.iter p#setter elist;
      p#getter


  method plArgList (elist:exp list) =
      let args = self#expl_to_pltypel elist in
      let args1 = List.map (fun s -> "+"^s) args in
       String.concat ", " args1

  method getTypefromLval (lv : lhost*offset) =
    match lv with
    | (Var vi, _) -> vi.vtype
    | _ ->
       begin
       print_endline (lv_str lv);
       failwith " : undefined type in getTypefromLval"
       end

  method plRet t =
    let ty = self#getTypefromLval t in
      match ty with
      | TVoid _ -> ""
      | _ ->
         let s = self#cTypeToPlType ty in
         cur_ret_type <- s;
         " -"^s

  method createPlInterface lv fexp elist =
    let is_fp fn =
      if self#has fn "__cil_" && self#has fn "_ssa_" then
        true
      else false in
    let fn = e_str fexp in
      match is_fp fn with
      | false ->
        begin
          let args = self#plArgList elist
          and ret = self#plRet lv
          and name = "c_"^(string_of_int !pl_c_count) in
            let res = (
              if args <> "" && ret <> "" then
              ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"("^args^", "^ret^"))."
              else if args = "" && ret = "" then
              ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"(+integer))."
              else
              ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"("^args^ret^"))."
            ) in
          if List.mem res plinter_list then ""
          else (plinter_list <- res::plinter_list; res)
        end
      | true ->
        begin
          let args = self#plArgList (elist@[fexp])
          and ret = self#plRet lv
          and name = "c_"^(string_of_int !pl_c_count) in
            let res = (
              if args <> "" && ret <> "" then
              ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"("^args^", "^ret^"))."
              else if args = "" && ret = "" then
              ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"(+integer))."
              else
              ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"("^args^ret^"))."
            ) in
          if List.mem res plinter_list then ""
          else (plinter_list <- res::plinter_list; res)
        end

  method createPlInterfaceNoRet fexp elist =
    let is_fp fn =
      if self#has fn "__cil_" && self#has fn "_ssa_" then
        true
      else false in
    let fn = e_str fexp in
      match is_fp fn with
      | false ->
        begin
          let args = self#plArgList elist
          and name = "c_"^(string_of_int !pl_c_count) in
          let res = (
            if args = "" then
                ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"(+integer))."
            else
            ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"("^args^"))."
          ) in
          if List.mem res plinter_list then ""
          else (plinter_list <- res::plinter_list; res)
        end
      | true ->
        begin
          let args = self#plArgList (elist@[fexp])
          and name = "c_"^(string_of_int !pl_c_count) in
          let res = (
            if args = "" then
                ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"(+integer))."
            else
            ":- foreign(babel_"^f_unique_name^""^func_name^""^name^"("^args^"))."
          ) in
          if List.mem res plinter_list then ""
          else (plinter_list <- res::plinter_list; res)
        end

  method mkCall lv fexp elist =
    let funName = e_str fexp in
      if List.mem funName white_list (* this is a prolog function*)
      (* then self#mkPrologCall lv fexp elist *)
      then self#mkCCall lv fexp elist  (* let's put a "babel_" as prefix *)
      else self#mkCCall lv fexp elist  (* let's put a "babel_" as prefix *)

  method mkCallNoRet fexp elist =
    let funName = e_str fexp in
      if List.mem funName white_list (* this is a prolog function*)
       then self#mkCCallNoRet fexp elist (* this is a c function*)
        (* then self#mkPrologCallNoRet fexp elist *)
      else
        self#mkCCallNoRet fexp elist (* this is a c function*)

  method mkPrologCall lv fexp elist =
    pl_c_count := !pl_c_count + 1;
        let funName = e_str fexp in
        let fn' = self#prolog_func_modify funName in
        let lvName   = lv_str lv
        and elistStr = List.map e_str elist in
        let argsStr  = String.concat ", " elistStr in
        if argsStr = "" then
        fn'^"("^(String.uppercase lvName)^"),"
      else
        fn'^"("^(String.uppercase argsStr)^" , "^(String.uppercase lvName)^"),"

(* ingore functions begin with babel_wrapper_ *)
  method mkPrologCallNoRet fexp elist =
    pl_c_count := !pl_c_count + 1;
      let funName = e_str fexp in
       let fn' = self#prolog_func_modify funName in
        let elistStr = List.map e_str elist in
        let argsStr  = String.concat ", " elistStr in
        if argsStr   = "" then
          fn'^"(VOID),"
        else
          fn'^"("^(String.uppercase argsStr)^", VOID),"

  method mkCCall lv fexp elist =
    let is_fp fn =
      if self#has fn "__cil_" && self#has fn "_ssa_" then
        true
      else false in
    let fn = e_str fexp in
      match is_fp fn with
      | false ->
        begin
          let helper e =
            match e with
            | Const _ -> e_str (constFold true e)
            | _ -> String.uppercase (e_str (constFold true e)) in
          let name = "c_"^(string_of_int !pl_c_count) in
          pl_c_count := !pl_c_count + 1;
          let lvName   = lv_str lv
          and elist_s = List.map helper elist in
          let args_s = String.concat ", " elist_s in
          if args_s = "" && lvName = "" then
            "babel_"^f_unique_name^""^func_name^""^name^"(0),"
          else if args_s = "" then
            "babel_"^f_unique_name^""^func_name^""^name^"("^(String.uppercase lvName)^"),"
          else
            "babel_"^f_unique_name^""^func_name^""^name^"("^args_s^" , "^(String.uppercase lvName)^"),"
        end
      | true ->
        begin
          let helper e =
            match e with
            | Const _ -> e_str (constFold true e)
            | _ -> String.uppercase (e_str (constFold true e)) in
          let name = "c_"^(string_of_int !pl_c_count) in
          pl_c_count := !pl_c_count + 1;
          let lvName   = lv_str lv
          and elist_s = List.map helper (elist@[fexp]) in
          let args_s = String.concat ", " elist_s in
          if args_s = "" && lvName = "" then
            "babel_"^f_unique_name^""^func_name^""^name^"(0),"
          else if args_s = "" then
            "babel_"^f_unique_name^""^func_name^""^name^"("^(String.uppercase lvName)^"),"
          else
            "babel_"^f_unique_name^""^func_name^""^name^"("^args_s^" , "^(String.uppercase lvName)^"),"
        end


(* ingore functions begin with babel_wrapper_ *)
  method mkCCallNoRet fexp elist =
    let is_fp fn =
      if self#has fn "__cil_" && self#has fn "_ssa_" then
        true
      else false in
    let fn = e_str fexp in
      match is_fp fn with
      | false ->
        begin
          let helper e =
            match e with
            | Const c ->
                        begin
                         match c with
                          | CStr _ -> Str.global_replace (Str.regexp "\"") "'" (e_str (constFold true e))
                          | _ -> (e_str (constFold true e))
                        end
            | _ -> String.uppercase (e_str (constFold true e)) in
          let name = "c_"^(string_of_int !pl_c_count) in
          pl_c_count := !pl_c_count + 1;
            let elist_s = List.map helper elist in
            let args_s = String.concat ", " elist_s in
            if args_s = "" then
              "babel_"^f_unique_name^""^func_name^""^name^"(0),"
            else
              "babel_"^f_unique_name^""^func_name^""^name^"("^args_s^"),"
        end
      | true ->
        begin
          let helper e =
            match e with
            | Const c ->
                        begin
                         match c with
                          | CStr _ -> Str.global_replace (Str.regexp "\"") "'" (e_str (constFold true e))
                          | _ -> (e_str (constFold true e))
                        end
            | _ -> String.uppercase (e_str (constFold true e)) in
          let name = "c_"^(string_of_int !pl_c_count) in
          pl_c_count := !pl_c_count + 1;
            let elist_s = List.map helper (elist@[fexp]) in
            let args_s = String.concat ", " elist_s in
            if args_s = "" then
              "babel_"^f_unique_name^""^func_name^""^name^"(0),"
            else
              "babel_"^f_unique_name^""^func_name^""^name^"("^args_s^"),"
        end


  method insertInCFile c =
     let oc = open_out_gen [Open_append; Open_creat] 0o666  "babel.c" in
        Printf.fprintf oc "%s\n" c;
      close_out oc

  method insertInPlFile pl =
     let oc = open_out_gen [Open_append; Open_creat] 0o666  "babel.pl" in
        Printf.fprintf oc "%s\n" pl;
      close_out oc


  method is_logic e =
    let help_t t =
      match t with
       | TInt (ik,_) ->
          begin
            match ik with
            | IBool -> true
            | _ -> false
          end
       | _ -> false
    and help_op_bin op =
      match op with
        | Lt | Gt | Le | Ge | Eq | Ne
        | BXor | BOr | LAnd | LOr -> true
        | _ -> false
    and help_op_un op =
      match op with
        | Neg | BNot | LNot -> true
        | _ -> false in
    match e with
      | BinOp (op, _, _, t) -> help_op_bin op
      | UnOp (LNot, _, t) -> true
      | UnOp (op, _, t) -> false
        (*  help_op_un op *)
      | _ -> false

  method is_unop e =
    match e with
      | UnOp (op, e, t) -> true
      | _ -> false


  method babel_exp lv e =
    let arr_help lv =
      let split = Str.split (Str.regexp_string "[") in
      let n = lv_str lv in
      let items = split n in
        let n' = List.nth items 0 in
          let n0 = String.sub n' 0 (String.length n' - 2) in
        if Hashtbl.mem arrayTb n0 then n0
      else (print_string n; failwith "undefined array in arr_help")
    and arr_index lv n =
      let n' = lv_str lv in
        String.sub n' (String.length n) 2 in
    let arr_help1 lv =
      let n = arr_help lv in
        let i = arr_index lv n in
          String.uppercase (n^i) in
    let bool_helper lv e =
      match e with
      | BinOp (op, e1, e2, ty) ->
        begin
          let conds = self#mkCondStr op e1 e2 in
          let str1 = "\n("^conds^" ->\n"
          and str2 = (String.uppercase (lv_str lv))^" is 1"
          and str3 = (String.uppercase (lv_str lv))^" is 0" in
          (*
          and str2 = "babelAssign("^(String.uppercase (lv_str lv))^", 1)"
          and str3 = "babelAssign("^(String.uppercase (lv_str lv))^", 0)" in
           *)
          str1^str2^"\n; "^str3^"),\n"
        end
      | UnOp (op, e, ty) ->
          begin
            let e0 =  Const(CInt64(Int64.zero, IInt, None)) in
            let conds = self#mkCondStr Eq e e0 in
            let str1 = "\n("^conds^" ,\n"
            and str2 = (String.uppercase (lv_str lv))^" is 1"
            and str3 = (String.uppercase (lv_str lv))^" is 0" in
            (*
            and str2 = "babelAssign("^(String.uppercase (lv_str lv))^", 1)"
            and str3 = "babelAssign("^(String.uppercase (lv_str lv))^", 0)" in
             *)
            str1^str2^"\n; "^str3^"),\n"
          end
      | _ -> failwith "bool expression doesn't support in babel_exp" in
    let rec helper lv e =
      match e with
      | CastE (t, e') ->
        helper lv e'
      | StartOf (Mem e', off) ->
         let es = String.uppercase (e_str e') in
         print_string ("identified common right value : "^es^"\n");
         (* "babelAssign("^(String.uppercase (lv_str lv))^", "^es^")," *)
         (String.uppercase (lv_str lv))^" is "^es^","
      | Lval (Mem e', off) ->
              print_endline ("identified right pointer : "^(e_str e'));
              let es = string_of_int (self#ptr_size lv) in
              let es' = self#is_float lv in
              let et = self#exp_solver e' in
              let temp_val = self#get_temp_lv in
              let inter = self#pointer_r_interface es in
              if es' = 2 then
                et^"babel_ptrFR("^(String.uppercase (lv_str lv))^", "^temp_val^",2),"
              else if es' = 1 then
                et^"babel_ptrFR("^(String.uppercase (lv_str lv))^", "^temp_val^",1),"
              else
                et^inter^"("^(String.uppercase (lv_str lv))^", "^temp_val^", "^es^"),"
      | Const c ->
            begin
              match c with
              | CStr _ ->
                let es = Str.global_replace (Str.regexp "\"") "'" (e_str e) in
                  "babelAssignStr("^(String.uppercase (lv_str lv))^", "^es^"),"
              | _ ->
                begin
                  print_endline ("identified common right pointer : "^(e_str e));
                 (* "babelAssign("^(String.uppercase (lv_str lv))^", *)
                 (* "^(String.uppercase (e_str e))^")," *)
                  (String.uppercase (lv_str lv))^" is "^(String.uppercase (e_str e))^","
                end
            end
      | Lval (Var vi, off) ->
        (
          match vi.vtype with
            | TArray _ ->
              let rv = (Var vi, off)
              and i = match off with
                | Index (e', _) -> String.uppercase (e_str e')
                | _ -> failwith "unhandled offset of array" in
                "babelArrayR("^(String.uppercase (lv_str lv))^", "^(vi.vname)^", "^i^"),"
            | _ ->
              begin
               print_string ("identified lval exp: "^(e_str e)^"\n");
             (* "babelAssign("^(String.uppercase (lv_str lv))^", *)
             (* "^(String.uppercase (e_str e))^")," *)
              (String.uppercase (lv_str lv))^" is "^(String.uppercase (e_str e))^","
              end
        )
      | _ ->
        print_endline ("identified common right value : "^(e_str e));
        let et = self#exp_solver e in
        let temp_val = self#get_temp_lv in
       (* et^"babelAssign("^(String.uppercase (lv_str lv))^", "^temp_val^")," *)
       (* in *)
        et^(String.uppercase (lv_str lv))^" is "^temp_val^"," in
        if self#is_logic e then bool_helper lv e
        else helper lv e


  method babel_rptr e =
    let e_p = object(eself)
      inherit nopCilVisitor
        val mutable is_arith : bool = false
        method res = is_arith
        method vexpr e' =
          match e' with
          | Lval (Mem e', _) -> (is_arith <- false; SkipChildren)
          | StartOf (lh, _)
          | Lval (lh, _) ->
            begin
              match lh with
               | Var vn ->
                  (print_endline ("this is "^(vn.vname));
                   is_arith <- true; SkipChildren)
               | _ -> (is_arith <- false; SkipChildren)
            end
          | _ -> DoChildren
        end in
        ignore(visitCilExpr (e_p :> cilVisitor) e);
        e_p#res


  method babel_ptr_arith lv e =
    print_endline "in babel ptr arith";
    let rec size t =
      match unrollType t with
      | TVoid _ -> 1
      | TInt (ik, _) -> bytesSizeOfInt ik
      | TPtr (t, _) -> size t
      | TComp _ -> fst (bytesSizeAlignOfType t)
      | TArray _ -> 9
      | TFun _ -> 1
      | TFloat (fk, _) ->
          begin
            match fk with
            | FDouble -> 8
            | FFloat -> 4
          end
      | _ -> failwith ((t_str t)^"type not supported in ptr_arith") in
    let aux_s s1 s2 =
      let re = Str.regexp_string s2 in
      try ignore (Str.search_forward re s1 0); true
      with Not_found -> false
    in
    let ptr_collector = object
      inherit nopCilVisitor
        val mutable len : int = (-1)
        method get_ptr_len = len
        method vexpr e =
          let rec aux e =
            match e with
            | StartOf (lh, _)
            | Lval (lh, _) ->
               begin
                 match lh with
                 | Mem e -> failwith "undefined ptr collector"
                 | Var v ->
                    let rec aux1 t =
                      match t with
                      | TArray (ty, _, _) ->
                         begin
                           print_string ("find array " ^ v.vname);
                           print_endline (" type : " ^ (t_str ty));
                           if len = -1 then
                             let s = t_str ty in
                             len <-
                               if aux_s s "*" then
                                 8
                               else
                                 size (ty);
                           else
                             failwith "multiple pointer in expression"
                         end;
                         SkipChildren
                      | TPtr _ ->
                         begin
                           if len = -1 then
                             let s = t_str v.vtype in
                             print_string "adsasd ";
                             print_endline s;
                             len <-
                               if aux_s s "**" then
                                 8
                               else
                                 size (v.vtype);
                           else
                             failwith "multiple pointer in expression"
                         end;
                         SkipChildren
                      | TNamed (t', _) -> aux1 t'.ttype
                      | _ -> SkipChildren
                    in
                    aux1 v.vtype
                 | _ -> SkipChildren
               end
            | _ ->
               DoChildren
          in
          match e with
          | CastE (t, e') ->
             begin
               aux e';
               len <-
                 if len = -1 then
                   -1
                 else
                   size(t);
             end;
             SkipChildren
          | _ ->
             aux e
      end in
    let pl =
      match e with
      | CastE (t, e') ->
         begin
           (* aux e'; *)
           ignore(visitCilExpr (ptr_collector :> cilVisitor) e');
           ptr_collector#get_ptr_len
         end
      | _ ->
         begin
           ignore(visitCilExpr (ptr_collector :> cilVisitor) e);
           ptr_collector#get_ptr_len
         end
    in
        (* ignore(visitCilLval (ptr_collector :> cilVisitor) lv);
        ignore(visitCilExpr (ptr_collector :> cilVisitor) e);
        let pl = ptr_collector#get_ptr_len in
        *)
          if pl = (-1) then
            begin
              print_endline (e_str e);
              self#babel_exp lv e
            end
          else
            begin
              let is_mem_write = function
                | Mem _ -> true
                | _ -> false
              in
              let ptr_mem_write = function
                | Mem e -> e_str e
                | _ -> failwith "undefined"
              in
              let pl_s = (string_of_int pl)^"*"
              and exp_s = e_str e in
              let exp_s1 = Str.global_replace (Str.regexp "+") ("+"^pl_s) exp_s in
              let exp_s2 = Str.global_replace (Str.regexp "-") ("-"^pl_s) exp_s1 in
              match is_mem_write (fst lv) with
                | false ->
                   print_endline ("ptr arith "^(e_str e));
                   (* "babelAssign("^(String.uppercase (lv_str lv))^", *)
                   (* "^(String.uppercase exp_s2)^")," *)
                   (String.uppercase (lv_str lv))^" is "^(String.uppercase exp_s2)^","
                | true ->
                   print_endline "identified left pointer in ptr arith";
                   let es = string_of_int (self#ptr_size lv) in
                   let es' = self#is_float lv in
                   let vn = ptr_mem_write (fst lv) in
                   let ess =
                     (String.uppercase exp_s2)
                   in
                   let et = self#exp_solver_str ess in
                   let temp_val = self#get_temp_lv in
                   if es' = 2 then
                     et^"babel_ptrFW("^(String.uppercase vn)^", "^temp_val^",2),"
                   else if es' = 1 then
                     et^"babel_ptrFW("^(String.uppercase vn)^", "^temp_val^",1),"
                   else
                     et^"babel_ptrE("^(String.uppercase vn)^", "^temp_val^", "^es^"),"
            end


    method ptr_size1 (p : (Cil.lhost * Cil.offset)) : int * int =
      let rec bytesSizeAlignOfType (ty: typ) : int * int =
        match ty with
        | TVoid(_) -> let size = !M.theMachine.M.sizeof_void in size, size
        | TPtr(_) -> let size = !M.theMachine.M.sizeof_ptr in size, size
        | TFloat(_) -> let size = !M.theMachine.M.sizeof_float in size, size
        | TFun(_) -> let size = !M.theMachine.M.sizeof_fun in size, size
        | TInt(ik, _) -> let size = bytesSizeOfInt ik in size, size
        | TEnum(_) -> let size = !M.theMachine.M.sizeof_int in size, size
        | TArray(ty, Some(Const(CInt64(l, _, _))), _) ->
            let baseSize, baseAlign = bytesSizeAlignOfType ty in
            (Int64.to_int l) * baseSize, baseAlign
        | TNamed(ti, _) ->
            bytesSizeAlignOfType ti.ttype
        | TArray(_, _, _) ->
            raise(Todo("Size of unfixed-length array cannot be computed"))
        | TBuiltin_va_list(_) ->
            raise(Todo("Size of varg list cannot be computed"))
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
            size + padding, align in
    let is_onelevel_ptr v =
      let ts = t_str v.vtype in
        print_string (ts^"\n");
        if self#has ts "**" then false
        else true in
    let rec lhost lh =
      match lh with
      | Var v -> bytesSizeAlignOfType v.vtype
      | Mem e -> begin
                  match e with
                  | Lval (lh', _) ->
                    begin
                      match lh' with
                      | Var v' ->
                        if is_onelevel_ptr v' = true then
                          bytesSizeAlignOfType v'.vtype
                        else
                         !M.theMachine.M.sizeof_ptr, 0
                      | _ -> failwith " ** type not supported 4"
                    end
                  | _ -> failwith "type not supported 2"
                 end in
    match p with
    | (lh, _) -> lhost lh
    | _ -> failwith "type not supported 1"


    method is_float p =
     let rec size_v t =
         match unrollType t with
         | TFloat (fk, _) ->
           begin
             match fk with
             | FDouble -> 2
             | FFloat -> 1
           end
         | _ -> 0
     in
     let rec size_m t =
         match unrollType t with
         | TPtr (t, _) ->
           size_m t
         | TFloat (fk, _) ->
           begin
             match fk with
             | FDouble -> 2
             | FFloat -> 1
           end
         | _ -> 0
     in
     let is_onelevel_ptr v =
       let ts = t_str v.vtype in
         print_endline ts;
         if self#has ts "**" then false
         else true in
     let rec lhost lh =
       match lh with
       | Var v -> size_v v.vtype
       | Mem e -> begin
                   match e with
                   | Lval (lh', _) ->
                     begin
                       match lh' with
                       | Var v' ->
                         if is_onelevel_ptr v' = true then
                           size_m v'.vtype
                         else
                           0
                       | _ -> failwith " ** type not supported 4"
                     end
                   | _ -> failwith "type not supported 2"
                  end in
     match p with
     | (lh, _) -> lhost lh
     | _ -> failwith "type not supported 1"



  method ptr_size (p : (Cil.lhost * Cil.offset)) : int =
    let rec size_v t =
        match unrollType t with
        | TInt (ik, _) ->
          bytesSizeOfInt ik
        | TPtr (t, _) ->
         !M.theMachine.M.sizeof_ptr
        | TComp _ ->  8 
        | TEnum _ ->  4
        | TFloat (fk, _) ->
          begin
            match fk with
            | FDouble -> 8
            | FFloat -> 4
          end
        | _ -> (print_string (t_str t); failwith "type not supported 3") in
    let rec size_m t =
        match unrollType t with
        | TInt (ik, _) ->
          bytesSizeOfInt ik
        | TPtr (t, _) ->
          size_m t
        | TComp _ ->  8 
        | TEnum _ ->  4
        | TFloat (fk, _) ->
          begin
            match fk with
            | FDouble -> 8
            | FFloat -> 4
          end
        | _ -> (print_string (t_str t); failwith "type not supported 3") in
    let is_onelevel_ptr v =
      let ts = t_str v.vtype in
        print_endline ts;
        if self#has ts "**" then false
        else true in
    let rec lhost lh =
      match lh with
      | Var v -> size_v v.vtype
      | Mem e -> begin
                  match e with
                  | Lval (lh', _) ->
                    begin
                      match lh' with
                      | Var v' ->
                        if is_onelevel_ptr v' = true then
                          size_m v'.vtype
                        else
                         !M.theMachine.M.sizeof_ptr
                      | _ -> failwith " ** type not supported 4"
                    end
                  | _ -> failwith "type not supported 2"
                 end in
    match p with
    | (lh, _) -> lhost lh
    | _ -> failwith "type not supported 1"


  method exp_size e =
    let rec size_v t =
        match unrollType t with
        | TInt (ik, _) ->
          bytesSizeOfInt ik
        | TPtr (t, _) ->
          !M.theMachine.M.sizeof_ptr
        | TEnum _ ->  4
        | _ -> (print_string (t_str t); failwith "type not supported 3") in
    let rec size_m t =
        match unrollType t with
        | TInt (ik, _) ->
          bytesSizeOfInt ik
        | TPtr (t, _) ->
          size_m t
        | TEnum _ ->  4
        | _ -> (print_string (t_str t); failwith "type not supported 3") in
    let rec lhost lh =
      match lh with
      | Var v -> size_v v.vtype
      | Mem e -> begin
                  match e with
                  | Lval (lh', _) ->
                    begin
                      match lh' with
                      | Var v' -> size_m v'.vtype
                      | _ -> failwith " ** type not supported 4"
                    end
                  | _ -> failwith "type not supported 2"
                 end in
    match e with
    | Lval (lh, _) -> lhost lh
    | _ -> (print_string (e_str e);failwith "type not supported 1")


  method exp_solver e =
    let lv = "BabelExp_"^(string_of_int !exp_count) in
      lv^" is "^(String.uppercase (self#e_to_str e))^",\n"

  method exp_solver_str s =
    let lv = "BabelExp_"^(string_of_int !exp_count) in
      lv^" is "^(String.uppercase s)^",\n"

  method get_temp_lv =
    let t = "BabelExp_"^(string_of_int !exp_count) in
      exp_count := !exp_count + 1;
      t

  method pointer_r_interface l =
    match l with
    | "8" -> "babelPtrR"
    | "4" ->
      "babelPtrR"
    | "2" ->
      "babelPtrR"
    | "1" -> "babelPtrR_byte"
    | _ -> failwith "unsupport pointer length"

  method e_to_str e =
    let rec help e =
      match e with
      | CastE (t,e') ->
        help e'
      | _ -> e_str (constFold true e)

    in
    help e

  method trans_instr i =
   let arr_help lv =
      let split = Str.split (Str.regexp_string "[") in
      let n = lv_str lv in
      let items = split n in
        let n' = List.nth items 0 in
        let n0 = String.sub n' 0 (String.length n' - 2) in
        if Hashtbl.mem arrayTb n0 then n0
      else (print_endline n'; failwith "undefined array in arr_help")
   in
   let arr_index lv n =
     let n' = lv_str lv in
     String.sub n' (String.length n) 2
   in
   let arr_help1 lv =
     let n = arr_help lv in
     let i = arr_index lv n in
     String.uppercase (n^i)
   in
   let arr_help2 lv =
     let n = arr_help lv in
     let i = arr_index lv n in
     let i' = (int_of_string i) - 1 in
     if i' = 0 then String.uppercase n
     else
       let is = string_of_int i' in
       if String.length is = 2 then String.uppercase (n^is)
       else String.uppercase (n^"0"^is)
   in
   let is_ptr = function
     | Mem _ -> true
     | _ -> false
   and is_bptr lh e =
     let fp = match lh with
       | Mem _ -> true
       | _ -> false
     in
     let sp = match e with
       | Lval (Mem e', off) -> true
       | StartOf (Mem e', off) -> true
       | _ -> false in
     if fp = true && sp = true then true
     else false
   in
   let is_ptr_arith lv e =
     let aux s1 s2 =
       let re = Str.regexp_string s2 in
       try ignore (Str.search_forward re s1 0); true
       with Not_found -> false
     in
     print_endline ("check ptr arith "^(e_str e));
     let es = e_str e in
     if aux es "+" = false then
       false
     else
       begin
         match remove_cast_on_exp e with
         | StartOf _ ->
            begin
              print_string "found a start of XXX ";
              print_endline (e_str e);
              false
            end
         | _ ->
            begin
              let is_ptrl =
                let (lh, _) = lv in
                match lh with
                | Mem e' ->
                   begin
                     match e' with
                     | Lval(Var v, _) ->
                        begin
                        match v.vtype with
                        | TPtr (t', _) ->
                           begin
                             match t' with
                             | TPtr _ -> true
                             | TNamed (t, _) ->
                                begin
                                  match t.ttype with
                                    | TPtr _ -> true
                                    | _ -> false
                                end
                             | _ -> false
                           end
                        | _ -> false
                        end
                        (*
                        let ts = t_str (unrollType v.vtype) in
                        print_endline ts;
                        if aux ts "**" then
                          true
                        else false
                         *)
                     | _ -> false
                   end
                | Var v ->
                   begin
                     match v.vtype with
                     | TPtr _ -> true
                     | _ -> false
                   end
              in
              if is_ptrl = true then
                (
                  self#babel_rptr e
                )
              else false
            end
       end
   in
   let ptr_name = function
    | Mem e -> e_str e
    | _ -> failwith "not supported in ptr_name"
   in
   let is_arr = function
     | Mem _ -> false
     | Var vi ->
        (
          match vi.vtype with
          | TArray _ -> true
          | _ -> false
        )
   in
   match i with
    | Set (_ as lv, AddrOf rv, _) ->
        ""
    | Set (lv, e, _) when is_ptr_arith lv e ->
        self#babel_ptr_arith lv e
    | Set ((lh, _) as lv, e, _)  when is_bptr lh e  ->
      begin
        let e' =
          match e with
            | Lval (Mem e', _) -> e'
            | StartOf (Mem e', _) -> e'
        in
        print_endline ("identified both pointers : "^(e_str e'));
        let vn = ptr_name lh in
        let es = string_of_int (self#ptr_size lv) in
        let es' = self#is_float lv in
        let temp_val = self#get_temp_lv in
        let inter = self#pointer_r_interface es in
        let fc =
          if es' = 2 then
            "babel_ptrFR("^temp_val^", "^(String.uppercase (self#e_to_str e'))^",2),"
          else if es' = 1 then
            "babel_ptrFR("^temp_val^", "^(String.uppercase (self#e_to_str e'))^",1),"
          else
            inter^"("^temp_val^", "^(String.uppercase (self#e_to_str e'))^", "^es^"),"
        in
        let sc =
          if es' = 2 then
            "babel_ptrFW("^(String.uppercase vn)^", "^temp_val^",2),"
          else if es' = 1 then
            "babel_ptrFW("^(String.uppercase vn)^", "^temp_val^",1),"
          else
            "babel_ptrE("^(String.uppercase vn)^", "^temp_val^", "^es^"),"
        in
          fc^"\n"^sc
      end
    | Set ((lh, _) as lv, e, _) when is_ptr lh ->
       print_endline "identified left pointer ";
       let es = string_of_int (self#ptr_size lv) in
       let es' = self#is_float lv in
       let vn = ptr_name lh in
       let et = self#exp_solver e in
       let temp_val = self#get_temp_lv in
       if es' = 2 then
         et^"babel_ptrFW("^(String.uppercase vn)^", "^temp_val^",2),"
       else if es' = 1 then
         et^"babel_ptrFW("^(String.uppercase vn)^", "^temp_val^",1),"
       else
         et^"babel_ptrE("^(String.uppercase vn)^", "^temp_val^", "^es^"),"
    | Set ((lh, off) as lv , e, _) when is_arr lh ->
        let i = match off with
                  | Index (e', _) -> String.uppercase (e_str e')
                  | _ -> failwith "unhandled offset of array" in
          let et = self#exp_solver e in
          let temp_val = self#get_temp_lv in
        (* et^"babelArrayL("^(arr_help2 lv)^", "^i^", "^temp_val^", "^(arr_help1 lv)^")," *)
        et^"babelArrayL("^(lv_str lv)^", "^i^", "^temp_val^", "^(lv_str lv)^"),"
    | Set (lv , e, _) ->
        self#babel_exp lv e
    | Call (Some lv, e, elist, loc) ->
       let fn = e_str e in
         if self#has fn "babel_wrapper_" then
            ""
         else if self#is_reusable_func = true && fn = func_name then
            self#mkPrologCall lv e elist
         else
           let pl = self#createPlInterface lv e elist
           and c = self#createCInterface lv e elist in
             self#insertInCFile c;
             self#insertInPlFile pl;
             self#mkCall lv e elist
    | Call (None, e, elist, loc) ->
       let fn = e_str e in
         if self#has fn "babel_wrapper_" then
            ""
         else if self#is_reusable_func = true && fn = func_name then
           (* we can directly reuse the prolog code here*)
            self#mkPrologCallNoRet e elist
         else
          let pl = self#createPlInterfaceNoRet e elist
          and c = self#createCInterfaceNoRet e elist in
          self#insertInCFile c;
          self#insertInPlFile pl;
          self#mkCallNoRet e elist
    | _ -> ""

  method mkCondStr opcode e1 e2 =
    let opcode_trans op =
      match op_str op with
        | "12" -> " =:= "
        | "13" -> " \= "
        | "14" -> " > "
        | "15" -> " =< "
        | "16" -> " < "
        | "17" -> " >= "
        | _ ->
           begin
             print_endline (op_str op);
             failwith "undefined opcode"
           end
    in
    (*
    "babelJcc("^(op_str opcode)^", "^(String.uppercase (e_str e1))^", "
      ^(String.uppercase (e_str e2))^")"
     *)
    (String.uppercase (e_str e1))^ (opcode_trans opcode) ^(String.uppercase (e_str e2))


  (*Basically, when loop termination test if/else be detected,
  * we need to transform it into different prolog code
  *
  *  loop_entry(N, A, ResultN, ResultA) :-
      N > 0,!,                    <---- we should transform it like this
    succ(N0, N),
    succ(A, A1),
    loop_entry(N0, A1, ResultN, ResultA).
    loop_entry(N, A, N, A).
  * *)
  method checkGoto b1 =
  let l = List.length b1.bstmts in
  if l = 1 then
    let s = List.hd b1.bstmts in
    match s.skind with
    | Goto _ -> true
    | _ -> false
  else false

  method printOption s =
    match s with
    | None -> ()
    | Some stmt -> E.log "stmt option: %s\n" (e_str stmt)

  method getAllVariablesInst i acc =
    match i with
    | Set(lval, exp, lc) ->
        let varVisitor = object
        inherit nopCilVisitor
        val mutable vars : string list = []
        method get_vars = vars
        method vvrbl v = vars <- v.vname :: vars; DoChildren
        end in
          ignore(visitCilLval (varVisitor :> cilVisitor) lval);
          ignore(visitCilExpr (varVisitor :> cilVisitor) exp);
          varVisitor#get_vars@acc
    | _ -> []

  method getAllVariablesStmt varList s =
    match s.skind with
    |     Instr(l) -> List.fold_left (fun acc i -> self#getAllVariablesInst i acc) varList l
    |     If (BinOp (op, e1, e2, ty), b1, b2, loc) ->
      let varVisitor = object
        inherit nopCilVisitor
        val mutable vars : string list = []
        method get_vars = vars
        method vvrbl v = vars <- v.vname :: vars; DoChildren
        end in
          ignore(visitCilExpr (varVisitor :> cilVisitor) e1);
          ignore(visitCilExpr (varVisitor :> cilVisitor) e2);
          self#getAllVariablesBlk b1 varList;
          self#getAllVariablesBlk b2 varList;
          varVisitor#get_vars@varList
    | Loop (b, loc, stmt1, stmt2) ->
          self#getAllVariablesBlk b varList
    | Block b ->
          self#getAllVariablesBlk b varList
    | Return (Some e, _) ->
        let varVisitor = object
        inherit nopCilVisitor
        val mutable vars : string list = []
        method get_vars = vars
        method vvrbl v = vars <- v.vname :: vars; DoChildren
        end in
          ignore(visitCilExpr (varVisitor :> cilVisitor) e);
          varVisitor#get_vars@varList
    | _ -> varList

  method getAllVariablesBlk b varList =
    List.fold_left (fun acc s -> self#getAllVariablesStmt acc s) varList b.bstmts

  (* @Deprecated *)
  method variableCollector b =
    let varList = self#getAllVariablesBlk b [] in
      let module StringSet = Set.Make(String) in
        let stringset_of_list li =
        List.fold_left (fun set elem -> StringSet.add elem set) StringSet.empty li in
          let varSet = stringset_of_list varList in
          StringSet.fold (fun elem acc -> elem::acc) varSet []

  (* we only collect variable whose defination locates before current block *)
  method block_collector b loc =
    let p = object
      inherit nopCilVisitor
      val mutable vars : varinfo list = []
      method get_vars = List.map (fun v -> v.vname) vars
      method vvrbl v =
              if compareLoc v.vdecl loc > 0 || List.mem v vars
              then  DoChildren
              else
              (
                vars <- v :: vars;
                DoChildren
              )
      end in
        ignore(visitCilBlock (p :> cilVisitor) b);
        p#get_vars

  method printVariableList l =
    let help var = E.log "variable in loop %s\n" var in
    List.iter help l

  (*basically we need transfer c while(1) loop into this kidn of Prolog code
    *  loop_entry(N, A, ResultN, ResultA) :-
      N > 0,!,                    <---- we should transform it like this
    succ(N0, N),
    succ(A, A1),
    loop_entry(N0, A1, ResultN, ResultA).
    loop_entry(N, A, N, A).


loop_entry(N0, A0, FinalN, FinalA) :-
babelJcc(N0, 3), !,
babelAssign(A1, A0 + 1),
babelAssign(N1, N0 + 1),
loop_entry(N1, A1, FinalN, FinalA).
loop_entry(N0, A0, N0, A0).
 *)

  method entry_loop varList =
    let ssaVarSplit acc name =
      let l = String.length name in
      let count = int_of_string (String.sub name (l-2) 2)
      and varName = String.sub name 0 (l-2) in
        Hashtbl.add acc varName count; acc in
    let tempTable = List.fold_left ssaVarSplit (Hashtbl.create 30) varList
    and entryVars  = (Hashtbl.create 10) in
      let findMin name count =
        if Hashtbl.mem entryVars name then
          let minCount = Hashtbl.find entryVars name in
            Hashtbl.replace entryVars name (min count minCount)
        else Hashtbl.add entryVars name count in
      Hashtbl.iter findMin tempTable;
      entryVars

  method printEntryVarInLoop entryVarsTable =
    let queue1 = Queue.create ()
    and queue2 = Queue.create () in
    let loopEntryPrint name count =
      Queue.push ", " queue1;
      Queue.push ((String.uppercase name)^(self#countToStr count)) queue1;
      Queue.push (", Final"^(String.uppercase name)) queue2 in
    let print varStr =
      E.log "%s" varStr in
    Hashtbl.iter loopEntryPrint entryVarsTable;
    Queue.pop queue1;
    E.log("\nloop_entry(");
    Queue.iter print queue1;
    Queue.iter print queue2;
    E.log(") :- ")

   method returnEntryVarInLoop entryVarsTable =
    let queue1 = Queue.create ()
    and queue2 = Queue.create () in
    let loopEntryPrint name count =
      Queue.push ", " queue1;
      Queue.push ((String.uppercase name)^(self#countToStr count)) queue1;
      Queue.push (", Final"^(String.uppercase name)) queue2 in
        Hashtbl.iter loopEntryPrint entryVarsTable;
        Queue.pop queue1;
        let res1 = Queue.fold (^) "" queue1
        and res2 = Queue.fold (^) "" queue2 in
          "\nloop_entry_"^(string_of_int (Array.get whileCounts 0))^"("^res1^res2^") :- "

  method findExitVarInLoop varList =
  let ssaVarSplit acc name =
    let l = String.length name in
    let count = int_of_string (String.sub name (l-2) 2)
    and varName = String.sub name 0 (l-2) in
      Hashtbl.add acc varName count; acc in
  let tempTable = List.fold_left ssaVarSplit (Hashtbl.create 30) varList
  and entryVars  = (Hashtbl.create 10) in
    let findMax name count =
      if Hashtbl.mem entryVars name then
        let maxCount = Hashtbl.find entryVars name in
          Hashtbl.replace entryVars name (max count maxCount)
      else Hashtbl.add entryVars name count in
    Hashtbl.iter findMax tempTable;
    entryVars

  method printExitVarInLoop entryVarsTable =
    let queue1 = Queue.create ()
    and queue2 = Queue.create ()
    and queue3 = Queue.create () in
    let loopEntryPrint name count =
      Queue.push ", " queue1;
      Queue.push ((String.uppercase name)^(self#countToStr count)) queue1;
      Queue.push (", Final"^(String.uppercase name)) queue2 in
    let print varStr =
      E.log "%s" varStr in
    Hashtbl.iter loopEntryPrint entryVarsTable;
    Queue.pop    queue1;
    E.log("\nloop_entry(");
    Queue.iter print queue1;
    Queue.iter print queue2;
    E.log ").\n";
    E.log("\nloop_entry(");
    Queue.iter print queue1;
    E.log      ", ";
    Queue.iter print queue1;
    E.log      ").\n"

  method returnExitVarInLoop entryVarsTable exitVarsTable =
    let queue1 = Queue.create ()
    and queue2 = Queue.create ()
    and queue3 = Queue.create () in
    let h1 name count =
      print_string name;
      print_int count;
      Queue.push ", " queue1;
      Queue.push ((String.uppercase name)^(self#countToStr count)) queue1;
      Queue.push (", Final"^(String.uppercase name)) queue2
    and h2 name count =
      Queue.push ", " queue3;
      Queue.push ((String.uppercase name)^(self#countToStr count)) queue3 in
        Hashtbl.iter h1 exitVarsTable;
        Hashtbl.iter h2 entryVarsTable;
        Queue.pop queue1;
        Queue.pop queue3;
        let res1 = Queue.fold (^) " " queue1
        and res2 = Queue.fold (^) " " queue2
        and res3 = Queue.fold (^) " " queue3 in
      "\nloop_entry_"^(string_of_int (Array.get whileCounts 0))^"("^res1^res2^").\nloop_entry_"^(string_of_int (Array.get whileCounts 0))^"("^res3^", "^res3^").\n"

  method loopCall entryVarsTable exitVarsTable =
    let queue = Queue.create () in
    let helper name count queue =
      Queue.push ", " queue;
      Queue.push ((String.uppercase name)^(self#countToStr count)) queue in
        Hashtbl.iter (fun name count -> helper name count queue) entryVarsTable;
        Hashtbl.iter (fun name count -> helper name count queue) exitVarsTable;
        Queue.pop queue;
        let res1 = Queue.fold (^) "" queue in
      "loop_entry_"^(string_of_int (Array.get whileCounts 0))^"("^res1^"),"

  method countToStr count =
    if count < 10 then "0"^(string_of_int count)
    else string_of_int count

  method mergeTopNonStack n =
    let rec helper n =
      if n = 0 then ""
    else let code = prologWhiles#pop in
      code^(helper (n-1)) in
      helper n

  method removeLastChar str =
    let tempStr = String.trim str in
    let len = String.length tempStr in
      if len = 0 then ""
      else if String.get tempStr (len-1) = ',' then String.sub tempStr 0 (len-1)
    else tempStr


  method vstmts s =
    let s_str i =
      Pretty.sprint max_int (Cil.d_stmt () i) in
    let is_validate_ret e =
      match remove_cast_on_exp e with
        | Const _ -> true
        | Lval _ -> true
        | _ -> false
    in
    let construct_return_exp_const c =
      if !returnName == "Void" then
        begin
        print_string !returnName;
        failwith "undefined return"
        end
      else
        begin
          print_endline !returnName;
          let v = c_str c in
          (*"babelAssign(" ^ String.uppercase !returnName ^ "," ^ v ^ "), true"*)
          String.uppercase !returnName ^ " is " ^ v ^ ", true"
        end
    in
    let construct_return_exp_lval l =
      if !returnName == "Void" then
        begin
        print_string !returnName;
        failwith "undefined return"
        end
      else
        begin
          print_endline !returnName;
          let v = lv_str l in
          let vu = String.uppercase v in
          let ru = String.uppercase !returnName in
         (* "babelAssign(" ^ ru ^ "," ^ vu ^ "), true" *)
          ru ^ " is " ^ vu ^ ", true"
        end
    in
    let construct_return_exp e =
      match remove_cast_on_exp e with
        | Lval lv ->
           construct_return_exp_lval lv
        | Const c ->
           construct_return_exp_const c
        | _ ->  failwith "undefined return"
    in
    match s.skind with
      | Instr (instrList) ->
          let resList = List.map (fun instr -> self#trans_instr instr) instrList in
            String.concat "\n" resList
      | If (BinOp (op, e1, e2, ty), b1, b2, loc) ->
          let condStr = self#mkCondStr op e1 e2 in
          let check = self#checkGoto b2
          and l = List.length b1.bstmts in
          if check = true && l = 1 then
            condStr^"-> !,"
          else
              let str1 = "\n("^condStr^" ->\n" in
              let str2List = List.map (self#vstmts) b1.bstmts in
                let str2 = self#removeLastChar (String.concat "" str2List) in
              let str3List = List.map (self#vstmts) b2.bstmts in
                let str3 = self#removeLastChar (String.concat "" str3List) in
                if str3 = "" then
                  str1^str2^"\n; true),\n"
                else
                  str1^str2^"\n; "^str3^"),\n"
      | Loop (b, loc, stmt1, stmt2) ->
        let strList = List.map (self#vstmts) b.bstmts in
          let str = String.concat "" strList in
        let varList = self#block_collector b loc in
        let entryVars = self#entry_loop varList in
        let entryStr = self#returnEntryVarInLoop entryVars in
        let exitVars = self#findExitVarInLoop varList in
          let exitStr = self#returnExitVarInLoop entryVars exitVars in
          let loopStr = self#loopCall entryVars exitVars in
          (Array.set whileCounts 0 ((Array.get whileCounts 0)+1));
        prologWhiles#push (entryStr^str^exitStr);
        loopStr
      | Goto (stmt, loc) -> "!\n"
      | Block b ->
          let strList = List.map self#vstmts b.bstmts in
            String.concat "\n" strList
      | Return (Some e', _) when is_validate_ret e' ->
         construct_return_exp e'
     (* | Return (Some Lval(Var vi, _), _) -> "true " *)
      | Return (None, _) -> returnName := "Void"; "true "
      | Return _ -> failwith "undefined return"
      | Break _ | Continue _ -> ""
      | Switch _ -> failwith "undefined switch statement" (*CIL simplified C can not reach here*)
      | TryFinally _ |TryExcept _ ->
                       failwith "undefined try catch statement" (*C can not reach here*)

method func_wrap f =
  let wrapper_decl = Printf.sprintf
  "   %s babel_wrapper_%s(%s)                           // function name insert
      {
        // wrapper for function %s        // function name insert
         %s return_value; //  return value type (how about array type)

        //rountine code
        int func;
        PlTerm arg[%d];    //  function variable + return value insert
        PlBool res;

        func = Pl_Find_Atom(\"%s\"); // function name insert

      //routine code
        Pl_Query_Begin(PL_FALSE);

      //prepare parameters
      //partial routine code, pass in parameter  // we need to init arguments and return value
      %s
      //routine code, reserve a place for return value
      %s

      //partial routine code, 2 is not routine. (number of arguments) + 1
        res = Pl_Query_Call(func, %d, arg);          // insert (variable+return value)

      //get return value, partial routine code, 1 is not routine
        return_value = %s(arg[%d]);        // insert ()

      //routine code
        Pl_Query_End(PL_KEEP_FOR_PROLOG);

      //routine code
        return %s;
        }
      "
  in
    let fn = f.svar.vname
    and argsl = self#mem_var_collect f.slocals in
    let argsl' = argsl@f.sformals in
    let args = List.map self#singleArg1 argsl' in
     let s = String.concat ", " args in
      let len = (List.length argsl') + 1 in
        let astr = self#getArgsStr argsl'
        and t = self#getReturnType f in
        (* print_string (t^"a\n"); *)
        let t1 = if t = "void " then "int" else t
        and t2 = if t = "void " then "int" else t in
        let r = self#get_ret_name t in
        let rs = self#getReturnStr t (len - 1) in
        let fn' = self#prolog_func_modify fn in
        let ri =
          match t with
            | "float " | "double " -> "Pl_Rd_Float"
            | _ -> "Pl_Rd_Integer"
        in
        wrapper_decl t1 fn s fn t2 len fn' astr rs len ri (len-1) r


  (* prolog does not allow function name with upper case letter *)
  method prolog_func_modify fn =
    let i = String.get fn 0
    and s = String.sub fn 1 (String.length fn - 1) in
      let i' = Char.lowercase i in
        let is =  String.make 1 i'  in
          is^s

  method get_ret_name t =
    if t <> "void " then "return_value"
    else "0"

  method getArgsStr argsList =
    let rec helper args i =
      match args with
      | h::t ->
        let prologStr = self#ctype_translate h.vtype in
        "arg["^(string_of_int i)^"] = "^prologStr^"("^h.vname^");\n"^(helper t (i+1))
      | [] -> "" in
      helper argsList 0

  method getReturnStr returnType len =
        if returnType <> "void"
          then Printf.sprintf "arg[%d] = Pl_Mk_Variable();" len
          else "// no return value"


  method getReturnType func =
  let (ret, _, _, _) = splitFunctionType func.svar.vtype in
    Pretty.sprint max_int (d_type () ret)



  method ctype_translate t =
    match t with
    | TInt (ik, _) ->
        begin
        match ik with
        | IChar -> "Pl_Mk_Integer"
        | IUChar -> "Pl_Mk_Byte"
        | IBool -> "Pl_Mk_Boolean"
        | IInt -> "Pl_Mk_Integer"
        | IUInt -> "Pl_Mk_Positive"
        | ILong -> "Pl_Mk_Integer"
        | IULong -> "Pl_Mk_Integer"
        | IULong -> "Pl_Mk_Integer"
        | IULongLong -> "Pl_Mk_Integer"
        | _ ->
          let ts = t_str t in
            failwith ("unhandled C int type "^ts)
        end
    | TFloat (fk, _) ->
        begin
        match fk with
        | FFloat | FDouble -> "Pl_Mk_Float"
        | _ -> "Pl_Mk_Float"
        end
    | TArray _ -> "Pl_Mk_List"
    | TPtr _ -> "Pl_Mk_Integer"
    | TNamed (t', _) ->
        self#ctype_translate t'.ttype
    | TEnum _ -> "Pl_Mk_Integer"
    | _ -> "Pl_Mk_Integer"
             (*
      let ts = t_str t in
        failwith ("unhandled C type "^ts)
              *)


  method set_instrLine l i =
    let loc = get_instrLoc i in
      let loc' ={loc with line=l.line} in
        match i with
          Set(lv, e, loc) -> Set (lv, e, loc')
          | _ -> failwith "unsupported type in set_instrLine"

    method call_wrap func =
      let help l i =
          self#set_instrLine l i in
      let blk = func.sbody in
      let mem_instrs = self#mem_instr_collect func in
      (* self#return_variable_collect func; *)
      returnName := "BABEL_RET";
      let n = "return babel_wrapper_"^func.svar.vname in
      let argsl = (self#mem_var_collect func.slocals)@func.sformals in
      let args_exp = List.map (fun v -> Lval(Var(v), NoOffset)) argsl in
      (* obviously, it is an ad-hoc but efficient way *)
      let fun_var = copyVarinfo func.svar n in
      let fun_val = Lval(var fun_var) in
      let s = List.nth blk.bstmts 0 in
      let last_l = get_stmtLoc s.skind in
      let new_instrs = List.map (fun i -> help last_l i) mem_instrs
      and new_l = {last_l with line=last_l.line} in
      let call_i = Instr [Call(None, fun_val, args_exp, new_l)] in
      let stmts' = (mkStmt call_i)::blk.bstmts in
      (mkStmt (Instr new_instrs))::stmts'

    method shouldSkipFunction f = hasAttribute "babel_skip" f.vattr
    method babelTransFunction f = hasAttribute "babel_trans" f.vattr

    method getReturnVarName f =
      let isRet name =
        let re = Str.regexp_string "__retres" in
        try ignore (Str.search_forward re name 0); true
        with Not_found -> false in
      let l = List.filter (fun v -> isRet v.vname) f.slocals in
      if List.length l = 0 then "0" else (List.hd l).vname

    method getArgsStrProlog argsList =
      let res = List.fold_left (fun acc info -> acc^", "^(String.uppercase info.vname)) "" argsList in
      let res1 = String.trim res in
        if res = "" then ""
      else
        String.sub res 2 ((String.length res)-2)

    method getAllWhiles =
      prologWhiles#str


    method updateFunRet func =
      let t = self#getReturnType func in
       Hashtbl.replace funRet func.svar.vname t


    method mkFunHead func args =
      let fn = self#prolog_func_modify func.svar.vname in
      if args = "" then
        Printf.sprintf "\n%s(%s) :- \n" fn (String.uppercase !returnName)
      else if !returnName = "VOID" then
        Printf.sprintf "\n%s(%s) :- \n" fn args
      else
        Printf.sprintf "\n%s(%s, %s) :- \n" fn args (String.uppercase !returnName)

    (* record the array info, supporting future transform *)
    method array_filter func =
      let is_ssa n =
        try
          let l = String.length n in
          let p = String.sub n (l-2) 2 in
            ignore(int_of_string p);
            true
        with
        | _ -> false in
      let h' n l =
        if is_ssa n then ()
        else (* this is not the ssa version of array name *)
          Hashtbl.replace arrayTb n (int_of_string l) in
      let h v =
        match v.vtype with
        | TArray (_, lo, _) ->
            (match lo with None -> () | Some e -> (h' v.vname (e_str e)); ())
        | _ -> () in
        List.iter h func.slocals

    (* init the arrays :
     *  W = [0, 0, 0, 0, 0] when len_of_w = 5
     *  *)
    method array_init =
      (* Batteries can provide this method, however, we ad-hoc it ourselves *)
      let rec m n l =
        match n with
        | 0 -> l
        | _ -> m (n-1) ("0"::l) in
      let h n l acc =
        let h = (String.uppercase n)^" = "
        and el = m l [] in
          acc^h^"["^(String.concat "," el)^"],\n" in
      Hashtbl.fold h arrayTb ""

    (* some of the loop function (function name ended with _cil_lr_X) could be
     *  directly reused in Prolog code (don't have to call C wrapper again),
    *)
    method is_reusable_func =
      let is_loop = self#has func_name "_cil_lr_" in
      if has_mem_instrs = false && is_loop = true then
        true
      else false

    (* based on C-To-Prolog translate process,
     * we must collect all the specified variables
     * like
     *   __cil_fp_b_ssa_1
     *   __cil_pp_b_ssa_1
     *   __cil_gp_stderr
     *
     *  in which `b` is the original variable name
     *
     *     *)
    method mem_var_collect locals =
      List.filter (
                fun l ->
                    (
                      self#has l.vname "__cil_fp_" || self#has l.vname "__cil_pp_" || self#has l.vname "__cil_gp_"
                    )
                ) locals

    method mem_instr_collect f =
      let instrVisitor = object
        (* overkill *)
        inherit nopCilVisitor
        val mutable instrs : instr list = []
        val set_instrs = Hashtbl.create 10
        method get_instrs = instrs
        method vinst i =
            match i with
            | Set (lval, _, l) ->
              begin
                match lval with
                | (Var v, _) ->
                  if Hashtbl.mem set_instrs v.vname then SkipChildren
                  else
                    (
                      if self#has v.vname "__cil_fp_" || self#has v.vname "__cil_pp_" || self#has v.vname "__cil_gp_" then
                        (
                          instrs <- i::instrs;
                          Hashtbl.replace set_instrs v.vname 1;
                          SkipChildren
                        )
                      else DoChildren
                    )
                | _ -> SkipChildren
              end
            | _ -> SkipChildren
        end in
          ignore(visitCilFunction (instrVisitor :> cilVisitor) f);
          let il = instrVisitor#get_instrs in
            if List.length il = 0 then
              (
                has_mem_instrs <- false;
                il
              )
            else
              (
                has_mem_instrs <- true;
                il
              )


    method return_variable_collect f =
      let sVisitor = object
        inherit nopCilVisitor
        val mutable have_find: bool = false
        method vstmt s =
            match s.skind with
            | _ when have_find -> SkipChildren
            | Return (Some Lval(Var vi, _), _) ->
               print_endline ("set return variable as : " ^ vi.vname);
               returnName := vi.vname;
               have_find <- true;
               SkipChildren
            | _ ->
               begin
                 DoChildren
               end
        end in
      ignore(visitCilFunction (sVisitor :> cilVisitor) f)




    method vfunc func  =
      let insert_wrappers fw =
        (* iterate f.gloals list, find the first function *)
        let is_gfun g =
          match g with
          | GFun(_,_) -> true
          | _ -> false
        in
        let rec aux gl =
          match gl with
          | (h::t) when is_gfun h ->
             fw::h::t
          | (h::t) -> h::(aux t)
          | _ -> failwith "undefined global list"
        in
        f.globals <- aux f.globals
      in
      match func with
      | func when List.mem func.svar.vname white_list ->
         print_endline ("funcname : " ^ func.svar.vname);
         print_endline ("================== start babel transform for function: "^func.svar.vname^" ==========");
          func_name <- func.svar.vname;
          let wrapper = self#func_wrap func in
         (* f.globals <- f.globals @ [GText(wrapper)];*)
          insert_wrappers (GText(wrapper));

          func.sbody.bstmts <- self#call_wrap func;
          (* self#array_filter func; *)
          (* let arrInit = self#array_init in *)
          self#updateFunRet func;

          let funBodyList = List.map self#vstmts func.sbody.bstmts

          and mem_vars = self#mem_var_collect func.slocals in

          let args = self#getArgsStrProlog (mem_vars@func.sformals) in

          let funHead = self#mkFunHead func args
          and funBody = String.concat "" funBodyList
          and whileStr = self#getAllWhiles
          and oc = open_out_gen [Open_append; Open_creat] 0o666  "babel.pl"
          in
          let funBody1 = (self#removeLastChar funBody)^"." in
          (* Printf.fprintf oc "%s\n%s\n %s \n\n %s" funHead arrInit funBody1 whileStr; *)
          Printf.fprintf oc "%s\n%s\n %s \n\n %s" funHead "" funBody1 whileStr;
          close_out oc;
          print_endline ("================== finish babel transform for function: "^func.svar.vname^" ==========");
          SkipChildren
      | func ->
         print_endline ("funcname : " ^ func.svar.vname);
         self#updateFunRet func;
         SkipChildren


      initializer
      white_list <- self#update_whitelist;

end


(*
add exit function before return of main
*)
class babelExitVisitorClass f = object (self)
  inherit nopCilVisitor
  method vstmt (s : stmt) = begin
    match s.skind with
      Return _ ->
            let babelExitTy = TFun (voidType, Some [], false, []) in
            let babelExitFunc = findOrCreateFunc f "Pl_Stop_Prolog" babelExitTy in
            babelExitFunc.vstorage <- Extern;
            babelExitFunc.vattr <- [Attr ("babel_skip", [])] ;
           self#queueInstr [Call (None, Lval (var babelExitFunc), [], locUnknown)] ;
          SkipChildren
    | _ -> DoChildren
  end
end

let addBabelExit ?(main_name="main") (f: file) =
 let babelExitVisitor = new babelExitVisitorClass f in
       List.iter
        (function
            GFun(fdec, loc) when fdec.svar.vname = main_name ->
              ignore (visitCilFunction babelExitVisitor fdec);
            | _ -> ())
             f.globals

let addBabelInitializer ?(main_name="main") (f: file) =
   List.iter
        (function
            GFun(fdec, loc) when fdec.svar.vname = main_name ->
              (  let argvArg = ("argv", argvType, [])
                 and argcArg = ("argc", argcType, []) in
                 let babelInitTy = TFun (voidType, Some [argcArg;argvArg], false, []) in
                 let babelInitFunc = findOrCreateFunc f "Pl_Start_Prolog" babelInitTy in
                 babelInitFunc.vstorage <- Extern;
                 babelInitFunc.vattr <- [Attr ("babel_skip", [])];
                 let argslist = fdec.sformals in
                 let l = List.length argslist in
                 let argc_var = List.nth argslist 0 in
                 let argc_exp = Lval(Var(argc_var),NoOffset) in
                 let argv_var = List.nth argslist ((List.length argslist) - 1) in
                 let argv_exp = Lval(Var(argv_var),NoOffset) in
                 prependToBlock [Call (None, Lval (var babelInitFunc), [argc_exp;argv_exp], locUnknown)]fdec.sbody;
               )
            | _ -> ()) f.globals;
 f.globals <- GText("#include <gprolog.h>\n") :: f.globals

let prepareGlobalForCFG glob =
  match glob with
    GFun(func, _) -> prepareCFG func
  | _ -> ()


let feature : featureDescr =
  { fd_name = "c2p";
    fd_enabled = ref false;
    fd_description = "transform a program in Prolog";
    fd_extraopt = [];
    fd_post_check = true;
    fd_doit =
      function (f: file) ->
        (
          Simplemem.feature.fd_doit f ;
          iterGlobals f prepareGlobalForCFG ;
          (let ncVisitor = new normalizeConditionalsVisitor in
             visitCilFileSameGlobals (ncVisitor :> cilVisitor) f) ;
          Cfg.clearFileCFG f ;
          Cfg.computeFileCFG f ;

    (let instVisitor = new babelAssign f in
             visitCilFileSameGlobals (instVisitor :> cilVisitor) f) ;
          addBabelExit f;
          addBabelInitializer f ;
          );
  }


let main () : unit =
 (*
  if Array.length Sys.argv <> 1 then
    E.log "Usage: %s file\n" Sys.argv.(0)
  else
*)
    initCIL ();
    let f = Frontc.parse Sys.argv.(1) () in
    let f' = open_out (f.fileName ^ "il.c") in
    feature.fd_doit f;
    dumpFile defaultCilPrinter f' "" f;;

main();;
