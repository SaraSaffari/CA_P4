module stage1(clk, rst, jmp, pcOut);
	input jmp;
	input clk, rst;
	output [11:0] pcOut;
	
	mux_2_input  #(.WORD_LENGTH (12)) pcAdderInputAmux (
		.in1(12'd4), 
		.in2(offset), 
		.sel(jmp), 
		.out(pcAdderInputA)
	);


	adder #(.size(12)) pcAdder(
		.inputA(pcAdderInputA),
		.inputB(pcOut),
		.result(pcIn)
	);

	register #(.size(12)) pc(
		.clock(clk),
		.reset(rst),
		.regIn(pcIn),
		.regOut(pcOut)
	);

	instructionMemory insMemory(
		.clock(clk), 
		.address(pcOut), 
		.instruction(instruction)
	);
endmodule