declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 19 x i8 ] c"hello world %d %d\0A\00"
%struct.a = type { i32,i32 }
declare i32 @printf(i8 * %__format, ...)
@z = global %struct.a zeroinitializer
define void @g(%struct.a *sret %.result, %struct.a *byval %b) {
entry:
        %.t3 = getelementptr %struct.a * %b, i32 0, i32 0
        %.t4 = load i32 * %.t3
        %.t5 = add i32 %.t4, 1
        %.t6 = getelementptr %struct.a * %b, i32 0, i32 0
        store i32 %.t5, i32 * %.t6
        %.t1 = bitcast %struct.a * %.result to i8 * 
        %.t2 = bitcast %struct.a * %b to i8 * 
        call void (i8 *,i8 *,i32,i32) * @llvm.memcpy.i32(i8 * %.t1, i8 * %.t2, i32 8, i32 4)
        ret void
}
define void @f() {
entry:
        %tt = alloca %struct.a 
        %.t1 = bitcast %struct.a * %tt to i8 * 
        %.t2 = bitcast %struct.a * @z to i8 * 
        call void (i8 *,i8 *,i32,i32) * @llvm.memcpy.i32(i8 * %.t1, i8 * %.t2, i32 8, i32 4)
        call void (%struct.a *sret, %struct.a *byval) * @g(%struct.a * @z, %struct.a * %tt)
        ret void
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = getelementptr %struct.a * @z, i32 0, i32 0
        store i32 22, i32 * %.t1
        call void () * @f()
        %.t4 = getelementptr %struct.a * @z, i32 0, i32 0
        %.t5 = load i32 * %.t4
        %.t2 = getelementptr %struct.a * @z, i32 0, i32 1
        %.t3 = load i32 * %.t2
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 19 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t5, i32 %.t3)
        ret i32 0
}
