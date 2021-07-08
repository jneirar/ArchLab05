module mainfsm (
	clk,
	reset,
	Op,
	Funct,
	IRWrite,
	AdrSrc,
	ALUSrcA,
	ALUSrcB,
	ResultSrc,
	NextPC,
	RegW,
	MemW,
	Branch,
	ALUOp
);

	input wire clk;
	input wire reset;
	input wire [1:0] Op;
	input wire [5:0] Funct;
	output wire IRWrite;
	output wire AdrSrc;
	output wire [1:0] ALUSrcA;
	output wire [1:0] ALUSrcB;
	output wire [1:0] ResultSrc;
	output wire NextPC;
	output wire RegW;
	output wire MemW;
	output wire Branch;
	output wire ALUOp;
	reg [3:0] state;
	reg [3:0] nextstate;
	reg [12:0] controls;
	localparam [3:0] FETCH = 0;
	localparam [3:0] DECODE = 1;
	localparam [3:0] MEMADR = 2;
	localparam [3:0] MEMREAD = 3;
	localparam [3:0] MEMWB = 4;
	localparam [3:0] MEMWRITE = 5;	
	localparam [3:0] EXECUTER = 6;
	localparam [3:0] EXECUTEI = 7;
	localparam [3:0] ALUWB = 8;
	localparam [3:0] BRANCH = 9;
	localparam [3:0] UNKNOWN = 10;

	// state register
	always @(posedge clk or posedge reset)
		if (reset)
			state <= FETCH;
		else
			state <= nextstate;
	

	// ADD CODE BELOW
  	// Finish entering the next state logic below.  We've completed the 
  	// first two states, FETCH and DECODE, for you.

  	// next state logic
	always @(*)
		casex (state)
			FETCH: nextstate = DECODE;
			DECODE:
				case (Op)
					2'b00:
						if (Funct[5])
							nextstate = EXECUTEI;
						else
							nextstate = EXECUTER;
					2'b01: nextstate = MEMADR;
					2'b10: nextstate = BRANCH;
					default: nextstate = UNKNOWN;
				endcase
			MEMADR:
				case (Funct[0])
					1'b0: nextstate = MEMWRITE;
					1'b1: nextstate = MEMREAD;
					default: nextstate = UNKNOWN;
				endcase
			MEMREAD: nextstate = MEMWB;
			MEMWB: nextstate = FETCH;
			MEMWRITE: nextstate = FETCH;
			EXECUTER: nextstate = ALUWB;
			EXECUTEI: nextstate = ALUWB;
			ALUWB: nextstate = FETCH;
			BRANCH: nextstate = FETCH;
			default: nextstate = FETCH;
		endcase

	// ADD CODE BELOW
	// Finish entering the output logic below.  We've entered the
	// output logic for the first two states, FETCH and DECODE, for you.

	// state-dependent output logic
	always @(*)
		case (state)
			FETCH: controls 	= 13'b1000101001100;
			DECODE: controls 	= 13'b0000001001100;
			EXECUTER: controls 	= 13'b0000001000001;
			EXECUTEI: controls 	= 13'b0000001000011;
			ALUWB: controls 	= 13'b0001000000011;
			MEMADR: controls 	= 13'b0000001000010;
			MEMREAD: controls 	= 13'b0000010000010;
			MEMWRITE: controls 	= 13'b0010010000010;
			MEMWB: controls 	= 13'b0001010100010;
			BRANCH: controls 	= 13'b0100001010010;
			default: controls 	= 13'bxxxxxxxxxxxxx;
		endcase
	assign {NextPC, Branch, MemW, RegW, IRWrite, AdrSrc, ResultSrc, ALUSrcA, ALUSrcB, ALUOp} = controls;
endmodule