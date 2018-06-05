module stage3(clk, rst, r1, r2, disp_const, aluBInputSel, ZOutput, COutput, shiftCount,
		ALUOperation, ALUOUT, ZEn, CEn, aluInputAForwardingSel, aluInputBForwardingSel,
		Ex_Mem_aluResult, Mem_Wb_aluResult);
	input clk, rst;
	input [7:0] r1, r2, disp_const;
	input [3:0] ALUOperation;
	input aluBInputSel;
	input [1:0] aluInputAForwardingSel, aluInputBForwardingSel;
	input [7:0] Ex_Mem_aluResult, Mem_Wb_aluResult;
	wire ZInput, CInput;
	output ZOutput, COutput;
	input [2:0] shiftCount;
	output [7:0] ALUOUT;
	input ZEn, CEn;
	wire [7:0] A, B, aluInputA, aluInputB;
	assign A = r1;

	mux_3_input #(.WORD_LENGTH(8)) aluInputAForwardingMux (     // mux 6
		.in1(A), 
		.in2(Ex_Mem_aluResult), 
		.in3(Mem_Wb_aluResult), 
		.sel(aluInputAForwardingSel), 
		.out(aluInputA)
	);

	mux_3_input #(.WORD_LENGTH(8)) aluInputBForwardingMux (     // mux 7
		.in1(B), 
		.in2(Ex_Mem_aluResult), 
		.in3(Mem_Wb_aluResult), 
		.sel(aluInputBForwardingSel), 
		.out(aluInputB)
	);

	mux_2_input  #(.WORD_LENGTH (8)) aluBInputMux (    //mux 3
		.in1(r2), 
		.in2(disp_const), 
		.sel(aluBInputSel), 
		.out(B)
	);

	ALU alu(
		.inputA(aluInputA),
		.inputB(B),
		.carryIn(COutput),
		.operation(ALUOperation),
		.result(ALUOUT),
		.carryOut(CInput),
		.zero(ZInput),
		.shiftCount(shiftCount)
	);	


	registerWitEnb #(.size(1)) C(
		.clock(clk),
		.reset(rst),
		.enable(CEn),
		.regIn(CInput),
		.regOut(COutput)
	);

	registerWitEnb #(.size(1)) Z(
		.clock(clk),
		.reset(rst),
		.enable(ZEn),
		.regIn(ZInput),
		.regOut(ZOutput)
	);
endmodule