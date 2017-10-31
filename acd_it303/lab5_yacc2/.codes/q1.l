%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h> 
%}

%%
[\t\n ]

tanh return TANH;
cosh return COSH;
sinh return SINH;
sin return SIN;
cos return COS;
tan return TAN;
pow return POW;
exp return EXP;
log return LOG;
log10 return LOG10;
[0-9]+.[0-9]+ {yylval =atof(yytext);return NUM;}
[0-9]+ {yylval =atof(yytext);return NUM;}
. return yytext[0];
%%
