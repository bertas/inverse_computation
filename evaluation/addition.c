/* Generated by CIL v. 1.7.3 */
/* print_CIL_Input is false */

#line 46 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/i386/_types.h"
typedef long long __int64_t;
#line 71 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/_types.h"
typedef __int64_t __darwin_off_t;
#line 81 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/_stdio.h"
typedef __darwin_off_t fpos_t;
#line 92 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/_stdio.h"
struct __sbuf {
   unsigned char *_base ;
   int _size ;
};
#line 98
struct __sFILEX;
#line 98
struct __sFILEX;
#line 126 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/_stdio.h"
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
#line 126 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/_stdio.h"
typedef struct __sFILE FILE;
#line 184 "/usr/local/Cellar/gcc/8.2.0/lib/gcc/8/gcc/x86_64-apple-darwin18.2.0/8.2.0/include-fixed/stdio.h"
extern int ( /* format attribute */  printf)(char const   * __restrict    , ...) ;
#line 191
extern int ( /* format attribute */  scanf)(char const   * __restrict    , ...) ;
#line 269
extern int __swbuf(int  , FILE * ) ;
#line 278 "/usr/local/Cellar/gcc/8.2.0/lib/gcc/8/gcc/x86_64-apple-darwin18.2.0/8.2.0/include-fixed/stdio.h"
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
#line 2 "addition.c"
int addition(int num1 , int num2 ) 
{ 
  int sum ;

  {
#line 6
  sum = num1 + num2;
#line 11
  return (sum);
}
}
#line 14 "addition.c"
int main(void) 
{ 
  int var1 ;
  int var2 ;
  int res ;
  int tmp ;

  {
#line 17
  printf((char const   */* __restrict  */)"Enter number 1: ");
#line 18
  scanf((char const   */* __restrict  */)"%d", & var1);
#line 19
  printf((char const   */* __restrict  */)"Enter number 2: ");
#line 20
  scanf((char const   */* __restrict  */)"%d", & var2);
#line 26
  tmp = addition(var1, var2);
#line 26
  res = tmp;
#line 27
  printf((char const   */* __restrict  */)"Output: %d", res);
#line 29
  return (0);
}
}