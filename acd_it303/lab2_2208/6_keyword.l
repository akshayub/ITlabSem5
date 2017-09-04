%{
    #include<stdio.h>
    #include<ctype.h>
    int i;
%}

keyword main|int|char|double|float|for|while|do|union|struct|scanf|printf|if|else

%%

{keyword} {
    for(i=0;i<yyleng;i++)
        printf("%c",toupper(yytext[i]));
    }

%%

int main() {
    yyin=fopen("num.c","r");
    yylex();
    return 0;
}
