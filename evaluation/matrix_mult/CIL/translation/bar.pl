:-foreign(strlen_wrapper(+string,-integer)).


bar(INPUT,X,Y,RETURN_VALUE):-strlen_wrapper(INPUT,LENGTH),((LENGTH<5,XX is X+2,YY is Y);(\+(LENGTH<5),YY is Y+2,XX is X)),Z is YY-XX,((Z<10,R0 is XX);(Z>=10,R0 is YY)),loop(0,R0,J),write('newbar'),RETURN_VALUE is J.

loop(10,L,J) :-J is L, !.
loop(X,L,J) :- X<10,X1 is X+1, L1 is L+1, loop(X1,L1,J).  


