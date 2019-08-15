:-foreign(ptr_dereference(+float,-integer)).
:-foreign(strlen_wrapper(+string,-integer)).



test2(ARGV,RETURN_VALUE):- MEM1 is ARGV+4,MEM2 is ARGV+8, ptr_dereference(MEM1,RETURN_VALUE),write(RETURN_VALUE),nl,ptr_dereference(MEM2,SECOND),write(SECOND),nl.

