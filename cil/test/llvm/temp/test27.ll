declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G1 = internal constant [ 22 x i8 ] c"hello world %d %d %d\0A\00"
@.G0 = internal constant [ 4 x i8 ] c"fun\00"
declare i32 @printf(i8 * %__format, ...)
@s = global i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G0, i32 0, i32 0) to i8 *)
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t9 = load i8 * * @s
        %.t10 = getelementptr i8 * %.t9, i32 0
        %.t11 = load i8 * %.t10
        %.t12 = zext i8 %.t11 to i32 
        %.t5 = load i8 * * @s
        %.t6 = getelementptr i8 * %.t5, i32 1
        %.t7 = load i8 * %.t6
        %.t8 = zext i8 %.t7 to i32 
        %.t1 = load i8 * * @s
        %.t2 = getelementptr i8 * %.t1, i32 3
        %.t3 = load i8 * %.t2
        %.t4 = zext i8 %.t3 to i32 
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 22 x i8 ] * @.G1, i32 0, i32 0) to i8 *), i32 %.t12, i32 %.t8, i32 %.t4)
        ret i32 0
}
