declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 13 x i32 ] [ i32 104, i32 101, i32 108, i32 108, i32 111, i32 32, i32 119, i32 111, i32 114, i32 108, i32 100, i32 10, i32 0 ]
declare i32 @wprintf(i32 * %__format, ...)
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        call i32 (i32 *, ...) * @wprintf(i32 * bitcast(i32 * getelementptr([ 13 x i32 ] * @.G0, i32 0, i32 0) to i32 *))
        ret i32 0
}
