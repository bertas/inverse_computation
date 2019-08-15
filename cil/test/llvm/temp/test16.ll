declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 39 x i8 ] c"hello world - x.a is %d and x.b is %d\0A\00"
%struct.zz = type { i32,i32 }
declare i32 @printf(i8 * %__format, ...)
@x = global %struct.zz zeroinitializer
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t12 = getelementptr %struct.zz * @x, i32 0, i32 1
        store i32 2, i32 * %.t12
        %.t13 = getelementptr %struct.zz * @x, i32 0, i32 1
        %.t14 = load i32 * %.t13
        %.t15 = getelementptr %struct.zz * @x, i32 0, i32 0
        store i32 %.t14, i32 * %.t15
        %.t11 = icmp ne i32 %argc, 0
        br i1 %.t11, label %L3, label %L5
L5:
        br label %S1
L3:
        %.t5 = getelementptr %struct.zz * @x, i32 0, i32 1
        %.t6 = load i32 * %.t5
        %.t7 = getelementptr %struct.zz * @x, i32 0, i32 0
        %.t8 = load i32 * %.t7
        %.t9 = add i32 %.t6, %.t8
        %.t10 = getelementptr %struct.zz * @x, i32 0, i32 1
        store i32 %.t9, i32 * %.t10
        br label %S1
S1:
        %.t3 = getelementptr %struct.zz * @x, i32 0, i32 0
        %.t4 = load i32 * %.t3
        %.t1 = getelementptr %struct.zz * @x, i32 0, i32 1
        %.t2 = load i32 * %.t1
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 39 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t4, i32 %.t2)
        ret i32 0
}
