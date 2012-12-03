SRC = \
	ALU16Bit.v \
	ALU1Bit.v \
	ALU32Bit.v \
	ALU4Bit.v \
        CLA.v \
	Control.v \
	DataMemory.v \
	InstructionMemory.v \
	Mux32Bit2To1.v \
	Mux32Bit3To1.v \
	Mux5Bit2To1.v \
	OverflowDetection.v \
	RegisterFile.v \
	SignExtension.v \

STAGES = \
	 IFStage.v \
	 IDStage.v \
	 EXStage.v \
	 MEMStage.v \
	 WBStage.v \

src:
	@echo $(SRC) $(STAGES)

flags:
	@echo -Wimplicit
