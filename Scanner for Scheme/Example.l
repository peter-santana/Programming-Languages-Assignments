
%%

%class schemeAnalyzer
%standalone
%line
%column

program = {form}
form = {definition}|{expression}

NewLine = [\n]

empty = ""


token = {identifier}|{boolean}|{number}|{character}|{string}|"("|\)|"#("|"'"|"`{}"|","|.


delimiter = {whitespace}|"("|\)|\"|";"


endofline = \r|\n|\r\n


whitespace = [\ \n\s\t\f]


comment = ;({token}*|{empty}*)


atmosphere = {whitespace}|{comment}

intertoken_space = {atmosphere}

identifier = {initial}{subsequent}*

initial = {letter}

special_initial ="!"|"$"|%|&|"*"|"/"|:|<|=|>|"?"|"~"|_|"^"



subsequent = {initial}|{digit}


digit = [0-9]


special_subsequent = .|"+"|-

peculiar_identifier = "+"|\-|\.\.\.


syntatic_keyword = {expression_keyword} |"else" |"=>" |"define" |"unquote" |"unquote-splicing" |{list_functions}

keyword = "access" | "and" | "begin" | "bkpt" | "case" | "cond" | "cons-stream" | "declare" | "define" | "delay" | "do" | "lambda" 

expression_keyword = "quote"
	|"lambda"
	|"if"
	|"set!"
	|"begin"
	|"cond"
	|"and"
	|"or"
	|"case"
	|"let"
	|"let*"
	|"letrec"
	|"do"
	|"delay"
	|"quasiquote"
list_functions = "cdr"
	|"car" 
	|"cons"
	|"list?"
	|"empty?"
letter = [a-zA-z_]


datum = {boolean}|{number}|{character}|{string}|{symbol}|{list}|{vector}


boolean = #t | #f


number = {num_2}
	|{num_8}
	|{num_10}
	|{num_16}
character = #\\[a-zA-Z0-9_]| #\\{special_initial}| #"\newline"| #"\space"

string = \" {string_character}* \"

string_character = \"|\\|[a-zA-Z0-9_]|{empty}|{whitespace}
symbol = {identifier}

list = \({datum}*\)|\({datum}+\.{datum}\)|{abbreviation}


abbreviation = \'{datum}
	|\`{datum}
	|\,{datum}
	|\,\@{datum}
vector = \#\({datum}*\)


num_2 = {prefix_2}{complex_2}
complex_2 = {real_2}
	|{real_2}@{real_2}
	|{real_2}"+"{imag_2}
	|{real_2}-{imag_2}
	|"+"{imag_2}
	|-{imag_2}
imag_2 = i
	|{ureal_2}i
real_2 ={sign}?{ureal_2}
ureal_2 = {uinteger_2}
	|{uinteger_2}"/"{uinteger_2}
	|{decimal_10}
uinteger_2 = {digit_2}+#*
prefix_2 = {radix_2}{exactness}
	|{exactness}{radix_2}


num_8 = {prefix_8}{complex_8}
complex_8 = {real_8}
	|{real_8}\@{real_8}
	|{real_8}"+"{imag_8}
	|{real_8}\-{imag_8}
	|"+"{imag_8}
	|\-{imag_8}
imag_8 = i
	|{ureal_8}i
real_8 ={sign}?{ureal_8}
ureal_8 = {uinteger_8}
	|{uinteger_8}"/"{uinteger_8}
	|{decimal_10}
uinteger_8 = {digit_8}+#*
prefix_8 = {radix_8}{exactness}
	|{exactness}{radix_8}

num_10 ={prefix_10}{complex_10}
complex_10 = {real_10}
	|{real_10}\@{real_10}
	|{real_10}"+"{imag_10}
	|{real_10}"-"{imag_10}
	|"+"{imag_10}
	|\-{imag_10}
imag_10 = "i"
	|{ureal_10}"i"
real_10 ={sign}?{ureal_10}
ureal_10 = {uinteger_10}
	|{uinteger_10}"/"{uinteger_10}
	|{decimal_10}
uinteger_10 = {digit_10}+#*
prefix_10 = {radix_10}{exactness}
	|{exactness}{radix_10}

num_16 = {prefix_16}{complex_16}
complex_16 = {real_16}
	|{real_16}\@{real_16}
	|{real_16}"+"{imag_16}
	|{real_16}-{imag_16}
	|"+"{imag_16}
	|\-{imag_16}
imag_16 = "i"|{ureal_16}"i"
real_16 ={sign}?{ureal_16}
ureal_16 = {uinteger_16}
	|{uinteger_16}"/"{uinteger_16}
	|{decimal_10}
uinteger_16 = {digit_16}+#*
prefix_16 = {radix_16}{exactness}
	|{exactness}{radix_16}

decimal_10 = {uinteger_10}{exponent}
	|\.{digit_10}+#*{suffix}
	|{digit_10}+\.{digit_10}*#*{suffix}
	|{digit_10}+#+\.#+{suffix}
suffix = {empty}
	|{exponent}
exponent = {exponent_marker}{sign}{digit_10}+
exponent_marker = "e"
	|"s"
	|"f"
	|"d"
	|"l"
sign = {empty}|"+"|\-
exactness = {empty}|#i|#e
operators = "+"|-|"/"|"<"|"<="|"="|">="|">"|"*"

radix_2 = "#b"
radix_8 = "#o"
radix_10 = {empty}|"#d"
radix_16 = "#x"
digit_2 = [0-1]
digit_8 = [0-7]
digit_10 = {digit}
digit_16 = {digit}|a|b|c|d|e|f

%%
/*-- Tasks --*/

{keyword} {System.out.println("KEYWORD" + ":" + yytext());}

/*--Newlines and Whitespaces--*/
{NewLine} {System.out.print("\n");} /*Aesthetic*/
{whitespace} {}

/*--Parenthesis--*/
"(" {System.out.print("LP ");}
")" {System.out.print("RP ");}
"[" {System.out.print("LP ");}
"]" {System.out.print("RP ");}

/*--Primitives--*/
{string} {System.out.print("STRING ");}
{number} {System.out.print("NUM ");}
{boolean} {System.out.print("BOOL ");}
{character} {System.out.print("CHAR ");}

/*--Operators--*/
{operators} {if(yytext().equals("+")){System.out.print("SUMOP ");} else if(yytext().equals("-")){System.out.print("MINOP ");} else if(yytext().equals("/")){System.out.print("DIVOP ");} else if(yytext().equals("<")){System.out.print("LESSTHAN ");} else if(yytext().equals("<=")){System.out.print("LESSEQUALTHAN ");}else if(yytext().equals("=")){System.out.print("EQUALS ");}else if(yytext().equals(">=")){System.out.print("GREATEREQUALTHAN ");} else if(yytext().equals(">")){System.out.print("GREATERTHAN ");}}

/*--Reserved Words and Functions--*/
{syntatic_keyword} {System.out.print("RESERVED ");}

/*--Comments--*/
{comment} {System.out.print("COMMENT ");}

/*--Identifiers--*/
{identifier} {System.out.print("ID ");}