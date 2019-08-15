

pl_code global X0_main__a3
	call_c     fast Pl_Allocate(6)
	move       X(1),Y(0)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483641)
	move_ret   X(1)
	move       X(1),Y(1)
	pl_call    X1_246D61696E2F335F2461757831__a1
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	move       Y(1),X(1)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(2)
	call_c     fast Pl_Put_Y_Variable(&Y(2))
	move_ret   X(3)
	move       Y(0),X(4)
	call_c     fast Pl_Put_Nil()
	move_ret   X(5)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(6)
	call_c     fast Pl_Put_Y_Variable(&Y(3))
	move_ret   X(7)
	pl_call    X0_oneouterloop__a8
	move       Y(3),X(0)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	move       Y(2),X(0)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	move       Y(2),X(1)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(2)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(3)
	move       Y(0),X(4)
	call_c     fast Pl_Put_Nil()
	move_ret   X(5)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(6)
	call_c     fast Pl_Put_Y_Variable(&Y(4))
	move_ret   X(7)
	pl_call    X0_oneouterloop__a8
	move       Y(4),X(0)
	pl_call    X0_write__a1
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	move       Y(3),X(1)
	move       Y(4),X(2)
	call_c     fast Pl_Put_Nil()
	move_ret   X(3)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(4)
	call_c     fast Pl_Put_Y_Variable(&Y(5))
	move_ret   X(5)
	pl_call    X0_calculate_out_loop__a6
	move       Y(5),X(0)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	call_c     fast Pl_Put_Unsafe_Value(Y(5))
	move_ret   X(1)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_pr__a2


