`timescale 1ns/1ns

module controller_tb;
	reg clk;
	reg reset;
	reg [31:12] Instr;
	reg [3:0] ALUFlags;
	wire PCWrite;
	wire MemWrite;
	wire RegWrite;
	wire IRWrite;
	wire AdrSrc;
	wire [1:0] RegSrc;
	wire [1:0] ALUSrcA;
	wire [1:0] ALUSrcB;
	wire [1:0] ResultSrc;
	wire [1:0] ImmSrc;
	wire [1:0] ALUControl;

	controller ctrl(
		clk,
		reset,
		Instr,
		ALUFlags,
		PCWrite,
		MemWrite,
		RegWrite,
		IRWrite,
		AdrSrc,
		RegSrc,
		ALUSrcA,
		ALUSrcB,
		ResultSrc,
		ImmSrc,
		ALUControl
		);
	
	always begin
		clk <= 1;
		#(1);
		clk <= 0;
		#(1);
	end

	
	initial begin
		reset <= 1;
		ALUFlags <=4'b0000;
		Instr <= 20'hE0800; //ADD R0, R15, R15
		#10
		reset <= 0;
		#8
		Instr <= 20'hE2803; //ADD R3, R0, #12
		#8
		Instr <= 20'hE0434; //SUB R4, R3, R3 
		#8
		Instr <= 20'hE2437; //SUB R7, R3, #9 
		#8
		Instr <= 20'hE0034; //AND R4, R3, R3
		#8
		Instr <= 20'hE2005; //AND R5, R0, #6
		#8
		Instr <= 20'hE1856; //ORR R6, R5, R7 
		#8
		Instr <= 20'hE3875; //ORR R5, R7, #10
		#8
		Instr <= 20'hE5845; //STR R5, [R4, #84] 
		#8
		Instr <= 20'hE5948; //LDR R8, [R4, #84]
		#10
		Instr <= 20'h0AFFF; //BEQ MAIN (not taken)
		#6
		Instr <= 20'hEAFFF; //B END
		#6
		Instr <= 20'hE1834; //ORR R4, R3, R3 
		#8
		$finish;
	end
	
    initial begin
        $dumpfile("out.vcd");
        $dumpvars;
    end
endmodule