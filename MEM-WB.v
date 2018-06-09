module MEM_WB_pipeline(clk, rst, enb, IData, IaluResult, Idest, IregWrite, IregWriteDataSel, OData, OaluResult, Odest, OregWrite, OregWriteDataSel);
	input clk, rst;
	
	input [7:0] IData, IaluResult;
	input [2:0] Idest;
	input IregWrite, IregWriteDataSel, enb;

	output [7:0] OData, OaluResult;
	output [2:0] Odest;
	output OregWrite, OregWriteDataSel;

	registerWitEnb #(.size(21)) Reg(
		.clock(clk),
		.reset(rst),
		.enable(enb),
		.regIn({IData, IaluResult, Idest, IregWrite, IregWriteDataSel}),
		.regOut({OData, OaluResult, Odest, OregWrite, OregWriteDataSel })
	);
endmodule