/*
Reads the file "infile.txt" and counts the number of times each ASCII character appears in this file.
*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

void compute_histogram(char *page, int page_size, int *histogram, int num_buckets) {
	int num_threads = omp_get_max_threads();
	int local_histogram[num_threads][num_buckets];

#	pragma omp parallel
	{
		int tid = omp_get_thread_num();

		for(int j = 0; j < num_buckets; j++)
			local_histogram[tid][j] = 0;

#		pragma omp for
		for(int i = 0; i < page_size; i++) {
			char read_character = page[i];
			local_histogram[tid][read_character]++;
		}
	}

#	pragma omp for
	for(int i = 0; i < num_buckets; i++) {
		for(int t = 0; t < num_threads; t++)
			histogram[i] += local_histogram[t][i];
	}
}

int main(int argc, char* argv[ ]) {
	const int num_buckets = 128;
	int histogram[num_buckets];
	for (int j = 0; j < num_buckets; j++)
		histogram[j]=0;

	FILE *f = fopen("infile.txt", "rb");
	fseek(f, 0, SEEK_END);
	int page_size = ftell(f);
	rewind(f);
	char *page = malloc(page_size + 1);
	fread(page, page_size, 1, f);
	fclose(f);
	page[page_size] = '\0';

	compute_histogram(page, page_size, histogram, num_buckets);

	printf("ASCII\tCount\n");
	for (int j = 0; j < num_buckets; j++)
		printf("%d\t%d\n", j, histogram[j]);

	return 0;
}
