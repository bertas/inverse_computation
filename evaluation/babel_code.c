#include <gprolog.h>

PlBool babel_ptrR(PlLong* p,  PlLong* star_p, PlLong len)
{

	if (star_p == 0)
	    return PL_FALSE;
	else
	{
		switch(len)
		{
		    case 1:
		    	*p = *(unsigned char*)star_p;
		    	break;
		    case 2:
		    	*p = *(short*)star_p;
		    	break;
		    case 4:
		    	*p = *(int*)star_p;
		    	break;
		    case 8:
		    	*p = *(long long*)star_p;
		    	break;
		    default :
		    	printf("undefined exp length in babel_ptrR\n");
		}
	}

		return PL_TRUE;
}

PlBool babel_ptrR_byte(PlLong* p,  PlLong* star_p, PlLong len)
{

	if (star_p == 0)
	    return PL_FALSE;
	else
	{
		switch(len)
		{
		    case 1:
		    	*p = *(unsigned char*)star_p;
		    	break;
		    case 2:
		    	*p = *(short*)star_p;
		    	break;
		    case 4:
		    	*p = *(int*)star_p;
		    	break;
		    case 8:
		    	*p = *(long long*)star_p;
		    	break;
		    default :
		    	printf("undefined exp length in babel_ptrR\n");
		}
	}

	return PL_TRUE;
}

PlBool babel_ptrE(PlLong* p,  PlLong e, PlLong len)
{
	if (p == 0)
	    return PL_FALSE;

	switch(len)
		{
		    case 1:
		    	*(unsigned char*)p = (unsigned char)e;
		    	break;
		    case 2:
		    	*(short*) p = (short)e;
		    	break;
		    case 4:
		    	*(int*)p = (int)e;
		    	break;
		    case 8:
		    	*(long long*)p = (long long)e;
		    	break;
		    default :
		    	printf("undefined exp length in babel_ptrL\n");
		}

        return PL_TRUE;
}

PlBool babel_ptrFR(double* fp, PlLong ptr, PlLong len)
{
  if(len == 2)
  *(double *)fp = *(double *)ptr;
   else if (len == 1)
  *(float *)fp = *(float *)ptr;
  else
  return PL_FALSE;

  return PL_TRUE;
}

PlBool babel_ptrFW(PlLong ptr, double f, PlLong len)
{
  if (len == 2)
  *(double *)ptr = f;
   else if (len == 1)
  *(float *)ptr = f;
  else
  return PL_FALSE;
  
  return PL_TRUE;
}

