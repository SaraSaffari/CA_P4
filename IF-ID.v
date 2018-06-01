module IF_ID_pipline(clk, rst, Ipc, Iinstruction, Oinstruction, Opc);
	input clk, rst;
	input [11:0]Ipc;
	input [18:0]Iinstruction;
	input [11:0]Opc;
	input [18:0]Oinstruction;
	
	register #(.size(12)) pcReg(
		.clock(clk),
		.reset(rst),
		.regIn(Ipc),
		.regOut(Opc)
	);

	register #(.size(19)) IR(
		.clock(clk),
		.reset(rst),
		.regIn(Iinstruction),
		.regOut(Oinstruction)
	);
endmodule