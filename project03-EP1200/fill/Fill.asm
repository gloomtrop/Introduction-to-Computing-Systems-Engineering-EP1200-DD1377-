// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.	
	
	@i
	M = 0		//Sätter i:s minne till M = 0
(MAIN)
	@24576
	D = M		//Sätter keyboardes värde till register D *
	@BLACK
	D;JGT		//Skickar till BLACK om D > 0
	@WHITE
	D;JEQ		//Skickar till WHITE om D = 0
	@MAIN
	0;JMP		//Hoppar upp i main igen
	
(BLACK)			//GÖR SKÄRMEN SVART
	
	@i		
	D = M		//Sätter i:s minne till register D
	@SCREEN
	A = A + D	//Sätter skärmens adress till dess adress + i:s M
	M = -1		//Sätter skärmens minne till -1
	@24576
	D = M		//Sätter keyboardens minne till D
	@MAIN		
	D;JLE		//Skickar till MAIN om värdet på keyboarden är <= 0
	@i
	M = M +1	//Ökar värdet på ink. med 1
	@BLACK
	0;JMP		//Hoppar upp till BLACK igen

(WHITE)			//GÖR SKÄRMEN VIT
	@i
	D = M
	@SCREEN
	A = A + D	//Adderar på i:s värde på skärmens adress 16384
	M = 0		//Sätter skärmens värdet till 0
	@SCREEN
	D = M		
	@MAIN
	D;JEQ		//Skickar till MAIN om skärmens adressvärde (16384) = 0
	@i
	M = M - 1	//Sätter i:s värde -1 av M
	@WHITE
	0;JMP




//Not*:BUG IN CPU - SIMULATOR!!!
//This gives me an error message in the FillAutomatic script when ran
//ANSWE:"There is, however, a bug in the simulator that when you write to the KEYBOARD //address, it affects what will be read the next time from KEYBOARD."
//Source: http://nand2tetris-questions-and-answers-forum.32033.n3.nabble.com/Fill-//asm-screen-flickering-td4029947.html#a4029948
	