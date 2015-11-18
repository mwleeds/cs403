/*
Creates two huge arrays and computes their dot product.
*/

#include <stdio.h>
#include <math.h>
#include <omp.h>

#define N 1000000
long a[N], b[N], z;

int main(int argc, char* argv[ ]) {
	int i, chunk=100;

	for (i=0; i < N; i++) {
		a[i] = i;
		b[i] = N-i;
	}

	z = 0;
#	pragma omp parallel for default(shared) private(i) schedule(static,chunk) reduction(+:z)
	for (i=0; i < N; i++)
		z += a[i] * b[i];

	printf("Dot product = %ld\n", z);

	return 0;
}
