/*
Arranges 16 processes into 4 groups each having 4 processes.
*/

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#define NPROCS 16

int main(int argc, char *argv[])  {
	int rank, new_rank, sendbuf, recvbuf, numtasks;
	int P[4][4]={{0,1,2,3}, {4,5,6,7}, {8,9,10,11}, {12,13,14,15} };
	MPI_Group orig_group, new_group;
	MPI_Comm new_comm;

	MPI_Init(&argc,&argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &numtasks);

	if (numtasks != NPROCS) {
		printf("Must specify MP_PROCS= %d. Terminating.\n",NPROCS);
		MPI_Finalize();
		exit(0);
	}

	sendbuf = rank;
	MPI_Comm_group(MPI_COMM_WORLD, &orig_group);
	MPI_Group_incl(orig_group, NPROCS/4, P[rank/4], &new_group);

	MPI_Comm_create(MPI_COMM_WORLD, new_group, &new_comm);
	MPI_Allreduce(&sendbuf, &recvbuf, 1, MPI_INT, MPI_SUM, new_comm);

	MPI_Group_rank (new_group, &new_rank);
	printf("rank= %2d newgroup= %2d newrank= %2d recvbuf= %2d\n",rank,rank/4,new_rank,recvbuf);

	MPI_Finalize();
	return 0;
}
