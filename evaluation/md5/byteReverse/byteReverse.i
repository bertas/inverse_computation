# 1 "byteReverse.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "byteReverse.c"

void byteReverse(unsigned char *buf, unsigned longs)
{
    unsigned int t;
    do {
 t = (uint32) ((unsigned) buf[3] << 8 | buf[2]) << 16 |
     ((unsigned) buf[1] << 8 | buf[0]);
 *(unsigned int *) buf = t;
 buf += 4;
    } while (--longs);
}
