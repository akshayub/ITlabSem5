#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <sys/time.h>

int main(int argc, char *argv[]) {

	if (argc != 2){
		printf("usage : use commmandline argument for image filename\n");
		exit(-1);
	}

	char *filename = argv[1];

	struct timeval tstart, tend;
	struct timezone temp;

	FILE *file = fopen(filename, "rb");
	FILE *opfile = fopen("output.bmp", "w");

	gettimeofday(&tstart, &temp);

	char get_char;
	int counter = 0, max = 54;
	while((get_char=fgetc(file))!= EOF) {
		if (counter >= max){
			if (get_char > 0)
				get_char = 120;
			else
				get_char = -120;
			counter++;
		}
		fprintf(opfile, "%c", get_char);
	}
	fprintf(opfile, "%c", get_char);

	gettimeofday(&tend, &temp);

	fclose(file);
	fclose(opfile);

	printf("Time taken %lf\n",
		((tend.tv_sec * 1000000 + tend.tv_usec) - (tstart.tv_sec * 1000000 + tstart.tv_usec))/1000000.0
	);

	return 0;
}
