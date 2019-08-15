declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 16 x i8 ] c"hello world %g\0A\00"
declare i32 @printf(i8 * %__format, ...)
@a = global float sitofp(i32 3 to float)
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = load float * @a
        %.t2 = fpext float %.t1 to double 
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 16 x i8 ] * @.G0, i32 0, i32 0) to i8 *), double %.t2)
        ret i32 0
}
