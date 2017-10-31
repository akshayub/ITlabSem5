number [0-9]+(\.[0-9]+)?
word [a-zA-Z_][_a-zA-Z0-9]*

%%
[ \t\n]
{number}      return NUM;
{word}        return ID;
.           return yytext[0];
%%