	.text	

fail:
	movl	pl_reg_bank+1024,%eax
	jmp	*-4(%eax)
	.p2align	4,,15
	.type	X0_test__a2,@function
.globl X0_test__a2

X0_test__a2:
	jmp	X0_atoi_wrapper__a2
	.p2align	4,,15
	.type	X0_test2__a2,@function
.globl X0_test2__a2

X0_test2__a2:
	jmp	X0_strlen_wrapper__a2
	.p2align	4,,15
	.type	X0_main__a2,@function
.globl X0_main__a2

X0_main__a2:
	movl	$3,%eax
	call	Pl_Allocate
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+1040,%edi
	movl	%eax,-16(%edi)
	movl	pl_reg_bank+4,%eax
	movl	%eax,-20(%edi)
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	$-2147483641,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+8
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	$-2147483641,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+0
	movl	-16(%edi),%eax
	movl	%eax,pl_reg_bank+4
	leal	-24(%edi),%eax
	call	Pl_Put_Y_Variable
	movl	%eax,pl_reg_bank+12
	movl	$.Lcont0,pl_reg_bank+1036
	jmp	X0_loop__a4
.Lcont0:
	movl	pl_reg_bank+1040,%edi
	movl	-16(%edi),%eax
	movl	%eax,pl_reg_bank+0
	movl	$.Lcont1,pl_reg_bank+1036
	jmp	X0_write__a1
.Lcont1:
	movl	ta+0,%eax
	call	Pl_Put_Atom_Tagged
	movl	%eax,pl_reg_bank+0
	movl	$.Lcont2,pl_reg_bank+1036
	jmp	X0_write__a1
.Lcont2:
	movl	pl_reg_bank+1040,%edi
	movl	-24(%edi),%eax
	movl	%eax,pl_reg_bank+0
	movl	$.Lcont3,pl_reg_bank+1036
	jmp	X0_write__a1
.Lcont3:
	movl	$.Lcont4,pl_reg_bank+1036
	jmp	X0_nl__a0
.Lcont4:
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	$-2147483645,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+0
	movl	pl_reg_bank+1040,%edi
	movl	-20(%edi),%eax
	movl	pl_reg_bank+0,%edx
	call	Pl_Unify
	testl	%eax,%eax
	je	fail
	call	Pl_Deallocate
	jmp	*pl_reg_bank+1036
	.p2align	4,,15
	.type	X0_loop__a4,@function
.globl X0_loop__a4

X0_loop__a4:
	movl	$Lpred4_1+0,%eax
	call	Pl_Create_Choice_Point4
	movl	at+28,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+0,%eax
	leal	pl_reg_bank+16,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+4,%eax
	leal	pl_reg_bank+20,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+16,%eax
	movl	pl_reg_bank+20,%edx
	call	Pl_Blt_Lte
	testl	%eax,%eax
	je	fail
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+8,%eax
	leal	pl_reg_bank+8,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+0,%eax
	leal	pl_reg_bank+16,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+8,%eax
	movl	pl_reg_bank+16,%edx
	call	Pl_Fct_Mul
	movl	%eax,pl_reg_bank+8
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+0,%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+0,%eax
	call	Pl_Fct_Inc
	movl	%eax,pl_reg_bank+0
	jmp	X0_loop__a4

Lpred4_1:
	call	Pl_Delete_Choice_Point4
	movl	$2,%eax
	call	Pl_Allocate
	movl	pl_reg_bank+8,%eax
	movl	pl_reg_bank+1040,%edi
	movl	%eax,-16(%edi)
	movl	pl_reg_bank+12,%eax
	movl	%eax,-20(%edi)
	movl	pl_reg_bank+0,%eax
	movl	%eax,pl_reg_bank+8
	movl	fn+0,%eax
	call	Pl_Put_Structure_Tagged
	movl	%eax,pl_reg_bank+0
	movl	pl_reg_bank+8,%eax
	call	Pl_Unify_Local_Value
	testl	%eax,%eax
	je	fail
	movl	pl_reg_bank+4,%eax
	call	Pl_Unify_Local_Value
	testl	%eax,%eax
	je	fail
	movl	$.Lcont5,pl_reg_bank+1036
	jmp	X1_5C5C2B__a1
