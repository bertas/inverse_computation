declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
%struct.__anonstruct_precisionType_1 = type { i32 * }
define void @pnorm(%struct.__anonstruct_precisionType_1 * %u) {
entry:
        %.t14 = getelementptr %struct.__anonstruct_precisionType_1 * %u, i32 0, i32 0
        %.t15 = load i32 * * %.t14
        br label %S1
L9:
        %.t1 = ptrtoint i32 * %.t12 to i32 
        %.t2 = getelementptr %struct.__anonstruct_precisionType_1 * %u, i32 0, i32 0
        %.t3 = load i32 * * %.t2
        %.t4 = ptrtoint i32 * %.t3 to i32 
        %.t6 = icmp ugt i32 %.t1, %.t4
        %.t5 = select i1 %.t6, i32 1, i32 0
        %.t7 = icmp ne i32 %.t5, 0
        br i1 %.t7, label %L3, label %L4
L7:
        br label %S0
L4:
        br label %S0
L3:
        br label %S1
S1:
        %uPtr.10 = phi i32 * [ %.t12, %L3 ], [ %.t15, %entry ]
        %.t13 = sub i32 0, 1
        %.t12 = getelementptr i32 * %uPtr.10, i32 %.t13
        %.t8 = load i32 * %.t12
        %.t10 = icmp ne i32 %.t8, 0
        %.t9 = select i1 %.t10, i32 1, i32 0
        %.t11 = icmp ne i32 %.t9, 0
        br i1 %.t11, label %L7, label %L9
S0:
        ret void
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        ret i32 0
}
