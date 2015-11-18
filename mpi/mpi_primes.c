/*
Counts number of primes in range 1 to N for values of N up to 10 million.
*/

# include <stdio.h>
# include <stdlib.h>
# include <math.h>
# include <time.h>
# include <mpi.h>

int prime_number ( int n, int id, int p ) {
  int i, j, prime, total=0;

  for ( i = 2 + id; i <= n; i += p ) {
    prime = 1;
    for ( j = 2; j*j <= i; j++ ) {
      if ( ( i % j ) == 0 ) {
        prime = 0;
        break;
      }
    }
    total += prime;
  }
  return total;
}

int main ( int argc, char *argv[] ) {
  int i, id, n, n_factor, n_hi, n_lo, p, primes, primes_part;
  double wtime;

  n_lo = 1;
  n_hi = 10000000;
  n_factor = 10;

  MPI_Init ( &argc, &argv );
  MPI_Comm_size ( MPI_COMM_WORLD, &p );
  MPI_Comm_rank ( MPI_COMM_WORLD, &id );

  if ( id == 0 ) {
    printf ( "Count the number of primes from 1 to N using %d processes:\n\n", p );
    printf ( "         N    Primes          Time\n" );
  }

  for ( n = n_lo; n <= n_hi; n *= n_factor ) {
    if ( id == 0 ) wtime = MPI_Wtime ( );

    MPI_Bcast ( &n, 1, MPI_INT, 0, MPI_COMM_WORLD );

    primes_part = prime_number ( n, id, p );

    MPI_Reduce ( &primes_part, &primes, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD );

    if ( id == 0 ) {
      wtime = MPI_Wtime ( ) - wtime;
      printf ( "  %8d  %8d  %14f\n", n, primes, wtime );
    }
  }

  MPI_Finalize ( );
  return 0;
}
