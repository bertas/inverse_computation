# 1 "newfact.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 361 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "newfact.c" 2
int main(int n)
{
 int n = 5;
 fact(n);

}


int fact (int n)
{
 int v;
 int p;
 p = 1;
 v = 2;
  while (v <= n) {
   p *= v;
   v ++;
  }
 return p;
}
