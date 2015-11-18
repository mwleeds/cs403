/*
Tests the scatter and scan functions.
*/

#include <stdio.h>
#include <mpi.h>
#define SIZE 4

int main(int argc, char *argv[])  {
	int numtasks, rank, sendcount, recvcount, source;
	float sendbuf[SIZE][SIZE] = {
		{11.0, 12.0, 13.0, 14.0},
		{15.0, 16.0, 17.0, 18.0},
		{19.0, 20.0, 21.0, 22.0},
		{23.0, 24.0, 25.0, 26.0} };
	float recvbuf[SIZE], scanbuf[SIZE];

	MPI_Init(&argc,&argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &numtasks);

	if (numtasks == SIZE) {
		sendcount = SIZE;
		recvcount = SIZE;
		MPI_Scatter(sendbuf,sendcount,MPI_FLOAT,recvbuf,recvcount,MPI_FLOAT,0,MPI_COMM_WORLD);
		printf("rank= %d  results: %f %f %f %f\n",rank,recvbuf[0],recvbuf[1],recvbuf[2],recvbuf[3]);
		MPI_Scan(recvbuf,scanbuf,SIZE,MPI_FLOAT,MPI_SUM,MPI_COMM_WORLD);
		printf("rank= %d  results: %f %f %f %f\n",rank,scanbuf[0],scanbuf[1],scanbuf[2],scanbuf[3]);
	}
	else
		printf("Must specify exactly %d processors. Terminating.\n",SIZE);

	MPI_Finalize();
	return 0;
}
