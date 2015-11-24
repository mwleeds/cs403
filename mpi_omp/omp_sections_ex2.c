/*
Illustrates functional parallelism or task parallelism as in example 2 of the OpenMP lecture notes.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#define N 1000000

double Alpha( ) {
	double sum=0;
	for (int k=1; k<=N; k++)
		sum += 1.0 / k;
	return sum;
}

double Beta( ) {
	double sum=0;
	for (int k=1; k<=N; k++)
		sum += 2.0 / (k + 1);
	return sum;
}

double Gamma(double a, double b) {
	double sum=0;
	for (int k=1; k<=N; k++)
		sum += a / (a*k + b);
	return sum;
}

double Delta( ) {
	double sum=0;
	for (int k=1; k<=N; k++)
		sum += 3.0 / (2*k + 1);
	return sum;
}

double Epsilon(double c, double d) {
	double sum=0;
	for (int k=1; k<=N; k++)
		sum += (c + d) / (c*k + d);
	return sum;
}

int main(int argc, char* argv[ ]) {
	double v, w, x, y, z;
	double timer = omp_get_wtime();
	int thread_count = 1;
	if (argc>1)
		thread_count = strtol(argv[1], NULL, 10);

#	pragma omp parallel num_threads(thread_count)
  	{
#		pragma omp sections
		{
#			pragma omp section
			{
				v = Alpha( );
				printf("v = %lf\n", v);
			}
#			pragma omp section
			{
				w = Beta( );
				printf("w = %lf\n", w);
			}
		}

#		pragma omp sections
		{
#			pragma omp section
			{
				x = Gamma(v, w);
				printf("x = %lf\n", x);
			}
#			pragma omp section
			{
				y = Delta( );
				printf("y = %lf\n", y);
			}
		}
	}

	z = Epsilon(x, y);
	printf("z = %lf\n", z);

	timer = omp_get_wtime() - timer;
	printf("timer = %lf\n", timer);

	return 0;
}
