:-foreign(bit_move1_wrapper(+float,+float,-float)).
:-foreign(bit_move2_wrapper(+float,+float,+float,-float)).
:-foreign(ptr_dereference_update(+float,+float)).



byte_reverse(BUF,LONGS):- MEM5 is BUF +3, MEM6 is BUF+2, bit_move1_wrapper(MEM5,MEM6,TMP),
  MEM7 is BUF +1,MEM8 is BUF,bit_move2_wrapper(TMP,MEM7,MEM8,T),
  ptr_dereference_update(BUF,T),BUF1 is BUF+4, LONGS1 is LONGS-1, loop(BUF1,LONGS1).
  

loop(BUF,LONGS):- write('in loop'),nl,LONGS=\=0,MEM5 is BUF +3, MEM6 is BUF+2, bit_move1_wrapper(MEM5,MEM6,TMP),
  MEM7 is BUF +1,MEM8 is BUF,bit_move2_wrapper(TMP,MEM7,MEM8,T),
  ptr_dereference_update(BUF,T),BUF1 is BUF+4, LONGS1 is LONGS-1,loop(BUF1,LONGS1).

loop(BUF,LONGS):-LONGS =:=0.
