declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 23 x i8 ] c"hello world - x is %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@x = global i32 zeroinitializer
@y = global i8 zeroinitializer
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        store i8 7, i8 * @y
        %.t7 = load i8 * @y
        %.t8 = zext i8 %.t7 to i32 
        %.t9 = sub i32 0, %.t8
        store i32 %.t9, i32 * @x
        %.t5 = icmp ne i8 * * %argv, null
        %.t4 = select i1 %.t5, i32 0, i32 1
        %.t6 = icmp ne i32 %.t4, 0
        br i1 %.t6, label %L3, label %L5
L5:
        br label %S1
L3:
        %.t2 = load i32 * @x
        %.t3 = sub i32 0, %.t2
        store i32 %.t3, i32 * @x
        br label %S1
S1:
        %.t1 = load i32 * @x
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 23 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}