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
  if (! strcmp(yytext, "result")) return SUPER;
  if (! strcmp(yytext, "new")) return NEWC;
  if (! strcmp(yytext, "return")) return RETURN;
  if (! strcmp(yytext, "object")) return OBJECT;

  yylval.S = strdup(yytext);
  return(ID);
}

int keywordOrIdC() {
  if (! strcmp(yytext, "Integer")) return INTC;
  if (! strcmp(yytext, "String")) return STRINGC;
  if (! strcmp(yytext, "Void")) return VOIDC;

	yylval.S = strdup(yytext);
	return(CLASSNAME);
}


int quelSymbole()
{

  if (! strcmp(yytext, "&")) return ET;

  if (! strcmp(yytext, ":")) return DP;

  if (! strcmp(yytext, ",")) return VIRG;

  if (! strcmp(yytext, ".")) return POINT;

  if (! strcmp(yytext, "\\")) return ANTISL;
  
  return(yytext[0]);

}



void lexError(char c) {
  fprintf(stderr, "Error: Skipping invalid character '%c' on line %d\n",
          c, yylineno);
  setError(LEXICAL_ERROR);
}

%}

%%
{Entier} 	{ yylval.I = atoi(yytext); return(CSTE); }
{Symbole}	{ return quelSymbole(); }
":="		{ return(AFF); }
"="		{ yylval.C = EQ; return(RELOP); }
"<>"		{ yylval.C = NE; return(RELOP); }
"<="		{ yylval.C = INFE; return(RELOP); }
">="		{ yylval.C = SUPE; return(RELOP); }
">"		{ yylval.C = SUP; return(RELOP); }
"<"		{ yylval.C = INF; return(RELOP); }

"/*"({NotStar}|({Star}+{NotStarPar}))*{Star}*"*/"  { }
{Delim}        { }
{Lower}{LC}*   { return keywordOrId(); }
{Upper}{LC}*   { return keywordOrIdC(); }
";"            { return(SEMI); }
{Guill}({BS}|{PasBSG})*{Guill}   {yylval.S = yytext; return STRINGC;}

. 		         { lexError(yytext[0]); }
%%
