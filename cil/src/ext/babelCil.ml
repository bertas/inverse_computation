(* Copyright (c) 2012, Jiang Ming & Yufei Jiang
 *
 * This file is part of ****, which is distributed under the revised
 * BSD license.  A copy of this license can be found in the file LICENSE.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See LICENSE
 * for details.
 *)

open Cil

(*
 * Utilities that should be in the O'Caml standard libraries.
 *)

let isSome o =
  match o with
    | Some _ -> true
    | None   -> false


let curFundec : fundec ref = ref dummyFunDec
let idCount = ref 0
let stmtCount = Cfg.start_id
let funCount = ref 0
let branches = ref []
let curBranches = ref []
(* Control-flow graph is stored inside the CIL AST. *)

let getNewId () = ((idCount := !idCount + 1); !idCount)
let addBranchPair bp = (curBranches := bp :: !curBranches)
let addFunction () = (branches := (!funCount, !curBranches) :: !branches;
		      curBranches := [];
		      funCount := !funCount + 1)

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

let prependToBlock (is : instr list) (b : block) =
  b.bstmts <- mkStmt (Instr is) :: b.bstmts
	
let isSymbolicType ty = isIntegralType (unrollType ty)


let idType   = intType
let bidType  = intType
let fidType  = uintType
let valType  = TInt (ILongLong, [])
let addrType = TInt (IULong, [])
let boolType = TInt (IUChar, [])
let opType   = intType  (* enum *)
let argcType = intType
let argvType = TPtr(TPtr(charType, []),[])


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


