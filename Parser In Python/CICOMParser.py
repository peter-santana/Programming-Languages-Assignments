__author__ = 'Peter L Santana'

#Parser


import ply.yacc as parser
import CICOMLexer

tokens = CICOMLexer.tokens


def p_Exp(p):
    '''Exp : Term
            | Term Binop Exp
            | IF Exp THEN Exp  ELSE Exp
            | LET Def IN Exp
            | MAP IdList TO Exp '''


def p_Term(p):
    '''Term : Unop Term
            | Factor
            | Factor LPAREN ExpList RPAREN
            | Empty
            | Int
            | Bool '''


def p_Factor(p):
    '''Factor : LPAREN Exp RPAREN
              | Prim
              | Id '''


def p_ExpList(p):
    ''' ExpList :
                | PropExpList  '''


def p_PropExpList(p):
    ''' PropExpList : Exp
                    | Exp COMMA PropExpList '''


def p_IdList(p):
    ''' IdList :
                | PropIdList '''


def p_PropIdList(p):
    ''' PropIdList : Id
                    | Id  COMMA PropIdList '''


def p_Def(p):
    ''' Def : Id ASSIGN Exp SEMCOLON Def
            | Id ASSIGN Exp SEMCOLON
            '''


def p_Empty(p):
    ''' Empty : EMPTY '''


def p_Bool(p):
    ''' Bool : TRUE
            | FALSE '''


def p_Unop(p):
    ''' Unop : Sign
            | NEGATION '''


def p_Sign(p):
    ''' Sign : SUM
            | MINUS '''


def p_Binop(p):
    ''' Binop : Sign
            | MULT
            | DIV
            | GREATEROREQUAL
            | LESSOREQUAL
            | EQUALS
            | NOTEQUAL
            | LESSTHAN
            | GREATERTHAN
            | AND
            | OR
            | ASSIGN '''


def p_Prim(p):
    '''Prim : ISNUM
            | ISFUNCTION
            | ISLIST
            | ISEMPTY
            | ISCONS
            | CONS
            | FIRST
            | REST
            | ARITY '''


def p_Id(p):
    '''Id : CHARACTERS
            | Id CHARACTERS
            | Id DIGITS
          '''


def p_Int(p):
    ''' Int : DIGITS
            | Int DIGITS'''


def p_error(p):
    print("Syntax error in input!")


# Parser object
parser = parser.yacc()
