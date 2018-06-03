module MEM_WB_pipeline(clk, rst, IData, IaluResult, Idest, IregWrite, IregWriteDataSel, OData, OaluResult, Odest, OregWrite, OregWriteDataSel);
	input clk, rst;
	
	input [7:0] IData, IaluResult;
	input [2:0] Idest;
	input IregWrite, IregWriteDataSel;

	output [7:0] OData, OaluResult;
	output [2:0] Odest;
	output OregWrite, OregWriteDataSel;

	register #(.size(21)) Reg(
		.clock(clk),
		.reset(rst),
		.regIn({IData, IaluResult, Idest, IregWrite, IregWriteDataSel}),
		.regOut({OData, OaluResult, Odest, OregWrite, OregWriteDataSel })
	);
endmodule