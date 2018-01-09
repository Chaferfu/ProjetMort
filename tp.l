Chiffre [0-9]
Entier {Chiffre}+
Lower	[a-z]
Upper	[A-Z]
Lettre	[a-zA-Z]
LC 	({Lettre}|{Chiffre})
Delim   [ \b\t\n\r]
Symbole [&+\-*/():,.{}]
BS      \\.
PasBSG [^\\"]
Guill		"\""
Star  		"*"
NotStar		[^*]
NotStarPar      [^*/]

%{
#include <string.h>
#include <strings.h>
#include "tp.h"
#include "tp_y.h"

extern char *strdup(char *);
extern YYSTYPE yylval;
extern int yylineno;
extern int yylex();

int keywordOrId() { 
  if (! strcmp(yytext, "is")) return IS;
  if (! strcmp(yytext, "class")) return CLASS;
  if (! strcmp(yytext, "var")) return VAR;
  if (! strcmp(yytext, "extends")) return EXTENDS;
  if (! strcmp(yytext, "def")) return DEF;
  if (! strcmp(yytext, "super")) return SUPER;
  if (! strcmp(yytext, "override")) return OVERRIDE;
  if (! strcmp(yytext, "if")) return IF;
  if (! strcmp(yytext, "then")) return THEN;
  if (! strcmp(yytext, "else")) return ELSE;
  if (! strcmp(yytext, "this")) return THIS;
  if (! strcmp(yytext, "super")) return SUPER;
  if (! strcmp(yytext, "result")) return RESULT;
  if (! strcmp(yytext, "new")) return NEWC;
  if (! strcmp(yytext, "return")) return RETURN;
  if (! strcmp(yytext, "object")) return OBJECT;

  yylval.S = strdup(yytext);
  return(Id);
}


int keywordOrIdC() {
  if (! strcmp(yytext, "Integer")) return INTC;
  if (! strcmp(yytext, "String")) return STRINGC;
  if (! strcmp(yytext, "Void")) return VOIDC;

	yylval.S = strdup(yytext);
	return(Classname);
}

int quelSymbole()
{

  if (! strcmp(yytext, "&")) return CONCAT;

  if (! strcmp(yytext, ":")) return DP;

  if (! strcmp(yytext, ",")) return VIRG;

  if (! strcmp(yytext, ".")) return POINT;

  if (! strcmp(yytext, "\\")) return ANTISL;

  if (! strcmp(yytext, "+")) return ADD;

  if (! strcmp(yytext, "-")) return SUB;

  if (! strcmp(yytext, "*")) return MULT;

  if (! strcmp(yytext, "/")) return DIV;
  
  return(yytext[0]);
}



void lexError(char c) {
  fprintf(stderr, "Error: Skipping invalid character '%c' on line %d\n",
          c, yylineno);
  setError(LEXICAL_ERROR);
}

%}

%%
{Entier} 	{ yylval.I = atoi(yytext); return(Cste); }
{Symbole}	{ return quelSymbole(); }
":="		{ return(AFF); }
"="		{ yylval.C = EQ; return(RelOp); }
"<>"		{ yylval.C = NE; return(RelOp); }
"<="		{ yylval.C = INFE; return(RelOp); }
">="		{ yylval.C = SUPE; return(RelOp); }
">"		{ yylval.C = SUP; return(RelOp); }
"<"		{ yylval.C = INF; return(RelOp); }

"/*"({NotStar}|({Star}+{NotStarPar}))*{Star}*"*/"  { }
{Delim}        { }
{Lower}{LC}*   { return keywordOrId(); }
{Upper}{LC}*   { return keywordOrIdC(); }
";"            { return(SEMI); }
{Guill}({BS}|{PasBSG})*{Guill}   {yylval.S = yytext; return STRINGC;}

. 		         { lexError(yytext[0]); }
%%
