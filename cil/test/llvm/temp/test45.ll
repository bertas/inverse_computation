declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 13 x i8 ] c"hello world\0A\00"
declare i32 @printf(i8 * %__format, ...)
define i32 @f() {
entry:
        ret i32 2
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        call i32 () * @f()
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 13 x i8 ] * @.G0, i32 0, i32 0) to i8 *))
        ret i32 0
}
