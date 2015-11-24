/*
Hybrid MPI and OpenMP program.
Each thread of each process prints a hello greeting.
*/

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <omp.h>

int main(int argc, char *argv[ ]) {
	int numprocs, myrank, namelength;
	char processor_name[MPI_MAX_PROCESSOR_NAME];
	int me = 0, numthreads = 1;

	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);
	MPI_Get_processor_name(processor_name, &namelength);

#	pragma omp parallel default(shared) private(me, numthreads)
	{
		numthreads = omp_get_num_threads( );
		me = omp_get_thread_num( );
		printf("Hello from thread %d out of %d from process %d out of %d on %s\n",
			me, numthreads, myrank, numprocs, processor_name);
	}
	MPI_Finalize( );
}
