//Python Parser Deliverable 3
//CS 4450 Principls of Programming Launguages
//Joseph Coryell (jck36)

grammar PythonParser3;


//A program is a series of statments followed by the end of file
// using newlines as statment terminators, fix later
program: (statement NEWLINE*)* EOF;

//statments are assigments, conditionals, or if statements
statement: assign | array_assign | if_statement | while_statement | for_statement;

// a statment block is a series of statments, will need to change this to work with indentation later
//newlines bad, fix later
statement_block
    : statement (NEWLINE+ statement)* NEWLINE*  //this gaurantees atlest one statment in the block, and allows for multiple newlines between statments
    ;                                           //dont change unless really needed


assign: VARID '='  expression
      | VARID '+=' expression
      | VARID '-=' expression
      | VARID '*=' expression
      | VARID '/=' expression
      ;
array_assign: VARID '=' '[' (expression (',' expression)*)? ']';

//epressions are actully layered stuctures
//following order of operations
expression
    : logic
    ;

logic
    : comparison ((AND | OR) comparison)*
    ;

comparison
    : addition (('<' | '<=' | '>' | '>=' | '==' | '!=') addition)*
    ;

addition 
    : multiplication (('+' | '-') multiplication)*
    ;

multiplication
    : exponentiation (('*' | '/' | '%' | '//') exponentiation)*
    ;

exponentiation
    : NOT exponentiation                 //this should go in logic, but it doesnt work there
    | term ('**' exponentiation)?
    ;

// catch all to prevent left recursion in expressions
term
    : NUMBER
    | BOOLEAN
    | STRING
    | VARID
    | '(' expression ')'
    ;

// an if can be followed by one or more elifs and an else
// newlines to separate statments from blocks, bad, fix later
if_statement
    : IF expression ':' (NEWLINE+ statement_block | statement)
      (elif_statement)* (else_statement)?
    ;

elif_statement
    : ELIF expression ':' NEWLINE statement_block
    ;

else_statement
    : ELSE ':' NEWLINE statement_block
    ;
while_statement
    : WHILE expression ':' (NEWLINE+ statement_block | statement)
    ;
for_statement
    : FOR VARID IN (VARID | range) ':' (NEWLINE+ statement_block | statement)
    ;
range
    : 'range' '(' expression (',' expression)* ')'
    ;

//keywords, to prevent weird VARID matching
IF: 'if';
ELIF: 'elif';
ELSE: 'else';
WHILE: 'while';
FOR: 'for';
IN: 'in';
AND: 'and';
OR: 'or';
NOT: 'not';


// data types

//matching to python variable naming rules (starts with letter , _ followed by letters, numbers, _)
VARID: [a-zA-Z_][a-zA-Z_0-9]*;

//numbers, including negatives and decimals (works for .5 and 5. )
NUMBER: '-'? ( [0-9] + ('.'[0-9]*)?| '.'[0-9]+ );

BOOLEAN: 'True' | 'False';

STRING: '"' (~["\r\n])* '"' 
      | '\'' (~['\r\n])* '\'';

WHITESPACE: [ \t]+ -> skip; //change to handle tabs later

NEWLINE: ('\r'? '\n'); //newline used to mark end of statments, for indentations later
COMMENT: '#' ~[\r\n]* -> skip;
MULTILINE_COMMENT
    :   '\'' '\'' '\'' .*? '\'' '\'' '\''
        -> skip
    ;


