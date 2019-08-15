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


module E = Errormsg

(*
 * Utilities that should be in the O'Caml standard libraries.
 *)

let isSome o =
  match o with
    | Some _ -> true
    | None   -> false


let idCount = ref 0
let stmtCount = Cfg.start_id
let funCount = ref 0

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


(* this class transform all the global variables into local variables,
 * marking all the instrunctions into "babel_elim",
 * creating coressponding C instructions together with functions (on heap)
 * the babel_condition function will eliminate all the instructions with attributes
 * of "babel_elim", then do babel transform on control flow
 * *)

class babelTrans fdec =

  let counter = ref 0
  and gtable = Hashtbl.create 10
  and func_que = Queue.create ()
  and fd: fundec ref = ref dummyFunDec
  and babelFuncWhiteList = ["init64"; "dec64"; "enc64"] in


  let unaryOpCode op =
    let c =
      match op with
        | Neg -> 19  | BNot -> 20  |  LNot -> 21
    in
      integer c
  in

  let binaryOpCode op =
    (* let c = *)
      match op with
        | PlusA   ->  0  | MinusA  ->  1  | Mult  ->  2  | Div   ->  3
        | Mod     ->  4  | BAnd    ->  5  | BOr   ->  6  | BXor  ->  7
        | Shiftlt ->  8  | Shiftrt ->  9  | LAnd  -> 10  | LOr   -> 11
        | Eq      -> 12  | Ne      -> 13  | Gt    -> 14  | Le    -> 15
        | Lt      -> 16  | Ge      -> 17
            (* Other/unhandled operators discarded and treated concretely. *)
        | _ -> 18
    (* in *)
      (* integer c *)
  in

  let toAddr e = CastE (addrType, e) in

  let toValue e =
      if isPointerType (typeOf e) then
        CastE (valType, CastE (addrType, e))
      else
        CastE (valType, e) in

  let mkInstFunc name args =
    let args' = List.map (fun v -> (v.vname, v.vtype, v.vattr)) args in
    let ty = TFun (voidType, Some (args'), false, []) in
    let func = findOrCreateFunc fdec name ty in
      func.vstorage <- Extern;
      func.vattr <- [Attr ("babel_skip", [])];
      func in

  let mkInstFunc_ret name args rt =
    let args' = List.map (fun v -> (v.vname, v.vtype, v.vattr)) args in
    let ty = TFun (rt, Some (args'), false, []) in
    let func = findOrCreateFunc fdec name ty in
      func.vstorage <- Extern;
      func.vattr <- [Attr ("babel_skip", [])];
      func in

  let mkInstCall func gl =
      Call (None, Lval (var func), gl, locUnknown) in

  let mkInstCall_ret func gl ret =
      Call (Some ret, Lval (var func), gl, locUnknown) in

  let mkCallInstr name gl =
      let el = List.map (
          fun v ->
            let n =
              if v.vname.[0] = '*' then
                String.sub v.vname 1 (String.length v.vname - 1)
              else v.vname in
            let v' = copyVarinfo v n in
              Lval (Var v',NoOffset)
          ) gl in
    let ptrInstr name = mkInstFunc name gl in
     mkInstCall (ptrInstr name) el in


  let mkInit name gl v =
      let el = List.map (
          fun v ->
            let n =
              if v.vname.[0] = '*' then
                String.sub v.vname 1 (String.length v.vname - 1)
              else v.vname in
            let v' = copyVarinfo v n in
              Lval (Var v',NoOffset)
          ) gl in
    let ptrInstr name = mkInstFunc name gl in
     mkInstCall_ret (ptrInstr name) el (Var v,NoOffset) in


  (* might be adjusted when doing Prolog transform *)
  let mkRet name gl fd =
    let rn = fd.svar.vname^"_ret"   (* there should be not var with same name *)
    and ft = fd.svar.vtype in
    let TFun (rt, _, _, _) = ft in  (* crash if not TFun, but that won't happen *)
    let r = makeLocalVar fd rn rt
    and ptrInstr name = mkInstFunc_ret name gl ft in
      let el = List.map (
          fun v ->
            let n =
              if v.vname.[0] = '*' then
                String.sub v.vname 1 (String.length v.vname - 1)
              else v.vname in
            let v' = copyVarinfo v n in
              Lval (Var v',NoOffset)
          ) gl in
        mkInstCall_ret (ptrInstr name) el (Var r,NoOffset) in

  let e_str e =
      Pretty.sprint max_int (Cil.d_exp () e) in

  let lv_str lv =
      Pretty.sprint max_int (Cil.d_lval () lv) in

  let op_str op =
      Pretty.sprint max_int (Pretty.num (binaryOpCode op)) in

  let loc_str loc =
      Pretty.sprint max_int (Cil.d_loc () loc) in

  let t_str t =
      Pretty.sprint max_int (Cil.d_type () t) in

  let i_str i =
      Pretty.sprint max_int (Cil.d_instr () i) in

  let s_str i =
      Pretty.sprint max_int (Cil.d_stmt () i) in

  object (self)
    inherit nopCilVisitor

  val mutable f_args : varinfo list = []
  val mutable f_typ : string = ""

  method cTypeToPlType t =
     let t_str t =
        Pretty.sprint max_int (Cil.d_type () t) in
    match t with
    | TInt (ik, _) ->
      begin match ik with
      | IChar -> "char"
      | IBool -> "boolean"
      | IInt -> "integer"
      | IUInt -> "positive"
      | IShort -> "short"
      | IUShort -> "unsigned short"
      | ILong -> "integer"
      | IULong -> "positive"
      end
    | TFloat (fk, _) ->
      begin match fk with
      | FFloat | FDouble -> "float"
      | FLongDouble -> "float"
      end
    | _ ->
      let s =  t_str t in
        E.log "cTypeToPlType failed  %s \n" s;
        ""
    (*TODO : we should have other cases*)

    method formal_args gl =
      let t_str t =
        Pretty.sprint max_int (Cil.d_type () t) in
      let rec helper args =
        match args with
          | h::t ->
              let ts = t_str (self#get_type h) in
              ts^" "^h.vname^","^(helper t)
          | [] -> "" in
      let fa = helper gl in
        if fa = "" then ""
        else
          String.sub fa 0 (String.length fa - 1)

  method create_cinstr i gl =
     let fs = !fd.svar.vname in
    let c_cinstr str_i =
      let gls = self#formal_args gl in
      let s = "void "^fs^"_c_instr_"^(string_of_int !counter)^"("^gls^")\n{\n"^str_i^";\n}\n" in
        Queue.add s func_que;
        counter := !counter + 1 in
    let s = fs^"_c_instr_"^(string_of_int !counter) in
      c_cinstr (i_str i);
      mkCallInstr s gl

  (* check certain instr has func args, if not, return [] *)
  method get_all_args_instr i =
    let p = object
      inherit nopCilVisitor
      val mutable vars : varinfo list = []
      method get_vars = vars
      method vvrbl v =
         match v.vtype with
            | (TFun _) -> SkipChildren
            | (_) ->
              begin
                ( if List.mem v vars || v.vglob then
                  ()
                else vars <- v :: vars );
                DoChildren
              end
            | _ ->
              DoChildren
    end in
    match i with
      | Set(lval, exp, lc) ->
        ignore(visitCilLval (p :> cilVisitor) lval);
        ignore(visitCilExpr (p :> cilVisitor) exp);
        p#get_vars
      | Call (None, _, elist, _) ->
        let _ = List.map (visitCilExpr (p :> cilVisitor)) elist in
          p#get_vars
      | Call (Some lv, _, elist, _) ->
        ignore(visitCilLval (p :> cilVisitor) lv);
        let _ = List.map (visitCilExpr (p :> cilVisitor)) elist in
          p#get_vars
      | _ -> failwith "unhandled pattern in get_all_args"

  method elim_instr i =
    match i with
    | Set _ | Call _ ->
      let gl = self#get_all_args_instr i in
        self#create_cinstr i gl
    | _ ->
      let is = i_str i in
      failwith ("unhandled situation"^is) (* TODO *)

  method create_cret e =
    match e with
      | Lval (Var vi, _) -> (
                    let ts = t_str vi.vtype in
                      let arg = ts^" "^vi.vname in
                      let rets = "return "^(e_str e)^";" in
                      (* TODO: ad-hoc way, error when return value are pointers *)
                    let s = ts^" c_ret_"^(string_of_int !counter)^"("^arg^")\n{\n"^rets^";\n}\n" in
                      Queue.add s func_que;
                    let s = "c_ret_"^(string_of_int !counter) in
                      counter := !counter + 1;
                      mkRet s [vi] !fd
                   )
      | _ -> failwith "unhandled return type"


  method create_ccond s gl =
    let fs = !fd.svar.vname in
    let c_ccond str_s =
      let gls = self#formal_args gl in
      let s = "void "^fs^"_c_cond_"^(string_of_int !counter)^"("^gls^")\n{\n"^str_s^";\n}\n" in
        Queue.add s func_que;
        counter := !counter + 1 in
    let s' = fs^"_c_cond_"^(string_of_int !counter) in
      c_ccond (s_str s);
      mkCallInstr s' gl

  (* check certain instr has func args, if not, return [] *)
  (* we should not include the global variables *)
  method get_all_args_stmt s =
    let p = object
      inherit nopCilVisitor
      val mutable vars : varinfo list = []
      method get_vars = vars
      method vvrbl v =
         match v.vtype with
            | (TFun _) -> SkipChildren
            | (_) ->
              begin
                ( if List.mem v vars || v.vglob then
                  ()
                else vars <- v :: vars );
                DoChildren
              end
            | _ ->
              DoChildren
    end in
    match s.skind with
      | If (BinOp (op, e1, e2, ty), b1, b2, loc) ->
          ignore(visitCilExpr (p :> cilVisitor) e1);
          ignore(visitCilExpr (p :> cilVisitor) e2);
          ignore(visitCilBlock (p :> cilVisitor) b1);
          ignore(visitCilBlock (p :> cilVisitor) b2);
          p#get_vars
      | Loop (b, loc, s1, s2) ->
          ignore(visitCilBlock (p :> cilVisitor) b);
          p#get_vars
      | Switch (e, b, sl, _) ->
          ignore(visitCilExpr (p :> cilVisitor) e);
          ignore(visitCilBlock (p :> cilVisitor) b);
          List.map (visitCilStmt (p :> cilVisitor)) sl;
          p#get_vars
      | _ -> failwith "unhandled pattern in get_all_args_stmt"

  method elim_stmt s =
    let gl = self#get_all_args_stmt s in
      self#create_ccond s gl

  method vstmts s =
    match s.skind with
      | Instr instrList ->
            s.skind <- Instr (List.map (self#elim_instr) instrList)
      | If (BinOp (op, e1, e2, ty), b1, b2, loc) ->
            s.skind <- Instr [(self#elim_stmt s)]
      | Loop (b, loc, stmt1, stmt2) ->
            s.skind <- Instr [(self#elim_stmt s)]
        (* Watch out! after the CIL simplify, all the loop statements are put
         * in basic blocks! *)
      | Block b ->
            List.iter (self#vstmts) b.bstmts
       | Return (Some e, loc) ->
              s.skind <- Instr [(self#create_cret e)]
       | Switch _ -> s.skind <- Instr [(self#elim_stmt s)]
       | _ -> ()

  method g_collect f =
      let varVisitor = object
        inherit nopCilVisitor
        val mutable vars : varinfo list = []
        method get_vars = vars
        method vvrbl v =
          match (v.vglob, v.vtype) with
            | (_, TFun _) -> SkipChildren
            | (true, _ ) ->
              begin
                 vars <- v::vars;
                 DoChildren
              end
            | _ ->
                DoChildren
        end in
          ignore(visitCilFunction (varVisitor :> cilVisitor) f);
          varVisitor#get_vars

  method insert_gstart globals =
      let t_str t =
       Pretty.sprint max_int (Cil.d_type () t) in
      let helper gvar =
        let gval = (Var gvar, NoOffset)
        and t = t_str gvar.vtype
        and new_name = gvar.vname^"01" in
        let new_fake_name = t^new_name
        and new_gvar = copyVarinfo gvar new_name in
        let new_fake_gvar = copyVarinfo gvar new_fake_name in
          new_gvar.vglob <- false;
          new_fake_gvar.vglob <- false;
          Hashtbl.replace gtable gvar.vname (Var new_gvar, NoOffset);
          mkStmtOneInstr(Set((Var new_fake_gvar, NoOffset), Lval gval, locUnknown)) in
      List.map helper globals

  method insert_gend globals =
      let helper gvar =
        let new_gvar = Hashtbl.find gtable gvar.vname in
          mkStmtOneInstr(Set((Var gvar, NoOffset), Lval new_gvar, locUnknown)) in
       List.map helper globals

  method local_collect f =
    f.slocals <- List.map (fun v ->
        match v.vtype with
        | TArray _-> v
        | _ -> v.vname <- ("*"^v.vname); v ) f.slocals

  method type_collect f =
    let t_str t =
      Pretty.sprint max_int (Cil.d_type () t) in
    f_typ <- t_str f.svar.vtype

  method create_decl v =
    let t_str t =
        Pretty.sprint max_int (Cil.d_type () t) in
    let n = v.vname
    and ts = t_str v.vtype in
      let ret = "static "^ts^" "^n^";" in
        ret

  method create_heap_init func v =
    match v.vtype with
    | TArray _ -> self#create_heap_init_arr func v
    | _ -> self#create_heap_init_normal func v

  method create_heap_init_normal func v =
    let ts = t_str (self#get_type v) in
    let n = v.vname in
      let n' = String.sub n 1 (String.length n - 1) in
    let fb_name = ts^"* func_init_"^func.svar.vname^"_"^n'^"(){\n"
    and t_str t =
        Pretty.sprint max_int (Cil.d_type () t) in
        let ret = "return ("^ts^"*)malloc(sizeof("^ts^"));" in
          fb_name^ret^"\n}"

  method create_heap_init_arr func v =
    let ts = t_str (self#get_type v) in
    let n = v.vname
    and len = self#array_len v in
    let fb_name = ts^" func_init_"^func.svar.vname^"_"^n^"(){\n"
    and ts = t_str (self#get_type v) in
      let ret = "return ("^ts^")malloc("^len^"*sizeof("^ts^"));" in
        fb_name^ret^"\n}"

  (* get type of each entry in one array *)
  method get_type v =
    match v.vtype with
      | TArray (t, _, attr) -> TPtr (t, attr)
      | _ -> v.vtype

  method create_heap_free v =
    let n = String.copy v.vname in
      if n.[0] = '*' then n.[0] <- ' ';
      let ret = "if("^n^"){\nfree("^n^");\n"^n^" = NULL;\n}" in
        ret

  method array_len v =
    match v.vtype with
    | TArray (_, Some e, _) -> e_str e
    | _ -> failwith "unhandled array_len situation"

  (* for pointer names start with one or more *, we remove all prefix * *)
  method pname_trim s =
    let rec help s' i =
      if s'.[i] = ' ' || s'.[i] = '*' then
        help s' (i+1)
      else i  in
    let i' = help s 0 in
      String.sub s i' (String.length s - i')

  method create_cfunc_stmt func =
      let concat_body b sl =
        b := String.concat "\n" sl
      and b_init = ref ""
      and b_free = ref ""
      and () = self#local_collect func in
        let b_args = self#formal_args func.slocals in
          let ff_name = "void func_free_"^(func.svar.vname)^"("^b_args^"){\n"
          and oc = open_out ("babel_"^(func.svar.vname)^".c") in
            (List.map (self#create_heap_init func) func.slocals
            |> concat_body b_init);
            (List.map self#create_heap_free func.slocals
            |> concat_body b_free);
            Printf.fprintf oc "%s\n%s%s\n}" !b_init ff_name !b_free;
            close_out oc

  method cfunc_init_call func =
    let vlist = func.slocals in
    List.map (fun v ->
              let n = self#pname_trim v.vname in
                let fb_name = "func_init_"^func.svar.vname^"_"^n in
                  mkStmtOneInstr(mkInit fb_name [] v)
            ) vlist

  method cfunc_free_call func =
    let vlist = func.slocals
    and fb_name = "func_free_"^(func.svar.vname) in
      [mkStmtOneInstr(mkCallInstr fb_name vlist)]

  method append_cfunc_stmt func =
    let stmts = Queue.fold (^) "\n" func_que in
    let oc = open_out_gen [Open_append] 0o666 ("babel_"^(func.svar.vname)^".c") in
      Printf.fprintf oc "%s" stmts;
      close_out oc

  method clear =
    Hashtbl.reset gtable;
    Queue.clear func_que

  method vfunc(f) =
    match f with
      | f when List.mem f.svar.vname babelFuncWhiteList ->
          let globals = self#g_collect f in
          f.svar.vattr <- [Attr ("babel_trans", [])];
          self#create_cfunc_stmt f;
          self#type_collect f;
          f_args <- f.sformals;
          fd := f;
          List.iter self#vstmts f.sbody.bstmts;
          (* f.sbody.bstmts <- (self#insert_gstart globals)@f.sbody.bstmts; *)
          (* f.sbody.bstmts <- f.sbody.bstmts@(self#insert_gend globals); *)
          f.sbody.bstmts <- (self#cfunc_init_call f)@f.sbody.bstmts;
          f.sbody.bstmts <- f.sbody.bstmts@(self#cfunc_free_call f);
          (* f.sbody.bstmts <- f.sbody.bstmts@(self#cfunc_ret f); *)
          self#append_cfunc_stmt f;
          self#clear;
          DoChildren
      | f ->
          f.svar.vattr <- [Attr ("babel_skip", [])];
          DoChildren
      | _ -> SkipChildren

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
            (* babelExitFunc.vstorage <- Extern; *)
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
                 (* babelInitFunc.vstorage <- Extern; *)
                 babelInitFunc.vattr <- [Attr ("babel_skip", [])];
                 let argslist = fdec.sformals in
                 let l = List.length argslist in
                 (* TODO: currently main function without argc,argv will crush*)
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
  { fd_name = "BabelCondition";
    fd_enabled = ref false;
    fd_description = "transform a program's if conditons in Prolog";
    fd_extraopt = [];
    fd_post_check = true;
    fd_doit =
      function (f: file) ->
        ((* Simplify the code:
          *  - simplifying expressions with complex memory references
          *  - converting loops and switches into goto's and if's
          *  - transforming functions to have exactly one return *)
          Simplemem.feature.fd_doit f ;
          (* iterGlobals f prepareGlobalForCFG ; *)
          Oneret.feature.fd_doit f ;
          (* To simplify later processing:
           *  - ensure that every 'if' has a non-empty else block
           *  - try to transform conditional expressions into predicates
           *    (e.g. "if (!x) {}" to "if (x == 0) {}") *)
          (let ncVisitor = new normalizeConditionalsVisitor in
             visitCilFileSameGlobals (ncVisitor :> cilVisitor) f) ;
          (* Clear out any existing CFG information. *)
          (* Cfg.clearFileCFG f ; *)
          (* Compute the control-flow graph. *)
          (* Cfg.computeFileCFG f ; *)
          (* Finally instrument the program. *)
    (let translator = new babelTrans f in
             visitCilFileSameGlobals (translator :> cilVisitor) f) ;
          (* Add a function to initialize the instrumentation library. *)
					addBabelExit f;
          addBabelInitializer f ;

					);
  }
