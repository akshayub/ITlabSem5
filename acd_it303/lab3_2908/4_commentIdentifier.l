%{
    #include <stdio.h>
    #include <string.h>
    int comments = 0;
    int identifiers = 0;
%}

COMMENT \/\/.*
IDENTIFIER 

%%

{COMMENT} {
    comments++;
}
{IDENTIFIER} {
    identifiers++;
}

%%

int main() {
    yylex();
    printf("%d %d\n",comments,identifiers);
}
