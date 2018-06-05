module stage1(clk, rst, pcEnb, pcAdderInputASel, pcOut, disp, pcInputSel, stackOutput, jumpAdr, instruction);
	input pcAdderInputASel;
	input clk, rst;
	output [11:0] pcOut;
	wire [11:0] pcIn;
	input [11:0] disp;
	input [1:0] pcInputSel;
	input [11:0] stackOutput;
	input [11:0] jumpAdr;
	input pcEnb;
	output [18:0] instruction;
	wire [11:0] pcAdderResult, pcAdderInputA;
	mux_2_input  #(.WORD_LENGTH (12)) pcAdderInputAmux (    //mux 1
		.in1(disp), 
		.in2(12'd1), 
		.sel(pcAdderInputASel), 
		.out(pcAdderInputA)
	);

	adder #(.size(12)) pcAdder(
		.inputA(pcAdderInputA),
		.inputB(pcOut),
		.result(pcAdderResult)
	);

	mux_3_input #(.WORD_LENGTH(12)) pcInputMux (     // mux 2
		.in1(pcAdderResult), 
		.in2(stackOutput), 
		.in3(jumpAdr), 
		.sel(pcInputSel), 
		.out(pcIn)
	);

	registerWitEnb #(.size(12)) pc(
		.clock(clk),
		.reset(rst),
		.enable(pcEnb),
		.regIn(pcIn),
		.regOut(pcOut)
	);

	instructionMemory insMemory(
		.clock(clk), 
		.address(pcOut), 
		.instruction(instruction)
	);

endmodule