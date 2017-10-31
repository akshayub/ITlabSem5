ALPHA [A-Za-z]
DIGIT [0-9]
%%
[\t\n ]
SELECT|select return SELECT;
from|FROM return FROM;
where|WHERE return WHERE;
and|AND return AND;
or|OR return OR;
NOT|not return NOT;
{ALPHA}({ALPHA}|{DIGIT})* return ID;
{DIGIT}+ return NUM;
"<=" return LE;
">=" return GE;
"!=" return NE;

. return yytext[0];
%%
