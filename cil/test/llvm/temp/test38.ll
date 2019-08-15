declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 16 x i8 ] c"hello world %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@x = internal global i32 zeroinitializer
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        store i32 2, i32 * @x
        %.t1 = load i32 * @x
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 16 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
