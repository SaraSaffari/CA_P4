module stage2(clk, rst, init, instruction, regFileWriteData, stackOut, stackIn, readData1, readData2, Z, C, AluInputBSel, ALUfunction, shiftCount, pcAdderInputBSel, pcInputSel, const_disp, dest, writeAddress, DMMemWrite);
	
	//controller signals:
	//stage 1 signals:
	output pcAdderInputBSel, pcInputSel;
	//stage 2 signals:
	wire push, pop;
	wire selectR2;
	wire registerFileR2DataSel;

	// stage 3 signals:
	output AluInputBSel;
	output [3:0] ALUfunction;
	// stage 4 signals:
	output DMMemWrite;
	// stage 5 signals:

	wire regFileWriteDataSel;


	controller CU (
		.init_signal(init), 
		.clock(clk), 
		.allBits(instruction), 
		.Zero(Z), 
		.CarryOut(C), 
		.regFileWriteDataSel(regFileWriteDataSel), 
		.selectR2(registerFileR2DataSel), 
		.AluInputBSel(AluInputBSel), 
		.ALUfunction(ALUfunction), 
		.STM(DMMemWrite), 
		.LDM(), 
		.enablePC(), 
		.enableZero(), 
		.enableCarry(), 
		.pcAdderInputBSel(pcAdderInputBSel), 
		.push(push), 
		.pop(pop), 
		.pcInputSel(pcInputSel)
	);


	input clk, rst, init;
	input [7:0] regFileWriteData;
	output [7:0] readData2, readData1;
	input [18:0] instruction;
	input [11:0] stackIn;
	output [11:0] stackOut;
	input C, Z;
	output [2:0] shiftCount;
	output [7:0] const_disp;
	output [2:0] dest;
	input [2:0] writeAddress;

	assign dest = instruction[13:11];
	assign shiftCount = instruction[7:5];
	assign const_disp = instruction[7:0];

	registerFile regFile(
		.clock(clk), 
		.regWrite(regWrite), 
		.writeRegister(writeAddress), 
		.writeData(regFileWriteData), 
		.readRegister1(instruction[10:8]), 
		.readRegister2(registerFileR2Data), 
		.readData1(readData1), 
		.readData2(readData2)
	);

	mux_2_input  #(.WORD_LENGTH (8)) registerFileR2DataMux (    //mux 5
		.in1(instruction[7:5]), 
		.in2(instruction[13:11]), 
		.sel(registerFileR2DataSel), 
		.out(registerFileR2Data)
	);

	stack  ST(
		.clock(clk), 
		.push(push), 
		.pop(pop), 
		.result(stackOut), 
		.in(stackIn)
	);

endmodule 