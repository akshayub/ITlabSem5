*Write a program to convert a grey scale image to black and white image.*
<br>
*Implement the same using OpenMP and compare the sequential and parallel programs*<br>

_Note: Converting to binary is often used in order to find a Region Of Interest -- a portion of the image that is of interest for further processing._

Reading an image in C
```
FILE *input;
char get_char;
input = fopen("myimage.bmp", "rb");
while((get_char=fgetc(input))!= EOF)
   {
   ...
   }
fclose(input);
```
Reads a file with one byte at a time.
<br>
To convert grey scale to binary, one simple method is compare each byte with a threshold. If the pixel value is less than threshold, then bit value=0, else bit value =1.
<br>
One can use mean value for comparison.
<br>
You can also check with Msb. If MSB is 0 , bit is 0 else 1.
<br>
Use any one technique to implement the same.
