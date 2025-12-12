from antlr4 import *
from PythonParser3Lexer import PythonParser3Lexer
from PythonParser3Parser import PythonParser3Parser
from antlr4.tree.Trees import Trees
import sys

if len(sys.argv) < 2:
    print("Usage: python maketree.py <filename>")
    sys.exit(1)

filename = sys.argv[1]

input_stream = FileStream(filename)


lexer = PythonParser3Lexer(input_stream)
stream = CommonTokenStream(lexer)
parser = PythonParser3Parser(stream)

tree = parser.program()

print(Trees.toStringTree(tree, None, parser))
