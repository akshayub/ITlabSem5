%{
    #include <stdio.h>
    #include <stdlib.h>
    int comments = 0;
    int identifiers = 0;
%}

KEYWORDS int|char|float|double

LINE \/\/.*
%s COMMENT

%%

{KEYWORDS}[ A-Za-z_][0-9A-Za-z]+ {
    identifiers++;
}

"/*" {
    BEGIN COMMENT;
}

<COMMENT>"*/" {
    BEGIN 0;
    comments++;
}

<COMMENT>. {
    ;
}


{LINE} {
    comments++;
}

.|\n {
    fprintf(yyout, "%s",yytext);
}

%%

int main(int argc, char* argv[]) {

    if (argc != 2) {
        printf("Usage: ./a.out <inputfile>\n");
        exit(0);
    }

    yyin = fopen(argv[1], "r");
    //yyout = fopen(argv[2], "w");
    yylex();
    printf("Comments: %d\n",comments);
    printf("Identifiers: %d\n",identifiers);
}
