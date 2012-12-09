module EXStage_tb();
  reg MEMRegWrite;
  reg [31:0] MEMData;
  reg [4:0] MEMRd;
  reg WBRegWrite;
  reg [31:0] WBData;
  reg [4:0] WBRd;
  reg ALUSrc;
  reg [2:0] ALUControl;
  reg MemRead;
  reg MemWrite;
  reg RegWrite;
  reg [31:0] DataA;
  reg [31:0] DataB;
  reg [31:0] SignExtend;
  reg [4:0] Rs;
  reg [4:0] Rt;
  reg [4:0] Rd;
  reg Clk;
  wire EXRegWrite;
  wire EXMemRead;
  wire EXMemWrite;
  wire [4:0] EXRd;
  wire [31:0] EXData;
  wire [31:0] EXALUData;

  EXStage exs(MEMRegWrite, MEMData, MEMRd, WBRegWrite, WBData, WBRd, ALUSrc,
    ALUControl, MemRead, MemWrite, RegWrite, DataA, DataB, SignExtend, Rs, Rt,
    Rd, Clk, EXRegWrite, EXMemRead, EXMemWrite, EXRd, EXData, EXALUData);

  initial begin
    $monitor("%g:%b Data:%h ALU:%h", $time, Clk, EXData, EXALUData);

    MEMRegWrite <= 0; MEMData <= 0; MEMRd <= 0; WBRegWrite <= 0; WBData <= 0;
    WBRd <= 0; ALUSrc <= 0; ALUControl <= 0; MemRead <= 0; MemWrite <= 0;
    RegWrite <= 0; DataA <= 0; DataB <= 0; SignExtend <= 0; Rs <= 0; Rt <= 0;
    Rd <= 0;

    // Simulate R-type
    DataA <= 'h dead_0000;
    DataB <= 'h 0000_beef;
    ALUControl <= 'b 001;
    ALUSrc <= 0;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;

    // Simulate lw/sw
    SignExtend <= 'h 0000_dad5;
    ALUControl <= 'b 010;
    ALUSrc <= 1;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;

    ALUSrc <= 0;
    ALUControl <= 'b 001;

    // Simulate forwarding from second previous cycle to rs
    WBRegWrite <= 1;
    Rs <= 'b 00001;
    Rt <= 'b 11111;
    WBRd <= 'b 00001;
    WBData <= 'h abcd_0000;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;

    // Simulate forwarding from second previous cycle to rt
    Rt <= 'b 00001;
    Rs <= 'b 11111;
    WBRd <= 'b 00001;
    WBData <= 'h 0000_9876;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;

    // Simulate forwarding from previous cycle to rs
    MEMRegWrite <= 1;
    Rs <= 'b 00001;
    Rt <= 'b 11111;
    MEMRd <= 'b 00001;
    MEMData <= 'h 1234_0000;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;

    // Simulate forwarding from previous cycle to rt
    Rt <= 'b 00001;
    Rs <= 'b 11111;
    MEMRd <= 'b 00001;
    MEMData <= 'h 0000_5432;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;
  end
endmodule
