module EXStage(
  input MEMRegWrite,
  input [31:0] MEMData,
  input [4:0] MEMRd,
  input WBRegWrite,
  input [31:0] WBData,
  input [4:0] WBRd,
  input ALUSrc,
  input [2:0] ALUControl,
  input MemRead,
  input MemWrite,
  input RegWrite,
  input [31:0] DataA,
  input [31:0] DataB,
  input [31:0] SignExtend,
  input [4:0] Rs,
  input [4:0] Rt,
  input [4:0] Rd,
  input Clk,
  output reg EXRegWrite,
  output reg EXMemRead,
  output reg EXMemWrite,
  output reg [4:0] EXRd,
  output reg [31:0] EXData,
  output reg [31:0] EXALUData
);
  initial begin
    EXRegWrite <= 0; EXMemRead <= 0; EXMemWrite <= 0; EXRd <= 0; EXData <= 0;
    EXALUData <= 0;
  end

  reg [2:0] fwd_a, fwd_b;

  always @(*) begin
    // Forward from previous cycle.
    if (MEMRegWrite && MEMRd && MEMRd == Rs)
      fwd_a <= 'b 01;
    // Forward from second previous cycle.
    else if (WBRegWrite && WBRd && WBRd == Rs)
      fwd_a <= 'b 10;
    // Don't forward.
    else
      fwd_a <= 'b 00;

    if (MEMRegWrite && MEMRd && MEMRd == Rt)
      fwd_b <= 'b 01;
    else if (WBRegWrite && WBRd && WBRd == Rt)
      fwd_b <= 'b 10;
    else
      fwd_b <= 'b 00;
  end

  wire [31:0] input_a;
  Mux32Bit3To1 fam(DataA, MEMData, WBData, fwd_a, input_a);

  wire[31:0] data_b;
  Mux32Bit3To1 fbm(DataB, MEMData, WBData, fwd_b, data_b);

  wire [31:0] input_b;
  Mux32Bit2To1 ibm(data_b, SignExtend, ALUSrc, input_b);

  wire [31:0] alu_result;
  ALU32Bit alu(input_a, input_b, ALUControl, alu_result,,,);

  always @(negedge Clk) begin
    // Run one tick after MEMStage (two after WBStage).
    #2;

    EXRegWrite <= RegWrite;
    EXMemRead <= MemRead;
    EXMemWrite <= MemWrite;
    EXRd <= Rd;
    EXData <= data_b;
    EXALUData <= alu_result;
  end
endmodule
