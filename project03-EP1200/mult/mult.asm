// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// Kör en loop där R0 plussas ihop R1 gånger 
// vilket blir summan R2=R0*R1 tillslut
// Villkor: Kör loopen tills D = 0, där D0 = R1


	@i
	M = 1	//Sätter ett minne till 1 för att kolla först 
	@sum	
	M = 0 	//Summan (produkten) sätts till 0
	@R1
	D = M
	@END
	D;JEQ		//Skickar till slutet om faktor är 0
	@diff
	M = D	
	@R0
	D = M
	@END
	D;JEQ		//Skickar till slutet om faktor är 0
	@diff
	M = M - D	//Räknar differensen mellan R1 och R0
	D = M
	@RONE		//Skickar till R_One om R1> R0
	D;JGE		
	@RZERO		//Skickar till R_Zero om R0 < R1
	D;JLT
	

(RONE)		//Sätter R1 som värdet man adderar R0[M] gånger
	@R1
	D = M
	@first
	M = D
	@R0
	D = M
	@counter
	M = D
	@LOOP
	0;JMP
	
(RZERO)		//Sätter R0 som värdet man adderar R1[M] gånger
	@R0
	D = M
	@first
	M = D
	@R1
	D = M
	@counter
	M = D
	@LOOP
	0;JMP
	
	
(LOOP)			//Adderar antingen R0, R1[M] gånger (R0>=R1)
			// eller R1, R0[M] gånger ( R0<R1)
	@i
	D = M		//Sätter register D till värdet från minnet i:s adress
	@counter 
	D = D - M	// i-R
	@END
	D;JGT 		//Om (i-R) > 0 goto END
	@first
	D = M		
	@sum
	M = D + M	//Adderar på R till summan här
	@i
	M = M + 1	//Inkrementerar i:s värde i minnet med 1	
	@LOOP		
	0;JMP		//Hoppar tillbaka till början av loopen


(END)			//Slut på loop
	@sum		
	D= M
	@R2		//Sparar värdet från summan (produkten)
	M = D		// i minnet på R2
	@END
	0;JMP
	
		