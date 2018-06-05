module stage2(clk, rst, init, instruction, regFileWriteData, stackOut, stackIn, readData1, readData2, Z, C, AluInputBSel, ALUfunction, shiftCount, pcAdderInputASel, pcInputSel, const_disp, dest, writeAddress, DMMemWrite, ControllerOutput_regFileWriteDataSel, LDM, controllerInput_regWrite, Cenb, Zenb, r1Address, r2Address, sstall);
	
	//controller signals:
	//stage 1 signals:
	output pcAdderInputASel;
	output [1:0] pcInputSel;
	//stage 2 signals:
	wire push, pop;
	// wire selectR2;
	wire registerFileR2DataSel;

	// stage 3 signals:
	output AluInputBSel;
	output [3:0] ALUfunction;
	output Cenb, Zenb;
	// stage 4 signals:
	output DMMemWrite;
	// stage 5 signals:

	output ControllerOutput_regFileWriteDataSel;
	output LDM;


	wire [18:0] controllerAllBits;
	wire ControllerOutputStall;
	
	wire fuckingOutput;
	register #(.size(1)) fuckingReg(
		.clock(clk),
		.reset(rst),
		.regIn(ControllerOutputStall),
		.regOut(fuckingOutput)
	);

	mux_2_input  #(.WORD_LENGTH (19)) controllerInstructionMux (    //mux 8
		.in1(instruction), 
		.in2({6'b111101,13'd0}), 
		.sel(sstall | fuckingOutput), 
		.out(controllerAllBits)
	);

	controller CU (
		.init_signal(init), 
		.clock(clk), 
		.allBits(controllerAllBits), 
		.Zero(Z), 
		.CarryOut(C), 
		.regFileWriteDataSel(ControllerOutput_regFileWriteDataSel), 
		.selectR2(registerFileR2DataSel), 
		.AluInputBSel(AluInputBSel), 
		.ALUfunction(ALUfunction), 
		.STM(DMMemWrite), 
		.LDM(LDM), 
		// .enablePC(pcEnb), 
		.enableZero(Zenb), 
		.enableCarry(Cenb), 
		.pcAdderInputASel(pcAdderInputASel), 
		.push(push), 
		.pop(pop), 
		.pcInputSel(pcInputSel),
		.stall(ControllerOutputStall)
	);

	input sstall;
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
	input controllerInput_regWrite;
	wire [2:0] registerFileR2Data;
	output [2:0] r1Address, r2Address;
	assign r1Address = instruction[10:8];
	assign r2Address = registerFileR2Data;
	assign dest = instruction[13:11];
	assign shiftCount = instruction[7:5];
	assign const_disp = instruction[7:0];

	registerFile regFile(
		.clock(clk), 
		.regWrite(controllerInput_regWrite), 
		.writeRegister(writeAddress), 
		.writeData(regFileWriteData), 
		.readRegister1(r1Address), 
		.readRegister2(registerFileR2Data), 
		.readData1(readData1), 
		.readData2(readData2)
	);

	mux_2_input  #(.WORD_LENGTH (3)) registerFileR2DataMux (    //mux 5
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