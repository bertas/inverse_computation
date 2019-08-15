declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 27 x i8 ] c"hello world - %d %d %d %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
define i32 @silly(i32 %w) {
entry:
        switch i32 %w, label %L6 [ i32 6, label %S3 i32 5, label %S4 i32 11, label %S5 ]
L6:
        ret i32 7
S5:
        ret i32 22
S4:
        br label %S3
S3:
        %a.8 = phi i32 [ 9, %S4 ], [ 7, %entry ]
        %.t1 = mul i32 %a.8, 7
        ret i32 %.t1
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 (i32) * @silly(i32 6)
        %.t2 = call i32 (i32) * @silly(i32 5)
        %.t3 = call i32 (i32) * @silly(i32 11)
        %.t4 = call i32 (i32) * @silly(i32 0)
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 27 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t4, i32 %.t3, i32 %.t2, i32 %.t1)
        ret i32 0
}
