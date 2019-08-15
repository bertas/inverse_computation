declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 4 x i8 ] c"%d\0A\00"
%struct.fun = type { i32,i32 }
declare i32 @printf(i8 * %__format, ...)
@d = global %struct.fun zeroinitializer
@c = global %struct.fun * @d
define i32 @f() {
entry:
        %.t8 = load %struct.fun * * @c
        %.t7 = getelementptr %struct.fun * %.t8, i32 0, i32 0
        store i32 11, i32 * %.t7
        %.t9 = getelementptr %struct.fun * @d, i32 0, i32 0
        store i32 12, i32 * %.t9
        %.t2 = load %struct.fun * * @c
        %.t1 = getelementptr %struct.fun * %.t2, i32 0, i32 0
        %.t3 = load i32 * %.t1
        %.t4 = getelementptr %struct.fun * @d, i32 0, i32 0
        %.t5 = load i32 * %.t4
        %.t6 = add i32 %.t3, %.t5
        ret i32 %.t6
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 () * @f()
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
