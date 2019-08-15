declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 19 x i8 ] c"hello world %d %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
define i32 @x() {
entry:
        ret i32 1
}
define i32 @y() {
entry:
        ret i32 1
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 () * @y()
        %.t2 = call i32 () * @x()
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 19 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t2, i32 %.t1)
        ret i32 0
}
