module Pipeline();
  reg Clk;
  reg SubClk;

  wire [31:0] Inst;
  wire EXRegWrite;
  wire EXMemRead;
  wire [4:0] EXRd;
  wire MEMRegWrite;
  wire [31:0] MEMData;
  wire [4:0] MEMRd;
  wire WBRegWrite;
  wire [31:0] WBData;
  wire [4:0] WBRd;
  wire Branch;
  wire Jump;
  wire Stall;
  wire [31:0] BranchOffset;
  wire [25:0] JumpAddress;
  wire ALUSrc;
  wire [2:0] ALUControl;
  wire MemRead;
  wire MemWrite;
  wire RegWrite;
  wire [31:0] DataA;
  wire [31:0] DataB;
  wire [31:0] SignExtend;
  wire [4:0] Rs;
  wire [4:0] Rt;
  wire [4:0] Rd;
  wire EXMemWrite;
  wire [31:0] EXData;
  wire [31:0] EXALUData;

  IFStage ifs(Branch, Jump, Stall, BranchOffset, JumpAddress, Clk, Inst);

  IDStage ids(Inst, EXRegWrite, EXMemRead, EXRd, MEMRegWrite, MEMData, MEMRd,
    WBRegWrite, WBData, WBRd, Clk, SubClk, Branch, Jump, Stall, BranchOffset,
    JumpAddress, ALUSrc, ALUControl, MemRead, MemWrite, RegWrite, DataA, DataB,
    SignExtend, Rs, Rt, Rd);

  EXStage exs(MEMRegWrite, MEMData, MEMRd, WBRegWrite, WBData, WBRd, ALUSrc,
    ALUControl, MemRead, MemWrite, RegWrite, DataA, DataB, SignExtend, Rs, Rt,
    Rd, Clk, EXRegWrite, EXMemRead, EXMemWrite, EXRd, EXData, EXALUData);

  MEMStage ms(EXRegWrite, EXMemRead, EXMemWrite, EXRd, EXData, EXALUData, Clk,
    MEMRd, MEMData, MEMRegWrite);

  WBStage wbs(MEMRd, MEMData, MEMRegWrite, SubClk, WBRd, WBData, WBRegWrite);

  initial begin
    Clk <= 1;
    forever #5 Clk <= ~Clk;
  end

  always @(posedge Clk) begin
    SubClk <= 0;
    #1;
    SubClk <= 1;
  end

  initial begin
    #130;
    $finish;
  end
endmodule
