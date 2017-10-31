%{

#include<math.h>
extern yylval; 
%}
ALPHA [A-Za-z]
DIGIT [0-9]
%%

{DIGIT}+ {yylval=atoi(yytext);return NUM;}
[\n] {return 0;}
. return yytext[0];
%%
