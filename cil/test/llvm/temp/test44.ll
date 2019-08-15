declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 16 x i8 ] c"hello world %f\0A\00"
declare void @__builtin_va_end(i8 *)
declare void @__builtin_va_arg(i8 *,i32,i8 *)
declare void @__builtin_va_start(i8 *)
declare i32 @printf(i8 * %__format, ...)
define double @sum(i32 %s0, ...) {
entry:
        %address.args = alloca i8 * 
        %.t6 = sitofp i32 %s0 to double 
        %.t7 = bitcast i8 * * %address.args to i8 * 
        call void (i8 *) * @llvm.va_start(i8 * %.t7)
        br label %S2
L6:
        %.t1 = bitcast i8 * * %address.args to i8 * 
        call void (i8 *) * @llvm.va_end(i8 * %.t1)
        ret double %s.10
L5:
        %.t2 = add double %s.10, %.t5
        br label %S2
S2:
        %tmp.12 = phi double [ %.t5, %L5 ], [ 0.00000000000000000000e+00, %entry ]
        %n.11 = phi double [ %.t5, %L5 ], [ 0.00000000000000000000e+00, %entry ]
        %s.10 = phi double [ %.t2, %L5 ], [ %.t6, %entry ]
        %.t4 = va_arg i8 * * %address.args, i32 
        %.t5 = sitofp i32 %.t4 to double 
        %.t3 = fcmp une double %.t5, 0.00000000000000000000e+00
        br i1 %.t3, label %L5, label %L6
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call double (i32, ...) * @sum(i32 4, i32 3, i32 32, i32 22, i32 0)
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 16 x i8 ] * @.G0, i32 0, i32 0) to i8 *), double %.t1)
        ret i32 0
}
