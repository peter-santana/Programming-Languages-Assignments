__author__ = 'PETER SANTANA'
'''
LEXER

This is the lexer component for the CICOM language. 
'''
import ply.lex as lex
from ply.lex import TOKEN


# Base tokens
tokens = [
    'CHARACTERS',
    'DELIMITERS',
    'OPERATORS',
    'DIGITS'
]
# Reserved words or variables
reserved = {
    'if': 'IF',
    'then': 'THEN',
    'else': 'ELSE',
    'let': 'LET',
    'in': 'IN',
    'map': "MAP",
    'to': 'TO',
    'true': 'TRUE',
    'false': 'FALSE',
    'number?': 'ISNUM',
    'function?': 'ISFUNCTION',
    'list?': 'ISLIST',
    'empty?': 'ISEMPTY',
    'empty': 'EMPTY',
    'cons?': 'ISCONS',
    'cons': 'CONS',
    'first': 'FIRST',
    'rest': 'REST',
    'arity': 'ARITY'
}
# Tokens to be assigned in runtime
unrelatedTokens = [
    'ASSIGN',
    'GREATEROREQUAL',
    'NOTEQUAL',
    'LESSOREQUAL',
    'DUALOPERATORS',
    'MINUS',
    'LBRACKET',
    'RPAREN',
    'LPAREN',
    'RBRACKET',
    'COMMA',
    'SEMCOLON',
    'RESERVED'
]
# Operators and their token values
operator_2 = {'+': 'SUM',
              '~': 'NEGATION',
              '*': 'MULT',
              '/': 'DIV',
              '=': 'EQUALS',
              '<': 'LESSTHAN',
              '>': 'GREATERTHAN',
              '&': 'AND',
              '|': 'OR'}




tokens += list(reserved.values()) + unrelatedTokens + list(operator_2.values())




t_ignore = ' \t'



def t_RESERVED(t):
    r'if | then | else | let | in | map | to | true | false | number\? | function\? | list\? | empty\? | empty | cons\? | cons | first | rest | arity'
    if t.value in reserved:
        t.type = reserved[t.value]
    return t

t_CHARACTERS = r'[A-Za-z\_\?]'
t_DIGITS = r'[0-9]'


def t_DELIMITERS(t):
    r'\( | \) | \[ | \] | \, | \;'
    if t.value == '(':
        t.type = 'LPAREN'
    elif t.value == ')':
        t.type = 'RPAREN'
    elif t.value == '[':
        t.type = 'LBRACKET'
    elif t.value == ']':
        t.type = 'RBRACKET'
    elif t.value == ',':
        t.type = 'COMMA'
    elif t.value == ';':
        t.type = 'SEMCOLON'
    return t


def t_DUALOPERATORS(t):
    r'\<\= | \>\= | \:\= | \!\= '
    if t.value == '>=':
        t.type = 'GREATEROREQUAL'
    elif t.value == ':=':
        t.type = 'ASSIGN'
    elif t.value == '!=':
        t.type = 'NOTEQUAL'
    elif t.value == '<=':
        t.type = 'LESSOREQUAL'
    return t


def t_OPERATORS(t):
    r'\+ | \- | \~ | \* | \/ | \= | \< | \> | \& | \| '
    if t.value == '-':
        t.type = 'MINUS'
    if t.value in operator_2:
        t.type = operator_2[t.value]
    return t


def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)


lexer = lex.lex()
