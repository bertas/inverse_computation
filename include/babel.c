/* Copyright (c) 2012, Yufei Jiang (yzj107@ist.psu.edu)
 *
 * This file is part of BABEL, which is distributed under the revised
 * BSD license.  A copy of this license can be found in the file LICENSE.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See LICENSE
 * for details.
 */

#include <SWI-Prolog.h>
#include <stdio.h>
#include "babel.h"





//char *program = argv[0];



predicate_t pred_assign;
predicate_t pred_if;

void __BabelInit(char** argv){

  int number_of_plav=3;
  char *program;
  char *plav[number_of_plav];
  program=argv[0];
  plav[0] = program;
  //strcat(plav[0]," -q");
  //plav[0]="./a.out";
  plav[1] = " -q";
  //plav[2] = "-nosignals"
  //plav[3] = NULL;
  //plav[2] = NULL;
  //plav[3] = NULL;
  plav[2]= NULL;
  
  printf("%s\n","init");
  
  if ( !PL_initialise(number_of_plav-1, plav) )
    PL_halt(1);
	

   pred_assign = PL_predicate("assign",2,"user");
   pred_if=PL_predicate("conditionaljump",4,"user");
  
}


void __BabelExit(){
  PL_halt(0);
}

void __BabelAssign( __BABEL_ADDR babel_addr, __BABEL_VALUE rval){
	  //term_t t[2];t[0]= t[1]=
  
  //-----------------------------
  
  //pred_assign = PL_predicate("assign",2,"user");
 
  //-----------------------------
  
  
  term_t t0=PL_new_term_refs(2);
  term_t t1=t0+1;
  
  PL_put_integer(t1,rval);
  
  int result=PL_call_predicate(NULL,PL_Q_NORMAL,pred_assign,t0);
////store  
  PL_get_integer(t0,babel_addr);

}

int  __BabelJcc( __BABEL_OP op, __BABEL_VALUE lval, __BABEL_VALUE rval){
  int result;
  term_t t0 = PL_new_term_refs(4);
  term_t t1=t0+1;
  term_t t2=t0+2;
  term_t t3=t0+3;

  PL_put_integer(t0,op);
  PL_put_integer(t1,lval);
  PL_put_integer(t2,rval);
  
  PL_call_predicate(NULL, PL_Q_NORMAL, pred_if, t0);
  
  PL_get_integer(t3,&result);
  
  //to release the memory
  PL_reset_term_refs(t0);
  
  return result; 
}


