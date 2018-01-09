/* attention: NEW est defini dans tp.h Utilisez un autre nom de token */
%token IS CLASS VAR EXTENDS DEF OVERRIDE IF THEN ELSE AFF 
%token OBJECT NEWC RETURN INTC STRINGC VOIDC
%token<S> ID CLASSNAME SUPER THIS RESULT
%token<I> CSTE
%token<C> RELOP

%left ADD SUB
%left MULT DIV


%{
#include "tp.h"
#include "tp_y.h"

extern int yylex();
extern void yyerror(char *);
%}

%%
Prog : classLOpt block
;

classLOpt:
;

block:
;
