declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 4 x i8 ] c"%d\0A\00"
declare i32 @printf(i8 * %__format, ...)
@a = global [ 20 x i32 ] zeroinitializer
define i32 @f() {
entry:
        br label %S8
L12:
        br label %S1
L11:
        %.t8 = mul i32 %i.8, 2
        %.t9 = getelementptr i32 * getelementptr([ 20 x i32 ] * @a, i32 0, i32 0), i32 %i.8
        store i32 %.t8, i32 * %.t9
        %.t10 = add i32 %i.8, 1
        br label %S8
S8:
        %i.8 = phi i32 [ %.t10, %L11 ], [ 0, %entry ]
        %.t12 = icmp slt i32 %i.8, 20
        %.t11 = select i1 %.t12, i32 1, i32 0
        %.t13 = icmp ne i32 %.t11, 0
        br i1 %.t13, label %L11, label %L12
L5:
        ret i32 %sum.18
L4:
        %.t1 = getelementptr [ 20 x i32 ] * @a, i32 0, i32 %i.17
        %.t2 = load i32 * %.t1
        %.t3 = add i32 %sum.18, %.t2
        %.t4 = add i32 %i.17, 1
        br label %S1
S1:
        %sum.18 = phi i32 [ %.t3, %L4 ], [ 0, %L12 ]
        %i.17 = phi i32 [ %.t4, %L4 ], [ 5, %L12 ]
        %.t6 = icmp slt i32 %i.17, 15
        %.t5 = select i1 %.t6, i32 1, i32 0
        %.t7 = icmp ne i32 %.t5, 0
        br i1 %.t7, label %L4, label %L5
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        %.t1 = call i32 () * @f()
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 %.t1)
        ret i32 0
}
