declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G1 = internal constant [ 4 x i8 ] c"yes\00"
@.G0 = internal constant [ 16 x i8 ] c"hello world %d\0A\00"
%struct._IO_marker = type { %struct._IO_marker *,%struct._IO_FILE *,i32 }
%struct._IO_FILE = type { i32,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,%struct._IO_marker *,%struct._IO_FILE *,i32,i32,i32,i16,i8,[ 1 x i8 ],i8 *,i64,i8 *,i8 *,i8 *,i8 *,i32,i32,[ 40 x i8 ] }
declare void @__builtin_va_end(i8 *)
declare void @__builtin_va_start(i8 *)
declare i32 @_IO_putc(i32 %__c,%struct._IO_FILE * %__fp)
@stdout = external global %struct._IO_FILE *
declare i32 @vprintf(i8 * %__format,i8 * %__arg)
declare i32 @fputs(i8 * %__s,%struct._IO_FILE * %__stream)
define void @myprintf(i8 * %extra,i8 * %fmt, ...) {
entry:
        %address.pargs = alloca i8 * 
        %.t3 = bitcast i8 * %extra to i8 * 
        %.t1 = load %struct._IO_FILE * * @stdout
        %.t2 = bitcast %struct._IO_FILE * %.t1 to %struct._IO_FILE * 
        call i32 (i8 *,%struct._IO_FILE *) * @fputs(i8 * %.t3, %struct._IO_FILE * %.t2)
        %.t4 = load %struct._IO_FILE * * @stdout
        call i32 (i32,%struct._IO_FILE *) * @_IO_putc(i32 58, %struct._IO_FILE * %.t4)
        %.t5 = bitcast i8 * * %address.pargs to i8 * 
        call void (i8 *) * @llvm.va_start(i8 * %.t5)
        %.t7 = bitcast i8 * %fmt to i8 * 
        %.t6 = load i8 * * %address.pargs
        call i32 (i8 *,i8 *) * @vprintf(i8 * %.t7, i8 * %.t6)
        %.t8 = bitcast i8 * * %address.pargs to i8 * 
        call void (i8 *) * @llvm.va_end(i8 * %.t8)
        ret void
}
define i32 @main(i32 %argc,i8 * * %argv) {
entry:
        call void (i8 *,i8 *, ...) * @myprintf(i8 * bitcast(i8 * getelementptr([ 4 x i8 ] * @.G1, i32 0, i32 0) to i8 *), i8 * bitcast(i8 * getelementptr([ 16 x i8 ] * @.G0, i32 0, i32 0) to i8 *), i32 12)
        ret i32 0
}
