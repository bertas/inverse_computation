:-foreign(ptr_dereference(+float,-integer)).
:-foreign(strlen_wrapper(+string,-integer)).


main(ARGC,ARGV,RETURN_VALUE):- INPUT is 1,((ARGC =\= 19, write('need 2 3*3 interger matrices'),nl);(nl)), I is 0,oneouterloop(I,INPUT,RETURN_INPUT,INPUTFORUSE,ARGV,[],LISTFORINNER,LISTFORUSE), write(LISTFORUSE),nl,write(INPUTFORUSE),nl,I1 is 0,oneouterloop(I1,INPUTFORUSE,MIDDLE_INPUT,OUT_INPUT,ARGV,[],SECONDMIDDLELIST,SECONDLIST),write(SECONDLIST), I2 is 0, calculate_out_loop(I2,LISTFORUSE,SECONDLIST,[],MIDDLE_LIST,OUT_LIST),write(OUT_LIST),nl,I3 is 0,pr(I3,OUT_LIST). 


pr(I,LIST):- I<3,J is 0,prline(I,J,LIST),I1 is I+1, pr(I1,LIST).
pr(I,LIST):- \+(I<3).


prline(I,J,LIST):- J<3,INDEX is I*3+J+1, nth(INDEX,LIST,ELEMENT),write(ELEMENT),write(' '),J1 is J+1,prline(I,J1,LIST).
prline(I,J,LIST):- \+(J<3), nl.

oneouterloop(I,INPUT,RETURN_INPUT,INPUTFORUSE,ARGV,LIST,RETURN_LIST,LISTFORUSE):- I<3,J is 0, oneinnerloop(J,INPUT,RETURN_INPUT,ARGV,LIST,RETURN_LIST), write(RETURN_LIST), write('helpful') ,nl, I1 is I+1,oneouterloop(I1,RETURN_INPUT,INPUT1,INPUTFORUSE,ARGV,RETURN_LIST,LIST1,LISTFORUSE).
oneouterloop(I,RETURN_INPUT,INPUT1,INPUTFORUSE,ARGV,LIST,RETURN_LIST,LISTFORUSE):- \+(I<3),append(LIST,[],RETURN_LIST),write(LIST),write('check'),nl,write(RETURN_LIST),write('check2'),nl,append(LIST,[],LISTFORUSE),INPUTFORUSE is RETURN_INPUT.


oneinnerloop(J,INPUT,RETURN_INPUT,ARGV,LIST,RETURN_LIST):- J<3, TMP is INPUT, INPUT1 is INPUT+1,MEM12 is ARGV+(TMP*4),ptr_dereference(MEM12,STARMEM12),write(STARMEM12),nl,append(LIST,[STARMEM12],LIST1),J1 is J+1,write(LIST1),nl,oneinnerloop(J1,INPUT1,RETURN_INPUT,ARGV,LIST1,RETURN_LIST).
oneinnerloop(J,INPUT,RETURN_INPUT,ARGV,LIST,RETURN_LIST):- \+(J<3), RETURN_INPUT is INPUT, append(LIST,[],RETURN_LIST).






calculate_out_loop(I,FIRST_MA,SECOND_MA,LIST,RETURN_LIST,OUT_LIST):- write('out'),nl,I<3, J is 0,calculate_middle_loop(I,J,FIRST_MA,SECOND_MA,LIST,RETURN_LIST),I1 is I+1, write(I1),write('I1'),nl,calculate_out_loop(I1,FIRST_MA,SECOND_MA,RETURN_LIST,TMP_LIST,OUT_LIST).
calculate_out_loop(I,FIRST_MA,SECOND_MA,LIST,RETURN_LIST,OUT_LIST):- \+(I<3),append(LIST,[],OUT_LIST).

calculate_middle_loop(I,J,FIRST_MA,SECOND_MA,LIST,RETURN_LIST):- write('middle'),nl,J<3,K is 0,calculate_inner_loop(I,J,K,FIRST_MA,SECOND_MA,0,PASS_PRODUCT,RETURN_PRODUCT), write(RETURN_PRODUCT),write('product'),nl,append(LIST,[RETURN_PRODUCT],LIST1),J1 is J+1,write(LIST1),write('llllllllllll'),nl, calculate_middle_loop(I,J1,FIRST_MA,SECOND_MA,LIST1,RETURN_LIST).
calculate_middle_loop(I,J,FIRST_MA,SECOND_MA,LIST,RETURN_LIST):- \+(J<3),append(LIST,[],RETURN_LIST),write(RETURN_LIST),write('mmmmmmmmmmmmmmmm'),nl.



calculate_inner_loop(I,J,K,FIRST_MA,SECOND_MA,EXISTING_PRODUCT,PASS_PRODUCT,RETURN_PRODUCT):- write('inner'),nl,K<3, INDEX1 is I*3+K+1, INDEX2 is K*3+J+1,write(INDEX2),nl,nth(INDEX1,FIRST_MA,MUL1),nth(INDEX2,SECOND_MA,MUL2),PRODUCT is MUL1*MUL2,write(PRODUCT),nl, PASS_PRODUCT is EXISTING_PRODUCT+PRODUCT, K1 is K+1,calculate_inner_loop(I,J,K1,FIRST_MA,SECOND_MA,PASS_PRODUCT,TMP_PRODUCT,RETURN_PRODUCT).
calculate_inner_loop(I,J,K,FIRST_MA,SECOND_MA,EXISTING_PRODUCT,PASS_PRODUCT,RETURN_PRODUCT):- \+(K<3),RETURN_PRODUCT is EXISTING_PRODUCT.









test(LIST):-append(LIST,[1,2,3],LIST1),write(LIST1),nl,append(LIST1,[],LIST2),write(LIST2),nl.
test2(ARGV,RETURN_VALUE):-write(ARGV),nl,write(T),nl,MEM12 is ARGV+4,write('start'),nl,write('okok'),nl, ptr_dereference(ARGV,RETURN_VALUE),ptr_dereference(MEM12,SECOND),write('dsdsd'),nl,write(RETURN_VALUE),nl,write(SECOND),nl.
test3(INPUT):-strlen_wrapper(INPUT,Z).

ptr_dereference(INPUT,INTEGER).
