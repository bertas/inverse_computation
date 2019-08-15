declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G4 = internal constant [ 18 x i8 ] c"starting sort...\0A\00"
@.G3 = internal constant [ 4 x i8 ] c"%d\0A\00"
@.G2 = internal constant [ 11 x i8 ] c"missorted\0A\00"
@.G1 = internal constant [ 9 x i8 ] c"s:n:1234\00"
@.G0 = internal constant [ 35 x i8 ] c"Usage: qsort -sSEED -nSIZE -[123]\0A\00"
%struct._IO_marker = type { %struct._IO_marker *,%struct._IO_FILE *,i32 }
%struct._IO_FILE = type { i32,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,%struct._IO_marker *,%struct._IO_FILE *,i32,i32,i32,i16,i8,[ 1 x i8 ],i8 *,i64,i8 *,i8 *,i8 *,i8 *,i32,i32,[ 40 x i8 ] }
@stderr = external global %struct._IO_FILE *
declare i32 @fprintf(%struct._IO_FILE * %__stream,i8 * %__format, ...)
declare i32 @printf(i8 * %__format, ...)
declare i32 @atoi(i8 * %__nptr)
declare i32 @lrand48()
declare void @srand48(i32 %__seedval)
declare i8 * @malloc(i32 %__size)
declare void @exit(i32 %__status)
@optarg = external global i8 *
declare i32 @getopt(i32 %___argc,i8 * * %___argv,i8 * %__shortopts)
declare void @seq_sort(i32 %base,i32 %n)
@from = global i32 * zeroinitializer
@to = global i32 * zeroinitializer
@size = global i32 8
@selected_sort = global void (i32,i32) * @seq_sort
define void @usage() {
entry:
        %.t1 = load %struct._IO_FILE * * @stderr
        %.t2 = bitcast %struct._IO_FILE * %.t1 to %struct._IO_FILE * 
        call i32 (%struct._IO_FILE *,i8 *, ...) * @fprintf(%struct._IO_FILE * %.t2, i8 * bitcast(i8 * getelementptr([ 35 x i8 ] * @.G0, i32 0, i32 0) to i8 *))
        call void (i32) * @exit(i32 2)
        unreachable
}
define i32 @intopt(i32 %min) {
entry:
        %.t4 = load i8 * * @optarg
        %.t5 = bitcast i8 * %.t4 to i8 * 
        %.t6 = call i32 (i8 *) * @atoi(i8 * %.t5)
        %.t2 = icmp slt i32 %.t6, %min
        %.t1 = select i1 %.t2, i32 1, i32 0
        %.t3 = icmp ne i32 %.t1, 0
        br i1 %.t3, label %L2, label %L4
L4:
        br label %S0
L2:
        call void () * @usage()
        br label %S0
S0:
        ret i32 %.t6
}
define void @setup(i32 %argc,i8 * * %argv) {
entry:
        call void (i32) * @srand48(i32 42)
        br label %S8
L21:
        %.t10 = load i32 * @size
        %.t11 = bitcast i32 %.t10 to i32 
        %.t12 = mul i32 %.t11, 4
        %.t13 = call i8 * (i32) * @malloc(i32 %.t12)
        %.t14 = bitcast i8 * %.t13 to i32 * 
        store i32 * %.t14, i32 * * @from
        %.t15 = load i32 * @size
        %.t16 = bitcast i32 %.t15 to i32 
        %.t17 = mul i32 %.t16, 4
        %.t18 = call i8 * (i32) * @malloc(i32 %.t17)
        %.t19 = bitcast i8 * %.t18 to i32 * 
        store i32 * %.t19, i32 * * @to
        br label %S1
L20:
        switch i32 %.t27, label %S11 [ i32 49, label %S13 i32 110, label %S15 i32 115, label %S17 ]
S17:
        %.t21 = call i32 (i32) * @intopt(i32 1)
        %.t22 = bitcast i32 %.t21 to i32 
        call void (i32) * @srand48(i32 %.t22)
        br label %S8
S15:
        %.t20 = call i32 (i32) * @intopt(i32 2)
        store i32 %.t20, i32 * @size
        br label %S8
S13:
        store void (i32,i32) * @seq_sort, void (i32,i32) * * @selected_sort
        br label %S8
S11:
        call void () * @usage()
        br label %S8
S8:
        %tmp.53 = phi i32 [ %tmp.53, %S11 ], [ %tmp.53, %S13 ], [ %tmp.53, %S15 ], [ %.t21, %S17 ], [ 0, %entry ]
        %opt.51 = phi i32 [ %.t27, %S11 ], [ %.t27, %S13 ], [ %.t27, %S15 ], [ %.t27, %S17 ], [ 0, %entry ]
        %.t26 = bitcast i8 * * %argv to i8 * * 
        %.t27 = call i32 (i32,i8 * *,i8 *) * @getopt(i32 %argc, i8 * * %.t26, i8 * getelementptr([ 9 x i8 ] * @.G1, i32 0, i32 0))
        %.t24 = icmp ne i32 %.t27, -1
        %.t23 = select i1 %.t24, i32 1, i32 0
        %.t25 = icmp ne i32 %.t23, 0
        br i1 %.t25, label %L20, label %L21
L5:
        ret void
L4:
        %.t1 = call i32 () * @lrand48()
        %.t2 = bitcast i32 %.t1 to i32 
        %.t3 = load i32 * * @from
        %.t4 = getelementptr i32 * %.t3, i32 %i.76
        store i32 %.t2, i32 * %.t4
        %.t5 = add i32 %i.76, 1
        br label %S1
S1:
        %tmp___2.80 = phi i32 [ %.t1, %L4 ], [ 0, %L21 ]
        %i.76 = phi i32 [ %.t5, %L4 ], [ 0, %L21 ]
        %.t6 = load i32 * @size
        %.t8 = icmp slt i32 %i.76, %.t6
        %.t7 = select i1 %.t8, i32 1, i32 0
        %.t9 = icmp ne i32 %.t7, 0
        br i1 %.t9, label %L4, label %L5
}
define void @seq_sort(i32 %base,i32 %n) {
entry:
        %.t87 = icmp sle i32 %n, 1
        %.t86 = select i1 %.t87, i32 1, i32 0
        %.t88 = icmp ne i32 %.t86, 0
        br i1 %.t88, label %L53, label %L55
L55:
        %.t83 = load i32 * * @from
        %.t84 = getelementptr i32 * %.t83, i32 %base
        %.t85 = load i32 * %.t84
        br label %S41
L53:
        ret void
L49:
        br label %S30
L48:
        %.t73 = load i32 * * @from
        %.t74 = getelementptr i32 * %.t73, i32 %i.73
        %.t75 = load i32 * %.t74
        %.t77 = icmp slt i32 %.t75, %.t85
        %.t76 = select i1 %.t77, i32 1, i32 0
        %.t78 = icmp ne i32 %.t76, 0
        br i1 %.t78, label %L44, label %L46
L46:
        br label %S42
L44:
        %.t67 = add i32 %j.74, 1
        %.t68 = load i32 * * @from
        %.t69 = getelementptr i32 * %.t68, i32 %i.73
        %.t70 = load i32 * %.t69
        %.t71 = load i32 * * @to
        %.t72 = getelementptr i32 * %.t71, i32 %j.74
        store i32 %.t70, i32 * %.t72
        br label %S42
S42:
        %tmp.68 = phi i32 [ %j.74, %L44 ], [ %tmp.78, %L46 ]
        %j.64 = phi i32 [ %.t67, %L44 ], [ %j.74, %L46 ]
        %.t66 = add i32 %i.73, 1
        br label %S41
S41:
        %tmp.78 = phi i32 [ %tmp.68, %S42 ], [ 0, %L55 ]
        %j.74 = phi i32 [ %j.64, %S42 ], [ %base, %L55 ]
        %i.73 = phi i32 [ %.t66, %S42 ], [ %base, %L55 ]
        %.t79 = add i32 %base, %n
        %.t81 = icmp slt i32 %i.73, %.t79
        %.t80 = select i1 %.t81, i32 1, i32 0
        %.t82 = icmp ne i32 %.t80, 0
        br i1 %.t82, label %L48, label %L49
L38:
        br label %S19
L37:
        %.t56 = load i32 * * @from
        %.t57 = getelementptr i32 * %.t56, i32 %i.133
        %.t58 = load i32 * %.t57
        %.t60 = icmp eq i32 %.t58, %.t85
        %.t59 = select i1 %.t60, i32 1, i32 0
        %.t61 = icmp ne i32 %.t59, 0
        br i1 %.t61, label %L33, label %L35
L35:
        br label %S31
L33:
        %.t50 = add i32 %j.134, 1
        %.t51 = load i32 * * @from
        %.t52 = getelementptr i32 * %.t51, i32 %i.133
        %.t53 = load i32 * %.t52
        %.t54 = load i32 * * @to
        %.t55 = getelementptr i32 * %.t54, i32 %j.134
        store i32 %.t53, i32 * %.t55
        br label %S31
S31:
        %tmp___0.129 = phi i32 [ %j.134, %L33 ], [ %tmp___0.139, %L35 ]
        %j.124 = phi i32 [ %.t50, %L33 ], [ %j.134, %L35 ]
        %.t49 = add i32 %i.133, 1
        br label %S30
S30:
        %tmp___0.139 = phi i32 [ %tmp___0.129, %S31 ], [ 0, %L49 ]
        %j.134 = phi i32 [ %j.124, %S31 ], [ %j.74, %L49 ]
        %i.133 = phi i32 [ %.t49, %S31 ], [ %base, %L49 ]
        %.t62 = add i32 %base, %n
        %.t64 = icmp slt i32 %i.133, %.t62
        %.t63 = select i1 %.t64, i32 1, i32 0
        %.t65 = icmp ne i32 %.t63, 0
        br i1 %.t65, label %L37, label %L38
L27:
        br label %S12
L26:
        %.t39 = load i32 * * @from
        %.t40 = getelementptr i32 * %.t39, i32 %i.193
        %.t41 = load i32 * %.t40
        %.t43 = icmp sgt i32 %.t41, %.t85
        %.t42 = select i1 %.t43, i32 1, i32 0
        %.t44 = icmp ne i32 %.t42, 0
        br i1 %.t44, label %L22, label %L24
L24:
        br label %S20
L22:
        %.t33 = add i32 %j.194, 1
        %.t34 = load i32 * * @from
        %.t35 = getelementptr i32 * %.t34, i32 %i.193
        %.t36 = load i32 * %.t35
        %.t37 = load i32 * * @to
        %.t38 = getelementptr i32 * %.t37, i32 %j.194
        store i32 %.t36, i32 * %.t38
        br label %S20
S20:
        %tmp___1.190 = phi i32 [ %j.194, %L22 ], [ %tmp___1.200, %L24 ]
        %j.184 = phi i32 [ %.t33, %L22 ], [ %j.194, %L24 ]
        %.t32 = add i32 %i.193, 1
        br label %S19
S19:
        %tmp___1.200 = phi i32 [ %tmp___1.190, %S20 ], [ 0, %L38 ]
        %j.194 = phi i32 [ %j.184, %S20 ], [ %j.134, %L38 ]
        %i.193 = phi i32 [ %.t32, %S20 ], [ %base, %L38 ]
        %.t45 = add i32 %base, %n
        %.t47 = icmp slt i32 %i.193, %.t45
        %.t46 = select i1 %.t47, i32 1, i32 0
        %.t48 = icmp ne i32 %.t46, 0
        br i1 %.t48, label %L26, label %L27
L16:
        %.t18 = sub i32 %j.74, %base
        call void (i32,i32) * @seq_sort(i32 %base, i32 %.t18)
        %.t19 = sub i32 %j.134, %base
        %.t20 = sub i32 %n, %.t19
        call void (i32,i32) * @seq_sort(i32 %j.134, i32 %.t20)
        %.t21 = add i32 %base, 1
        br label %S1
L15:
        %.t22 = load i32 * * @to
        %.t23 = getelementptr i32 * %.t22, i32 %i.223
        %.t24 = load i32 * %.t23
        %.t25 = load i32 * * @from
        %.t26 = getelementptr i32 * %.t25, i32 %i.223
        store i32 %.t24, i32 * %.t26
        %.t27 = add i32 %i.223, 1
        br label %S12
S12:
        %i.223 = phi i32 [ %.t27, %L15 ], [ %base, %L27 ]
        %.t28 = add i32 %base, %n
        %.t30 = icmp slt i32 %i.223, %.t28
        %.t29 = select i1 %.t30, i32 1, i32 0
        %.t31 = icmp ne i32 %.t29, 0
        br i1 %.t31, label %L15, label %L16
L9:
        ret void
L8:
        %.t4 = load i32 * * @from
        %.t5 = getelementptr i32 * %.t4, i32 %i.283
        %.t6 = load i32 * %.t5
        %.t7 = load i32 * * @from
        %.t8 = sub i32 %i.283, 1
        %.t9 = getelementptr i32 * %.t7, i32 %.t8
        %.t10 = load i32 * %.t9
        %.t12 = icmp slt i32 %.t6, %.t10
        %.t11 = select i1 %.t12, i32 1, i32 0
        %.t13 = icmp ne i32 %.t11, 0
        br i1 %.t13, label %L4, label %L6
L6:
        br label %S2
L4:
        %.t2 = load %struct._IO_FILE * * @stderr
        %.t3 = bitcast %struct._IO_FILE * %.t2 to %struct._IO_FILE * 
        call i32 (%struct._IO_FILE *,i8 *, ...) * @fprintf(%struct._IO_FILE * %.t3, i8 * bitcast(i8 * getelementptr([ 11 x i8 ] * @.G2, i32 0, i32 0) to i8 *))
        call void (i32) * @exit(i32 2)
        br label %S2
S2:
        %.t1 = add i32 %i.283, 1
        br label %S1
S1:
        %i.283 = phi i32 [ %.t1, %S2 ], [ %.t21, %L16 ]
        %.t14 = add i32 %base, %n
        %.t16 = icmp slt i32 %i.283, %.t14
        %.t15 = select i1 %.t16, i32 1, i32 0
        %.t17 = icmp ne i32 %.t15, 0
        br i1 %.t17, label %L8, label %L9
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        call void (i32,i8 * *) * @setup(i32 %argc, i8 * * %argv)
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 18 x i8 ] * @.G4, i32 0, i32 0) to i8 *))
        %.t9 = load i32 * @size
        %.t10 = load void (i32,i32) * * @selected_sort
        call void (i32,i32) * %.t10(i32 0, i32 %.t9)
        br label %S1
L5:
        ret i32 0
L4:
        %.t1 = load i32 * * @from
        %.t2 = getelementptr i32 * %.t1, i32 %i.9
        %.t3 = load i32 * %.t2
        call i32 (i8 *, ...) * @printf(i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G3, i32 0, i32 0) to i8 *), i32 %.t3)
        %.t4 = add i32 %i.9, 1
        br label %S1
S1:
        %i.9 = phi i32 [ %.t4, %L4 ], [ 0, %entry ]
        %.t5 = load i32 * @size
        %.t7 = icmp slt i32 %i.9, %.t5
        %.t6 = select i1 %.t7, i32 1, i32 0
        %.t8 = icmp ne i32 %.t6, 0
        br i1 %.t8, label %L4, label %L5
}
