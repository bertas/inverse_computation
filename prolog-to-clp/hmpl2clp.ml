:- use_module(library(clpfd)).
:- use_module(library(ansi_term)).
:- use_module(library(type_check)).

:- op(1150, fx, infer).
:- op(1150, fx, type).
:- op(1130, xfx, ---> ).
:- op(1150, fx, pred).
:- op(1150, fx, trust_pred).
:- op(500,yfx,::).
:- op(500,yfx,:<).

:- dynamic have_type/1.

class read_file =
	object(self)
    inherit nopCilVisitor

    method vstmt (s: stmt) : stmt visitAction = 
      match s.skind with
      | Instr(il) ->
          let instrToStmt = fun i -> mkStmtOneInstr i in
          let stmtList = List.map instrToStmt il in
          let blk = mkBlock(stmtList) in
          ChangeTo(mkStmt(Block(blk)))
      | _ -> DoChildren

  	end

class process (localsAndParams: varinfo list) =
	object(self)
    	inherit nopCilVisitor

    	val mutable aliasSet = VS.empty

    	method getAliasSet = aliasSet

    	method resolveExp = resolveExp localsAndParams

    	method vlval (lv: lval) : lval visitAction = 
      		match lv with 
      		| Mem(e), NoOffset ->
          	let aliasList = self#resolveExp e in
          	let newAliasSet = List.fold_left (fun s v -> VS.add v s) aliasSet aliasList in
          	aliasSet <- newAliasSet;
          	DoChildren
      		| _ -> DoChildren

    	method vexpr (e: exp) : exp visitAction =
      		let aliasList = self#resolveExp e in
      		let newAliasSet = List.fold_left (fun s v -> VS.add v s) aliasSet aliasList in
      		aliasSet <- newAliasSet;
      		DoChildren
      
  	end

class insert (localsAndParams: fd: fundec) =
  	object(self)
    	inherit nopCilVisitor

    	val localsAndParams =
      	List.filter (fun x -> isSimpleType x.vtype) (fd.slocals @ fd.sformals)

    method resolveExp = resolveExp localsAndParams

    method private mkFlushReadInstr (v: varinfo) : instr =
      	let vp =
        	try
          		IH.find flushHash v.vid
        	with
          		Not_found -> 
            		let init = SingleInit(AddrOf(Var(v), NoOffset)) in
            		let ty = TPtr(v.vtype, [Attr("const", [])]) in
            		v.vaddrof <- true;
            		let vp' = makeLocalVar fd (cilFlushPrefix ^ v.vname) ~init:init ty in
            		IH.add flushHash v.vid vp';
            		vp'
      	in
      	let mem = Mem(Lval(Var(vp), NoOffset)) in
      	Set((Var(v), NoOffset), Lval(mem, NoOffset), locUnknown)

    method private mkFlushWriteInstr (v: varinfo) : instr =    
      	let vp = 
        	try
          		IH.find flushHash v.vid
        with
          	Not_found -> 
            	let init = SingleInit(AddrOf(Var(v), NoOffset)) and
                	ty = TPtr(v.vtype, [Attr("const", [])]) in
            v.vaddrof <- true;
            let vp' = makeLocalVar fd (cilFlushPrefix ^ v.vname) ~init:init ty in
            IH.add flushHash v.vid vp';
            vp'
      	in
      	let mem = Mem(Lval(Var(vp), NoOffset)) in
      	Set((mem, NoOffset), Lval(Var(v), NoOffset), locUnknown)

