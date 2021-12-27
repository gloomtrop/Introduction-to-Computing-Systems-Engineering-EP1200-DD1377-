"""
hvmParser.py -- Parser class for Hack VM translator
"""

from hvmCommands import *

class Parser(object):
    def __init__(self, sourceName, comments=None):
        """
        Open 'sourceFile' and gets ready to parse it.
        """
        self.file = open(sourceName, 'r');
        self.lineNumber = 0
        self.line = ''
        self.rawline = ''
        self.comments = comments

    def Advance(self):
        """
        Reads the next command from the input and makes it the current
        command.
        Returns True if a command was found, False at end of file.
        """
        while True:
            if self.file:
                self.rawline = self.file.readline()
                if len(self.rawline) == 0:
                    return False
                self.rawline = self.rawline.replace('\n', '')
                self.line = self.rawline
                i = self.line.find('//')                
                if i != -1:
                    if self.comments:
                        self.comments.Write('    '+self.line[i:])
                    self.line = self.line[:i]
                self.line = self.line.replace('\t', ' ').strip()
                if len(self.line) == 0:
                    continue
                self._Parse()
                return True
            else:
                return False

    def CommandType(self):
        """
        Returns the type of the current command:
            C_ARITHMETIC = 1
            C_PUSH = 2
            C_POP = 3
            C_LABEL = 4
            C_GOTO = 5
            C_IF = 6
            C_FUNCTION = 7
            C_RETURN = 8
            C_CALL = 9
        """
        return self.commandType
		
    def Arg1(self):
        """
        Returns the command's first argument.
        """
        return self.arg1

    def Arg2(self):
        """
        Returns the command's second argument.
        """
        return self.arg2

    """
    The function to be implemented. 
	For Project 6 the function should parse PUSH/POP and the arithmetic commands.
	Parses the current comment. Assumes that there is a single whitespace between the command and between each argument,
     (there can be up to 2 arguments). 
	Fills in 'commandType', 'arg1' and 'arg2'.
    Some examples:
---------------------------------------------------------------------
|        currentLine	-> desired contents							|
---------------------------------------------------------------------
| "push constant 2"		-> arg1="constant", arg2=2		|
| "call yourfunction 3" -> arg1="yourfunction", arg2=3	|
| "and"					-> arg1="and", arg2=0				|
| "label xyz"			-> arg1="xyz"							|
---------------------------------------------------------------------
    """

    def _Parse(self): #Klar
        self.commandType = None
        self.arg1 = None
        self.arg2 = None
        split_line = self.line.split()
        if split_line[0] in T_ARITHMETIC: #Example: add, sub
            self.commandType = C_ARITHMETIC
            self.arg1 = split_line[0]   
        elif split_line[0] in (T_LABEL, T_GOTO, T_IF): #Example: label xyz 
            if split_line[0] == T_LABEL:
                self.commandType == C_LABEL
            if split_line[0] == T_GOTO:
                self.commandType == C_GOTO
            if split_line[0] == T_IF:
                self.commandType == C_IF
            self.arg1 = split_line[1]
        elif split_line[0] in (T_PUSH, T_POP, T_FUNCTION, T_CALL): #Example: push constant 2
            if split_line[0] == T_PUSH:
                self.commandType = C_PUSH
            if split_line[0] == T_POP:
                self.commandType = C_POP
            if split_line[0] == T_FUNCTION:
                self.commandType = C_FUNCTION
            if split_line[0] == T_CALL:
                self.commandType = C_CALL
            self.arg1 = split_line[1]
            self.arg2 = int(split_line[2])
        else:
            self.commandType == C_RETURN
            
        # command [arg1 [arg2]]
        # self.commandType = None  #this should store the type of the command
        # self.arg1 = None         #this should store the first argument of the command (if there is a first argument)
        # self.arg2 = None         #this should store the second argument of the command (if there is a second argument)

