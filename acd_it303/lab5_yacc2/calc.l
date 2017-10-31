number [0-9]+\.?|[0-9]*\.[0-9]+
%%
[ \t]   { ; }
log     return LOG;
factorial return FACTORIAL;
bin_dec   return BIN_DEC;
pi      return PIVAL;
sin     return SIN;
cos     return COS;
tan     return TAN;
sinh    return SINH;
cosh    return COSH;
tanh    return TANH;
asin    return ASIN;
acos    return ACOS;
atan    return ATAN;
ceil    return CEIL;
floor   return FLOOR;
abs     return ABS;
{number}	{ yylval=atof(yytext);return NUMBER; }
"+"     return PLUS;
"-"     return MINUS;
"~"     return UNARYMINUS;
"/"     return DIV;
"*"     return MUL;
"^"     return POW;
sqrt    return SQRT;
"("     return OB;
")"     return CB;
"%"     return MOD;
"="     return ASSIGN;
\n|.    return yytext[0];
%%