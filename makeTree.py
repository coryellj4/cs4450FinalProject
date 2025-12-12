from antlr4 import *
from PythonParser3Lexer import PythonParser3Lexer
from PythonParser3Parser import PythonParser3Parser
from antlr4.tree.Trees import Trees


input_stream = FileStream("project_deliverable_3.py")

lexer = PythonParser3Lexer(input_stream)
stream = CommonTokenStream(lexer)
parser = PythonParser3Parser(stream)


tree = parser.program()


print(Trees.toStringTree(tree, None, parser))
