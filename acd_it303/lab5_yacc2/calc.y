%{
    #include<stdio.h>
    #include <alloca.h>
    #include <math.h>
    #include <stdlib.h>
    #include <stddef.h>
    #include <ctype.h>
    #include <string.h>
    #define YYSTYPE double

    float factorial(int n) {
        int c;
        float result = 1;

        for (c = 1; c <= n; c++)
            result = result * c;
        return result;
    }

    long int bin_dec(long int num) {
        long int rem,sum=0,power=0;
        while(num>0) {
            rem = num%10;
            num = num/10;
            sum = sum + rem * pow(2,power);
            power++;
        }
        return sum;
    }
%}

%token NUMBER MOD PIVAL
%token PLUS MINUS DIV MUL POW SQRT OB CB UNARYMINUS
%token ASIN ACOS ATAN SIN SINH COS COSH TAN TANH ASSIGN CEIL FLOOR ABS FACTORIAL BIN_DEC
%left PLUS MINUS MUL DIV UNARYMINUS LOG

%%

S	: S ST1 '\n'	{ printf("%g\n", $2); }
	| S '\n'
	|
	;
ST1 : pow
    ;
pow : add
    | pow POW add { $$ = pow($1,$3); }
	| SQRT OB ST1 CB { $$ = sqrt($3) ; }
    ;
add : mul
    | add PLUS mul  { $$ = $1 + $3;}
    | add MINUS mul { $$ = $1 - $3; }
    ;
mul : unary
    | mul MUL unary { $$ = $1 * $3; }
    | mul DIV unary { $$ = $1 / $3; }
    | mul MOD unary { $$ = fmod($1,$3); }
    ;
unary   : primary
        | MINUS primary %prec UNARYMINUS { $$ = -$2; }
        | LOG unary { $$ = log($2); }
        ;
primary : PIVAL { $$ = M_PI; }
        | OB ST1 CB { $$ = $2; }
        | fn
        ;
fn      : SIN OB ST1 CB { $$ = sin($3); }
        | COS OB ST1 CB { $$ = cos($3); }
	    | SINH OB ST1 CB { $$ = sinh($3); }
        | ASIN OB ST1 CB { $$ = asin($3); }
        | ACOS OB ST1 CB { $$ = acos($3); }
        | ATAN OB ST1 CB { $$ = atan($3);}
        | TAN OB ST1 CB { $$ = tan($3);}
        | COSH OB ST1 CB { $$ = cosh($3);}
        | TANH OB ST1 CB { $$ = tanh($3);}
	    | CEIL OB ST1 CB { $$ = ceil($3);}
	    | FLOOR OB ST1 CB { $$ = floor($3);}
	    | ABS OB ST1 CB { $$ = abs($3);}
	    | FACTORIAL OB ST1 CB { $$ = factorial((int)$3);}
	    | BIN_DEC OB ST1 CB { $$ = bin_dec((float)$3);}
	    | NUMBER
        ;

%%

#include <stdio.h>
#include <ctype.h>
#include "lex.yy.c"

int main() {
    yyparse();
}
