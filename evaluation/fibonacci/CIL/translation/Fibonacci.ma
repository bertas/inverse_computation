

pl_code global X0_fibonacci__a2
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(2)
	pl_jump    X0_ifone__a2


pl_code global X0_ifone__a2
	call_c     fast Pl_Create_Choice_Point2(&Lpred2_1)
	call_c     fast Pl_Get_Integer_Tagged(-2147483641,X(0))
	fail_ret   
	call_c     fast Pl_Get_Integer_Tagged(-2147483641,X(1))
	fail_ret   
	pl_ret     

Lpred2_1:
	call_c     fast Pl_Delete_Choice_Point2()
	call_c     fast Pl_Allocate(2)
	move       X(0),Y(0)
	move       X(1),Y(1)
	move       Y(0),X(0)
	call_c     fast Pl_Put_Integer_Tagged(-2147483641)
	move_ret   X(1)
	pl_call    X1_5C5C3D__a2
	move       Y(0),X(0)
	move       Y(1),X(1)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_iftwo__a2


pl_code global X0_iftwo__a2
	call_c     fast Pl_Create_Choice_Point2(&Lpred3_1)
	call_c     fast Pl_Get_Integer_Tagged(-2147483637,X(0))
	fail_ret   
	call_c     fast Pl_Get_Integer_Tagged(-2147483641,X(1))
	fail_ret   
	pl_ret     

Lpred3_1:
	call_c     fast Pl_Delete_Choice_Point2()
	call_c     fast Pl_Allocate(4)
	move       X(0),Y(0)
	move       X(1),Y(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Fct_Dec(X(0))
	move_ret   X(0)
	call_c     fast Pl_Put_Y_Variable(&Y(2))
	move_ret   X(1)
	pl_call    X0_fibonacci__a2
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483637)
	move_ret   X(1)
	call_c     fast Pl_Fct_Sub(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Put_Y_Variable(&Y(3))
	move_ret   X(1)
	pl_call    X0_fibonacci__a2
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(2),&X(0))
	call_c     fast Pl_Math_Load_Value(Y(3),&X(1))
	call_c     fast Pl_Fct_Add(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Unify(Y(1),X(0))
	fail_ret   
	call_c     fast Pl_Deallocate()
	pl_ret     


long local at(6)


c_code  initializer Object_Initializer

	call_c     Pl_New_Object(&Prolog_Object_Initializer,&System_Directives,&User_Directives)
	c_ret      


c_code  local Prolog_Object_Initializer

	call_c     Pl_Create_Atom("/home/yufeijiang/Dropbox/security thursday/multilingual obfuscation/babel/evaluation/fibonacci/CIL/translation/Fibonacci.pl")
	move_ret   at(0)
	call_c     Pl_Create_Atom("fibonacci")
	move_ret   at(1)
	call_c     Pl_Create_Atom("ifone")
	move_ret   at(4)
	call_c     Pl_Create_Atom("iftwo")
	move_ret   at(5)
	call_c     Pl_Create_Atom("is")
	move_ret   at(3)
	call_c     Pl_Create_Atom("user")
	move_ret   at(2)

	call_c     fast Pl_Create_Pred(at(1),2,at(0),1,129,&X0_fibonacci__a2)

	call_c     fast Pl_Create_Pred(at(4),2,at(0),3,129,&X0_ifone__a2)

	call_c     fast Pl_Create_Pred(at(5),2,at(0),6,129,&X0_iftwo__a2)
	c_ret      

c_code  local System_Directives

	c_ret      

c_code  local User_Directives

	c_ret      
