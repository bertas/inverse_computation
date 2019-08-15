

pl_code global X0_test__a2
	pl_jump    X0_atoi_wrapper__a2


pl_code global X0_test2__a2
	pl_jump    X0_strlen_wrapper__a2


pl_code global X0_main__a2
	call_c     fast Pl_Allocate(3)
	move       X(0),Y(0)
	move       X(1),Y(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483641)
	move_ret   X(2)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483641)
	move_ret   X(0)
	move       Y(0),X(1)
	call_c     fast Pl_Put_Y_Variable(&Y(2))
	move_ret   X(3)
	pl_call    X0_loop__a4
	move       Y(0),X(0)
	pl_call    X0_write__a1
	call_c     fast Pl_Put_Atom_Tagged(ta(0))
	move_ret   X(0)
	pl_call    X0_write__a1
	move       Y(2),X(0)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	call_c     fast Pl_Unify(Y(1),X(0))
	fail_ret   
	call_c     fast Pl_Deallocate()
	pl_ret     


pl_code global X0_loop__a4
	call_c     fast Pl_Create_Choice_Point4(&Lpred4_1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(X(0),&X(4))
	call_c     fast Pl_Math_Load_Value(X(1),&X(5))
	call_c     fast Pl_Blt_Lte(X(4),X(5))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Math_Load_Value(X(2),&X(2))
	call_c     fast Pl_Math_Load_Value(X(0),&X(4))
	call_c     fast Pl_Fct_Mul(X(2),X(4))
	move_ret   X(2)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Math_Load_Value(X(0),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	pl_jump    X0_loop__a4

Lpred4_1:
	call_c     fast Pl_Delete_Choice_Point4()
	call_c     fast Pl_Allocate(2)
	move       X(2),Y(0)
	move       X(3),Y(1)
	move       X(0),X(2)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(2))
	fail_ret   
	call_c     fast Pl_Unify_Local_Value(X(1))
	fail_ret   
	pl_call    X1_5C5C2B__a1
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Unify(Y(1),X(0))
	fail_ret   
	call_c     fast Pl_Deallocate()
	pl_ret     


pl_code global X0_debug__a3
	call_c     fast Pl_Allocate(2)
	move       X(1),Y(0)
	move       X(2),Y(1)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	move       Y(0),X(0)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	call_c     fast Pl_Unify(Y(1),X(0))
	fail_ret   
	call_c     fast Pl_Deallocate()
	pl_ret     


pl_code global X0_atoi_wrapper__a2
	call_c     Pl_Set_C_Bip_Name("atoi_wrapper",2)
	call_c     Pl_Rd_Integer_Check(X(0))
	move_ret   FL(0)
	call_c     Pl_Check_For_Un_Integer(X(1))
	call_c     atoi_wrapper(FL(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_Integer(FL(1),X(1))
	fail_ret   
	pl_ret     


pl_code global X0_str_pointer_dereference_wrapper__a2
	call_c     Pl_Set_C_Bip_Name("str_pointer_dereference_wrapper",2)
	call_c     Pl_Rd_Positive_Check(X(0))
	move_ret   FL(0)
	call_c     Pl_Check_For_Un_String(X(1))
	call_c     str_pointer_dereference_wrapper(FL(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_String(FL(1),X(1))
	fail_ret   
	pl_ret     


pl_code global X0_strlen_wrapper__a2
	call_c     Pl_Set_C_Bip_Name("strlen_wrapper",2)
	call_c     Pl_Rd_String_Check(X(0))
	move_ret   FL(0)
	call_c     Pl_Check_For_Un_Integer(X(1))
	call_c     strlen_wrapper(FL(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_Integer(FL(1),X(1))
	fail_ret   
	pl_ret     


pl_code local ensure_linked
	pl_jump    X1_24666F7263655F666F726569676E5F6C696E6B__a0


long local at(12)
long local ta(1)
long local fn(1)


c_code  initializer Object_Initializer

	call_c     Pl_New_Object(&Prolog_Object_Initializer,&System_Directives,&User_Directives)
	c_ret      


c_code  local Prolog_Object_Initializer

	call_c     Pl_Create_Atom("/home/yufeijiang/Dropbox/security thursday/multilingual obfuscation/babel/evaluation/factorial/CIL/translation/main.pl")
	move_ret   at(0)
	call_c     Pl_Create_Atom("=<")
	move_ret   at(7)
	call_c     Pl_Create_Atom("atoi_wrapper")
	move_ret   at(9)
	call_c     Pl_Create_Atom("debug")
	move_ret   at(8)
	call_c     Pl_Create_Atom("is")
	move_ret   at(5)
	call_c     Pl_Create_Atom("loop")
	move_ret   at(6)
	call_c     Pl_Create_Atom("main")
	move_ret   at(4)
	call_c     Pl_Create_Atom("str_pointer_dereference_wrapper")
	move_ret   at(10)
	call_c     Pl_Create_Atom("strlen_wrapper")
	move_ret   at(11)
	call_c     Pl_Create_Atom("test")
	move_ret   at(1)
	call_c     Pl_Create_Atom("test2")
	move_ret   at(3)
	call_c     Pl_Create_Atom("user")
	move_ret   at(2)
	call_c     fast Pl_Create_Atom_Tagged("! is ")
	move_ret   ta(0)
	call_c     fast Pl_Create_Functor_Arity_Tagged("=<",2)
	move_ret   fn(0)

	call_c     fast Pl_Create_Pred(at(1),2,at(0),5,129,&X0_test__a2)

	call_c     fast Pl_Create_Pred(at(3),2,at(0),6,129,&X0_test2__a2)

	call_c     fast Pl_Create_Pred(at(4),2,at(0),8,129,&X0_main__a2)

	call_c     fast Pl_Create_Pred(at(6),4,at(0),10,129,&X0_loop__a4)

	call_c     fast Pl_Create_Pred(at(8),3,at(0),13,129,&X0_debug__a3)

	call_c     fast Pl_Create_Pred(at(9),2,at(0),1,129,&X0_atoi_wrapper__a2)

	call_c     fast Pl_Create_Pred(at(10),2,at(0),2,129,&X0_str_pointer_dereference_wrapper__a2)

	call_c     fast Pl_Create_Pred(at(11),2,at(0),3,129,&X0_strlen_wrapper__a2)
	c_ret      

c_code  local System_Directives

	c_ret      

c_code  local User_Directives

	c_ret      
