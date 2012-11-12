SRC = \
	ALU16Bit.v \
	ALU1Bit.v \
	ALU32Bit.v \
	ALU4Bit.v \
	ALUOpToALUControl.v \
        CLA.v \
	Control.v \
	DataMemory.v \
	Mux32Bit2To1.v \
	Mux5Bit2To1.v \
	OldControl.v \
	OverflowDetection.v \
	RegisterFile.v \
	SignExtension.v \

src:
	@echo $(SRC)
