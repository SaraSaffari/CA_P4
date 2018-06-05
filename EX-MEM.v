module EX_MEM_pipline(clk, rst, IaluResult, Ir2, Idest, IDMMemWrite, IregWrite, IregWriteDataSel, OaluResult, Or2, Odest, ODMMemWrite, OregWrite, OregWriteDataSel);
	input clk, rst;
	
	input [7:0] IaluResult, Ir2;
	input [2:0] Idest;
	input IDMMemWrite, IregWrite, IregWriteDataSel;

	output [7:0] OaluResult, Or2;
	output [2:0] Odest;	
	output ODMMemWrite, OregWrite, OregWriteDataSel;

	register #(.size(22)) Reg(
		.clock(clk),
		.reset(rst),
		.regIn({IaluResult, Ir2, Idest, IDMMemWrite, IregWrite, IregWriteDataSel}),
		.regOut({OaluResult, Or2, Odest, ODMMemWrite, OregWrite, OregWriteDataSel})
	);
endmodule