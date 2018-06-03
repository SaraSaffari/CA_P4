module forwardingUnit(Ex_Mem_dest, Ex_Mem_regWrite, Id_Ex_r1Address, Id_Ex_r2Address, Mem_Wb_regWrite, Mem_Wb_dest, aluInputAForwardingSel, aluInputBForwardingSel);
	
	input [2:0] Ex_Mem_dest, Mem_Wb_dest, Id_Ex_r1Address, Id_Ex_r2Address;
	input Ex_Mem_regWrite, Mem_Wb_regWrite;
	output reg aluInputAForwardingSel, aluInputBForwardingSel;

	always @(*) begin
		aluInputBForwardingSel = 2'b00;
		aluInputAForwardingSel = 2'b00;

		if (Ex_Mem_regWrite == 1  && Ex_Mem_dest == Id_Ex_r1Address)  aluInputAForwardingSel = 2'b01;	
		if (Ex_Mem_regWrite == 1  && Ex_Mem_dest == Id_Ex_r2Address)  aluInputBForwardingSel = 2'b01;	
		
		if (Mem_Wb_regWrite == 1  && Mem_Wb_dest == Id_Ex_r1Address  &&
			(Ex_Mem_regWrite == 0 || Ex_Mem_dest != Id_Ex_r1Address))  aluInputAForwardingSel = 2'b10;
		
		if (Mem_Wb_regWrite == 1  && Mem_Wb_dest == Id_Ex_r2Address  &&
			(Ex_Mem_regWrite == 0 || Ex_Mem_dest != Id_Ex_r2Address))  aluInputBForwardingSel = 2'b10;

	end
	



endmodule