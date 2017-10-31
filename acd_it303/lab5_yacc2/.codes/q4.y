%{
#include <stdio.h>
#include <stdlib.h>
int count = 0;
%}

%token ID NUM IF LE GE EQ NE OR AND
%right '='
%left AND OR
%left '<''>' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'
%%

S : ST {printf("Input accepted.%d\n",count);exit(0);};
ST : IF'('E2')' '{' ST1 '}' {count = count +1;}
	;

ST1 : ST
| E 
;

E : ID '=' E3 ';'
;
E3 : ID '=' E3
|E3'+'E3
|E3'-'E3
|E3'*'E3
|E3'/'E3
|E3'<'E3
|E3'>'E3
|E3 LE E3
|E3 GE E3
|E3 EQ E3
|E3 NE E3
|E3 OR E3
|E3 AND E3
|ID
|NUM
; 

E2 : E3'<'E3
|E3'>'E3
|E3 LE E3
|E3 GE E3
|E3 EQ E3
|E3 NE E3
|E3 OR E3
|E3 AND E3
|ID
|NUM
;
%%

#include "lex.yy.c"

main()
{
	printf("Enter the statement :");
	yyparse();

}
