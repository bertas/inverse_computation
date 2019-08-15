test(N1,FIB):- FIB is 2, N1\=1, write('aaa'), callee(FIB-1), write('bbb').
callee(FIB):- write(FIB).
