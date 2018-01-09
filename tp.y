/* attention: NEW est defini dans tp.h Utilisez un autre nom de token */
%token IS CLASS VAR EXTENDS DEF OVERRIDE IF THEN ELSE AFF 
%token OBJECT NEWC RETURN INTC STRINGC VOIDC ADD SUB MULT DIV CONCAT
%token<S> Id Classname SUPER THIS RESULT
%token<I> Cste
%token<C> RelOp

%right AFF
%nonassoc RelOp
%left ADD SUB CONCAT
%left MULT DIV
%right '.'
%nonassoc UNARY

%type <pT> 	TypeC ExtendsOpt BlocOpt AffOpt MethodeC
			TypeCOpt Expr ExprLOpt LExpr
			ExprOperateur Instr InstrLOpt 
			LInstr Bloc 
			Envoi Selection
%type <pC> 	Class classTete classLOpt
%type <pM> 	DeclMethodeLOpt LDeclMethode DeclMethode
%type <pV> 	DeclChampLOpt LDeclChamp DeclChamp Param paramLOpt
			LParam
%type <I> 	OverrideOpt

%{
#include "tp.h"
#include "tp_y.h"

extern int yylex();
extern void yyerror(char *);
%}

%%
Prog : classLOpt Bloc
;

classTete: CLASS Classname { $$ = makeClass($2); }
;

classLOpt: Class classLOpt {/*TODO : à trouver */;}
| 	{$$ = NIL(Class)}
;

Class: classTete '(' paramLOpt ')' ExtendsOpt BlocOpt IS '{' DeclChampLOpt DeclMethodeLOpt '}'
									{ /*TODO*/ ;}
;

paramLOpt: LParam {	$$ = $1; }
|				  { $$ = NIL(VarDecl); }
;

LParam: Param ',' LParam { $1->nextParam = $3; $$=$1; }
| Param            	     { $$ = $1; }
;

Param: Id ':' Classname  {/*TODO*/; }
;


DeclChampLOpt: LDeclChamp {/*TODO*/; }
| 			{/*TODO*/; }
;

LDeclChamp: DeclChamp ';' LDeclChamp {/*TODO*/; }
| DeclChamp {/*TODO*/; }
;

DeclChamp: VAR Id ':' TypeC AffOpt ';' {/*TODO*/; }
;

TypeC: INTC {/*TODO*/; }    //INTC STRINGC ET VOIDC peuvent êtres traités dans Classname en les mettant dans le même environnement (qui sera rentré à la main à la compilation)
| STRINGC {/*TODO*/; }
| VOIDC {/*TODO*/; }
| Classname {/*TODO*/; }
;

AffOpt: AFF Expr {/*TODO*/; }
|
;

DeclMethodeLOpt: LDeclMethode {/*TODO*/; }
|  				{/*TODO*/; }
;

LDeclMethode: DeclMethode ';' LDeclMethode {/*TODO*/; }
| DeclMethode {/*TODO*/; }
;

DeclMethode : OverrideOpt DEF Id '(' paramLOpt ')' ':' TypeC AFF Expr {/*TODO*/; }
| OverrideOpt DEF Id '(' paramLOpt ')' TypeCOpt IS /*TODO Bloc*/ {/*TODO*/; }
;

TypeCOpt: ':' TypeC {/*TODO*/; }
| {/*TODO*/; }
;

OverrideOpt: OVERRIDE {/*TODO*/; }
|     				  {/*TODO*/; }
;

ExtendsOpt: EXTENDS {/*TODO*/; }
|					{/*TODO*/; }
;

BlocLOpt: LBloc {/*TODO*/; }
| 				{/*TODO*/; }
;

LBloc: Bloc LBloc {/*TODO*/; }
| 			      {/*TODO*/; }
;

Expr: Id {/*TODO*/; }
| Cste {/*TODO*/; }
| '(' Expr ')' {/*TODO*/; }
| '(' Classname Expr ')' 		//Correspond à un Cast
| Selection   /*TODO*/
| NEWC Classname '(' ExprLOpt ')' {/*TODO*/; }   //Correspond à une Instanciation
| Envoi {/*TODO*/; }
| ExprOperateur {/*TODO*/; }
;

ExprLOpt: LExpr {/*TODO*/; }
| 				{/*TODO*/; }
;

LExpr: Expr LExpr {/*TODO*/; }
| Expr 			  {/*TODO*/; }
;

ExprOperateur: Expr ADD Expr {/*TODO*/; }
| Expr SUB Expr {/*TODO*/; }
| Expr MULT Expr {/*TODO*/; }
| Expr DIV Expr {/*TODO*/; }
| SUB Expr {/*TODO*/; }
| ADD Expr {/*TODO*/; }             /*Voir syntaxe pour unaire*/
| Expr CONCAT Expr {/*TODO*/; }
| Expr RelOp Expr
:

Instr : Expr ';' {/*TODO*/; }
| Bloc  {/*TODO*/; }
| RETURN ';' {/*TODO*/; }
| Selection AFF Expr ';' {/*TODO*/; }
| IF Expr THEN Instr ELSE Instr {/*TODO*/; }
;


InstrLOpt: LInstr {/*TODO*/; }
| 							{/*TODO*/; }
;

LInstr: Instr LInstr {/*TODO*/; }
| Instr 			 {/*TODO*/; }
;

Bloc: '{' InstrLOpt '}' {/*TODO*/; }
| '{' LDeclChamp IS LInstr '}' {/*TODO*/; }
;

BlocOpt: Bloc {/*TODO*/; }
|
;

Envoi: Expr '.' MethodeC {/*TODO*/; }
;

MethodeC: Id '(' ExprLOpt ')'
;

Selection: Expr '.' Id {/*TODO*/; }
| Id 				   {/*TODO*/; }
| THIS 				   {/*TODO*/; }
| SUPER				   {/*TODO*/; }
| RESULT 			   {/*TODO*/; } //RESULT peut être traité dans Id en le mettant dans le même environnement (qui sera rentré à la main à la compilation)
;
