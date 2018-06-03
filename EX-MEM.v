module EX_MEM_pipline(clk, rst,IaluResult, Ir2, Idest, IDMAddress, OaluResult, Or2, Odest, ODMMemWrite);
	input clk, rst;
	
	input [7:0] IaluResult, Ir2;
	input [2:0] Idest;
	input IDMMemWrite;

	output [7:0] OaluResult, Or2;
	output [2:0] Odest;	
	output ODMMemWrite;

	register #(.size(19)) Reg(
		.clock(clk),
		.reset(rst),
		.regIn({IaluResult, Ir2, Idest, IDMMemWrite}),
		.regOut({OaluResult, Or2, Odest, ODMMemWrite})
	);
endmodule