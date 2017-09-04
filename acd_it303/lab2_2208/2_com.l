%{
    int count=0;
%}

%%

.*com\n {count++;ECHO;}
. ;

%%

int main()
{
    yylex();
    printf("Count= %d\n",count);
    return 0;

}
