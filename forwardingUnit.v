module forwardingUnit(Ex_Mem_dest, Ex_Mem_regWrite,Id_Ex_regWriteDataSel,
			Id_Ex_regWrite, Id_Ex_Dest, Id_Ex_r1Address,
         Id_Ex_r2Address, Mem_Wb_regWrite, Mem_Wb_dest, aluInputAForwardingSel,
         aluInputBForwardingSel, stage2_out_r1Address, stage2_out_r2Address, stall, 
         DataMemoryDataSel,Ex_Mem_r2Address, aluInputBMuxSel, clk);                       
	
	input aluInputBMuxSel;
	input [2:0] Ex_Mem_dest, Mem_Wb_dest, Id_Ex_r1Address, Id_Ex_r2Address, Id_Ex_Dest;
	input [2:0] stage2_out_r1Address, stage2_out_r2Address, Ex_Mem_r2Address;
	input Ex_Mem_regWrite, Mem_Wb_regWrite, Id_Ex_regWriteDataSel, Id_Ex_regWrite;
	output reg [1:0] aluInputAForwardingSel, aluInputBForwardingSel;
	output reg DataMemoryDataSel;

	output reg stall;
	// wire previousStall;
	input clk;
	//TODO: you should put this register far from eyes!!!
	// register #(.size(1)) C(
	// 	.clock(clk),
	// 	.reset(1'b0),
	// 	.regIn(stall),
	// 	.regOut(previousStall)
	// );
	always @(*) begin
		aluInputBForwardingSel = 2'b00;
		aluInputAForwardingSel <= 2'b00;
		stall = 1'b0;
		DataMemoryDataSel = 1'b0;


		if ( (Ex_Mem_regWrite == 1'b1)  && (Ex_Mem_dest == Id_Ex_r1Address ) )   aluInputAForwardingSel <= 2'b01;	
		if (Ex_Mem_regWrite == 1'b1  && Ex_Mem_dest == Id_Ex_r2Address && aluInputBMuxSel == 1'b0)  aluInputBForwardingSel = 2'b01;	
		
		if (Mem_Wb_regWrite == 1'b1  && Mem_Wb_dest == Id_Ex_r1Address  &&
			(Ex_Mem_regWrite == 1'b0 || Ex_Mem_dest != Id_Ex_r1Address))  aluInputAForwardingSel = 2'b10;
		
		if (Mem_Wb_regWrite == 1'b1  && Mem_Wb_dest == Id_Ex_r2Address  &&
			(Ex_Mem_regWrite == 1'b0 || Ex_Mem_dest != Id_Ex_r2Address || aluInputBMuxSel != 1'b0 ))  aluInputBForwardingSel = 2'b10;

		if(Mem_Wb_dest == Ex_Mem_r2Address) DataMemoryDataSel = 1'b1;
		if(Id_Ex_regWrite == 1'b1 && Id_Ex_regWriteDataSel == 1'b0 &&
			(Id_Ex_Dest == stage2_out_r1Address || Id_Ex_Dest == stage2_out_r2Address	))
			begin stall = 1'b1; /*aluInputBForwardingSel = 2'd2;*/ end


		
	end
	



endmodule