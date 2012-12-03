module IDStage_tb();
  reg [31:0] Inst;
  reg EXRegWrite;
  reg EXMemRead;
  reg [4:0] EXRd;
  reg MEMRegWrite;
  reg [31:0] MEMData;
  reg [4:0] MEMRd;
  reg WBRegWrite;
  reg [31:0] WBData;
  reg [4:0] WBRd;
  reg Clk;
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

  IDStage ids(Inst, EXRegWrite, EXMemRead, EXRd, MEMRegWrite, MEMData, MEMRd,
    WBRegWrite, WBData, WBRd, Clk, Branch, Jump, Stall, BranchOffset,
    JumpAddress, ALUSrc, ALUControl, MemRead, MemWrite, RegWrite, DataA, DataB,
    SignExtend, Rs, Rt, Rd);

  initial begin
    $monitor("%g:%b  S:%b  B:%b  BO:%h  J:%b  JA:%h  ALU:%b  CTRL:%b  MR:%b  MW:%b  RW:%b  DA:%h  DB:%h  SE:%h  Rs:%b  Rt:%b  Rd:%b",
      $time, Clk, Stall, Branch, BranchOffset, Jump, JumpAddress, ALUSrc,
      ALUControl, MemRead, MemWrite, RegWrite, DataA, DataB, SignExtend, Rs, Rt,
      Rd);

    EXRegWrite <= 0; EXMemRead <= 0; EXRd <= 0; MEMRegWrite <= 0; MEMData <= 0;
    MEMRd <= 0; WBRegWrite <= 0; WBData <= 0; WBRd <= 0;

    // add $0, $1, $0
    Inst <= 'b 000000_00000_00001_00000_00000_100000;
    Clk <= 1;
    #1;
    Clk <= ~Clk;
    #1;

    // beq $2, $3, 0
    Inst <= 'b 000100_00010_00011___0000_0000_0000_0000;
    Clk <= ~Clk;
    #1;
    Clk <= ~Clk;
    #1;

    // j 1
    Inst <= 'b 000010___0000_0000_0000_0000_0000_000001;
    Clk <= ~Clk;
    #1;
    Clk <= ~Clk;
    #1;

    // lw $1, ...
    // add $1, $1, $1
    EXMemRead <= 1;
    EXRegWrite <= 1;
    EXRd <= 1;
    Inst <= 'b 000000_00001_00001_00001_00000_100000;
    Clk <= ~Clk;
    #1;
    Clk <= ~Clk;
    #1;

    // add $1, $1, $1
    // ...
    // add $1, $1, $1
    EXMemRead <= 0;
    EXRegWrite <= 0;
    EXRd <= 0;
    WBRd <= 1;
    WBData <= 'h d00d_d00d;
    WBRegWrite <= 1;
    Inst <= 'b 000000_00001_00001_00001_00000_100000;
    Clk <= ~Clk;
    #1;
    Clk <= ~Clk;
    #1;

    $finish;
  end
endmodule