pl_code local X1_246D61696E2F335F2461757831__a1
	call_c     fast Pl_Create_Choice_Point1(&Lpred2_1)
	call_c     fast Pl_Allocate(0)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(5),2)
	call_c     fast Pl_Math_Load_Value(X(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483569)
	move_ret   X(1)
	call_c     fast Pl_Blt_Neq(X(0),X(1))
	fail_ret   
	call_c     fast Pl_Put_Atom_Tagged(ta(0))
	move_ret   X(0)
	pl_call    X0_write__a1
	call_c     fast Pl_Deallocate()
	pl_jump    X0_nl__a0

Lpred2_1:
	call_c     fast Pl_Delete_Choice_Point1()
	pl_jump    X0_nl__a0


pl_code global X0_pr__a2
	call_c     fast Pl_Create_Choice_Point2(&Lpred3_1)
	call_c     fast Pl_Allocate(2)
	move       X(0),Y(0)
	move       X(1),Y(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Blt_Lt(X(0),X(1))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(1)
	move       Y(0),X(0)
	move       Y(1),X(2)
	pl_call    X0_prline__a3
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       Y(1),X(1)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_pr__a2

Lpred3_1:
	call_c     fast Pl_Delete_Choice_Point2()
	move       X(0),X(1)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(1))
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	pl_jump    X1_5C5C2B__a1


pl_code global X0_prline__a3
	call_c     fast Pl_Create_Choice_Point3(&Lpred4_1)
	call_c     fast Pl_Allocate(4)
	move       X(0),Y(0)
	move       X(1),Y(1)
	move       X(2),Y(2)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(Y(1),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Blt_Lt(X(0),X(1))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Fct_Mul(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Math_Load_Value(Y(1),&X(1))
	call_c     fast Pl_Fct_Add(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       Y(2),X(1)
	call_c     fast Pl_Put_Y_Variable(&Y(3))
	move_ret   X(2)
	pl_call    X0_nth__a3
	move       Y(3),X(0)
	pl_call    X0_write__a1
	call_c     fast Pl_Put_Atom_Tagged(ta(1))
	move_ret   X(0)
	pl_call    X0_write__a1
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(1),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(1)
	move       Y(0),X(0)
	move       Y(2),X(2)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_prline__a3

Lpred4_1:
	call_c     fast Pl_Delete_Choice_Point3()
	call_c     fast Pl_Allocate(0)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(1))
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	pl_call    X1_5C5C2B__a1
	call_c     fast Pl_Deallocate()
	pl_jump    X0_nl__a0


pl_code global X0_oneouterloop__a8
	call_c     fast Pl_Create_Choice_Point(&Lpred5_1,8)
	call_c     fast Pl_Allocate(6)
	move       X(0),Y(0)
	move       X(2),Y(1)
	move       X(3),Y(2)
	move       X(4),Y(3)
	move       X(6),Y(4)
	move       X(7),Y(5)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(2)
	call_c     fast Pl_Blt_Lt(X(0),X(2))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(0)
	move       X(5),X(4)
	move       Y(1),X(2)
	move       Y(3),X(3)
	move       Y(4),X(5)
	pl_call    X0_oneinnerloop__a6
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       Y(1),X(1)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(2)
	move       Y(2),X(3)
	move       Y(3),X(4)
	move       Y(4),X(5)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(6)
	move       Y(5),X(7)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_oneouterloop__a8

Lpred5_1:
	call_c     fast Pl_Delete_Choice_Point(8)
	call_c     fast Pl_Allocate(5)
	move       X(1),Y(0)
	move       X(3),Y(1)
	move       X(5),Y(2)
	move       X(6),Y(3)
	move       X(7),Y(4)
	move       X(0),X(1)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(1))
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	pl_call    X1_5C5C2B__a1
	move       Y(2),X(0)
	call_c     fast Pl_Put_Nil()
	move_ret   X(1)
	move       Y(3),X(2)
	pl_call    X0_append__a3
	move       Y(2),X(0)
	call_c     fast Pl_Put_Nil()
	move_ret   X(1)
	move       Y(4),X(2)
	pl_call    X0_append__a3
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Unify(Y(1),X(0))
	fail_ret   
	call_c     fast Pl_Deallocate()
	pl_ret     


pl_code global X0_oneinnerloop__a6
	call_c     fast Pl_Create_Choice_Point(&Lpred6_1,6)
	call_c     fast Pl_Allocate(8)
	move       X(0),Y(0)
	move       X(2),Y(1)
	move       X(3),Y(2)
	move       X(4),Y(3)
	move       X(5),Y(4)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(2)
	call_c     fast Pl_Blt_Lt(X(0),X(2))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(X(1),&X(2))
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(X(1),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       X(0),Y(5)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(2),&X(0))
	call_c     fast Pl_Math_Load_Value(X(2),&X(1))
	call_c     fast Pl_Put_Integer_Tagged(-2147483629)
	move_ret   X(2)
	call_c     fast Pl_Fct_Mul(X(1),X(2))
	move_ret   X(1)
	call_c     fast Pl_Fct_Add(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Put_Y_Variable(&Y(6))
	move_ret   X(1)
	pl_call    X0_ptr_dereference__a2
	move       Y(6),X(0)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	move       Y(3),X(0)
	call_c     fast Pl_Put_List()
	move_ret   X(1)
	call_c     fast Pl_Unify_Local_Value(Y(6))
	fail_ret   
	call_c     fast Pl_Unify_Nil()
	fail_ret   
	call_c     fast Pl_Put_Y_Variable(&Y(7))
	move_ret   X(2)
	pl_call    X0_append__a3
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	call_c     fast Pl_Put_Unsafe_Value(Y(5))
	move_ret   X(1)
	move       Y(1),X(2)
	move       Y(2),X(3)
	call_c     fast Pl_Put_Unsafe_Value(Y(7))
	move_ret   X(4)
	move       Y(4),X(5)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_oneinnerloop__a6

Lpred6_1:
	call_c     fast Pl_Delete_Choice_Point(6)
	call_c     fast Pl_Allocate(4)
	move       X(1),Y(0)
	move       X(2),Y(1)
	move       X(4),Y(2)
	move       X(5),Y(3)
	move       X(0),X(1)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(1))
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	pl_call    X1_5C5C2B__a1
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Unify(Y(1),X(0))
	fail_ret   
	move       Y(2),X(0)
	call_c     fast Pl_Put_Nil()
	move_ret   X(1)
	move       Y(3),X(2)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_append__a3


pl_code global X0_calculate_out_loop__a6
	call_c     fast Pl_Create_Choice_Point(&Lpred7_1,6)
	call_c     fast Pl_Allocate(5)
	move       X(0),Y(0)
	move       X(1),Y(1)
	move       X(2),Y(2)
	move       X(4),Y(3)
	move       X(5),Y(4)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Blt_Lt(X(0),X(1))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(1)
	move       X(3),X(4)
	move       Y(0),X(0)
	move       Y(1),X(2)
	move       Y(2),X(3)
	move       Y(3),X(5)
	pl_call    X0_calculate_middle_loop__a6
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       Y(1),X(1)
	move       Y(2),X(2)
	move       Y(3),X(3)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(4)
	move       Y(4),X(5)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_calculate_out_loop__a6

Lpred7_1:
	call_c     fast Pl_Delete_Choice_Point(6)
	call_c     fast Pl_Allocate(2)
	move       X(3),Y(0)
	move       X(5),Y(1)
	move       X(0),X(1)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(1))
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	pl_call    X1_5C5C2B__a1
	move       Y(0),X(0)
	call_c     fast Pl_Put_Nil()
	move_ret   X(1)
	move       Y(1),X(2)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_append__a3


pl_code global X0_calculate_middle_loop__a6
	call_c     fast Pl_Create_Choice_Point(&Lpred8_1,6)
	call_c     fast Pl_Allocate(8)
	move       X(0),Y(0)
	move       X(1),Y(1)
	move       X(2),Y(2)
	move       X(3),Y(3)
	move       X(4),Y(4)
	move       X(5),Y(5)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(Y(1),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Blt_Lt(X(0),X(1))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(2)
	move       Y(0),X(0)
	move       Y(1),X(1)
	move       Y(2),X(3)
	move       Y(3),X(4)
	call_c     fast Pl_Put_Integer_Tagged(-2147483645)
	move_ret   X(5)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(6)
	call_c     fast Pl_Put_Y_Variable(&Y(6))
	move_ret   X(7)
	pl_call    X0_calculate_inner_loop__a8
	move       Y(4),X(0)
	call_c     fast Pl_Put_List()
	move_ret   X(1)
	call_c     fast Pl_Unify_Local_Value(Y(6))
	fail_ret   
	call_c     fast Pl_Unify_Nil()
	fail_ret   
	call_c     fast Pl_Put_Y_Variable(&Y(7))
	move_ret   X(2)
	pl_call    X0_append__a3
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(1),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(1)
	move       Y(0),X(0)
	move       Y(2),X(2)
	move       Y(3),X(3)
	call_c     fast Pl_Put_Unsafe_Value(Y(7))
	move_ret   X(4)
	move       Y(5),X(5)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_calculate_middle_loop__a6

Lpred8_1:
	call_c     fast Pl_Delete_Choice_Point(6)
	call_c     fast Pl_Allocate(2)
	move       X(4),Y(0)
	move       X(5),Y(1)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(1))
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	pl_call    X1_5C5C2B__a1
	move       Y(0),X(0)
	call_c     fast Pl_Put_Nil()
	move_ret   X(1)
	move       Y(1),X(2)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_append__a3


pl_code global X0_calculate_inner_loop__a8
	call_c     fast Pl_Create_Choice_Point(&Lpred9_1,8)
	call_c     fast Pl_Allocate(12)
	move       X(0),Y(0)
	move       X(1),Y(1)
	move       X(2),Y(2)
	move       X(3),Y(3)
	move       X(4),Y(4)
	move       X(5),Y(5)
	move       X(6),Y(6)
	move       X(7),Y(7)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(7),2)
	call_c     fast Pl_Math_Load_Value(Y(2),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Blt_Lt(X(0),X(1))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Fct_Mul(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Math_Load_Value(Y(2),&X(1))
	call_c     fast Pl_Fct_Add(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       X(0),Y(8)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(2),&X(0))
	call_c     fast Pl_Put_Integer_Tagged(-2147483633)
	move_ret   X(1)
	call_c     fast Pl_Fct_Mul(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Math_Load_Value(Y(1),&X(1))
	call_c     fast Pl_Fct_Add(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(0)
	move       X(0),Y(9)
	move       Y(9),X(0)
	pl_call    X0_write__a1
	pl_call    X0_nl__a0
	move       Y(8),X(0)
	move       Y(3),X(1)
	call_c     fast Pl_Put_Y_Variable(&Y(10))
	move_ret   X(2)
	pl_call    X0_nth__a3
	move       Y(9),X(0)
	move       Y(4),X(1)
	call_c     fast Pl_Put_Y_Variable(&Y(11))
	move_ret   X(2)
	pl_call    X0_nth__a3
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(10),&X(0))
	call_c     fast Pl_Math_Load_Value(Y(11),&X(1))
	call_c     fast Pl_Fct_Mul(X(0),X(1))
	move_ret   X(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(5),&X(0))
	call_c     fast Pl_Math_Load_Value(X(1),&X(1))
	call_c     fast Pl_Fct_Add(X(0),X(1))
	move_ret   X(0)
	call_c     fast Pl_Unify(Y(6),X(0))
	fail_ret   
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(2),&X(0))
	call_c     fast Pl_Fct_Inc(X(0))
	move_ret   X(2)
	move       Y(0),X(0)
	move       Y(1),X(1)
	move       Y(3),X(3)
	move       Y(4),X(4)
	move       Y(6),X(5)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(6)
	move       Y(7),X(7)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_calculate_inner_loop__a8

Lpred9_1:
	call_c     fast Pl_Delete_Choice_Point(8)
	call_c     fast Pl_Allocate(2)
	move       X(5),Y(0)
	move       X(7),Y(1)
	call_c     fast Pl_Put_Structure_Tagged(fn(0))
	move_ret   X(0)
	call_c     fast Pl_Unify_Local_Value(X(2))
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	pl_call    X1_5C5C2B__a1
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(Y(0),&X(0))
	call_c     fast Pl_Unify(Y(1),X(0))
	fail_ret   
	call_c     fast Pl_Deallocate()
	pl_ret     


pl_code global X0_test__a1
	call_c     fast Pl_Allocate(1)
	call_c     fast Pl_Put_List()
	move_ret   X(1)
	call_c     fast Pl_Unify_Integer_Tagged(-2147483641)
	fail_ret   
	call_c     fast Pl_Unify_List()
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483637)
	fail_ret   
	call_c     fast Pl_Unify_List()
	fail_ret   
	call_c     fast Pl_Unify_Integer_Tagged(-2147483633)
	fail_ret   
	call_c     fast Pl_Unify_Nil()
	fail_ret   
	call_c     fast Pl_Put_Y_Variable(&Y(0))
	move_ret   X(2)
	pl_call    X0_append__a3
	move       Y(0),X(0)
	call_c     fast Pl_Put_Nil()
	move_ret   X(1)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(2)
	pl_call    X0_append__a3
	call_c     fast Pl_Deallocate()
	pl_jump    X0_nl__a0


pl_code global X0_test2__a2
	call_c     fast Pl_Allocate(1)
	call_c     Pl_Set_Bip_Name_Untagged_2(at(3),2)
	call_c     fast Pl_Math_Load_Value(X(0),&X(2))
	call_c     fast Pl_Put_Integer_Tagged(-2147483629)
	move_ret   X(3)
	call_c     fast Pl_Fct_Add(X(2),X(3))
	move_ret   X(2)
	move       X(2),Y(0)
	pl_call    X0_ptr_dereference__a2
	call_c     fast Pl_Put_Unsafe_Value(Y(0))
	move_ret   X(0)
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(1)
	call_c     fast Pl_Deallocate()
	pl_jump    X0_ptr_dereference__a2


pl_code global X0_test3__a1
	call_c     fast Pl_Put_X_Variable()
	move_ret   X(1)
	pl_jump    X0_strlen_wrapper__a2


pl_code global X0_ptr_dereference__a2
	call_c     Pl_Set_C_Bip_Name("ptr_dereference",2)
	call_c     Pl_Rd_Float_Check(X(0))
	move_ret   FD(0)
	call_c     Pl_Check_For_Un_Integer(X(1))
	call_c     ptr_dereference(FD(0),&FL(1))
	fail_ret   
	call_c     Pl_Un_Integer(FL(1),X(1))
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


long local at(19)
long local ta(2)
long local fn(1)


c_code  initializer Object_Initializer

	call_c     Pl_New_Object(&Prolog_Object_Initializer,&System_Directives,&User_Directives)
	c_ret      


c_code  local Prolog_Object_Initializer

	call_c     Pl_Create_Atom("$main/3_$aux1")
	move_ret   at(4)
	call_c     Pl_Create_Atom("/home/yufeijiang/Dropbox/security thursday/multilingual obfuscation/babel/evaluation/matrix_mult/CIL/translation/main.pl")
	move_ret   at(0)
	call_c     Pl_Create_Atom("<")
	move_ret   at(7)
	call_c     Pl_Create_Atom("=\\=")
	move_ret   at(5)
	call_c     Pl_Create_Atom("calculate_inner_loop")
	move_ret   at(13)
	call_c     Pl_Create_Atom("calculate_middle_loop")
	move_ret   at(12)
	call_c     Pl_Create_Atom("calculate_out_loop")
	move_ret   at(11)
	call_c     Pl_Create_Atom("is")
	move_ret   at(3)
	call_c     Pl_Create_Atom("main")
	move_ret   at(1)
	call_c     Pl_Create_Atom("oneinnerloop")
	move_ret   at(10)
	call_c     Pl_Create_Atom("oneouterloop")
	move_ret   at(9)
	call_c     Pl_Create_Atom("pr")
	move_ret   at(6)
	call_c     Pl_Create_Atom("prline")
	move_ret   at(8)
	call_c     Pl_Create_Atom("ptr_dereference")
	move_ret   at(17)
	call_c     Pl_Create_Atom("strlen_wrapper")
	move_ret   at(18)
	call_c     Pl_Create_Atom("test")
	move_ret   at(14)
	call_c     Pl_Create_Atom("test2")
	move_ret   at(15)
	call_c     Pl_Create_Atom("test3")
	move_ret   at(16)
	call_c     Pl_Create_Atom("user")
	move_ret   at(2)
	call_c     fast Pl_Create_Atom_Tagged(" ")
	move_ret   ta(1)
	call_c     fast Pl_Create_Atom_Tagged("need 2 3*3 interger matrices")
	move_ret   ta(0)
	call_c     fast Pl_Create_Functor_Arity_Tagged("<",2)
	move_ret   fn(0)

	call_c     fast Pl_Create_Pred(at(1),3,at(0),5,129,&X0_main__a3)

	call_c     fast Pl_Create_Pred(at(4),1,at(0),5,1,&X1_246D61696E2F335F2461757831__a1)

	call_c     fast Pl_Create_Pred(at(6),2,at(0),8,129,&X0_pr__a2)

	call_c     fast Pl_Create_Pred(at(8),3,at(0),12,129,&X0_prline__a3)

	call_c     fast Pl_Create_Pred(at(9),8,at(0),15,129,&X0_oneouterloop__a8)

	call_c     fast Pl_Create_Pred(at(10),6,at(0),19,129,&X0_oneinnerloop__a6)

	call_c     fast Pl_Create_Pred(at(11),6,at(0),27,129,&X0_calculate_out_loop__a6)

	call_c     fast Pl_Create_Pred(at(12),6,at(0),30,129,&X0_calculate_middle_loop__a6)

	call_c     fast Pl_Create_Pred(at(13),8,at(0),35,129,&X0_calculate_inner_loop__a8)

	call_c     fast Pl_Create_Pred(at(14),1,at(0),46,129,&X0_test__a1)

	call_c     fast Pl_Create_Pred(at(15),2,at(0),47,129,&X0_test2__a2)

	call_c     fast Pl_Create_Pred(at(16),1,at(0),48,129,&X0_test3__a1)

	call_c     fast Pl_Create_Pred(at(17),2,at(0),1,129,&X0_ptr_dereference__a2)

	call_c     fast Pl_Create_Pred(at(18),2,at(0),2,129,&X0_strlen_wrapper__a2)
	c_ret      

c_code  local System_Directives

	c_ret      

c_code  local User_Directives

	c_ret      
