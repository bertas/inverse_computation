let main () : unit =
	initCIL();
	let f = Frontc.pars Sys.argv.(1) () in
	let f' = open_out (f.fileName ^ "il.c") in
	feature.fd_doit f;
	dumpFile defaultCilPrinter f' "" f;;

main();;

let feature : featureDescr =
	{
		fd_name = "c2p";
		fd_enabled = ref false;
		fd_description = "transform a program in Prolog";
		fd_extraopt = [];
		fd_post_check = true;
		fd_doit =
			function (f: file) ->
				(
					Simplemem.feature.fd_doit f;
					iterGlobals f prepareGlobalForCFG;
					(
						let ncVisitor = new normalizeConditionalsVisitor in
							visitCilFileSameGlobals (ncVisitor :> cilVisitor) f
              (*a visitor for the whole file that does not change the globals,
                more efficient for long files compared with visitCilFile*)
					);
					Cfg.clearFileCFG f;
          (*clear the sid, succs, and preds field of each statement*)
					Cfg.computeFileCFG f;
          (*compute the cfg for an entire file, by calling cfgFun on each function*)
					(
						let instVistor = new babelAssign f in
							visitCilFileSameGlobals (instVistor :> cilVisitor) f
              (*cilVisitor is a vistor interface for traversing CIL trees*)
					);
				)
	}

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
      		| _ -> invalid_arg "negateCompareOp"
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

let prepareGlobalForCFG glob =
  	match glob with
    	GFun(func, _) -> prepareCFG func
      (*Prepare a function for CFG information computation by Cil.computeCFGInfo. 
        This function converts all Break, Switch, Default and Continue Cil.stmtkinds 
        and Cil.labels into Ifs and Gotos, giving the function body a very CFG-like character.*)
  	| _ -> ()

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
          (print_endline (t_str t); failwith "type not supported 4") in
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
        | SizeOfE(e) -> e_size e
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
        Pretty.sprint max_int (Cil.d_type () t) 
      in
      let ty = self#getTypefromLval lv 
      in
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
    let rt = self#ret lv 
    in
    if rt = "" then ""
    else
      let rname = "* babel_ret" 
      in
      aux^rname

  method varList elist =
      let count = ref (-1) 
      in
      let names = List.map (
                        fun v -> (count := !count + 1; "arg_"^(string_of_int !count))
                        ) elist 
      in
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

  method mkCall lv fexp elist =
    let funName = e_str fexp in
      if List.mem funName white_list 
      then self#mkCCall lv fexp elist  
      else self#mkCCall lv fexp elist  

  method mkCallNoRet fexp elist =
    let funName = e_str fexp in
      if List.mem funName white_list 
       then self#mkCCallNoRet fexp elist 
      else
        self#mkCCallNoRet fexp elist 
        
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
          str1^str2^"\n; "^str3^"),\n"
        end
      | UnOp (op, e, ty) ->
          begin
            let e0 =  Const(CInt64(Int64.zero, IInt, None)) in
            let conds = self#mkCondStr Eq e e0 in
            let str1 = "\n("^conds^" ,\n"
            and str2 = (String.uppercase (lv_str lv))^" is 1"
            and str3 = (String.uppercase (lv_str lv))^" is 0" in
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
              (String.uppercase (lv_str lv))^" is "^(String.uppercase (e_str e))^","
              end
        )
      | _ ->
        print_endline ("identified common right value : "^(e_str e));
        let et = self#exp_solver e in
        let temp_val = self#get_temp_lv in
        et^(String.uppercase (lv_str lv))^" is "^temp_val^"," in
        if self#is_logic e then bool_helper lv e
        else helper lv e

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
    (String.uppercase (e_str e1))^ (opcode_trans opcode) ^(String.uppercase (e_str e2))

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
    (*babelAssign definintion here*)
    | Set (_ as lv, AddrOf rv, _) ->
        ""
    | Set (lv , e, _) ->
        self#babel_exp lv e
    | Call (Some lv, e, elist, loc) ->
       let fn = e_str e in
         if self#has fn "babel_wrapper_" then
            ""
         else if self#is_reusable_func = true && fn = func_name then
            self#mkPrologCall lv e elist
         else
           let pl = self#createPlInterface lv e elistin
             self#insertInPlFile pl;
             self#mkCall lv e elist
    | Call (None, e, elist, loc) ->
       let fn = e_str e in
         if self#has fn "babel_wrapper_" then
            ""
         else if self#is_reusable_func = true && fn = func_name then
            self#mkPrologCallNoRet e elist
         else
          let pl = self#createPlInterfaceNoRet e elist in
            self#insertInPlFile pl;
            self#mkCallNoRet e elist
    | _ -> ""