class typeinference =
	object(self)
    	inherit nopCilVisitor

    	val rd = new detectReturnVisitor

    	method private needReplicate (ib: block) (eb: block) : bool * bool =
      		let hasReturnBlock b =
        		List.fold_left (||) false (List.map rd#hasReturn b.bstmts)
      		in
      		let rec ifLastNonBlkStmtNotReturn blk = 
        	let len = List.length blk.bstmts in
        	if len = 0 then
          		true
        	else
          	let lastStmt = List.nth blk.bstmts (len - 1) in
          	match lastStmt.skind with
          	| Return(_, _) -> false
          	| Block(blk') -> ifLastNonBlkStmtNotReturn blk'
          	| If(_, ib, eb, _) ->
            	((ifLastNonBlkStmtNotReturn ib) && (ifLastNonBlkStmtNotReturn eb))
          	| Loop(_, _, _, _) ->
            	raise(Invalid_argument "stmtReplicator cannot process loop statements")
          	| Switch(_, _, _, _) ->
            	raise(Invalid_argument "stmtReplicator cannot process switch statements")
          	| _ -> true
      	in
      	let hasRet = (hasReturnBlock ib) || (hasReturnBlock eb) in
      	if hasRet then
        	(ifLastNonBlkStmtNotReturn ib), (ifLastNonBlkStmtNotReturn eb)
      	else
        	false, false
              
    	method vstmt (s: stmt) : stmt visitAction =
      		match s.skind with
      		| If(cond, ib, eb, loc) ->
          		let iNeedRep, eNeedRep = self#needReplicate ib eb in
          		if iNeedRep || eNeedRep then
            		let stmtsToRep = getSameLevelSuccTrans s in
            		let iRepStmts = List.map copyStmt stmtsToRep in
            		let eRepStmts = List.map copyStmt stmtsToRep in
            		let ib' = if iNeedRep then mkBlock (ib.bstmts @ iRepStmts) else ib in
            		let eb' = if eNeedRep then mkBlock (eb.bstmts @ eRepStmts) else eb in
            		ChangeDoChildrenPost(mkStmt(If(cond, ib', eb', loc)), fun x -> x)
          		else
            		DoChildren
      	| _ -> 
          	DoChildren

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

class term_expansion (fd: fundec) =
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

class find_constructor =
  object(self)
    inherit nopCilVisitor

    val localsAndParams = fd.slocals @ fd.sformals

    method private isNonSSAVar (vi: varinfo) : bool =
      isFunctionType vi.vtype || isArrayType vi.vtype || vi.vglob

    method vvrbl (vi: varinfo) : varinfo visitAction =
      if self#isNonSSAVar vi then
        SkipChildren
      else
        let sn = VM.find vi.vname map in
        let nvname = varSSAName vi.vname sn in
        let nv =
          try
            List.find (fun vi -> vi.vname = nvname) localsAndParams
          with
            Not_found -> makeLocalVar fd nvname vi.vtype
        in
  ChangeTo nv
  end

class find_predicates =
	object(self)
    	inherit nopCilVisitor

    	val rd = new detectReturnVisitor

    	method private needReplicate (ib: block) (eb: block) : bool * bool =
      		let hasReturnBlock b =
        		List.fold_left (||) false (List.map rd#hasReturn b.bstmts)
      		in
      		let rec ifLastNonBlkStmtNotReturn blk = 
        		let len = List.length blk.bstmts in
        		if len = 0 then
          			true
        	else
     			let lastStmt = List.nth blk.bstmts (len - 1) in
          		match lastStmt.skind with
          		| Return(_, _) -> false
          		| Block(blk') -> ifLastNonBlkStmtNotReturn blk'
          		| If(_, ib, eb, _) ->
              		((ifLastNonBlkStmtNotReturn ib) && (ifLastNonBlkStmtNotReturn eb))
          		| Loop(_, _, _, _) ->
              		raise(Invalid_argument "stmtReplicator cannot process loop statements")
          		| Switch(_, _, _, _) ->
              		raise(Invalid_argument "stmtReplicator cannot process switch statements")
          		| _ -> true
      		in
      		let hasRet = (hasReturnBlock ib) || (hasReturnBlock eb) in
      		if hasRet then
        		(ifLastNonBlkStmtNotReturn ib), (ifLastNonBlkStmtNotReturn eb)
      		else
        		false, false
              
    	method vstmt (s: stmt) : stmt visitAction =
      		match s.skind with
      		| If(cond, ib, eb, loc) ->
          		let iNeedRep, eNeedRep = self#needReplicate ib eb in
          		if iNeedRep || eNeedRep then
            		let stmtsToRep = getSameLevelSuccTrans s in
            		let iRepStmts = List.map copyStmt stmtsToRep in
            		let eRepStmts = List.map copyStmt stmtsToRep in
					let ib' = if iNeedRep then mkBlock (ib.bstmts @ iRepStmts) else ib in
            		let eb' = if eNeedRep then mkBlock (eb.bstmts @ eRepStmts) else eb in
            		ChangeDoChildrenPost(mkStmt(If(cond, ib', eb', loc)), fun x -> x)
          		else
            		DoChildren
      		| _ -> 
          			DoChildren

    	method vexpr (e: exp) : exp visitAction =
      		SkipChildren

   		 method vlval (lv: lval) : lval visitAction =
      		SkipChildren

  	end

class getenvironment  (fd: fundec) (hasReturn: bool) =
  	object(self)
    	inherit nopCilVisitor

    	val mutable retVal : varinfo option = 
      		if hasReturn then
        		let retTy = getFunctionReturnType fd in
        		if isVoidType retTy then
          			None
        		else
          			let var = makeTempVar fd ~name:"__cil_ret" retTy in
          			Some var
      		else
        		None

    	method getRetVar = 
     		 match retVal with
      		| Some var -> var
     		| None -> raise(Not_found)

    	method getRetVarAsExp = 
     		match retVal with
      		| Some var -> Lval(Var(var), NoOffset)
      		| None -> raise(Not_found)

    	method encapReturn (e: exp) (loc: location) : stmt =
      		let retLval = Var(self#getRetVar), NoOffset in
      		let retStmt = mkStmt (Return(Some(Lval(retLval)), loc)) in
      		let si = Set(retLval, e, loc) in
      		let setStmt = mkStmtOneInstr(si) in
      		let block = mkBlock([setStmt; retStmt]) in
      		mkStmt(Block(block))

    	val inloop = ref 0

    	method vstmt (s: stmt) : stmt visitAction =
      		match s.skind with
      		| Loop(_) ->
          		inloop := !inloop + 1;
          		ChangeDoChildrenPost(s, fun x-> inloop := !inloop - 1; x)
      		| Return(Some e, loc) ->
          		if !inloop = 1 then (* only search the first-level loop *)
            		ChangeTo(self#encapReturn e loc)
          		else
            		SkipChildren
      		| _ ->
          		DoChildren
  	end

class transfer (fd: fundec) ==
	object (self)
	object(self)
    inherit nopCilVisitor

    val mutable ifHasReturn = false

    method hasReturn (s: stmt) : bool =
      	ifHasReturn <- false;
      	ignore(visitCilStmt (self :> cilVisitor) s);
      	ifHasReturn

    method vstmt (s: stmt) : stmt visitAction =
      	let removePred succ =
        	succ.preds <- List.filter (fun x -> x.sid != s.sid) succ.preds
      	in
      	if s.sid = initId then
        	DoChildren
      	else
        	match s.preds with
        	| [] ->
            	List.iter removePred s.succs;
            	ChangeTo(mkEmptyStmt ())
        	| _ -> DoChildren
      	if ifHasReturn then
        	SkipChildren
      	else
        match s.skind with
        	| Return(_, _) -> ifHasReturn <- true; SkipChildren
        	| _ -> DoChildren

    method vexpr (e: exp) : exp visitAction =
      	SkipChildren

    method vlval (lv: lval) : lval visitAction =
      	SkipChildren

  	end

class getintvarslist (fd: fundec) (map: int VM.t) =
  	object(self)
    	inherit nopCilVisitor

    	val localsAndParams = fd.slocals @ fd.sformals

    	method private isNonSSAVar (vi: varinfo) : bool =
      		isFunctionType vi.vtype || isArrayType vi.vtype || vi.vglob

    	method vvrbl (vi: varinfo) : varinfo visitAction =
      		if self#isNonSSAVar vi then
        		SkipChildren
      		else
        		let sn = VM.find vi.vname map in
        		let nvname = varSSAName vi.vname sn in
        		let nv =
          			try
            			List.find (fun vi -> vi.vname = nvname) localsAndParams
          			with
            			Not_found -> makeLocalVar fd nvname vi.vtype
        		in
	ChangeTo nv
  	end

class extracttype (fd: fundec) = 
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

class get_head_type (fd: fundec) (hasReturn: bool) =
  object(self)
    inherit nopCilVisitor

    val mutable retVal : varinfo option = 
      if hasReturn then
        let retTy = getFunctionReturnType fd in
        if isVoidType retTy then
          None
        else
          let var = makeTempVar fd ~name:"__cil_ret" retTy in
          Some var
      else
        None

    method getRetVar = 
      match retVal with
      | Some var -> var
      | None -> raise(Not_found)

    method getRetVarAsExp = 
      match retVal with
      | Some var -> Lval(Var(var), NoOffset)
      | None -> raise(Not_found)

    method encapReturn (e: exp) (loc: location) : stmt =
      let retLval = Var(self#getRetVar), NoOffset in
      let retStmt = mkStmt (Return(Some(Lval(retLval)), loc)) in
      let si = Set(retLval, e, loc) in
      let setStmt = mkStmtOneInstr(si) in
      let block = mkBlock([setStmt; retStmt]) in
      mkStmt(Block(block))

    val inloop = ref 0

    method vstmt (s: stmt) : stmt visitAction =
      match s.skind with
      | Loop(_) ->
          inloop := !inloop + 1;
          ChangeDoChildrenPost(s, fun x-> inloop := !inloop - 1; x)
      | Return(Some e, loc) ->
          if !inloop = 1 then (* only search the first-level loop *)
            ChangeTo(self#encapReturn e loc)
          else
            SkipChildren
      | _ ->
          DoChildren
  end

class construct_head_type = 
  object(self)
    inherit nopCilVisitor

    val mutable ifHasReturn = false

    method hasReturn (s: stmt) : bool =
      ifHasReturn <- false;
      ignore(visitCilStmt (self :> cilVisitor) s);
      ifHasReturn

    method vstmt (s: stmt) : stmt visitAction =
      if ifHasReturn then
        SkipChildren
      else
        match s.skind with
        | Return(_, _) -> ifHasReturn <- true; SkipChildren
        | _ -> DoChildren

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

class get_env =
  object(self)
    inherit nopCilVisitor

    val rd = new detectReturnVisitor

    method private needReplicate (ib: block) (eb: block) : bool * bool =
      let hasReturnBlock b =
        List.fold_left (||) false (List.map rd#hasReturn b.bstmts)
      in
      let rec ifLastNonBlkStmtNotReturn blk = 
        let len = List.length blk.bstmts in
        if len = 0 then
          true
        else
          let lastStmt = List.nth blk.bstmts (len - 1) in
          match lastStmt.skind with
          | Return(_, _) -> false
          | Block(blk') -> ifLastNonBlkStmtNotReturn blk'
          | If(_, ib, eb, _) ->
              ((ifLastNonBlkStmtNotReturn ib) && (ifLastNonBlkStmtNotReturn eb))
          | Loop(_, _, _, _) ->
              raise(Invalid_argument "stmtReplicator cannot process loop statements")
          | Switch(_, _, _, _) ->
              raise(Invalid_argument "stmtReplicator cannot process switch statements")
          | _ -> true
      in
      let hasRet = (hasReturnBlock ib) || (hasReturnBlock eb) in
      if hasRet then
        (ifLastNonBlkStmtNotReturn ib), (ifLastNonBlkStmtNotReturn eb)
      else
        false, false
              
    method vstmt (s: stmt) : stmt visitAction =
      match s.skind with
      | If(cond, ib, eb, loc) ->
          let iNeedRep, eNeedRep = self#needReplicate ib eb in
          if iNeedRep || eNeedRep then
            let stmtsToRep = getSameLevelSuccTrans s in
            let iRepStmts = List.map copyStmt stmtsToRep in
            let eRepStmts = List.map copyStmt stmtsToRep in
            let ib' = if iNeedRep then mkBlock (ib.bstmts @ iRepStmts) else ib in
            let eb' = if eNeedRep then mkBlock (eb.bstmts @ eRepStmts) else eb in
            ChangeDoChildrenPost(mkStmt(If(cond, ib', eb', loc)), fun x -> x)
          else
            DoChildren
      | _ -> 
          DoChildren

    method vexpr (e: exp) : exp visitAction =
      SkipChildren

    method vlval (lv: lval) : lval visitAction =
      SkipChildren

  end

class add_to_env =
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

class infer_body =
  object(self)
    inherit nopCilVisitor

    val mutable aliasSet = VS.empty

    method getAliasSet = aliasSet

    method resolveExp = resolveExp localsAndParams

    method vlval (lv: lval) : lval visitAction = 
      match lv with 
      | Mem(e), NoOffset ->
          let aliasList = self#resolveExp e in
          let newAliasSet = List.fold_left (fun s v -> VS.add v s) aliasSet aliasList in
          aliasSet <- newAliasSet;
          DoChildren
      | _ -> DoChildren

    method vexpr (e: exp) : exp visitAction =
      let aliasList = self#resolveExp e in
      let newAliasSet = List.fold_left (fun s v -> VS.add v s) aliasSet aliasList in
      aliasSet <- newAliasSet;
      DoChildren
      
  end

  class construct_type (fd: fundec) = 
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

let doit (input: file * StrSet) : file * StrSet.t =
	let f, blacklist = input in
  	let sivis = new singleInstrVisitor in
  	let singleInstrStmt (fn: fundec) : unit =
    	if ((StrSet.mem fn.svar.vname blacklist) ||
        	(fn.svar.vdecl.file <> f.fileName)) then
      		()
    	else
      		ignore(visitCilFunction sivis fn)
  in
  iterFunctions f singleInstrStmt;
  Cfg.computeFileCFG f;
  Ptranal.analyze_file f;
  Ptranal.compute_results false;
  let cvis = new cleanEmptyBlockVisitor in
  let flushMem (fn: fundec) : unit =
    	if ((StrSet.mem fn.svar.vname blacklist) ||
        	(fn.svar.vdecl.file <> f.fileName)) then
      	()
    	else
      		let fvis = new flushMemVisitor fn in
      		ignore(Liveness.computeLiveness fn);
      		ignore(visitCilFunction (fvis :> cilVisitor) fn);
      		ignore(visitCilFunction (cvis :> cilVisitor) fn)
  in
  iterFunctions f flushMem;
  Cfg.clearFileCFG f;
  f, blacklist