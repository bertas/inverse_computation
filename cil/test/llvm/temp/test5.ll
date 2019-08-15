declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 36 x i8 ] c"hello world - %d args, and x is %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t3 = icmp ne i32 %argc, 0
        br i1 %.t3, label %L3, label %L5
L5:
        br label %S1
L3:
        %.t2 = sub i32 0, 2
        br label %S1
S1:
        %x.9 = phi i32 [ %.t2, %L3 ], [ 2, %L5 ]
        %.t1 = sub i32 0, %argc
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 36 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1, i32 %x.9)
        ret i32 0
}
