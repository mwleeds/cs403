/*
Each thread prints a hello greeting.
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

void Hello(void) {
	int my_rank = omp_get_thread_num( );
	int thread_count = omp_get_num_threads( );
	printf("Hello from thread %d of %d\n", my_rank, thread_count);
}

int main(int argc, char* argv[ ]) {
	/* get number of threads from command line */
	int thread_count = 0;
	if (argc>1) {
		thread_count = strtol(argv[1], NULL, 10);
		omp_set_num_threads(thread_count);
	}

#	pragma omp parallel num_threads(thread_count)
	Hello( );

	return 0;
}
