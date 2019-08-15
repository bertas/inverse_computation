:-foreign(atoi_wrapper(+integer,-integer)).
:-foreign(str_pointer_dereference_wrapper(+positive, -string)).
:-foreign(strlen_wrapper(+string,-integer)).

test(INPUT,VALUE):- atoi_wrapper(INPUT,VALUE).
test2(INPUT,VALUE):- strlen_wrapper(INPUT,VALUE).

main(ARGC,ARGV,RETRES8):-  INPUT is 6, FAC is 1,
	              I is 1, loop(I,INPUT,FAC,RETURN_FAC),write(INPUT),write('! is '),write(RETURN_FAC),nl,RETRES8 is 0.

loop(I,INPUT,FAC,RETURN_FAC):- I =< INPUT, FAC1 is FAC*I,I1 is I+1,loop(I1,INPUT,FAC1,RETURN_FAC).
loop(I,INPUT,FAC,RETURN_FAC):- \+(I=<INPUT),RETURN_FAC is FAC.

debug(ARGC,ARGV,RETRES):- write(ARGC),nl,write(ARGV),nl,RETRES is 0.












:-foreign(atoi_wrapper(+integer,-integer)).
:-foreign(str_pointer_dereference_wrapper(+positive, -string)).
:-foreign(strlen_wrapper(+string,-integer)).

test(INPUT,VALUE):- atoi_wrapper(INPUT,VALUE).
test2(INPUT,VALUE):- strlen_wrapper(INPUT,VALUE).

main(ARGC,ARGV,RETRES8):- write('start'),nl, MEM7 is ARGV+1, write('start'),nl,str_pointer_dereference_wrapper(MEM7,STARMEM7),write('start'),nl, atoi_wrapper(STARMEM7,TMP), write('start'),nl,INPUT is TMP, FAC is 1,
	              I is 1, loop(I,INPUT,FAC,RETURN_FAC),write(INPUT),write('! is '),write(RETURN_FAC),RETRES8 is 0.

loop(I,INPUT,FAC,RETURN_FAC):- I =< INPUT, FAC1 is FAC*I,I1 is I+1,loop(I1,INPUT,FAC1,RETURN_FAC).
loop(I,INPUT,FAC,RETURN_FAC):- \+(I=<INPUT),RETURN_FAC is FAC.

debug(ARGC,ARGV,RETRES):- write(ARGC),nl,write(ARGV),nl,RETRES is 0.
