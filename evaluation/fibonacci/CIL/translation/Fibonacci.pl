fibonacci(N,FIB):- FIB0 is 0, ifone(N,FIB).

ifone(N,FIB):- N=1, FIB=1.  
ifone(N,FIB):- N\=1, iftwo(N,FIB).

iftwo(N,FIB):- N=2,FIB=1.
iftwo(N,FIB):- N0 is N-1, fibonacci(N0,TMP), N1 is N-2, fibonacci(N1,TMP0), FIB is TMP+TMP0.
