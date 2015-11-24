/*
Approximates pi using integral of 4/(1 + x*x) between 0 and 1, which is 4*(arctan 1 - arctan 0) = 4*(pi/4) = pi.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

int main(int argc, char *argv[]) {
	int n, i;
	double pi, width, sum, x;

	while (1) {
		printf("Enter the number of intervals (or 0 to quit): ");
		fflush(stdout);
		scanf("%d",&n);
		if (n <= 0) break;

		width = 1.0 / (double)n;
		sum = 0.0;

#		pragma omp parallel for private(x) shared(n,width) reduction(+:sum)
		for (i = 1; i <= n; i++) {
			x = width * ((double)i - 0.5);
			sum += 4.0 / (1.0 + x*x);
		}

		pi = width * sum;
		printf("pi is approximately %.16f, Error is %.16f\n", pi, fabs(pi - M_PI));
	}
	return 0;
}
