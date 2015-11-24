/*
Processes form a cycle to test non-blocking sends and receives.
*/

#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[])  {
	int numtasks, rank, next, prev, buf[2], tag1=1, tag2=2;
	MPI_Request reqs[4];
	MPI_Status stats[4];

	MPI_Init(&argc,&argv);
	MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	next = (rank==(numtasks-1)) ? 0 : (rank+1);
	prev = (rank==0) ? (numtasks-1) : (rank-1);

	MPI_Irecv(&buf[0], 1, MPI_INT, prev, tag1, MPI_COMM_WORLD, &reqs[0]);
	MPI_Irecv(&buf[1], 1, MPI_INT, next, tag2, MPI_COMM_WORLD, &reqs[1]);

	MPI_Isend(&rank, 1, MPI_INT, prev, tag2, MPI_COMM_WORLD, &reqs[2]);
	MPI_Isend(&rank, 1, MPI_INT, next, tag1, MPI_COMM_WORLD, &reqs[3]);

	/* could do some work here */

	MPI_Waitall(4, reqs, stats);
	printf("Task %d received values %d and %d.\n", rank, buf[0], buf[1]);

	MPI_Finalize();
	return 0;
}
