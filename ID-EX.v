module ID_EX_pipline(clk, rst, Ir1, Ir2, Iconst_disp, Isc, Idest,IaluFunction, IAluInputBSel, IDMMemWrite, IregWrite, IregWriteDataSel, IZenb, ICenb, Or1, Or2, Oconst_dOsp, Osc, Odest, OaluFunction, OAluInputBSel, ODMMemWrite, OregWrite, OregWriteDataSel, OZenb, OCenb);
	input clk, rst;

	input [7:0]Ir2, Ir1, Iconst_disp;
	input [2:0]Isc, Idest;
	input [3:0] IaluFunction;
	input IAluInputBSel, IDMMemWrite, IregWrite, IregWriteDataSel;
	input IZenb, ICenb;
	output [7:0]Or2, Or1, Oconst_dOsp;
	output [2:0]Osc, Odest;
	output [3:0] OaluFunction;
	output OAluInputBSel, ODMMemWrite, OregWrite, OregWriteDataSel;
	output OZenb, OCenb;

	register #(.size(40)) Reg(
		.clock(clk),
		.reset(rst),
		.regIn({Ir1, Ir2, Iconst_disp, Isc, Idest, IaluFunction, IAluInputBSel, IDMMemWrite, IregWrite, IregWriteDataSel, ICenb, IZenb}),
		.regOut({Or1, Or2, Oconst_dOsp, Osc, Odest, OaluFunction, OAluInputBSel, ODMMemWrite, OregWrite, OregWriteDataSel, OCenb, OZenb})
	);

endmodule