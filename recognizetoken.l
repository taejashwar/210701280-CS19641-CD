%option noyywrap

%{
#include <stdio.h>
int n = 0;
%}

letter [a-zA-Z]
digit [0-9]
id [_a-zA-Z]
AO [+|\-|/|%|*]
RO  [<|>|<=|>=|==]
pp [#]

%%
"void"          { printf("%s return type\n", yytext); }
{letter}*[(][)] { printf("%s Function\n", yytext); }
"int"|"float"|"if"|"else"  { printf("%s keywords\n", yytext); }
"printf"        { printf("%s keywords\n", yytext); }
{id}({id}|{digit})* { printf("%s Identifier\n", yytext); }
{digit}{digit}* { printf("%s Numbers\n", yytext); }
{AO}            { printf("%s Arithmetic Operators\n", yytext); }
{RO}            { printf("%s Relational Operators\n", yytext); }
{pp}{letter}*[<]{letter}*[.]{letter}[>] { printf("%s processor Directive\n", yytext); }
[\n]            { n++; }
"."|","|"}"|"{"|";" { printf("%s others\n", yytext); }
.               { /* ignore anything else */ }

%%

int main() {
    FILE *file = fopen("sample.c", "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();
    printf("No of Lines %d\n", n);
    fclose(file);
    return 0;
}
