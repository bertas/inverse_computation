declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 18 x i8 ] c"hello world - %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
define void @silly(i32 * %w) {
entry:
        %.t1 = load i32 * %w
        %.t2 = add i32 %.t1, 1
        store i32 %.t2, i32 * %w
        ret void
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %address.zz = alloca i32 
        store i32 9, i32 * %address.zz
        call void (i32 *) * @silly(i32 * %address.zz)
        %.t1 = load i32 * %address.zz
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 18 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
