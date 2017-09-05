%{
    #include <stdio.h>
    #include <stdlib.h>
    int simple = 1;
%}

KEYWORDS ([Aa]nd)|([Oo]r)|([Bb]ut)|([Ss]o)|([Ff]or)|([Nn]or)|([Yy]et)

%%

[ \t]{KEYWORDS}[ \t] {
    simple = 0;
}

. {
    ;
}

%%

int main(int argc, char* argv[]) {
    yylex();
    if (simple) {
        printf("The statement is simple.\n");
    }
    else {
        printf("The statement is complex.\n");
    }
}
