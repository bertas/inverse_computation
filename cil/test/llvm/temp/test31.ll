declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 18 x i8 ] c"hello world - %d\0A\00"
declare i32 @printf(i8 * %__format, ...)
define void @silly(i32 * %w) {
entry:
        %.t1 = getelementptr i32 * %w, i32 1
        %.t2 = load i32 * %.t1
        %.t3 = add i32 %.t2, 1
        %.t4 = getelementptr i32 * %w, i32 1
        store i32 %.t3, i32 * %.t4
        ret void
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %zz = alloca [ 2 x i32 ] 
        %.t1 = getelementptr [ 2 x i32 ] * %zz, i32 0, i32 0
        store i32 3, i32 * %.t1
        %.t2 = getelementptr [ 2 x i32 ] * %zz, i32 0, i32 1
        store i32 5, i32 * %.t2
        %.t3 = getelementptr [ 2 x i32 ] * %zz, i32 0, i32 0
        call void (i32 *) * @silly(i32 * %.t3)
        %.t4 = getelementptr [ 2 x i32 ] * %zz, i32 0, i32 1
        %.t5 = load i32 * %.t4
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 18 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t5)
        ret i32 0
}
