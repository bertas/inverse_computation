(* Copyright (c) 2012, Jiang Ming
 *
 * This file is part of ****, which is distributed under the revised
 * BSD license.  A copy of this license can be found in the file LICENSE.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See LICENSE
 * for details.
 *)

open Pretty
open Cil



let lvMap: (string, string) Hashtbl.t = Hashtbl.create 1024 

let idType   = intType
let bidType  = intType
let fidType  = uintType
let valType  = TInt (ILongLong, [])
(*let valType  = TInt (ILong, []) **)
let addrType = TInt (IULong, [])
let boolType = TInt (IUChar, [])
let opType   = intType  (* enum *)
let argcType = intType
let argvType = TPtr(TPtr(charType, []),[])

let prologFile = ref stdout;;
let firstComma = ref true;;
let firstInstr = ref true;;
let first_block = ref false;;
let if_string = ref "";;
let postfix1 = ref "); (\\+ ";;
let postfix2 = ref "))";;
let loopHead = ref "";;
let newLoopHead = ref "";;
let loopBody = ref "";;
let inLoop = ref false ;;
let lsLoopConditionExpr= ref false ;;
let loopConExpr = ref "";;
let loopCounter = ref "";;
let loopValIn = ref "";;
let loopValOut = ref "";;
let loopExitBody = ref "";;
let hasLoop =ref false ;;
let returnExpr = ref "";;


(*
 * Utilities 
 *)

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


(* Utilities *)

let noAddr = zero

let shouldSkipFunction f = hasAttribute "babel_skip" f.vattr
let babelTransFunction f = hasAttribute "babel_trans" f.vattr


let prependToBlock (is : instr list) (b : block) =
  b.bstmts <- mkStmt (Instr is) :: b.bstmts

let isIntegral32Type t = 
  match unrollType t with
  | TInt (ikind, _) -> (
		                   match ikind with
											|  IULongLong -> false
											| _ -> true
		                  )
  | _ -> false

let isSymbolicType ty = isIntegralType (unrollType ty)

