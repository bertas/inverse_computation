declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 19 x i8 ] c"hello world %d %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@a = global i32 1
@b = global i32 2
@s = global [ 2 x i32 * ] [ i32 * @a,i32 * @b ]
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = getelementptr [ 2 x i32 * ] * @s, i32 0, i32 0
        %.t2 = load i32 * * %.t1
        store i32 22, i32 * %.t2
        %.t4 = load i32 * @a
        %.t3 = load i32 * @b
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 19 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t4, i32 %.t3)
        ret i32 0
}
