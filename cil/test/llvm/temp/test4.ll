declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 4 x i8 ] c"%d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@a = global [ 20 x i32 ] zeroinitializer
define i32 @f() {
entry:
        %.t3 = getelementptr [ 20 x i32 ] * @a, i32 0, i32 0
        store i32 33, i32 * %.t3
        %.t4 = getelementptr [ 20 x i32 ] * @a, i32 0, i32 2
        store i32 19, i32 * %.t4
        %.t1 = getelementptr [ 20 x i32 ] * @a, i32 0, i32 2
        %.t2 = load i32 * %.t1
        ret i32 %.t2
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 () * @f()
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
