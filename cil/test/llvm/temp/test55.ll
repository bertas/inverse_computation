declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 4 x i8 ] c"%d\0A\00"
%struct.fun = type { i32 }
declare i32 @printf(i8 * %__format, ...)
@a = global %struct.fun { i32 32 }
define void @pfun2(%struct.fun * * %z) {
entry:
        ret void
}
define void @pfun(%struct.fun * %z) {
entry:
        %address.z = alloca %struct.fun * 
        store %struct.fun * %z, %struct.fun * * %address.z
        call void (%struct.fun * *) * @pfun2(%struct.fun * * %address.z)
        %.t2 = load %struct.fun * * %address.z
        %.t1 = getelementptr %struct.fun * %.t2, i32 0, i32 0
        %.t3 = load i32 * %.t1
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t3)
        ret void
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        call void (%struct.fun *) * @pfun(%struct.fun * @a)
        ret i32 0
}
