/*
Searches integers in the range from A to B for value J such that F(J) = C, and measures elapsed time.
*/

# include <stdlib.h>
# include <stdio.h>
# include <time.h>
# include <mpi.h>

double cpu_time ( void ) {
  return ( double ) clock ( ) / ( double ) CLOCKS_PER_SEC;
}

int f ( int i ) {
  int huge = 2147483647, j, k, value;

  value = i;

  for ( j = 1; j <= 5; j++ ) {
    k = value / 127773;
    value = 16807 * ( value - k * 127773 ) - k * 2836;
    if ( value <= 0 ) value += huge;
  }

  return value;
}

int search ( int a, int b, int c, int id, int p ) {

  for ( int i = a + id; 0 < i && i <= b; i += p )
    if ( f(i) == c ) return i;

  return -1;
}

int main ( int argc, char *argv[] ) {
  int a, b, c, fj, huge = 2147483647, id, j, p;
  double wtime;

  MPI_Init ( &argc, &argv );
  MPI_Comm_rank ( MPI_COMM_WORLD, &id );
  MPI_Comm_size ( MPI_COMM_WORLD, &p );

  a = 1;
  b = huge;
  c = 45;

  if ( id == 0 )
  {
    printf ( "Search the integers from A to B for value J such that F(J) = C.\n\n" );
    printf ( "  A = %d\n", a );
    printf ( "  B = %d\n", b );
    printf ( "  C = %d\n", c );
  }

  wtime = MPI_Wtime ( );

  j = search ( a, b, c, id, p );

  wtime = MPI_Wtime ( ) - wtime;

  if ( j != -1 ) {
    printf ( "\nProcess %d found J = %d\n", id, j );
    printf ( "Verify F(J) = %d\n", f(j) );
  }

  if ( id == 0 )
    printf ( "Elapsed wallclock time is %g\n", wtime );

  MPI_Finalize ( );
  return 0;
}
