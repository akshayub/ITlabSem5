%{
    #include<stdio.h>
    #include<string.h>
    void push();
    char* top();
    void a1(char* a);
%}

%token ID

%%

S    : E  { printf("= %s \n",top());}
    ;
E    : E E '+' {a1(" + ");}
    | E E '*' {a1(" * ");}
    | E E '-' {a1(" - ");}
    | E E '/' {a1(" / ");}
    | ID    {push();}
    ;

%%
#include"lex.yy.c"

char st[100][10];
int indx=0;

void push()
{
   strcpy(st[indx++],yytext);
}

char* pop()
{
    return st[--indx];
}

char* top()
{
    return st[indx-1];
}
void a1(char* a)
{
    char buffer[20];
    char* c1=pop();
    char* c2=pop();
    bzero(buffer,20);
    strcat(buffer,c2);
    strcat(buffer,a);
    strcat(buffer,c1);
    strcpy(st[indx++],buffer);
}
main()
{
    yyparse();

}
