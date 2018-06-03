module IF_ID_pipline(clk, rst, Iinstruction, Ipc, Oinstruction, Opc);
	input clk, rst;
	input [18:0]Iinstruction;
	input [11:0]Ipc;
	output [18:0] Oinstruction;
	output [11:0] Opc;
	
	register #(.size(31)) Reg(
		.clock(clk),
		.reset(rst),
		.regIn({Ipc, Iinstruction}),
		.regOut({Opc, Oinstruction})
	);
endmodule