.Lcont5:
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+1040,%edi
	movl	-16(%edi),%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	-20(%edi),%eax
	movl	pl_reg_bank+0,%edx
	call	Pl_Unify
	testl	%eax,%eax
	je	fail
	call	Pl_Deallocate
	jmp	*pl_reg_bank+1036
	.p2align	4,,15
	.type	X0_debug__a3,@function
.globl X0_debug__a3

X0_debug__a3:
	movl	$2,%eax
	call	Pl_Allocate
	movl	pl_reg_bank+4,%eax
	movl	pl_reg_bank+1040,%edi
	movl	%eax,-16(%edi)
	movl	pl_reg_bank+8,%eax
	movl	%eax,-20(%edi)
	movl	$.Lcont6,pl_reg_bank+1036
	jmp	X0_write__a1
.Lcont6:
	movl	$.Lcont7,pl_reg_bank+1036
	jmp	X0_nl__a0
.Lcont7:
	movl	pl_reg_bank+1040,%edi
	movl	-16(%edi),%eax
	movl	%eax,pl_reg_bank+0
	movl	$.Lcont8,pl_reg_bank+1036
	jmp	X0_write__a1
.Lcont8:
	movl	$.Lcont9,pl_reg_bank+1036
	jmp	X0_nl__a0
.Lcont9:
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	$-2147483645,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+0
	movl	pl_reg_bank+1040,%edi
	movl	-20(%edi),%eax
	movl	pl_reg_bank+0,%edx
	call	Pl_Unify
	testl	%eax,%eax
	je	fail
	call	Pl_Deallocate
	jmp	*pl_reg_bank+1036
	.p2align	4,,15
	.type	X0_atoi_wrapper__a2,@function
.globl X0_atoi_wrapper__a2

X0_atoi_wrapper__a2:
	movl	$.LC0,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_C_Bip_Name
	movl	pl_reg_bank+0,%eax
	movl	%eax,0(%esp)
	call	Pl_Rd_Integer_Check
	movl	%eax,pl_foreign_long+0
	movl	pl_reg_bank+4,%eax
	movl	%eax,0(%esp)
	call	Pl_Check_For_Un_Integer
	movl	pl_foreign_long+0,%eax
	movl	%eax,0(%esp)
	movl	$pl_foreign_long+4,4(%esp)
	call	atoi_wrapper
	testl	%eax,%eax
	je	fail
	movl	pl_foreign_long+4,%eax
	movl	%eax,0(%esp)
	movl	pl_reg_bank+4,%eax
	movl	%eax,4(%esp)
	call	Pl_Un_Integer
	testl	%eax,%eax
	je	fail
	jmp	*pl_reg_bank+1036
	.p2align	4,,15
	.type	X0_str_pointer_dereference_wrapper__a2,@function
.globl X0_str_pointer_dereference_wrapper__a2

X0_str_pointer_dereference_wrapper__a2:
	movl	$.LC1,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_C_Bip_Name
	movl	pl_reg_bank+0,%eax
	movl	%eax,0(%esp)
	call	Pl_Rd_Positive_Check
	movl	%eax,pl_foreign_long+0
	movl	pl_reg_bank+4,%eax
	movl	%eax,0(%esp)
	call	Pl_Check_For_Un_String
	movl	pl_foreign_long+0,%eax
	movl	%eax,0(%esp)
	movl	$pl_foreign_long+4,4(%esp)
	call	str_pointer_dereference_wrapper
	testl	%eax,%eax
	je	fail
	movl	pl_foreign_long+4,%eax
	movl	%eax,0(%esp)
	movl	pl_reg_bank+4,%eax
	movl	%eax,4(%esp)
	call	Pl_Un_String
	testl	%eax,%eax
	je	fail
	jmp	*pl_reg_bank+1036
	.p2align	4,,15
	.type	X0_strlen_wrapper__a2,@function
.globl X0_strlen_wrapper__a2

