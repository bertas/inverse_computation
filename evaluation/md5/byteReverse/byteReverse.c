
void byteReverse(unsigned char *buf, unsigned longs)
{
    unsigned int t;
    do {
	t = (unsigned int) ((unsigned) buf[3] << 8 | buf[2]) << 16 |
	    ((unsigned) buf[1] << 8 | buf[0]);
	*(unsigned int *) buf = t;
	buf += 4;
    } while (--longs);
}
