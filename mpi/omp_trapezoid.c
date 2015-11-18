/*
Approximates the integral of f(x) from x=a to x=b using the trapezoid method with n trapezoids.
Example: If a=1, b=9, n=64, then global_result = 400.
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

double f(double x) {
	return x*x*x - 15*x*x + 60*x;
}

void Trap(double a, double b, int n, double* global_result_p) {
	double h, x, my_result;
	double local_a, local_b;
	int i, local_n;
	int my_rank = omp_get_thread_num( );
	int thread_count = omp_get_num_threads( );
	
	h = (b-a)/n;
	local_n = n/thread_count;
	local_a = a + my_rank * local_n * h;
	local_b = local_a + local_n * h;
	my_result = (f(local_a) + f(local_b)) / 2.0;

	for (i=1; i<=local_n-1; i++) {
		x = local_a + i*h;
		my_result += f(x);
	}
	my_result = my_result*h;

#	pragma omp critical
	*global_result_p += my_result;
}

int main(int argc, char* argv[ ]) {
	double global_result = 0.0;
	double a, b;
	int n, thread_count;

	thread_count = strtol(argv[1], NULL, 10);
	printf("Enter a, b, and n:\n");
	scanf("%lf %lf %d", &a, &b, &n);

#	pragma omp parallel num_threads(thread_count)
	Trap(a, b, n, &global_result);

	printf("With n = %d trapezoids, our estimate of the integral\n", n);
	printf("of function f from %f to %f = %f\n", a, b, global_result);
	return 0;
}
