babelJcc(OP, L, R) :-
    (  OP =:= 12 -> L =:= R
    ;  OP =:= 13 -> L \= R
    ;  OP =:= 14 -> L > R
    ;  OP =:= 15 -> L =< R
    ;  OP =:= 16 -> L < R
    ;  OP =:= 17 -> L >= R
    ).

:-foreign(babel_ptrR_byte(-byte, +integer, +integer)).
:-foreign(babel_ptrR(-integer, +integer, +integer)).
:-foreign(babel_ptrE(+integer, +integer, +integer)).
:-foreign(babel_ptrFR(-float, +integer,+integer)).
:-foreign(babel_ptrFW(+integer, +float,+integer)).


babelPtrR_byte(E, P, L) :- babel_ptrR_byte(T, P, L), E is T.
babelPtrR(E, P, L) :- babel_ptrR(T, P, L), E is T.
babelPtrL(P, E, L) :- babel_ptrE(P, E, L).

babelAssign(Var, Val) :- Var is Val.
babelAssignStr(Var, Val) :- Var = Val.
babelAssignBool(Var, Val) :- Var = Val.

babelArrayL([_|T], 0, X, [X|T]).
babelArrayL([H|T], I, X, [H|R]):- I > -1, NI is I-1, babelArrayL(T, NI, X, R), !.
babelArrayL(L, _, _, L).

babelArrayR(X, [X|_], 0).
babelArrayR(X, [_|T], I):- I > 0, NI is I-1, babelArrayR(X, T, NI), !.
