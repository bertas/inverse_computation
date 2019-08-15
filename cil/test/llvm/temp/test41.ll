declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 16 x i8 ] c"hello world %d\0A\00"
declare void @__builtin_va_end(i8 *)
declare void @__builtin_va_arg(i8 *,i32,i8 *)
declare void @__builtin_va_start(i8 *)
declare i32 @printf(i8 * %__format, ...)
define i32 @sum(i32 %s0, ...) {
entry:
        %address.args = alloca i8 * 
        %.t5 = bitcast i8 * * %address.args to i8 * 
        call void (i8 *) * @llvm.va_start(i8 * %.t5)
        br label %S2
L6:
        %.t1 = bitcast i8 * * %address.args to i8 * 
        call void (i8 *) * @llvm.va_end(i8 * %.t1)
        ret i32 %s.10
L5:
        %.t2 = add i32 %s.10, %.t4
        br label %S2
S2:
        %tmp.12 = phi i32 [ %.t4, %L5 ], [ 0, %entry ]
        %n.11 = phi i32 [ %.t4, %L5 ], [ 0, %entry ]
        %s.10 = phi i32 [ %.t2, %L5 ], [ %s0, %entry ]
        %.t4 = va_arg i8 * * %address.args, i32 
        %.t3 = icmp ne i32 %.t4, 0
        br i1 %.t3, label %L5, label %L6
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 (i32, ...) * @sum(i32 4, i32 3, i32 32, i32 22, i32 0)
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 16 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
