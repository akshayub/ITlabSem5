%{
    #include <stdio.h>
    #include <string.h>
%}

LOWER [a-z]
UPPER [A-Z]

%%

{LOWER} {
    int ch = yytext[0];
    ch += 5;
    if (ch > 122) {
        ch = 96 + (ch%122);
    }
    printf("%c",ch);
}

{UPPER} {
    int ch = yytext[0];
    ch += 5;
    if (ch > 90) {
        ch = 64 + (ch%90);
    }
    printf("%c",ch);
}

%%

int main() {
    yylex();
}
