%{
    #include <stdio.h>
    #include <stdlib.h>
    int a = 0, s = 0, m = 0, d = 0, bracvalid = 0, opvalid = 1;
%}

id [A-Za-z]+
OP_BRAC "("
CL_BRAC ")"

%%

{OP_BRAC} {
    bracvalid++;
}

{CL_BRAC} {
    bracvalid--;
}

{id} {
    printf("%s is an identifier\n",yytext);
    opvalid = 1;
}

[0-9]+ {
    opvalid = 1;
}

"+" {
    opvalid = 0;
    a++;
}

"-" {
    opvalid = 0;
    s++;
}

"*" {
    opvalid = 0;
    m++;
}

"/" {
    opvalid = 0;
    d++;
}

. {
    ;
}

%%

int main(int argc, char* argv[]) {
    yylex();
    if (bracvalid == 0 && opvalid == 1) {
        printf("The expression is valid. Operators used: \n");
        if (a) {
            printf("+\n");
        }
        if (s) {
            printf("-\n");
        }
        if (m) {
            printf("*\n");
        }
        if (d) {
            printf("/\n");
        }
    }
    else {
        printf("The expression is invalid");
    }
}
