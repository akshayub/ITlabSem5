var [A-Za-z_][A-Za-z0-9_]*
number [0-9]+(\.[0-9]+)?

%%
[ \t\n]
if          return IF;
{var}       return ID;
{number}    return NUM;
"<="        return LE;
">="        return GE;
"=="        return EQ;
"!="        return NE;
.           return yytext[0];
%%