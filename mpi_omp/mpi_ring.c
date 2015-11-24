/*
Measures time to send N messages around the ring of processes, for values of N up to 1 million.
*/

# include <stdio.h>
# include <stdlib.h>
# include <mpi.h>

void ring_io ( int p, int id ) {
  int dest, i, j, n, n_test_num=5, source, test, test_num=10;
  int n_test[5] = { 100, 1000, 10000, 100000, 1000000 };
  double tave, tmax, tmin, wtime, *x;
  MPI_Status status;

  if ( id == 0 ) {
    printf ( "Based on %d experiments sending N double precision values around the ring:\n\n", test_num );
    printf ( "       N           T min           T ave           T max\n" );
  }

  for ( i = 0; i < n_test_num; i++ ) {    
    n = n_test[i];
    x = ( double * ) malloc ( n * sizeof ( double ) );
    if ( id == 0 ) {
      dest = 1;
      source = p - 1;
      tave = 0.0;
      tmin = 1.0E+30;
      tmax = 0.0;
      for ( test = 1; test <= test_num; test++ ) {
        for ( j = 0; j < n; j++ )
          x[j] = ( double ) ( test + j );

        wtime = MPI_Wtime ( );
        MPI_Send ( x, n, MPI_DOUBLE, dest,   0, MPI_COMM_WORLD );
        MPI_Recv ( x, n, MPI_DOUBLE, source, 0, MPI_COMM_WORLD, &status );
        wtime = MPI_Wtime ( ) - wtime;

        tave = tave + wtime;
        if ( wtime < tmin ) tmin = wtime;
        if ( wtime > tmax ) tmax = wtime;
      }

      tave = tave / ( double ) ( test_num );
      printf ( "%8d  %14.6g  %14.6g  %14.6g\n", n, tmin, tave, tmax );
    }
    else {
      source = id - 1;
      dest = ( ( id + 1 ) % p );
 
      for ( test = 1; test <= test_num; test++ ) {
        MPI_Recv ( x, n, MPI_DOUBLE, source, 0, MPI_COMM_WORLD, &status );
        MPI_Send ( x, n, MPI_DOUBLE, dest,   0, MPI_COMM_WORLD );
      }
    }
    free ( x );
  }
}

int main ( int argc, char *argv[] ) {
  int error, id, p;

  MPI_Init ( &argc, &argv );
  MPI_Comm_size ( MPI_COMM_WORLD, &p );
  MPI_Comm_rank ( MPI_COMM_WORLD, &id );

  if ( id == 0 )
    printf ( "Measure time to transmit data around a ring of %d processes\n", p );

  ring_io ( p, id );

  MPI_Finalize ( );
  return 0;
}
