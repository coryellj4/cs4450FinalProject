//Python Parser Deliverable 1
//CS 4450 Principls of Programming Launguages
//Joseph Coryell (jck36)

grammar PythonParser1;


//A program is a series of statments followed by the end of file
program: statement* EOF;

//all statments are assignments for now
statement: assign | array_assign ;

assign: VARID '='  expression
      | VARID '+=' expression
      | VARID '-=' expression
      | VARID '*=' expression
      | VARID '/=' expression
      ;

array_assign: VARID '=' '[' (expression (',' expression)*)? ']';

// catch all to prevent left recursion in expressions
term: NUMBER
    | BOOLEAN
    | STRING
    | VARID;


expression: term ('+' | '-' | '*' | '/' | '%'| '//'|  '**') term
          | term ('+' | '-' | '*' | '/' | '%' | '//' | '**') expression
          | '(' term ')'
          | term
          ;

// data types

//matching to python variable naming rules (starts with letter , _ followed by letters, numbers, _)
VARID: [a-zA-Z_][a-zA-Z_0-9]*;

//numbers, including negatives and decimals (works for .5 and 5. )
NUMBER: '-'? ( [0-9] + ('.'[0-9]*)?| '.'[0-9]+ );

BOOLEAN: 'True' | 'False';

STRING: '"' .*? '"' 
        | '\'' .*? '\'';

WHITESPACE: [ \t\r\n]+ -> skip; //change to handle tabs later

