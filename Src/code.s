.global _start
_start:
MAIN: SUB R0, R15, R15		//R0 = R15 + R15      	E04F0 00F
	SUB R2, R1, #4			//R2 = R1 - 4	      	E2412 004
	ADD R3, R1, R4			//R3 = R1 + R4        	E0813 004
	ADD R1, R0, #25			//R1 = R0 + 25        	E2801 019
	ORR R4, R3, R1			//R4 = R3 | R1        	E1834 001
	ORR R3, R4, #9			//R3 = R4 | 9         	E3843 009	
	ANDS R3, R1, R2			//R3 = R1 & R2        	E0113 002	
	BEQ NEXT				//Taken, flags:0100		0A000 000
	STR R2, [R1, #4]		//mem[R1+4] = R2      	E5812 004
NEXT: BLT MAIN				//Not taken			    BAFFF FF5
	B END					//No flags           	EA000 000
	LDR R3, [R5]			//R3 = mem[R5]        	E5953 000
END: AND R4, R3, #20		//R4 = R3 & 20        	E2034 014