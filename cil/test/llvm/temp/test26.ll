declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 22 x i8 ] c"hello world %d %d %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@s = global [ 4 x i8 ] [ i8 102,i8 117,i8 110,i8 0 ]
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t7 = getelementptr [ 4 x i8 ] * @s, i32 0, i32 0
        %.t8 = load i8 * %.t7
        %.t9 = zext i8 %.t8 to i32 
        %.t4 = getelementptr [ 4 x i8 ] * @s, i32 0, i32 1
        %.t5 = load i8 * %.t4
        %.t6 = zext i8 %.t5 to i32 
        %.t1 = getelementptr [ 4 x i8 ] * @s, i32 0, i32 3
        %.t2 = load i8 * %.t1
        %.t3 = zext i8 %.t2 to i32 
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 22 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t9, i32 %.t6, i32 %.t3)
        ret i32 0
}
