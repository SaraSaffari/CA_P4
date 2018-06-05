module ID_EX_pipline(clk, rst, enb, Ir1, Ir2, Iconst_disp, Isc, Idest,IaluFunction, IAluInputBSel, IDMMemWrite, IregWrite, IregWriteDataSel, IZenb, ICenb, Ir1Address, Ir2Address, Or1, Or2, Oconst_dOsp, Osc, Odest, OaluFunction, OAluInputBSel, ODMMemWrite, OregWrite, OregWriteDataSel, OZenb, OCenb, Or1Address, Or2Address);
	input clk, rst;

	input [7:0]Ir2, Ir1, Iconst_disp;
	input [2:0]Isc, Idest;
	input [3:0] IaluFunction;
	input IAluInputBSel, IDMMemWrite, IregWrite, IregWriteDataSel;
	input IZenb, ICenb, enb;
	input [2:0] Ir1Address, Ir2Address;
	output [7:0]Or2, Or1, Oconst_dOsp;
	output [2:0]Osc, Odest;
	output [3:0] OaluFunction;
	output OAluInputBSel, ODMMemWrite, OregWrite, OregWriteDataSel;
	output OZenb, OCenb;
	input [2:0] Or1Address, Or2Address;

	registerWitEnb #(.size(46)) Reg(
		.clock(clk),
		.reset(rst),
		.enable(enb),
		.regIn({Ir1, Ir2, Iconst_disp, Isc, Idest, IaluFunction, IAluInputBSel, IDMMemWrite, IregWrite, IregWriteDataSel, ICenb, IZenb, Ir1Address, Ir2Address}),
		.regOut({Or1, Or2, Oconst_dOsp, Osc, Odest, OaluFunction, OAluInputBSel, ODMMemWrite, OregWrite, OregWriteDataSel, OCenb, OZenb, Or1Address, Or2Address})
	);

endmodule