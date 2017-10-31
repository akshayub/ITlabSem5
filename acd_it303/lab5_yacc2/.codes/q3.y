%{
#include<stdio.h>
#include<stdlib.h>

%}

%token NUM 
%right '='
%left '+' '-'
%left '*' '/'
%right UMINUS
%%

S: ST {printf("Expression accepted %d",$$);exit(0);};
ST : ST '+' ST{$$=$1+$3;}
     |ST '-' ST{$$=$1-$3;}
     |ST '*' ST{$$=$1*$3;}
     |ST '/' ST
{
if($3==0)
yyerror("error");
else
$$=$1/$3;}
|'('ST')'{$$=$2;}
|NUM {$$=$1;}
;

%%

#include "lex.yy.c"

void main()
{
	printf("Enter the statement :");
	yyparse();
}
yywrap(){}
yyerror(char* s)
{
printf("Error\n");
} 
