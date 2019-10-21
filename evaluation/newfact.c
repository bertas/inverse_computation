int main(int n)
{
	int n = 5;
	fact(n);

}


int fact (int n)
{
	int v;
	int p;
	p =  1;
	v = 2;
		while (v <= n) {
			p *= v;
			v ++;
		}
	return p;
}
