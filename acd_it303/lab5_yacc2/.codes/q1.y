%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define YYSTYPE double
%}

%token NUM SIN COS TAN POW EXP LOG LOG10 SINH COSH TANH 
%right '='
%left '+' '-'
%left '*' '/'
%right UMINUS
%%
S: ST {printf("Expression accepted %f",$$);exit(0);};
ST : ST '+' ST{$$=$1+$3;}
     |ST '-' ST{$$=$1-$3;}
     |ST '*' ST{$$=$1*$3;}
     |ST '/' ST
{
if($3==0)
yyerror("error");
else
$$=$1*1.0/$3;}
|SIN'(' ST ')'{$$ = sin($3*3.141/180);}
|COS'(' ST ')'{$$ = cos($3*3.141/180);}
|TAN'(' ST ')'{$$ = tan($3*3.141/180);}
|POW'(' ST ',' ST ')'{$$ = pow($3,$5);}
|LOG'(' ST ')'{$$ = log($3);}
|LOG10'(' ST ')'{$$ = log10($3);}
|EXP'(' ST ')'{$$ = exp($3);}
|SINH'(' ST ')'{$$ = sinh($3);}
|COSH'(' ST ')'{$$ = cosh($3);}
|TANH'(' ST ')'{$$ = tanh($3);}
|'('ST')'{$$=$2;}
|NUM {$$=$1;}
;


%%

#include"lex.yy.c"

void main(){
printf("Enter input\n");
yyparse();
}
yywrap(){}
yyerror(char* s)
{
printf("Error\n");
} 
