declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 19 x i8 ] c"hello world %d %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@s1 = global [ 3 x i8 ] [ i8 97,i8 97,i8 0 ]
@s2 = global [ 3 x i8 ] [ i8 98,i8 98,i8 0 ]
@s = global [ 2 x i8 * ] [ i8 * getelementptr([ 3 x i8 ] * @s1, i32 0, i32 1),i8 * getelementptr([ 3 x i8 ] * @s2, i32 0, i32 0) ]
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t6 = getelementptr [ 2 x i8 * ] * @s, i32 0, i32 0
        %.t7 = load i8 * * %.t6
        %.t8 = getelementptr i8 * %.t7, i32 0
        %.t9 = load i8 * %.t8
        %.t10 = zext i8 %.t9 to i32 
        %.t1 = getelementptr [ 2 x i8 * ] * @s, i32 0, i32 1
        %.t2 = load i8 * * %.t1
        %.t3 = getelementptr i8 * %.t2, i32 0
        %.t4 = load i8 * %.t3
        %.t5 = zext i8 %.t4 to i32 
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 19 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t10, i32 %.t5)
        ret i32 0
}