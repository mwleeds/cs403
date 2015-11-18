/*
Approximates pi using integral of 4/(1 + x*x) between 0 and 1, which is 4*(arctan 1 - arctan 0) = 4*(pi/4) = pi.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

int main(int argc, char *argv[]) {
	int n, myid, numthreads, i;
	double pi, width, sum, x;

	numthreads = omp_get_num_threads( );
	double mypi[numthreads];

	while (1) {
		printf("Enter the number of intervals (or 0 to quit): ");
		fflush(stdout);
		scanf("%d",&n);
		if (n <= 0) break;

		width = 1.0 / (double)n;

#		pragma omp parallel default(shared) private(myid,i,x,sum)
		{
			myid = omp_get_thread_num( );
			sum = 0.0;

			for (i = myid + 1; i <= n; i += numthreads) {
				x = width * ((double)i - 0.5);
				sum += 4.0 / (1.0 + x*x);
			}
			mypi[myid] = width * sum;
		}

		pi = 0;
#		pragma omp parallel for reduction(+:pi)
		for (i=0; i<numthreads; i++)
			pi += mypi[i];

		printf("pi is approximately %.16f, Error is %.16f\n", pi, fabs(pi - M_PI));
	}
	return 0;
}
