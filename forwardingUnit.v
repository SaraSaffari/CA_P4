module forwardingUnit(Ex_Mem_dest, Ex_Mem_regWrite,Ex_Mem_regWriteDataSel, Id_Ex_r1Address, Id_Ex_r2Address, Mem_Wb_regWrite, Mem_Wb_dest, aluInputAForwardingSel, aluInputBForwardingSel, stall);
	
	input [2:0] Ex_Mem_dest, Mem_Wb_dest, Id_Ex_r1Address, Id_Ex_r2Address;
	input Ex_Mem_regWrite, Mem_Wb_regWrite, Ex_Mem_regWriteDataSel;
	output reg [1:0] aluInputAForwardingSel, aluInputBForwardingSel;
	output reg stall;

	always @(*) begin
		aluInputBForwardingSel = 2'b00;
		aluInputAForwardingSel <= 2'b00;
		stall = 1'b0;


		if ( (Ex_Mem_regWrite == 1'b1)  && (Ex_Mem_dest == Id_Ex_r1Address ) )   aluInputAForwardingSel <= 2'b01;	
		if (Ex_Mem_regWrite == 1'b1  && Ex_Mem_dest == Id_Ex_r2Address)  aluInputBForwardingSel = 2'b01;	
		
		if (Mem_Wb_regWrite == 1'b1  && Mem_Wb_dest == Id_Ex_r1Address  &&
			(Ex_Mem_regWrite == 1'b0 || Ex_Mem_dest != Id_Ex_r1Address))  aluInputAForwardingSel = 2'b10;
		
		if (Mem_Wb_regWrite == 1'b1  && Mem_Wb_dest == Id_Ex_r2Address  &&
			(Ex_Mem_regWrite == 1'b0 || Ex_Mem_dest != Id_Ex_r2Address))  aluInputBForwardingSel = 2'b10;

		if(Ex_Mem_regWrite == 1'b1 && Ex_Mem_regWriteDataSel == 1'b0 &&
			(Ex_Mem_dest == Id_Ex_r1Address || Ex_Mem_dest == Id_Ex_r2Address)) stall = 1'b1;


		
	end
	



endmodule