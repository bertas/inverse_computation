declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 22 x i8 ] c"hello world %d %d %f\0A\00"
%struct.fun = type { i32,i32,double }
declare i32 @printf(i8 * %__format, ...)
@a = global %struct.fun { i32 1,i32 12,double 3.22999999999999971578e+01 }
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t5 = getelementptr %struct.fun * @a, i32 0, i32 0
        %.t6 = load i32 * %.t5
        %.t3 = getelementptr %struct.fun * @a, i32 0, i32 1
        %.t4 = load i32 * %.t3
        %.t1 = getelementptr %struct.fun * @a, i32 0, i32 2
        %.t2 = load double * %.t1
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 22 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t6, i32 %.t4, double %.t2)
        ret i32 0
}
