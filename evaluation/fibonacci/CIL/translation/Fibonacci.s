	.text	

fail:
	movl	pl_reg_bank+1024,%eax
	jmp	*-4(%eax)
	.p2align	4,,15
	.type	X0_fibonacci__a2,@function
.globl X0_fibonacci__a2

X0_fibonacci__a2:
	movl	at+12,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	$-2147483645,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+8
	jmp	X0_ifone__a2
	.p2align	4,,15
	.type	X0_ifone__a2,@function
.globl X0_ifone__a2

X0_ifone__a2:
	movl	$Lpred2_1+0,%eax
	call	Pl_Create_Choice_Point2
	movl	$-2147483641,%eax
	movl	pl_reg_bank+0,%edx
	call	Pl_Get_Integer_Tagged
	testl	%eax,%eax
	je	fail
	movl	$-2147483641,%eax
	movl	pl_reg_bank+4,%edx
	call	Pl_Get_Integer_Tagged
	testl	%eax,%eax
	je	fail
	jmp	*pl_reg_bank+1036

Lpred2_1:
	call	Pl_Delete_Choice_Point2
	movl	$2,%eax
	call	Pl_Allocate
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+1040,%edi
	movl	%eax,-16(%edi)
	movl	pl_reg_bank+4,%eax
	movl	%eax,-20(%edi)
	movl	-16(%edi),%eax
	movl	%eax,pl_reg_bank+0
	movl	$-2147483641,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+4
	movl	$.Lcont0,pl_reg_bank+1036
	jmp	X1_5C5C3D__a2
.Lcont0:
	movl	pl_reg_bank+1040,%edi
	movl	-16(%edi),%eax
	movl	%eax,pl_reg_bank+0
	movl	-20(%edi),%eax
	movl	%eax,pl_reg_bank+4
	call	Pl_Deallocate
	jmp	X0_iftwo__a2
	.p2align	4,,15
	.type	X0_iftwo__a2,@function
.globl X0_iftwo__a2

X0_iftwo__a2:
	movl	$Lpred3_1+0,%eax
	call	Pl_Create_Choice_Point2
	movl	$-2147483637,%eax
	movl	pl_reg_bank+0,%edx
	call	Pl_Get_Integer_Tagged
	testl	%eax,%eax
	je	fail
	movl	$-2147483641,%eax
	movl	pl_reg_bank+4,%edx
	call	Pl_Get_Integer_Tagged
	testl	%eax,%eax
	je	fail
	jmp	*pl_reg_bank+1036

Lpred3_1:
	call	Pl_Delete_Choice_Point2
	movl	$4,%eax
	call	Pl_Allocate
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+1040,%edi
	movl	%eax,-16(%edi)
	movl	pl_reg_bank+4,%eax
	movl	%eax,-20(%edi)
	movl	at+12,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	-16(%edi),%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+0,%eax
	call	Pl_Fct_Dec
	movl	%eax,pl_reg_bank+0
	leal	-24(%edi),%eax
	call	Pl_Put_Y_Variable
	movl	%eax,pl_reg_bank+4
	movl	$.Lcont1,pl_reg_bank+1036
	jmp	X0_fibonacci__a2
.Lcont1:
	movl	at+12,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+1040,%edi
	movl	-16(%edi),%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	$-2147483637,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+4
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+4,%edx
	call	Pl_Fct_Sub
	movl	%eax,pl_reg_bank+0
	leal	-28(%edi),%eax
	call	Pl_Put_Y_Variable
	movl	%eax,pl_reg_bank+4
	movl	$.Lcont2,pl_reg_bank+1036
	jmp	X0_fibonacci__a2
.Lcont2:
	movl	at+12,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+1040,%edi
	movl	-24(%edi),%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	-28(%edi),%eax
	leal	pl_reg_bank+4,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+4,%edx
	call	Pl_Fct_Add
	movl	%eax,pl_reg_bank+0
	movl	-20(%edi),%eax
	movl	pl_reg_bank+0,%edx
	call	Pl_Unify
	testl	%eax,%eax
	je	fail
	call	Pl_Deallocate
	jmp	*pl_reg_bank+1036
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
	movl	$.LC0,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+0
	movl	$.LC1,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+4
	movl	$.LC2,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+16
	movl	$.LC3,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+20
	movl	$.LC4,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+12
	movl	$.LC5,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+8
	movl	at+4,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$1,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_fibonacci__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+16,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$3,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_ifone__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+20,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$6,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_iftwo__a2+0,8(%esp)
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
.LC0:
	.string	"/home/yufeijiang/Dropbox/security thursday/multilingual obfuscation/babel/evaluation/fibonacci/CIL/translation/Fibonacci.pl"
.LC1:
	.string	"fibonacci"
.LC2:
	.string	"ifone"
.LC3:
	.string	"iftwo"
.LC4:
	.string	"is"
.LC5:
	.string	"user"
	.data	
	.align	4
	.local	at
	.comm	at,24,4
	.section	.note.GNU-stack,"",@progbits
