%{
    #include <stdio.h>
    #include <string.h>
    int read_count = 0;
    int write_count = 0;
%}

SCAN scanf
PRINT printf

%%

{SCAN} {
    read_count++;
    printf("readf");
}

{PRINT} {
    write_count++;
    printf("writef");
}

%%

int main() {
    yylex();
    printf("\nscanf: %d printf: %d\n",read_count, write_count);
}
