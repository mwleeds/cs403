/*
Creates three huge arrays and then tests several OMP pragmas.
*/

#include <stdio.h>
#include <omp.h>

#define N 1000000
float a[N], b[N], c[N], z;

int main(int argc, char* argv[ ]) {
	int i, chunk=100;

	for (i=0; i < N; i++) {
		a[i] = 2.0 * i;
		b[i] = 3.0 * (N-i);
	}

#	pragma omp parallel shared(a,b,c,chunk) private(i)
	{
#		pragma omp for schedule(dynamic,chunk) nowait
		for (i=0; i < N; i++)
			c[i] = a[i]*a[i] + b[i]*b[i];
	}

	z = c[0];
#	pragma omp parallel for reduction(min:z)
	for (i=0; i < N; i++)
		if (c[i] < z) z = c[i];

	printf("Minimum = %f\n", z);

	return 0;
}
