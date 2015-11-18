/*
Tests atomic updates where multiple threads overwrite the same array location.
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

float work1(int i) {
	return 2.0 * i;
}

float work2(int i) {
	return 3.0 * i;
}

void example(float *x, float *y, int *index, int n) {

#	pragma omp parallel for shared(x, y, index, n)
	for (int i = 0; i < n; i++) {

#		pragma omp atomic update
		x[index[i]] += work1(i);

		y[i] += work2(i);
	}
}

int main(int argc, char* argv[ ]) {
	float x[1000];
	float y[100000];
	int index[100000];

#	pragma omp parallel for shared(x)
	for (int i = 0; i < 1000; i++)
		x[i] = 0.0;

#	pragma omp parallel for shared(y, index)
	for (int i = 0; i < 100000; i++) {
		index[i] = i % 1000;
		y[i] = 0.0;
	}

	example(x, y, index, 100000);

	printf("%f\n", x[999]);

	return 0;
}
