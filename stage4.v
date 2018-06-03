module stage4(clk, DMMemWrite, DataMemoryAddress, dataMemoryOut, DMdataIn);
	
	input clk, DMMemWrite;
	input [7:0] DataMemoryAddress;
	output [7:0] dataMemoryOut;
	input [7:0] DMdataIn;

	dataMemory DM(
		.clock(clk),
		.memWrite(DMMemWrite), 
		.address(DataMemoryAddress), 
		.data(DMdataIn), 
		.out(dataMemoryOut)
	);

endmodule