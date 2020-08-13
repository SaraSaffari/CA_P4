module IF_ID_pipline(clk, rst, enb, Iinstruction, IpcAdderOut, Oinstruction, OpcAdderOut);
	input clk, rst, enb;
	input [31:0]Iinstruction;
	input [31:0]IpcAdderOut;
	output [31:0] Oinstruction;
	output [31:0] OpcAdderOut;
	
	registerWitEnb #(.size(64)) Reg(
		.clock(clk),
		.reset(rst),
		.enable(enb),
		.regIn({IpcAdderOut, Iinstruction}),
		.regOut({OpcAdderOut, Oinstruction})
	);
endmodule