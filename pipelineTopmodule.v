module pipeline(clk, rst, init);
	input clk, rst, init;
	//TODO: controll signals are incomplete in pipelines
	wire [2:0] pipelineInputShiftCount;
	wire [2:0] pipelineOutputShiftCount;
	wire [3:0] pipelineInputAluFunction;
	wire [3:0] pipelineOutputAluFunction;
	wire pipelineInputAluInputBSel;
	wire pipelineOutputAluInputBSel;
	wire [18:0] pipelineInputInstruction;
	wire [18:0] pipelineOutputInstruction;
	wire [11:0] piplineInputPc;
	wire [11:0] piplineOutputPc;
	wire [7:0] pipelineInputR1, pipelineInputR2;
	wire [7:0] pipelineOutputR1, pipeline2OutputR2, pipeline3OutputR2;
	wire [7:0] piplineInputDisp, pipelineOutputDisp;
	wire [7:0] pipelineInputConst_disp, pipelineOutputConst_disp;
	wire [1:0] pcInputSel;
	wire pcAdderInputASel;
	wire [11:0] stackOut;
	wire [7:0] regFileWriteData;
	wire Z, C, sstall;
	wire [2:0] pipeline2InputDest, pipline2OutputDest;
	wire [2:0] pipline3OutputDest, pipline4OutputDest;
	wire [7:0] pipelineInputAluResult, pipeline3OutputAluResult, pipeline4OutputAluResult;
	wire pipeline2InputDMMemWrite, pipeline2OutputDMMemWrite, pipeline3OutputDMMemWrite;
	wire [7:0] pipelineInputDMOut, pipelineOutputDMOut;
	wire pipeline2InputregWrite, pipeline2OutputregWrite, pipeline3OutputregWrite, pipeline4OutputregWrite;
	wire pipeline2InputregWriteDataSel, pipeline2OutputregWriteDataSel, pipeline3OutputregWriteDataSel, pipeline4OutputregWriteDataSel;
	wire pipelineInputZen, pipelineOutputZen, pipelineInputCen, pipelineOutputCen;
	wire [1:0] aluInputAForwardingSel, aluInputBForwardingSel;
	wire [2:0] pipelineInputR1Address, pipelineInputR2Address, piplineOutputR1Address, piplineOutputR2Address;
	stage1 s1(
		.clk(clk), 
		.rst(rst), 
		.pcEnb(~sstall),
		.pcAdderInputASel(pcAdderInputASel), 
		.pcOut(piplineInputPc),
		.disp({{4{pipelineInputConst_disp[7]}},pipelineInputConst_disp}),
		.pcInputSel(pcInputSel),
		.stackOutput(stackOut),
		.jumpAdr(pipelineOutputInstruction[11:0]),
		.instruction(pipelineInputInstruction)
	);	

	IF_ID_pipline if_id(
		.clk(clk), 
		.rst(rst), 
		.enb(~sstall),
		.Iinstruction(pipelineInputInstruction), 
		.Ipc(piplineInputPc), 
		.Oinstruction(pipelineOutputInstruction), 
		.Opc(piplineOutputPc)
	);

	stage2 s2(
		.clk(clk), 
		.rst(rst), 
		.init(init), 
		.instruction(pipelineOutputInstruction), 
		.regFileWriteData(regFileWriteData), 
		.stackOut(stackOut), 
		.stackIn(piplineOutputPc), 
		.readData1(pipelineInputR1), 
		.readData2(pipelineInputR2),
		.C(C),
		.Z(Z),
		.AluInputBSel(pipelineInputAluInputBSel),
		.ALUfunction(pipelineInputAluFunction),
		.shiftCount(pipelineInputShiftCount),
		.pcAdderInputASel(pcAdderInputASel), 
		.pcInputSel(pcInputSel),
		.const_disp(pipelineInputConst_disp),
		.dest(pipeline2InputDest),
		.writeAddress(pipline4OutputDest),
		.DMMemWrite(pipeline2InputDMMemWrite),
		.ControllerOutput_regFileWriteDataSel(pipeline2InputregWriteDataSel),
		.LDM(pipeline2InputregWrite),
		.controllerInput_regWrite(pipeline4OutputregWrite),
		.Cenb(pipelineInputCen), 
		.Zenb(pipelineInputZen),
		.r1Address(pipelineInputR1Address),
		.r2Address(pipelineInputR2Address),
		.sstall(sstall)
	);

	ID_EX_pipline id_ex(
		.clk(clk), 
		.rst(rst), 
		.enb(~sstall),
		.Ir1(pipelineInputR1), 
		.Ir2(pipelineInputR2), 
		.Iconst_disp(pipelineInputConst_disp), 
		.Isc(pipelineInputShiftCount), 
		.Idest(pipeline2InputDest), 
		.IaluFunction(pipelineInputAluFunction),
		.IAluInputBSel(pipelineInputAluInputBSel),
		.IDMMemWrite(pipeline2InputDMMemWrite),
		.IregWrite(pipeline2InputregWrite), 
		.IregWriteDataSel(pipeline2InputregWriteDataSel),
		.IZenb(pipelineInputZen),
		.ICenb(pipelineInputCen),
		.Ir1Address(pipelineInputR1Address),
		.Ir2Address(pipelineInputR2Address),
		.Or1(pipelineOutputR1), 
		.Or2(pipeline2OutputR2), 
		.Oconst_dOsp(pipelineOutputConst_disp), 
		.Osc(pipelineOutputShiftCount), 
		.Odest(pipline2OutputDest),
		.OaluFunction(pipelineOutputAluFunction),
		.OAluInputBSel(pipelineOutputAluInputBSel),
		.ODMMemWrite(pipeline2OutputDMMemWrite),
		.OregWrite(pipeline2OutputregWrite), 
		.OregWriteDataSel(pipeline2OutputregWriteDataSel),
		.OZenb(pipelineOutputZen),
		.OCenb(pipelineOutputCen),
		.Or1Address(piplineOutputR1Address),
		.Or2Address(piplineOutputR2Address)
	);

	stage3 s3(
		.clk(clk), 
		.rst(rst), 
		.r1(pipelineOutputR1), 
		.r2(pipeline2OutputR2), 
		.disp_const(pipelineOutputConst_disp), 
		.aluBInputSel(pipelineOutputAluInputBSel),
		.ZOutput(Z), 
		.COutput(C),
		.shiftCount(pipelineOutputShiftCount), 
		.ALUOperation(pipelineOutputAluFunction),
		.ALUOUT(pipelineInputAluResult),
		.ZEn(pipelineOutputZen), 
		.CEn(pipelineOutputCen),
		.aluInputAForwardingSel(aluInputAForwardingSel), 
		.aluInputBForwardingSel(aluInputBForwardingSel),
		.Ex_Mem_aluResult(pipeline3OutputAluResult), 
		.Mem_Wb_aluResult(regFileWriteData)  //TODO: this was pipeline4OutputAluResult  
	);
	forwardingUnit FW(
		.Ex_Mem_dest(pipline3OutputDest), 
		.Ex_Mem_regWrite(pipeline3OutputregWrite), 
		.Ex_Mem_regWriteDataSel(pipeline3OutputregWriteDataSel),
		.Id_Ex_r1Address(piplineOutputR1Address), 
		.Id_Ex_r2Address(piplineOutputR2Address), 
		.Mem_Wb_regWrite(pipeline4OutputregWrite), 
		.Mem_Wb_dest(pipline4OutputDest), 
		.aluInputAForwardingSel(aluInputAForwardingSel), 
		.aluInputBForwardingSel(aluInputBForwardingSel),
		.stall(sstall)
	);

	EX_MEM_pipline ex_mem(
		.clk(clk), 
		.rst(rst),
		.IaluResult(pipelineInputAluResult), 
		.Ir2(pipeline2OutputR2), 
		.Idest(pipline2OutputDest), 
		.IDMMemWrite(pipeline2OutputDMMemWrite),
		.IregWrite(pipeline2OutputregWrite), 
		.IregWriteDataSel(pipeline2OutputregWriteDataSel),
		//.IDMAddress(),  this is equal to IaluResult
		.OaluResult(pipeline3OutputAluResult), 
		.Or2(pipeline3OutputR2), 
		.Odest(pipline3OutputDest),
		.ODMMemWrite(pipeline3OutputDMMemWrite),
		.OregWrite(pipeline3OutputregWrite), 
		.OregWriteDataSel(pipeline3OutputregWriteDataSel)
		//.ODMAddress()  this is equal to IaluResult

	);

	stage4 s4(
		.clk(clk), 
		// .DMMemRead(pipeline3OutputR2), 
		.DMMemWrite(pipeline3OutputDMMemWrite), 
		.DataMemoryAddress(pipeline3OutputAluResult), 
		.dataMemoryOut(pipelineInputDMOut), 
		.DMdataIn(pipeline3OutputAluResult)
	);


	MEM_WB_pipeline mem_wb(
		.clk(clk), 
		.rst(rst), 
		.IData(pipelineInputDMOut), 
		.IaluResult(pipeline3OutputAluResult), 
		.Idest(pipline3OutputDest),
		.IregWrite(pipeline3OutputregWrite), 
		.IregWriteDataSel(pipeline3OutputregWriteDataSel),
		.OData(pipelineOutputDMOut), 
		.OaluResult(pipeline4OutputAluResult), 
		.Odest(pipline4OutputDest),
		.OregWrite(pipeline4OutputregWrite), 
		.OregWriteDataSel(pipeline4OutputregWriteDataSel)
	);

	stage5 s5(
		.aluResult(pipeline4OutputAluResult), 
		.dataMemoryOut(pipelineOutputDMOut), 
		.registerFileWriteData(regFileWriteData), 
		.registerFileWriteDataSel(pipeline4OutputregWriteDataSel)
		);

endmodule

