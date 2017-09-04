lower [a-z]
upper [A-Z]
space [ \t\n]

%%

{lower} {printf("%c",yytext[0]- 32);}
{upper} {printf("%c",yytext[0]+ 32);}
{space} ECHO;
. ECHO;

%%

int main()
{
    yylex();
}

