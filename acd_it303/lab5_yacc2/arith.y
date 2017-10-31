%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token NUM ID
%left '+' '-'
%left '*' '/'

%%
stmt    : expr {printf("Valid expression\n");}
        ;

expr    : expr '+' expr
        | expr '-' expr
        | expr '*' expr
        | expr '/' expr
        | '('expr')'
        | NUM
        | ID
        ;

%%

#include "lex.yy.c"
#include <ctype.h>

int main() {
    printf("Enter the expression: ");
    yyparse();
}