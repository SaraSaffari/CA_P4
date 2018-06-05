module IF_ID_pipline(clk, rst, enb, Iinstruction, Ipc, Oinstruction, Opc);
	input clk, rst, enb;
	input [18:0]Iinstruction;
	input [11:0]Ipc;
	output [18:0] Oinstruction;
	output [11:0] Opc;
	
	registerWitEnb #(.size(31)) Reg(
		.clock(clk),
		.reset(rst),
		.enable(enb),
		.regIn({Ipc, Iinstruction}),
		.regOut({Opc, Oinstruction})
	);
endmodule