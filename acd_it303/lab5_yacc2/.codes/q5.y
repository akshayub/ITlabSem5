%{
#include<stdio.h>
#include<stdlib.h>
%}

%token ID IF THEN SWITCH CASE WHILE BREAK DEFAULT NUM LE GE EQ NE AND OR
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'

%%
S : ST{printf("Input accepted");exit(0);};
ST : SWITCH'('ID')''{'B'}';
B : C
  |C D
  ;
C : C C
  |CASE NUM':'ST1 BREAK';'
  ;
D : DEFAULT':'ST1 BREAK';'
  | DEFAULT':'ST1
  ;

ST1 : WHILE'('E2')'E';'
     |IF'('E2')'THEN E';'
     |ST1 ST1
     |E';'
     ;

E2 : E'<'E
    |E'>'E
    |E LE E
    |E GE E
    |E NE E
    |E EQ E
    |E AND E
    |E OR E
    ;	

E : ID'='E
|E'+'E
|E'-'E
|E'*'E
|E'/'E
|E'<'E
|E'>'E
|E LE E
|E GE E
|E EQ E
|E NE E
|E OR E
|E AND E
|ID
|NUM
; 
%%
#include"lex.yy.c"

void main(){
printf("Enter input\n");
yyparse();
}
