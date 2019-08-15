declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 22 x i8 ] c"hello world %d %d %d\0A\00"
%struct.__anonstruct_z_6 = type { i32,i32 }
%struct.fun = type { i32,i32,%struct.__anonstruct_z_6 }
declare i32 @printf(i8 * %__format, ...)
@a = global %struct.fun { i32 1,i32 0,%struct.__anonstruct_z_6 { i32 33,i32 44 } }
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = getelementptr %struct.fun * @a, i32 0, i32 2, i32 1
        store i32 19, i32 * %.t1
        %.t6 = getelementptr %struct.fun * @a, i32 0, i32 0
        %.t7 = load i32 * %.t6
        %.t4 = getelementptr %struct.fun * @a, i32 0, i32 1
        %.t5 = load i32 * %.t4
        %.t2 = getelementptr %struct.fun * @a, i32 0, i32 2, i32 1
        %.t3 = load i32 * %.t2
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 22 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t7, i32 %.t5, i32 %.t3)
        ret i32 0
}
