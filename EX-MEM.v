module EX_MEM_pipline(clk, rst,enb, IaluResult, Ir2, Idest, IDMMemWrite, IregWrite, IregWriteDataSel, IR2Address, OaluResult, Or2, Odest, ODMMemWrite, OregWrite, OregWriteDataSel, OR2Address);
	input clk, rst;
	
	input [7:0] IaluResult, Ir2;
	input [2:0] Idest, IR2Address;
	input IDMMemWrite, IregWrite, IregWriteDataSel, enb;

	output [7:0] OaluResult, Or2;
	output [2:0] Odest, OR2Address;	
	output ODMMemWrite, OregWrite, OregWriteDataSel;

	registerWitEnb #(.size(25)) Reg(
		.clock(clk),
		.reset(rst),
		.enable(enb),
		.regIn({IaluResult, Ir2, Idest, IDMMemWrite, IregWrite, IregWriteDataSel, IR2Address}),
		.regOut({OaluResult, Or2, Odest, ODMMemWrite, OregWrite, OregWriteDataSel, OR2Address})
	);
endmodule