:- foreign(babel__implicit_mainc_0(+integer)).

main(N, BABEL_RET) :- 


 N___0 is 5,
babel__implicit_mainc_0(N___0),BABEL_RET is 0, true. 

 :- foreign(babel__implicit_mainc_0(+integer,  -integer)).
:- foreign(babel__implicit_mainc_0(+integer,  -integer)).
:- foreign(babel__implicit_mainc_0(+integer,  -integer)).
:- foreign(babel__implicit_mainc_0(+integer,  -integer)).
:- foreign(babel__implicit_mainc_0(+integer,  -integer)).
:- foreign(babel__implicit_mainc_1(+integer, +integer, +integer)).

main(ARGC, ARGV, BABEL_RET) :- 


 MEM_7 is ARGV +8* 1,
babel__implicit_mainc_0(*MEM_7 , TMP),
INPUT is TMP,
FAC is 1,
I is 1,loop_entry_0(FAC01, INPUT01, I01, FAC01, INPUT01, I01),
babel__implicit_mainc_1("%D! = %D\N", INPUT, FAC),BABEL_RET is 0, true. 

 
loop_entry_0(FAC01, INPUT01, I01, FinalFAC, FinalINPUT, FinalI) :- I =< INPUT-> !,BabelExp_0 is FAC * I,
FAC is BabelExp_0,
BabelExp_1 is I + 1,
I is BabelExp_1,
loop_entry_0( FAC01, INPUT01, I01 , FinalFAC, FinalINPUT, FinalI).
loop_entry_0( FAC01, INPUT01, I01,  FAC01, INPUT01, I01).
