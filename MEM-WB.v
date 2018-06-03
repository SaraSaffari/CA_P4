module MEM_WB_pipeline(clk, rst, IData, IaluResult, Idest, OData, OaluResult, Odest);
	input clk, rst;
	
	input [7:0] IData, IaluResult;
	input [2:0] Idest;

	output [7:0] OData, OaluResult;
	output [2:0] Odest;

	register #(.size(19)) Reg(
		.clock(clk),
		.reset(rst),
		.regIn({IData, IaluResult, Idest}),
		.regOut({OData, OaluResult, Odest})
	);
endmodule