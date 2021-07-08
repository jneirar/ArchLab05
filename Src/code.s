.global _start
_start:
MAIN: SUB R0, R15, R15		//R0 = 8 - 8 = 0      E04F000F
	ADD R1, R0, #25			//R1 = 0 + 19 = 19    E2801019
	SUB R2, R1, #4			//R2 = 19 - 4 = 15    E2412004
	AND R3, R1, R2			//R3 = 19 & 15 = 11   E0013002
	ORR R4, R3, R1			//R4 = 11 | 19 = 19   E1834001
	ADD R3, R1, R4			//R3 = 19 + 19 = 32   E0813004
	AND R4, R3, #20			//R4 = 32 & 14 = 10   E2034014
	ORR R3, R4, #9			//R3 = 10 | 9 = 19    E3843009
	SUBS R1, R1, R3			//R1 = R1 - R3, flags E0511003
	BEQ NEXT				//should be taken     0A000000
	ORR R1, R2, R3			//shouldn't happen    E1821003
NEXT: ADD R1, R1, #0x100	//R1 = 100            E2811C01
	STR R2, [R1, #4]		//mem[104] = 15       E5812004
	ADD R5, R2, #239		//R5 = 104            E28250EF
	LDR R3, [R5]			//R3 = mem[100]       E5953000
	SUBS R2, R2, R3			//R2 = R2 - R3, flag  E0522003
	BLT MAIN				//shouldn't be taken  BAFFFFEE
	B END					//always taken        EA000000
	AND R1, R2, R3			//shouldn't happen    E0021003
END: STR R4, [R0, #100]		//mem[100] = 10       E5804064
