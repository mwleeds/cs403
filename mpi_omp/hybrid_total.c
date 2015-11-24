/*
Hybrid MPI and OpenMP program.
Prints (x,y) for each thread y of each process x.
*/

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <omp.h>

#define NUM_THREADS 8

int main (int argc, char *argv[ ]) {
	int p,my_rank,count=0,total;
	omp_set_num_threads(NUM_THREADS);

	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD,&my_rank);

#	pragma omp parallel reduction(+:count)
	{
		int me = omp_get_thread_num( );
		printf("(%d,%d)\n",my_rank,me);
		count++;
	}

	MPI_Reduce(&count, &total, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD);

	if (my_rank==0) {
		printf("\nTotal number of threads = %d\n",total);
	}
	MPI_Finalize();
	return 0;
}
