%{
    #include <stdio.h>
    #include <string.h>
    int len = 0;
    char longest[100];
    int count = 0;
%}

WORD [A-Za-z0-9_]+

%%

{WORD} {
    if (yyleng > len) {
        len = yyleng;
        strcpy(longest,yytext);
    }
}
. {
    count++;
}

%%

int main() {
    yylex();
    int i;
    for (i = len - 1; i >= 0; i--) {
        printf("%c",longest[i]);
    }
    printf("\n");
}
