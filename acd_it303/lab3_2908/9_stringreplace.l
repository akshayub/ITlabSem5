%{
    #include <stdio.h>
    #include <string.h>
    char old[100], new[100];
%}

WORD [a-zA-Z]+

%%

{WORD} {
    if (strcmp(yytext, old) == 0) {
        printf("%s",new);
    }
    else {
        printf("%s",yytext);
    }
}

%%

int main(int argc, char* argv[]) {

    printf("Enter the string to find: ");
    scanf("%[^\t\n]s",old);
    getchar();
    printf("Enter the string to replace with: ");
    scanf("%[^\t\n]s",new);
    yylex();
}
