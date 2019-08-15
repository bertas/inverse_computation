declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 16 x i8 ] c"hello world %d\0A\00"
declare void @__builtin_va_end(i8 *)
declare void @__builtin_va_copy(i8 *,i8 *)
declare void @__builtin_va_arg(i8 *,i32,i8 *)
declare void @__builtin_va_start(i8 *)
declare i32 @printf(i8 * %__format, ...)
define i32 @sum(i32 %s0, ...) {
entry:
        %address.copy = alloca i8 * 
        %address.args = alloca i8 * 
        %.t14 = bitcast i8 * * %address.args to i8 * 
        call void (i8 *) * @llvm.va_start(i8 * %.t14)
        br label %S10
L18:
        %.t5 = bitcast i8 * * %address.args to i8 * 
        call void (i8 *) * @llvm.va_end(i8 * %.t5)
        br label %S2
L17:
        %.t10 = icmp eq i32 %s.27, %s0
        %.t9 = select i1 %.t10, i32 1, i32 0
        %.t11 = icmp ne i32 %.t9, 0
        br i1 %.t11, label %L13, label %L15
L15:
        br label %S11
L13:
        %.t7 = bitcast i8 * * %address.copy to i8 * 
        %.t8 = bitcast i8 * * %address.args to i8 * 
        call void (i8 *,i8 *) * @llvm.va_copy(i8 * %.t7, i8 * %.t8)
        br label %S11
S11:
        %.t6 = add i32 %s.27, %.t13
        br label %S10
S10:
        %tmp.29 = phi i32 [ %.t13, %S11 ], [ 0, %entry ]
        %n.28 = phi i32 [ %.t13, %S11 ], [ 0, %entry ]
        %s.27 = phi i32 [ %.t6, %S11 ], [ %s0, %entry ]
        %.t13 = va_arg i8 * * %address.args, i32 
        %.t12 = icmp ne i32 %.t13, 0
        br i1 %.t12, label %L17, label %L18
L6:
        %.t1 = bitcast i8 * * %address.copy to i8 * 
        call void (i8 *) * @llvm.va_end(i8 * %.t1)
        ret i32 %s.42
L5:
        %.t2 = add i32 %s.42, %.t4
        br label %S2
S2:
        %tmp___0.45 = phi i32 [ %.t4, %L5 ], [ 0, %L18 ]
        %n.43 = phi i32 [ %.t4, %L5 ], [ %.t13, %L18 ]
        %s.42 = phi i32 [ %.t2, %L5 ], [ %s.27, %L18 ]
        %.t4 = va_arg i8 * * %address.copy, i32 
        %.t3 = icmp ne i32 %.t4, 0
        br i1 %.t3, label %L5, label %L6
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 (i32, ...) * @sum(i32 4, i32 3, i32 32, i32 22, i32 0)
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 16 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
