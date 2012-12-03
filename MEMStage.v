module MEMStage(
  input EXRegWrite,
  input EXMemRead,
  input EXMemWrite,
  input [4:0] EXRd,
  input [31:0] EXData,
  input [31:0] EXALUData,
  input Clk,
  output reg [4:0] MEMRd,
  output reg [31:0] MEMData,
  output reg MEMRegWrite
);
  initial begin
    MEMRd <= 0; MEMData <= 0; MEMRegWrite <= 0;
  end

  wire [31:0] mem;
  DataMemory dm(EXALUData, EXData, EXMemRead, EXMemWrite, Clk, mem);

  wire [31:0] data;
  Mux32Bit2To1 memmux(EXALUData, mem, EXMemRead, data);

  always @(negedge Clk) begin
    // Run one tick after WBStage.
    #1;

    MEMRd <= EXRd;
    MEMData <= data;
    MEMRegWrite <= EXRegWrite;
  end
endmodule
