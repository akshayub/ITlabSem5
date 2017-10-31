%{
#include<stdio.h>
#include<stdlib.h>
%}
%token SELECT FROM WHERE AND OR ID NOT LE GE NE NUM
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'
%%

S: ST {printf("Input accepted");exit(0);};
ST : SELECT EXP FROM EXP2 WHERE COND';'
 ;
EXP :EXP','EXP
    |ID
    | '*'
    ;

EXP2 : ST
     | ID
     ;

COND : E3 AND COND
      |E3 OR COND
      |NOT E3
      |E3
      ;  
	
E3 : 
      |ID'='NUM
      |ID'>'NUM
      |ID'<'NUM
      |ID LE NUM
      |ID GE NUM
      |ID NE NUM
      ;  
%%


#include"lex.yy.c"

void main(){
printf("Enter input\n");
yyparse();
}
