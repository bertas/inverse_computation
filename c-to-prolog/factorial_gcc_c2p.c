/* Generated by CIL v. 1.7.3 */
/* print_CIL_Input is false */

#line 46 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/i386/_types.h"
typedef long long __int64_t;
#line 71 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types.h"
typedef __int64_t __darwin_off_t;
#line 81 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_stdio.h"
typedef __darwin_off_t fpos_t;
#line 92 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_stdio.h"
struct __sbuf {
   unsigned char *_base ;
   int _size ;
};
#line 98
struct __sFILEX;
#line 98
struct __sFILEX;
#line 126 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_stdio.h"
struct __sFILE {
   unsigned char *_p ;
   int _r ;
   int _w ;
   short _flags ;
   short _file ;
   struct __sbuf _bf ;
   int _lbfsize ;
   void *_cookie ;
   int (*_close)(void * ) ;
   int (*_read)(void * , char * , int  ) ;
   fpos_t (*_seek)(void * , fpos_t  , int  ) ;
   int (*_write)(void * , char const   * , int  ) ;
   struct __sbuf _ub ;
   struct __sFILEX *_extra ;
   int _ur ;
   unsigned char _ubuf[3] ;
   unsigned char _nbuf[1] ;
   struct __sbuf _lb ;
   int _blksize ;
   fpos_t _offset ;
};
#line 126 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_stdio.h"
typedef struct __sFILE FILE;
#line 184 "/usr/local/Cellar/gcc/9.2.0_1/lib/gcc/9/gcc/x86_64-apple-darwin18/9.2.0/include-fixed/stdio.h"
extern int ( /* format attribute */  printf)(char const   * __restrict    , ...) ;
#line 269
extern int __swbuf(int  , FILE * ) ;
#line 8 "factorial.c"
extern int ( /* missing proto */  atoi)() ;
#line 278 "/usr/local/Cellar/gcc/9.2.0_1/lib/gcc/9/gcc/x86_64-apple-darwin18/9.2.0/include-fixed/stdio.h"
__inline extern int __attribute__((__gnu_inline__))  ( __attribute__((__always_inline__)) __sputc)(int _c ,
                                                                                                   FILE *_p ) 
{ 
  unsigned char *tmp ;
  unsigned char tmp___0 ;
  int tmp___1 ;

  {
#line 279
  (_p->_w) --;
#line 279
  if (_p->_w >= 0) {
#line 280
    tmp = _p->_p;
#line 280
    (_p->_p) ++;
#line 280
    tmp___0 = (unsigned char )_c;
#line 280
    *tmp = tmp___0;
#line 280
    return ((int __attribute__((__gnu_inline__))  )tmp___0);
  } else
#line 279
  if (_p->_w >= _p->_lbfsize) {
#line 279
    if ((int )((char )_c) != 10) {
#line 280
      tmp = _p->_p;
#line 280
      (_p->_p) ++;
#line 280
      tmp___0 = (unsigned char )_c;
#line 280
      *tmp = tmp___0;
#line 280
      return ((int __attribute__((__gnu_inline__))  )tmp___0);
    } else {
#line 282
      tmp___1 = __swbuf(_c, _p);
#line 282
      return ((int __attribute__((__gnu_inline__))  )tmp___1);
    }
  } else {
#line 282
    tmp___1 = __swbuf(_c, _p);
#line 282
    return ((int __attribute__((__gnu_inline__))  )tmp___1);
  }
}
}
#line 5 "factorial.c"
int main(int argc , char **argv ) 
{ 
  int i ;
  int input ;
  int tmp ;
  int fac ;

  {
#line 8
  tmp = atoi(*(argv + 1));
#line 8
  input = tmp;
#line 9
  fac = 1;
#line 11
  i = 1;
#line 11
  while (i <= input) {
#line 12
    fac *= i;
#line 11
    i ++;
  }
#line 16
  printf((char const   */* __restrict  */)"%d! = %d\n", input, fac);
#line 17
  return (0);
}
}