X0_strlen_wrapper__a2:
	movl	$.LC2,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_C_Bip_Name
	movl	pl_reg_bank+0,%eax
	movl	%eax,0(%esp)
	call	Pl_Rd_String_Check
	movl	%eax,pl_foreign_long+0
	movl	pl_reg_bank+4,%eax
	movl	%eax,0(%esp)
	call	Pl_Check_For_Un_Integer
	movl	pl_foreign_long+0,%eax
	movl	%eax,0(%esp)
	movl	$pl_foreign_long+4,4(%esp)
	call	strlen_wrapper
	testl	%eax,%eax
	je	fail
	movl	pl_foreign_long+4,%eax
	movl	%eax,0(%esp)
	movl	pl_reg_bank+4,%eax
	movl	%eax,4(%esp)
	call	Pl_Un_Integer
	testl	%eax,%eax
	je	fail
	jmp	*pl_reg_bank+1036
	.p2align	4,,15
	.type	ensure_linked,@function

ensure_linked:
	jmp	X1_24666F7263655F666F726569676E5F6C696E6B__a0
	.p2align	4,,15
	.type	Object_Initializer,@function

Object_Initializer:
	pushl	%esi
	subl	$132,%esp
	movl	$Prolog_Object_Initializer+0,0(%esp)
	movl	$System_Directives+0,4(%esp)
	movl	$User_Directives+0,8(%esp)
	call	Pl_New_Object
	addl	$132,%esp
	popl	%esi
	ret	
	.p2align	4,,15
	.type	Prolog_Object_Initializer,@function

Prolog_Object_Initializer:
	pushl	%esi
	subl	$132,%esp
	movl	$.LC3,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+0
	movl	$.LC4,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+28
	movl	$.LC0,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+36
	movl	$.LC5,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+32
	movl	$.LC6,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+20
	movl	$.LC7,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+24
	movl	$.LC8,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+16
	movl	$.LC1,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+40
	movl	$.LC2,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+44
	movl	$.LC9,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+4
	movl	$.LC10,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+12
	movl	$.LC11,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+8
	movl	$.LC12,%eax
	call	Pl_Create_Atom_Tagged
	movl	%eax,ta+0
	movl	$.LC4,%eax
	movl	$2,%edx
	call	Pl_Create_Functor_Arity_Tagged
	movl	%eax,fn+0
	movl	at+4,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$5,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_test__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+12,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$6,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_test2__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+16,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$8,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_main__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+24,%eax
	movl	$4,%edx
	movl	at+0,%ecx
	movl	$10,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_loop__a4+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+32,%eax
	movl	$3,%edx
	movl	at+0,%ecx
	movl	$13,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_debug__a3+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+36,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$1,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_atoi_wrapper__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+40,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$2,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_str_pointer_dereference_wrapper__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+44,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$3,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_strlen_wrapper__a2+0,8(%esp)
	call	Pl_Create_Pred
	addl	$132,%esp
	popl	%esi
	ret	
	.p2align	4,,15
	.type	System_Directives,@function

System_Directives:
	pushl	%esi
	subl	$132,%esp
	addl	$132,%esp
	popl	%esi
	ret	
	.p2align	4,,15
	.type	User_Directives,@function

User_Directives:
	pushl	%esi
	subl	$132,%esp
	addl	$132,%esp
	popl	%esi
	ret	
	.section	.ctors,"aw",@progbits
	.align	4
	.long	Object_Initializer
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC12:
	.string	"! is "
.LC3:
	.string	"/home/yufeijiang/Dropbox/security thursday/multilingual obfuscation/babel/evaluation/factorial/CIL/translation/main.pl"
.LC4:
	.string	"=<"
.LC0:
	.string	"atoi_wrapper"
.LC5:
	.string	"debug"
.LC6:
	.string	"is"
.LC7:
	.string	"loop"
.LC8:
	.string	"main"
.LC1:
	.string	"str_pointer_dereference_wrapper"
.LC2:
	.string	"strlen_wrapper"
.LC9:
	.string	"test"
.LC10:
	.string	"test2"
.LC11:
	.string	"user"
	.data	
	.align	4
	.local	at
	.comm	at,48,4
	.local	fn
	.comm	fn,4,4
	.local	ta
	.comm	ta,4,4
	.section	.note.GNU-stack,"",@progbits
