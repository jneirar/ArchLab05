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
	
	reg [31:0] RAM [63:0];
	reg [31:0] i;
	reg [31:0] contSTR;

	controller ctrl(
		.clk(clk),
		.reset(reset),
		.Instr(Instr),
		.ALUFlags(ALUFlags),
		.PCWrite(PCWrite),
		.MemWrite(MemWrite),
		.RegWrite(RegWrite),
		.IRWrite(IRWrite),
		.AdrSrc(AdrSrc),
		.RegSrc(RegSrc),
		.ALUSrcA(ALUSrcA),
		.ALUSrcB(ALUSrcB),
		.ResultSrc(ResultSrc),
		.ImmSrc(ImmSrc),
		.ALUControl(ALUControl)
	);
	
	always begin
		clk <= 1;
		#(1);
		clk <= 0;
		#(1);
	end

	initial begin
		reset <= 1;
		Instr <= 20'hE04F0;
		#20
		reset <= 0;
		#8
		Instr <= 20'hE2801;
		#8
		Instr <= 20'hE2412;
		#8
		Instr <= 20'hE0013;
		#8
		Instr <= 20'hE1834;
		#8
		Instr <= 20'hE0813;
		#8
		Instr <= 20'hE2034;
		#8
		Instr <= 20'hE3843;
		#8
		Instr <= 20'hE0511;
		#8
		Instr <= 20'h0A000;
		#8
		Instr <= 20'hE1821;
		#8
		Instr <= 20'hE2811;
		#8
		Instr <= 20'hE5812;
		#8
		Instr <= 20'hE2825;
		#8
		Instr <= 20'hE5953;
		#8
		Instr <= 20'hE0522;
		#8
		Instr <= 20'hBAFFF;
		#8
		Instr <= 20'hEA000;
		#8
		Instr <= 20'hE0021;
		#8
		Instr <= 20'hE5804;
		$display("Simulation succeeded");
		#20;
		$finish;
	end

    initial begin
        $dumpfile("controller.vcd");
        $dumpvars;
    end
endmodule