let d_string (fmt : ('a,unit,doc,string) format4) : 'a = 
  let f (d: doc) : string = 
    Pretty.sprint 200 d
  in
  Pretty.gprintf f fmt 


(*
 * normalizeConditionalsVisitor ensures that every if block has an
 * accompanying else block (by adding empty "else { }" blocks where
 * necessary).  It also attempts to convert conditional expressions
 * into predicates (i.e. binary expressions with one of the comparison
 * operators ==, !=, >, <, >=, <=.)
 *)
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

  (* TODO(jburnim): We ignore casts here because downcasting can
   * convert a non-zero value into a zero -- e.g. from a larger to a
   * smaller integral type.  However, we could safely handle casting
   * from smaller to larger integral types. *)
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
          (* Ensure neither branch is empty. *)
          if (b1.bstmts == []) then b1.bstmts <- [mkEmptyStmt ()] ;
          if (b2.bstmts == []) then b2.bstmts <- [mkEmptyStmt ()] ;
          (* Ensure the conditional is actually a predicate. *)
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

(*-------------------------Begin of class babelFuncTrans----------------------------------------------*)
class babelFuncTrans f =

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
	
 let mkWrapperFunc name retType args =
    let ty = TFun (retType,  args, false, []) in
    let func = findOrCreateFunc f ("__Babel_" ^ name) ty in 
      func.vattr <- [Attr ("babel_trans", [])] ;
      func
  in

  let toAddr e = CastE (addrType, e) in

(* Cast to valType  = TInt (ILongLong, []) *)
  let toValue e =   
      if isPointerType (typeOf e) then
        CastE (valType, CastE (addrType, e))
      else
        CastE (valType, e)
  in
	
	

(* transfer expression to a uppercase string *)
let printExpr e =
	if isConstant e then String.uppercase (d_string "%a" d_exp e)
	else
   String.uppercase (d_string "(%a)" d_exp e)
in

(* transfer left value to a uppercase string *)
let printLv lv =
	String.uppercase (d_string "%a" d_lval lv)
in

(* transfer return value to a uppercase string *)
let printRet ret =
	if isConstant ret then String.uppercase (d_string "%a" d_exp ret)
	else String.uppercase (d_string "%a" d_exp ret)
in

let printUnop op =
  String.uppercase (d_string "%a" d_unop op)	
in

let printBinop op =
  String.uppercase (d_string "%a" d_binop op)	
in

(*
let createTmpVarString lv =
 let tmp_var = makeTempVar !curFundec ~name:(printLv lv) (typeOfLval lv) in 
 printLv (var tmp_var) 
in
 *)
let createTmpVarString lv =
	let n_string = string_of_int (getNewId ()) in
  (printLv lv) ^ n_string
in

let transforVarDef lv =
  let lv_string = printLv lv in
  let tmp_string = createTmpVarString lv in
  let () = Hashtbl.add lvMap lv_string tmp_string in
    tmp_string
in

(*
let transforVarUse lv =
  let lv_string = printLv lv in
   try 
       Hashtbl.find lvMap lv_string 
   with
      | Not_found -> let tmp_string = createTmpVarString lv in
                     Hashtbl.add lvMap lv_string tmp_string; 
                     tmp_string
in
*)
let transforVarUse lv =
  let lv_string = printLv lv in
   try 
       Hashtbl.find lvMap lv_string 
   with
      | Not_found -> lv_string
in
  
let rec transferExpr e =
    if isConstant e then
      String.uppercase (d_string "%a" d_exp e)
    else
      match e with
        | Lval lv ->
          ( let lv_string =  transforVarUse lv in
					  lv_string
					)

        | UnOp (op, e, _) ->
            (printUnop op) ^ (transferExpr e)

        | BinOp (op, e1, e2, _) ->

            (transferExpr e1) ^ (printBinop op) ^ (transferExpr e2) 

        | _ -> String.uppercase (d_string "(%a)" d_exp e)
  in

let append_1postfix b = 
     Printf.fprintf !prologFile "%s" (!postfix1 ^ !if_string) ;
		 first_block := false;
     b
in

let append_2postfix s = 
 (* let pf = (if (first_block =1) then ( first_block := 2;   !postfix1 ^ !if_string)
         else !postfix2) in *)
   (* Printf.fprintf !prologFile "%s" pf;*)
	    Printf.fprintf !prologFile "%s" !postfix2;			
      s
in

let append_loopHead s =
	    Printf.fprintf !prologFile ", %s" !loopHead;			
			inLoop := false;
      s	  
in

let isLoopCondition b =
	 		let break_stmt =  List.hd (b.bstmts) in
					match break_stmt.skind with
					 | Goto (sref, l) -> true
					 | _ -> false
in

object (self)
  inherit nopCilVisitor
(* output Loop(b,loc,cont_stm,break_stm) 
	  method vstmt(s) =
    match s.skind with
			| Loop(b,loc,Some cont_stm, Some break_stm) ->	
				 Printf.fprintf !prologFile "\n output b: \n %s \n" (d_string "%a" d_block b);
				 Printf.fprintf !prologFile "\n output cont_stm: \n %s \n" (d_string "%a" d_stmt cont_stm);
				 Printf.fprintf !prologFile "\n output break_stm: \n %s \n" (d_string "%a" d_stmt break_stm);
				 DoChildren	
      | _ -> DoChildren
end output loop *)	

(* output Loop condition) 
 	  method vstmt(s) =
    match s.skind with
			|  If (e, b1, b2, _) when (isLoopCondition b2) ->
				 Printf.fprintf !prologFile "\n output e: \n %s \n" (d_string "%a" d_exp e);
				 Printf.fprintf !prologFile "\n output b1: \n %s \n" (d_string "%a" d_block b1);
				 Printf.fprintf !prologFile "\n output b2: \n %s \n" (d_string "%a" d_block b2);
				 DoChildren	
      | _ -> DoChildren
*)

  method vinst(i) =
    match i with
      | Set (lv, e, _) ->
      (* Printf.fprintf !prologFile "%s is %s, " (printLv lv) (printExpr e); *)
			 
			 let lv_previous = transforVarUse lv in
			 let expr_string = transferExpr e in
			 let lv_new = transforVarDef lv in		
		(	 if !inLoop then 
			    (*
						loopHead := !loopHead ^ lv_previous ^ "," ;  
					  let s = Printf.sprintf ", %s is %s" lv_new expr_string;
						loopBody := !loopBody ^ s *)
				(	loopHead := !loopHead ^ lv_previous ^ ","; loopBody := !loopBody ^ ", " ^ lv_new ^ " is " ^ expr_string)	 	
			 else if !firstInstr	then
				  ( Printf.fprintf !prologFile "%s is %s" lv_new expr_string; firstInstr := false)
		       else			Printf.fprintf !prologFile ", %s is %s" lv_new expr_string 
		 );
			
        SkipChildren
      | _ -> DoChildren

  method vstmt(s) =
    match s.skind with
		  |  Loop(b,loc,Some cont_stm, Some break_stm) ->	
				 inLoop := true;
				 hasLoop := true;
				 let loop_name = !curFundec.svar.vname ^ "_loop" ^ string_of_int (getNewId ()) in
				 loopHead := Printf.sprintf "%s(" loop_name;
				 newLoopHead := Printf.sprintf "%s(" loop_name;
				 ChangeDoChildrenPost(s, append_loopHead)
		  |  If (e, b1, b2, _) when (isLoopCondition b2) ->  (* loop condition*)
				 (
					loopConExpr := transferExpr e;
					loopBody := Printf.sprintf ":-  %s" !loopConExpr;
        (*  loopBody := !loopBody ^ !loopConExpr; *)
					SkipChildren		 (* because b1 is empty and b2 is goto while_break*)
					)
	 	  |  If (e, b1, b2, _) ->
         if_string := transferExpr e;
         first_block := true;
         Printf.fprintf !prologFile "((%s, " !if_string ;
         ChangeDoChildrenPost(s, append_2postfix)
      | Return (Some e, _) ->
					returnExpr := transferExpr e;
					(if (!hasLoop) then (loopHead := !loopHead ^ !returnExpr ^ ")"; Printf.fprintf !prologFile "%s)" !returnExpr)); (* ad hoc*)
          Printf.fprintf !prologFile ", RETURN is %s.\n" !returnExpr ; 
					(if (!hasLoop) then (Printf.fprintf !prologFile "\n%s %s, %s." !loopHead !loopBody !loopHead )); (* ad hoc*)
					(if (!hasLoop) then (Printf.fprintf !prologFile "\n%s :- \\+(%s), loopValOut is loopValin, !." !loopHead !loopConExpr ));  (* hard code *)
					hasLoop := false;
          SkipChildren
			| Return (None, _) ->
           Printf.fprintf !prologFile ".\n" ;
          SkipChildren		
      | _ -> DoChildren

method vblock(b) =
	 if (!first_block) then
				            ChangeDoChildrenPost(b, append_1postfix)
				            else
										DoChildren


(* main () -> main (int argc , char **argv ) *)
(* write function head to prolog file  *)
   method vfunc(f) = 
		  curFundec := f;
		  match f with
			| f when shouldSkipFunction f.svar -> SkipChildren
			| f when f.svar.vname = "main" -> 
				  let (ret, args, isVarArgs, attrs) = splitFunctionType f.svar.vtype in
					let ty = TFun (ret, Some ([argcArg;argvArg]), isVarArgs, attrs) in
					let argslist = argsToList args in
          let len = List.length argslist in
				(	if len > 1 then setFunctionType f ty
					else setFunctionTypeMakeFormals f ty);
					SkipChildren  
			| _ ->(
				    
				    Hashtbl.clear lvMap; (*  reset lv_expr hash table for each function *)
				    (* let prologFile = ref (open_out (f.svar.vname ^ ".pl")) in *)
						 let () = prologFile := open_out (f.svar.vname ^ ".pl") in
			       let () = Printf.fprintf !prologFile "%s (" f.svar.vname in
				     let (ret, args, isVarArgs, attrs) = splitFunctionType f.svar.vtype in
						 let argslist = argsToList args in
						 firstComma := true;
						 firstInstr := true;
						 List.iter (fun (string, _, _) ->  
						 (
							 if !firstComma	then
						     (Printf.fprintf !prologFile "%s" (String.uppercase string); firstComma :=false)
						   else 
								 (Printf.fprintf !prologFile ", %s" (String.uppercase string) )
							) )argslist;
			
							
					(	if isVoidType ret 
						   then Printf.fprintf !prologFile ") :- "
						   else Printf.fprintf !prologFile ", RETURN) :- ");
				
(*		         let assignFunc       = mkWrapperFunc f.svar.vname ret args in
						 let ret_tmp = makeTempVar !curFundec ~name:"__ret" ret in      *)
(*have bug						 let callWrapperStmt = mkStmt(Instr[Call(Some(Var(ret_tmp),NoOffset), Lval (var assignFunc), argsToList(args), locUnknown)]) in	 *)
			       DoChildren
						)

end

(*-------------------------End of class babelFuncTrans----------------------------------------------*)

(*
add exit function before returen of main
*)
class babelExitVisitorClass f = object (self)
  inherit nopCilVisitor
	 
		val prologStop =   
    let fdec = emptyFunction "Pl_Stop_Prolog" in
    fdec.svar.vtype <- TFun (voidType, Some [], false, []);
    fdec
	
  method vstmt (s : stmt) = begin
    match s.skind with
      Return _ -> 
          self#queueInstr [Call (None, Lval (var prologStop.svar), [], locUnknown)] ;
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

(*
add Pl_Start_Prolog function at the beginning of main
*)

let prologStart: fundec =  
				let fdec = emptyFunction "Pl_Start_Prolog" in
				let argvArg = ("argv", argvType, []) in
				let argcArg = ("argc", argcType, []) in
        fdec.svar.vtype <- TFun(intType, Some [argcArg;argvArg], false, []);                          
        fdec

let addBabelInitializer ?(main_name="main") (f: file) = 
   List.iter 
        (function 
            GFun(fdec, loc) when fdec.svar.vname = main_name ->
              (  let argvArg = ("argv", argvType, []) in
							   let argcArg = ("argc", argcType, []) in
  						   let argslist = fdec.sformals in
								 let argc_var = List.hd argslist in
								 let argc_exp = Lval(Var(argc_var),NoOffset) in
                 let argv_var = List.nth argslist ((List.length argslist) - 1) in
								 let argv_exp = Lval(Var(argv_var),NoOffset) in 
    		         prependToBlock [Call (None, Lval(var prologStart.svar), [argc_exp;argv_exp], locUnknown)] fdec.sbody;
               )			
            | _ -> ()) f.globals;
 f.globals <- GText("#include <gprolog.h>\n") :: f.globals																		

let prepareGlobalForCFG glob =
  match glob with
    GFun(func, _) -> prepareCFG func
  | _ -> ()

let addBabelWrapperFunction (f: file) =
	let wrapper_decl = 
"int __Babel_Wrapper(int n){
//generate a return value if a function is not void,partial routine code
  int return_value;

//rountine code
  int func;
  PlTerm arg[10];
  PlBool res;

//routine code, register a predicate,fibonacci is not routine
  func = Pl_Find_Atom(\"fibonacci\");

//routine code 
  Pl_Query_Begin(PL_FALSE);

//prepare parameters
//partial routine code, pass in parameter
  arg[0] = Pl_Mk_Integer(n);
//routine code, reserve a place for return value
  arg[1] = Pl_Mk_Variable();

//partial routine code, 2 is not routine. (number of arguments) + 1
  res = Pl_Query_Call(func, 2, arg);

//get return value, partial routine code, 1 is not routine
  return_value = Pl_Rd_Integer(arg[1]);

//routine code
  Pl_Query_End(PL_KEEP_FOR_PROLOG);

//routine code
  return return_value;
}" in
 f.globals <- GText(wrapper_decl) :: f.globals


let feature : featureDescr =
  { fd_name = "BabelFuncTrans";
    fd_enabled = ref false;
    fd_description = "transform a program's function in Prolog";
    fd_extraopt = [];
    fd_post_check = true;
    fd_doit =
      function (f: file) ->
        ((* Simplify the code:
          *  - simplifying expressions with complex memory references
          *  - converting loops and switches into goto's and if's
          *  - transforming functions to have exactly one return *)
          Simplemem.feature.fd_doit f ;
          iterGlobals f prepareGlobalForCFG ;
          Oneret.feature.fd_doit f ;
          (* To simplify later processing:
           *  - ensure that every 'if' has a non-empty else block
           *  - try to transform conditional expressions into predicates
           *    (e.g. "if (!x) {}" to "if (x == 0) {}") *)
          (let ncVisitor = new normalizeConditionalsVisitor in
             visitCilFileSameGlobals (ncVisitor :> cilVisitor) f) ;
          (* Clear out any existing CFG information. *)
          Cfg.clearFileCFG f ;
          (* Compute the control-flow graph. *)
          Cfg.computeFileCFG f ;		
          (* Finally instrument the program. *)
	  (let instVisitor = new babelFuncTrans f in
             visitCilFileSameGlobals (instVisitor :> cilVisitor) f) ;
          (* Add a function to initialize the instrumentation library. *)
          addBabelWrapperFunction f;
					addBabelExit f;
          addBabelInitializer f ;
				       
					);  
  }

