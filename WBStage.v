module WBStage(
  input [4:0] MEMRd,
  input [31:0] MEMData,
  input MEMRegWrite,
  input Clk,
  output reg [4:0] WBRd,
  output reg [31:0] WBData,
  output reg WBRegWrite
);
  initial begin
    WBRd <= 0; WBData <= 0; WBRegWrite <= 0;
  end

  always @(negedge Clk) begin
    // Run on the first tick of the negative edge.
    WBRd <= MEMRd;
    WBData <= MEMData;
    WBRegWrite <= MEMRegWrite;
  end
endmodule
