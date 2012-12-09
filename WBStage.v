module WBStage(
  input [4:0] MEMRd,
  input [31:0] MEMData,
  input MEMRegWrite,
  input RegClk,
  output reg [4:0] WBRd,
  output reg [31:0] WBData,
  output reg WBRegWrite
);
  initial begin
    WBRd <= 0; WBData <= 0; WBRegWrite <= 0;
  end

  always @(negedge RegClk) begin
    WBRd <= MEMRd;
    WBData <= MEMData;
    WBRegWrite <= MEMRegWrite;
  end
endmodule
