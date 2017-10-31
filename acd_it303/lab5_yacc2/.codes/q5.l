ALPHA [a-zA-Z]
DIGIT [0-9]

%%
[ \n\t]
if return IF;
then return THEN;
switch return SWITCH;
while return WHILE;
case return CASE;
break return BREAK;
default return DEFAULT;
{DIGIT}+ return NUM;
{ALPHA}({ALPHA}|{DIGIT})* return ID;
"<=" return LE;
">=" return GE;
"==" return EQ;
"!=" return NE;
"&&" return AND;
"||" return OR;
. return yytext[0];
%%
