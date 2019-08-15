declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 4 x i8 ] c"%d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@a = global [ 10 x [ 20 x i32 ] ] zeroinitializer
@b = global [ 20 x i32 ] * getelementptr([ 10 x [ 20 x i32 ] ] * @a, i32 0, i32 0)
define i32 @f() {
entry:
        br label %S15
L19:
        br label %S8
L18:
        %.t19 = mul i32 %i.7, 2
        %.t21 = load [ 20 x i32 ] * * @b
        %.t22 = getelementptr [ 20 x i32 ] * %.t21, i32 1
        %.t20 = getelementptr [ 20 x i32 ] * %.t22, i32 0, i32 %i.7
        store i32 %.t19, i32 * %.t20
        %.t23 = add i32 %i.7, 1
        br label %S15
S15:
        %i.7 = phi i32 [ %.t23, %L18 ], [ 0, %entry ]
        %.t25 = icmp slt i32 %i.7, 20
        %.t24 = select i1 %.t25, i32 1, i32 0
        %.t26 = icmp ne i32 %.t24, 0
        br i1 %.t26, label %L18, label %L19
L12:
        br label %S1
L11:
        %.t12 = getelementptr [ 10 x [ 20 x i32 ] ] * @a, i32 0, i32 1, i32 %i.16
        %.t13 = load i32 * %.t12
        %.t14 = add i32 %sum1.17, %.t13
        %.t15 = add i32 %i.16, 1
        br label %S8
S8:
        %sum1.17 = phi i32 [ %.t14, %L11 ], [ 0, %L19 ]
        %i.16 = phi i32 [ %.t15, %L11 ], [ 5, %L19 ]
        %.t17 = icmp slt i32 %i.16, 15
        %.t16 = select i1 %.t17, i32 1, i32 0
        %.t18 = icmp ne i32 %.t16, 0
        br i1 %.t18, label %L11, label %L12
L5:
        %.t2 = icmp eq i32 %sum1.17, %sum2.27
        %.t1 = select i1 %.t2, i32 1, i32 0
        ret i32 %.t1
L4:
        %.t4 = load [ 20 x i32 ] * * @b
        %.t5 = getelementptr [ 20 x i32 ] * %.t4, i32 1
        %.t3 = getelementptr [ 20 x i32 ] * %.t5, i32 0, i32 %i.25
        %.t6 = load i32 * %.t3
        %.t7 = add i32 %sum2.27, %.t6
        %.t8 = add i32 %i.25, 1
        br label %S1
S1:
        %sum2.27 = phi i32 [ %.t7, %L4 ], [ 0, %L12 ]
        %i.25 = phi i32 [ %.t8, %L4 ], [ 5, %L12 ]
        %.t10 = icmp slt i32 %i.25, 15
        %.t9 = select i1 %.t10, i32 1, i32 0
        %.t11 = icmp ne i32 %.t9, 0
        br i1 %.t11, label %L4, label %L5
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 () * @f()
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
