%{
    #include <stdio.h>
    #include <stdlib.h>
    int count = 0;
%}


%%

[\t\n\ ]+[A-Za-z0-9_]*ab[^A-Za-z0-9_] {
    /*printf("%s is ending with a ab", yytext);*/
    count++;
}

. {
    ;
}

%%

int main(int argc, char* argv[]) {
    yylex();
    printf("Count: %d\n",count);
}
