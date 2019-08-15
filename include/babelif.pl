#conditional jump

greater(L,R,1):-L>R.
greater(L,R,0):-L=<R.

greaterequal(L,R,1):-L>=R.
greaterequal(L,R,0):-L<R.

less(L,R,1):-L<R.
less(L,R,0):-L>=R.

lessequal(L,R,1):-L=<R.
lessequal(L,R,0):-L>R.

equalto(L,R,1):-L=:=R.
equalto(L,R,0):-L=\=R.

notequal(L,R,1):-L=\=R.
notequal(L,R,0):-L=:=R.




conditionaljump(12,L,R,Result):-equalto(L,R,Result).


conditionaljump(13,L,R,Result):-notequal(L,R,Result).


conditionaljump(14,L,R,Result):-greater(L,R,Result).


conditionaljump(15,L,R,Result):-lessequal(L,R,Result).


conditionaljump(16,L,R,Result):-less(L,R,Result).


conditionaljump(17,L,R,Result):-greaterequal(L,R,Result).












