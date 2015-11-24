/*
Processes form pairs to test message sending and receiving.
*/

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main(int argc, char *argv[ ])
{
	int myrank, val;
	MPI_Status status;
	MPI_Init( &argc, &argv );
	MPI_Comm_rank( MPI_COMM_WORLD, &myrank );
	if ( myrank%2 == 0 ) {
		val = 1000 + myrank;
		MPI_Send( &val, 1, MPI_INT, myrank+1, 0, MPI_COMM_WORLD );
		printf( "Process %d sent value %d.\n", myrank, val );
	}
	else if ( myrank%2 == 1 ) {
		MPI_Recv( &val, 1, MPI_INT, myrank-1, 0, MPI_COMM_WORLD , &status );
		printf( "Process %d received value %d.\n", myrank, val );
	}
	MPI_Finalize( );
}
