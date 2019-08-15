# 1 "./byteReverse.cil.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./byteReverse.cil.c"
# 6 "byteReverse.c"
extern int ( uint32)() ;
# 2 "byteReverse.c"
void byteReverse(unsigned char *buf , unsigned int longs )
{
  unsigned int t ;
  int tmp ;
  unsigned char *mem_5 ;
  unsigned char *mem_6 ;
  unsigned char *mem_7 ;
  unsigned char *mem_8 ;
  unsigned int *mem_9 ;

  {
  {
# 5 "byteReverse.c"
  while (1) {
    while_continue: ;
# 6 "byteReverse.c"
    mem_5 = buf + 3;
# 6 "byteReverse.c"
    mem_6 = buf + 2;
# 6 "byteReverse.c"
    tmp = uint32(((unsigned int )*mem_5 << 8) | (unsigned int )*mem_6);
# 6 "byteReverse.c"
    mem_7 = buf + 1;
# 6 "byteReverse.c"
    mem_8 = buf + 0;
# 6 "byteReverse.c"
    t = (unsigned int )(tmp << 16) | (((unsigned int )*mem_7 << 8) | (unsigned int )*mem_8);
# 8 "byteReverse.c"
    mem_9 = (unsigned int *)buf;
# 8 "byteReverse.c"
    *mem_9 = t;
# 9 "byteReverse.c"
    buf += 4;
# 5 "byteReverse.c"
    longs --;
# 5 "byteReverse.c"
    if (longs != 0) {

    } else {
# 5 "byteReverse.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 2 "byteReverse.c"
  return;
}
}
