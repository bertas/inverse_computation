declare void @llvm.memcpy.i32(i8*, i8*, i32, i32) nounwind
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare void @llvm.va_end(i8*)
@.G0 = internal constant [ 5 x i8 ] c"foo\0A\00"
%struct._IO_marker = type { %struct._IO_marker *,%struct._IO_FILE *,i32 }
%struct._IO_FILE = type { i32,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,i8 *,%struct._IO_marker *,%struct._IO_FILE *,i32,i32,i32,i16,i8,[ 1 x i8 ],i8 *,i64,i8 *,i8 *,i8 *,i8 *,i32,i32,[ 40 x i8 ] }
declare void @__builtin_va_end(i8 *)
declare void @__builtin_va_start(i8 *)
@stdout = external global %struct._IO_FILE *
declare i32 @vfprintf(%struct._IO_FILE * %__s,i8 * %__format,i8 * %__arg)
define i32 @wprintf(i8 * %__fmt,i8 * %__arg) {
entry:
        %address.__arg = alloca i8 * 
        store i8 * %__arg, i8 * * %address.__arg
        %.t2 = load %struct._IO_FILE * * @stdout
        %.t3 = bitcast %struct._IO_FILE * %.t2 to %struct._IO_FILE * 
        %.t1 = load i8 * * %address.__arg
        %.t4 = call i32 (%struct._IO_FILE *,i8 *,i8 *) * @vfprintf(%struct._IO_FILE * %.t3, i8 * %__fmt, i8 * %.t1)
        ret i32 %.t4
}
define void @xprintf(i8 * %__fmt, ...) {
entry:
        %address.vl = alloca i8 * 
        %.t1 = bitcast i8 * * %address.vl to i8 * 
        call void (i8 *) * @llvm.va_start(i8 * %.t1)
        %.t2 = load i8 * * %address.vl
        call i32 (i8 *,i8 *) * @wprintf(i8 * %__fmt, i8 * %.t2)
        %.t3 = bitcast i8 * * %address.vl to i8 * 
        call void (i8 *) * @llvm.va_end(i8 * %.t3)
        ret void
}
define i32 @main() {
entry:
        call void (i8 *, ...) * @xprintf(i8 * bitcast(i8 * getelementptr([ 5 x i8 ] * @.G0, i32 0, i32 0) to i8 *))
        ret i32 0
}
