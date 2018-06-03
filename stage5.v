module stage5(aluResult, dataMemoryOut, registerFileWriteData, registerFileWriteDataSel);

	input [7:0] aluResult, dataMemoryOut;
	input registerFileWriteDataSel;
	output [7:0] registerFileWriteData;

	mux_2_input  #(.WORD_LENGTH (8)) aluBInputMux (    //mux 4
		.in1(dataMemoryOut),
		.in2(aluResult),
		.sel(registerFileWriteDataSel),
		.out(registerFileWriteData)
	);


endmodule