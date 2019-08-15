declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 16 x i8 ] c"hello world %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@a = global i16 50336
@b = global i16 1995
define i32 @sum() {
entry:
        %.t1 = load i16 * @a
        %.t2 = zext i16 %.t1 to i32 
        %.t3 = load i16 * @b
        %.t4 = zext i16 %.t3 to i32 
        %.t5 = add i32 %.t2, %.t4
        ret i32 %.t5
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 () * @sum()
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 16 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
