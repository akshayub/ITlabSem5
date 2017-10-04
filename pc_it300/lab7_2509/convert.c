#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <sys/time.h>
#define BMP_PIXEL_BEGIN 1078

int main(int argc, char *argv[]) {

	if (argc != 3){
		printf("usage : use commmandline argument for image filename and threshold percentage\n");
		exit(-1);
	}

	char *filename = argv[1];
	// varies from -128 to 127
	char threshold = (atoi(argv[2])*255/100.0);
	int fileLen = 0;

	struct timeval tstart, tend;
	struct timezone temp;

	FILE *file = fopen(filename, "rb");

	fseek(file, 0, 2);
	fileLen = ftell(file);
	printf("File Size : %d\n", fileLen);
	fseek(file, 0, 0);

	char filebytes[fileLen];

	fread(&filebytes, sizeof(char), fileLen, file);

	gettimeofday(&tstart, &temp);
	int i;

	#pragma omp parallel for num_threads(4)
	for (i = BMP_PIXEL_BEGIN; i<fileLen; i++ ) {
		if (filebytes[i] >= threshold)
			filebytes[i] = 0;
		else
			filebytes[i] = 255;
	}

	gettimeofday(&tend, &temp);

	fclose(file);

	FILE *opfile = fopen("output.bmp", "wb");
	fwrite(&filebytes, sizeof(char), fileLen, opfile);
	fclose(opfile);

	printf("Time taken %lf\n",
		((tend.tv_sec * 1000000 + tend.tv_usec) - (tstart.tv_sec * 1000000 + tstart.tv_usec))/1000000.0
	);

	return 0;
}
