/*
Approximates pi using Monte Carlo algorithm.
Chooses random points by throwing darts into unit square and counting how many land in unit quarter-circle.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>

double dartboard(int darts) {
	double x, y, pi; 
	int score = 0;

	for (int n = 1; n <= darts; n++)  {
		x = (double)rand() / (double)RAND_MAX;
		y = (double)rand() / (double)RAND_MAX;
		if (x*x + y*y <= 1.0)
			score++;
	}
	pi = 4.0 * (double)score / (double)darts;
	return pi;
}

int main (int argc, char *argv[]) {
	double homepi, pisum, pi, avepi;
	int taskid, numtasks, i;

	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
	MPI_Comm_rank(MPI_COMM_WORLD, &taskid);
	printf ("MPI task %d has started...\n", taskid);

	srand(taskid);

	avepi = 0;
	for (i = 0; i < 100; i++) {
		homepi = dartboard(100000);
		MPI_Reduce(&homepi, &pisum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
		if (taskid == 0) {
			pi = pisum/numtasks;
			avepi = ((avepi * i) + pi)/(i + 1);
			printf("After %8d throws, average value of pi = %10.8f\n",
				(100000 * (i + 1) * numtasks), avepi);
		}
	}

	if (taskid == 0)
		printf ("\nActual value of pi: %10.8f\n", M_PI);

	MPI_Finalize();
	return 0;
}
