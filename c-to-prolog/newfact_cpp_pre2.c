/* Generated by CIL v. 1.7.3 */
/* print_CIL_Input is false */

#line 4 "newfact.c"
int fact(int n ) ;
#line 1 "newfact.c"
int main(int n ) 
{ 
  int n___0 ;

  {
#line 3
  n___0 = 5;
#line 4
  fact(n___0);
#line 6
  return (0);
}
}
#line 9 "newfact.c"
int fact(int n ) 
{ 
  int v ;
  int p ;

  {
#line 13
  p = 1;
#line 14
  v = 2;
#line 15
  while (v <= n) {
#line 16
    p *= v;
#line 17
    v ++;
  }
#line 19
  return (p);
}
}