class babelCil f =

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

	
  let mkInstFunc name args =
    let ty = TFun (voidType, Some (args), false, []) in
    let func = findOrCreateFunc f ("__Babel" ^ name) ty in  (* val findOrCreateFunc: file -> string -> typ -> varinfo **)
      func.vstorage <- Extern ;
      func.vattr <- [Attr ("babel_skip", [])] ;
      func
  in

	let assignFunc       = mkInstFunc "Assign" [addrArg; valArg] in	
	
  (*
   * Functions to create calls to the above instrumentation functions.
   *)
  let mkInstCall func args =
    let args' =  args in
      Call (None, Lval (var func), args', locUnknown)
  in

  let unaryOpCode op =
    let c =
      match op with
        | Neg -> 19  | BNot -> 20  |  LNot -> 21
    in
      integer c
  in

  let binaryOpCode op =
    let c =
      match op with
        | PlusA   ->  0  | MinusA  ->  1  | Mult  ->  2  | Div   ->  3
        | Mod     ->  4  | BAnd    ->  5  | BOr   ->  6  | BXor  ->  7
        | Shiftlt ->  8  | Shiftrt ->  9  | LAnd  -> 10  | LOr   -> 11
        | Eq      -> 12  | Ne      -> 13  | Gt    -> 14  | Le    -> 15
        | Lt      -> 16  | Ge      -> 17
            (* Other/unhandled operators discarded and treated concretely. *)
        | _ -> 18
    in
      integer c
  in

  let toAddr e = CastE (addrType, e) in

  let toValue e =
      if isPointerType (typeOf e) then
        CastE (valType, CastE (addrType, e))
      else
        CastE (valType, e)
  in

 let mkAssign addr value  = mkInstCall assignFunc [toAddr addr; toValue value] in

(* Transform conditional jmp to prolog's rules*)
  let mkJccFunc name args =
    let ty = TFun (intType, Some (args), false, []) in
    let func = findOrCreateFunc f ("__Babel" ^ name) ty in  (* val findOrCreateFunc: file -> string -> typ -> varinfo **)
      func.vstorage <- Extern ;
      func.vattr <- [Attr ("babel_skip", [])] ;
      func
  in

let jccFunc       = mkJccFunc "Jcc" [opArg; lvalArg; rvalArg] in

  let mkJccCall func ra args =
      let args' =  args in
      Call (Some(Var(ra),NoOffset), Lval (var func), args', locUnknown)
  in

let mkJcc ra op lvalue rvalue =  mkJccCall jccFunc ra [binaryOpCode op; toValue lvalue; toValue rvalue] in 

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

object (self)
  inherit nopCilVisitor

  method vstmt(s) =
    match s.skind with
      | If (BinOp (op, e1, e2, ty), b1, b2, loc) ->
          let getFirstStmtId blk = (List.hd blk.bstmts).sid in
          let b1_sid = getFirstStmtId b1 in
          let b2_sid = getFirstStmtId b2 in
             addBranchPair (b1_sid, b2_sid);
						  let jcc_tmp = makeTempVar !curFundec ~name:"__jcc" intType in 
							self#queueInstr [mkJcc jcc_tmp op e1 e2];
						  s.skind <- If (Lval(Var(jcc_tmp), NoOffset), b1, b2, loc) ;  
            DoChildren
			| _ -> DoChildren

  method vinst(i) =
    match i with
      | Set (lv, e, _) ->
          if (isSymbolicType (typeOf e)) && (hasAddress lv) then  
           (  self#queueInstr [mkAssign (addressOf lv) e];
						  ChangeTo [] ) 
          else SkipChildren 

			 | _ -> DoChildren


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
					DoChildren  
			| _ -> addFunction () ; DoChildren

end


(*
add exit function before returen of main
*)
class babelExitVisitorClass f = object (self)
  inherit nopCilVisitor
  method vstmt (s : stmt) = begin
    match s.skind with
      Return _ -> 
            let babelExitTy = TFun (voidType, Some [], false, []) in
            let babelExitFunc = findOrCreateFunc f "__BabelExit" babelExitTy in
            babelExitFunc.vstorage <- Extern ;
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
(*
let addBabelInitializer f =
  let babelInitTy = TFun (voidType, Some [], false, []) in
  let babelInitFunc = findOrCreateFunc f "__BabelInit" babelInitTy in
  let globalInit = getGlobInit f in
    babelInitFunc.vstorage <- Extern ;
    babelInitFunc.vattr <- [Attr ("babel_skip", [])] ;
    prependToBlock [Call (None, Lval (var babelInitFunc), [], locUnknown)]
                   globalInit.sbody;
	  f.globals <- GText("#include <SWI-Prolog.h>\n") :: f.globals
 *)

let addBabelInitializer ?(main_name="main") (f: file) = 
   List.iter 
        (function 
            GFun(fdec, loc) when fdec.svar.vname = main_name ->
              (  let argvArg = ("argv", argvType, []) in
  		 					 let babelInitTy = TFun (voidType, Some [argvArg], false, []) in
  							 let babelInitFunc = findOrCreateFunc f "__BabelInit" babelInitTy in
                 babelInitFunc.vstorage <- Extern ;
     		         babelInitFunc.vattr <- [Attr ("babel_skip", [])] ;
								 let argslist = fdec.sformals in
                 let argv_var = List.nth argslist ((List.length argslist) - 1) in
								 let argv_exp = Lval(Var(argv_var),NoOffset) in 
    		         prependToBlock [Call (None, Lval (var babelInitFunc), [argv_exp], locUnknown)]fdec.sbody;
               )			
            | _ -> ()) f.globals;
 f.globals <- GText("#include <SWI-Prolog.h>\n") :: f.globals																		

let prepareGlobalForCFG glob =
  match glob with
    GFun(func, _) -> prepareCFG func
  | _ -> ()


let feature : featureDescr =
  { fd_name = "BabelCil";
    fd_enabled = ref false;
    fd_description = "preprocess a c source file with Cil";
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
(*					
	  (let instVisitor = new babelTransform f in
             visitCilFileSameGlobals (instVisitor :> cilVisitor) f) ;
          (* Add a function to initialize the instrumentation library. *)
					addBabelExit f;
          addBabelInitializer f ;
*)				       
					);  
  }
