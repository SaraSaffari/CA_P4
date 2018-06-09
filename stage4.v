module stage4(clk, DMMemWrite, DataMemoryAddress, dataMemoryOut, DMr2Out, DMcalculatedRegData, DataMemoryDataSel);
		
	input clk, DMMemWrite, DataMemoryDataSel;
	input [7:0] DataMemoryAddress;
	output [7:0] dataMemoryOut;
	input [7:0] DMr2Out, DMcalculatedRegData;
	wire [7:0 ]DMdataIn;

	mux_2_input  #(.WORD_LENGTH (8)) DataMemoryDataMux (    //mux 9
		.in1(DMr2Out), 
		.in2(DMcalculatedRegData), 
		.sel(DataMemoryDataSel), 
		.out(DMdataIn)
	);


	dataMemory DM(
		.clock(clk),
		.memWrite(DMMemWrite), 
		.address(DataMemoryAddress), 
		.data(DMdataIn), 
		.out(dataMemoryOut)
	);

endmodule