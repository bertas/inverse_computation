main(_, _, A) :-
	_ is 8,
	_ is 65535,
	loop_entry_0(B, B),
	A is 0,
	true.

loop_entry_0(A, B) :-
	(   C > 0 ->
	    !,
	    D is C - 1,
	    C is D,
	    loop_entry_0(A, B)
	).
loop_entry_0(A, A).
