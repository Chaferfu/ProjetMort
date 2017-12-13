/* attention: NEW est defini dans tp.h Utilisez un autre nom de token */
%token IS CLASS VAR EXTENDS DEF OVERRIDE IF THEN ELSE AFF
%token<S> Id
%token<I> Cste
%token<C> RelOp


%{
#include "tp.h"
#include "tp_y.h"

extern int yylex();
extern void yyerror(char *);
%}

%%
Prog : classLOpt block
;

classTete: CLASS CLASSNAME { /*TODO*/; }
;

paramLOpt: LParam {/*TODO*/; }
|				  {/*TODO*/; }
;

LParam: Param ',' LParam {/*TODO*/; }
| Param            	     {/*TODO*/; }
;

Param: ID ':' CLASSNAME  {/*TODO*/; }
;


DeclChampLOpt: LDeclChamp {/*TODO*/; }
| 			{/*TODO*/; }
;

LDeclChamp: DeclChamp ';' LDeclChamp {/*TODO*/; }
| DeclChamp {/*TODO*/; }
;

DeclChamp: VAR ID ':' TypeC AffOpt ';' {/*TODO*/; }
;

TypeC: INTC {/*TODO*/; }    //INTC STRINGC ET VOIDC peuvent êtres traités dans CLASSNAME en les mettant dans le même environnement (qui sera rentré à la main à la compilation)
| STRINGC {/*TODO*/; }
| VOIDC {/*TODO*/; }
| CLASSNAME {/*TODO*/; }
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

DeclMethode : OverrideOpt DEF ID '(' paramLOpt ')' ':' TypeC AFF Expr {/*TODO*/; }
| OverrideOpt DEF ID '(' paramLOpt ')' TypeCOpt IS /*TODO Bloc*/ {/*TODO*/; }
;

TypeCOpt: ':' TypeC {/*TODO*/; }
| {/*TODO*/; }
;

OverrideOpt: OVERRIDE {/*TODO*/; }
|     				  {/*TODO*/; }
;

Class: classTete '(' paramLOpt ')' ExtendsOpt /*TODO BlocOpt*/ IS '{' DeclChampLOpt DeclMethodeLOpt '}'
									{ /*TODO*/ ;}
;

ExtendsOpt: EXTENDS {/*TODO*/; }
|					{/*TODO*/; }
;


classLOpt: Class classLOpt {/*TODO : à trouver */;}
| 	{$$ = NIL(Class)}
;

BlocLOpt: LBloc {/*TODO*/; }
| 				{/*TODO*/; }
;

LBloc: Bloc LBloc {/*TODO*/; }
| 			      {/*TODO*/; }
;

Expr: ID {/*TODO*/; }
| Cste {/*TODO*/; }
| '(' Expr ')' {/*TODO*/; }
| '(' CLASSNAME Expr ')' 		//Correspond à un Cast
| Selection   /*TODO*/
| NEW CLASSNAME '(' ExprLOpt ')' {/*TODO*/; }   //Correspond à une Instanciation
| Envoi {/*TODO*/; }
| ExprOperateur {/*TODO*/; }
;

ExprLOpt: LExpr {/*TODO*/; }
| 				{/*TODO*/; }
;

LExpr: Expr LExpr {/*TODO*/; }
| Expr 			  {/*TODO*/; }
;

ExprOperateur: Expr '+' Expr {/*TODO*/; }
| Expr '-' Expr {/*TODO*/; }
| Expr '*' Expr {/*TODO*/; }
| Expr '/' Expr {/*TODO*/; }
| '-' Expr {/*TODO*/; }
| '+' Expr {/*TODO*/; }             /*Voir syntaxe pour unaire*/
| Expr '&' Expr {/*TODO*/; }
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

Linstr: Instr LInstr {/*TODO*/; }
| Instr 			 {/*TODO*/; }
;

Bloc: '{' Contenu '}' {/*TODO*/; }
;

Contenu: InstrLOpt {/*TODO*/; }
| LDeclChamp IS LInstr {/*TODO*/; }
;

Envoi: Expr '.' MethodeC {/*TODO*/; }
;

MethodeC: ID '(' ExprLOpt ')'
;

Selection: Expr '.' ID {/*TODO*/; }
| ID 				   {/*TODO*/; }
| THIS 				   {/*TODO*/; }
| SUPER				   {/*TODO*/; }
| RESULT 			   {/*TODO*/; } //RESULT peut être traité dans ID en le mettant dans le même environnement (qui sera rentré à la main à la compilation)
;




