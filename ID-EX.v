module ID_EX_pipline(clk, rst, Ir1, Ir2, Iconst_disp, Isc, Idest,IaluFunction, IAluInputBSel, IDMMemWrite, Or1, Or2, Oconst_dOsp, Osc, Odest, OaluFunction, OAluInputBSel, DDMMemWrite);
	input clk, rst;

	input [7:0]Ir2, Ir1, Iconst_disp;
	input [2:0]Isc, Idest, IaluFunction;
	input IAluInputBSel, IDMMemWrite;

	output [7:0]Or2, Or1, Oconst_dOsp;
	output [2:0]Osc, Odest, OaluFunction;
	output OAluInputBSel, ODMMemWrite;

	register #(.size(34)) Reg(
		.clock(clk),
		.reset(rst),
		.regIn({Ir1, Ir2, Iconst_disp, Isc, Idest, IaluFunction, IAluInputBSel, IDMMemWrite}),
		.regOut({Or1, Or2, Oconst_dOsp, Osc, Odest, OaluFunction, OAluInputBSel, ODMMemWrite})
	);

endmodule