declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G2 = internal constant [ 22 x i8 ] c"hello world %d %d %s\0A\00"
@.G1 = internal constant [ 4 x i8 ] c"baz\00"
@.G0 = internal constant [ 4 x i8 ] c"fun\00"
declare i32 @printf(i8 * %__format, ...)
@s = global [ 2 x i8 * ] [ i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G0, i32 0, i32 0) to i8 *),i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G1, i32 0, i32 0) to i8 *) ]
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t8 = getelementptr [ 2 x i8 * ] * @s, i32 0, i32 0
        %.t9 = load i8 * * %.t8
        %.t10 = getelementptr i8 * %.t9, i32 0
        %.t11 = load i8 * %.t10
        %.t12 = zext i8 %.t11 to i32 
        %.t3 = getelementptr [ 2 x i8 * ] * @s, i32 0, i32 0
        %.t4 = load i8 * * %.t3
        %.t5 = getelementptr i8 * %.t4, i32 1
        %.t6 = load i8 * %.t5
        %.t7 = zext i8 %.t6 to i32 
        %.t1 = getelementptr [ 2 x i8 * ] * @s, i32 0, i32 1
        %.t2 = load i8 * * %.t1
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 22 x i8 ] * @.G2, i32 0, i32 0) to i8 *), i32 %.t12, i32 %.t7, i8 * %.t2)
        ret i32 0
}
