module stage1(clk, rst, pcEnb, BrachTaken, PCAdder1Out, BranchAddress, InstMemoryOut);
	input BrachTaken;
	input clk, rst;
	wire [31:0] pcOut;
	wire [31:0] pcIn;
	output [31:0] PCAdder1Out;
	input [31:0] BranchAddress;
	input pcEnb;
	output [31:0] InstMemoryOut;
	
	mux_2_input  #(.WORD_LENGTH (32)) MUX1 (    //pc input max
		.in1(PCAdder1Out), 
		.in2(BranchAddress), 
		.sel(BrachTaken), 
		.out(pcIn)
	);

	registerWitEnb #(.size(32)) pc(
		.clock(clk),
		.reset(rst),
		.enable(pcEnb),
		.regIn(pcIn),
		.regOut(pcOut)
	);

	adder #(.size(32)) pcAdder(
		.inputA(32'd4),
		.inputB(pcOut),
		.result(PCAdder1Out)
	);


	instructionMemory insMemory(
		.clock(clk), 
		.address(pcOut), 
		.instruction(InstMemoryOut)
	);

endmodule