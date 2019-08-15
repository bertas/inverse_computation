declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 21 x i8 ] c"hello world %ld %ld\0A\00"
declare i32 @printf(i8 * %__format, ...)
@s1 = global [ 3 x i8 ] [ i8 97,i8 97,i8 0 ]
@s2 = global [ 3 x i8 ] [ i8 98,i8 98,i8 0 ]
@s = global [ 2 x i32 ] [ i32 ptrtoint(i8 * getelementptr([ 3 x i8 ] * @s1, i32 0, i32 0) to i32),i32 ptrtoint(i8 * getelementptr([ 3 x i8 ] * @s2, i32 0, i32 0) to i32) ]
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = getelementptr [ 2 x i32 ] * @s, i32 0, i32 1
        %.t2 = load i32 * %.t1
        %.t3 = inttoptr i32 %.t2 to i8 * 
        %.t7 = getelementptr i8 * %.t3, i32 0
        %.t8 = load i8 * %.t7
        %.t9 = zext i8 %.t8 to i32 
        %.t4 = getelementptr i8 * %.t3, i32 2
        %.t5 = load i8 * %.t4
        %.t6 = zext i8 %.t5 to i32 
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 21 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t9, i32 %.t6)
        ret i32 0
}
