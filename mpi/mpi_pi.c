/*
Approximates pi using integral of 4/(1 + x*x) between 0 and 1, which is 4*(arctan 1 - arctan 0) = 4*(pi/4) = pi.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>

int main(int argc, char *argv[]) {
	int n, myid, numprocs, i, rc;
	double mypi, pi, width, sum, x, a;

	MPI_Init(&argc,&argv);
	MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
	MPI_Comm_rank(MPI_COMM_WORLD,&myid);

	while (1) {
		if (myid == 0) {
			printf("Enter the number of intervals (or 0 to quit): ");
			fflush(stdout);
			scanf("%d",&n);
		}

		MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);

		if (n <= 0) break;
		width = 1.0 / (double)n;
		sum = 0.0;
		for (i = myid + 1; i <= n; i += numprocs) {
			x = width * ((double)i - 0.5);
			sum += 4.0 / (1.0 + x*x);
		}
		mypi = width * sum;

		MPI_Reduce(&mypi, &pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

		if (myid == 0)
			printf("pi is approximately %.16f, Error is %.16f\n", pi, fabs(pi - M_PI));
	}

	MPI_Finalize();
	return 0;
}
