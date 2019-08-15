/* Copyright (c) 2012, Jiang Ming (jum310@ist.psu.edu)
 *
 * This file is part of BABEL, which is distributed under the revised
 * BSD license.  A copy of this license can be found in the file LICENSE.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See LICENSE
 * for details.
 */

#ifndef LIBBABEL_BABEL_H__
#define LIBBABEL_BABEL_H__


#ifdef __cplusplus
#define EXTERN extern "C"
#else
#define EXTERN extern
#endif

/*
 * Type definitions.
 *
 * These macros must be kept in sync with the definitions in base/basic_types.h.
 * We use these obscure MACRO's rather than the definitions in basic_types.h
 * in an attempt to avoid clashing with names in instrumented programs
 * (and also because C does not support namespaces).
 */
#define __BABEL_ID int
#define __BABEL_BRANCH_ID int
#define __BABEL_FUNCTION_ID unsigned int
#define __BABEL_VALUE long long int
#define __BABEL_ADDR unsigned long int

#define __BABEL_OP int
#define __BABEL_BOOL unsigned char

/*
 * Constants representing possible C operators.
 *
 * TODO(jburnim): Arithmetic versus bitwise right shift?
 */
typedef enum {
  /* binary arithmetic */
  __BABEL_ADD       =  0,
  __BABEL_SUBTRACT  =  1,
  __BABEL_MULTIPLY  =  2,
  __BABEL_DIVIDE    =  3,
  __BABEL_MOD       =  4,
  /* binary bitwise operators */
  __BABEL_AND       =  5,
  __BABEL_OR        =  6,
  __BABEL_XOR       =  7,
  __BABEL_SHIFT_L   =  8,
  __BABEL_SHIFT_R   =  9,
  /* binary logical operators */
  __BABEL_L_AND     = 10,
  __BABEL_L_OR      = 11,
  /* binary comparison */
  __BABEL_EQ        = 12,
  __BABEL_NEQ       = 13,
  __BABEL_GT        = 14,
  __BABEL_LEQ       = 15,
  __BABEL_LT        = 16,
  __BABEL_GEQ       = 17,
  /* unhandled binary operators */
  __BABEL_CONCRETE  = 18,
  /* unary operators */
  __BABEL_NEGATE    = 19,
  __BABEL_NOT       = 20,
  __BABEL_L_NOT     = 21,
};

/*
 * Short-cut to indicate that a function should be skipped during
 * instrumentation.
 */
#define __SKIP __attribute__((babel_skip))

/*
 * Instrumentation functions.

extern void __BabelInit(void)  __attribute__((__babel_skip__)) ;
extern void __BabelExit(void)  __attribute__((__babel_skip__)) ;
extern int __BabelJcc(int id , int op , long long val , long long val )  __attribute__((__babel_skip__)) ;
extern void __BabelAssign(int id , unsigned long addr , long long val )  __attribute__((__babel_skip__)) ;

 */
EXTERN void __BabelInit(char**) __SKIP;
EXTERN void __BabelExit() __SKIP;
EXTERN int  __BabelJcc(__BABEL_OP, __BABEL_VALUE, __BABEL_VALUE); __SKIP;
EXTERN void __BabelAssign( __BABEL_ADDR, __BABEL_VALUE); __SKIP;




#endif  /* LIBBABEL_BABEL_H__ */
