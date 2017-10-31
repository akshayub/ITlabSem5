%{
    #include <stdio.h>
    #include <stdlib.h>
    
    int max(int a, int b) {
        return a > b? a : b;
    }
%}

%token NUM ID LE NE GE EQ IF
%left '>' '<' LE NE GE EQ

%%

count   : ST1 {printf("No. of nested ifs : %d\n", $1);}
        ;

ST1     : RAND
        | IF '(' E ')' '{' ST1 '}' {$$ = $6 + 1;}
        | IF '(' E ')' '{' ST1 '}' ST1 {$$ = max($6,$8);}
        ;

RAND    : ID '=' expr ';'
        | expr
        ;


expr    : expr '+' expr
        | expr '-' expr
        | expr '*' expr
        | expr '/' expr
        | '('expr')'
        | ID
        | NUM
        ;

E   : '(' E ')'
    | E '=' E
    | E '<' E
    | E '>' E
    | E LE E 
    | E GE E
    | E EQ E
    | E NE E
    | ID
    | NUM
    ;

%%

#include "lex.yy.c"
#include <ctype.h>
#include <stdio.h>

int main() {
    yyparse();
    return 0;
}