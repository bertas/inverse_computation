

main(ARGC, ARGV, BABEL_RET) :- 


 J is 8,
I is 65535,loop_entry_0(J01, J01),
BABEL_RET is 0, true. 

 
loop_entry_0(J01, FinalJ) :- J > 0-> !,BabelExp_0 is J - 1,
J is BabelExp_0,
loop_entry_0( J01 , FinalJ).
loop_entry_0( J01,  J01).
