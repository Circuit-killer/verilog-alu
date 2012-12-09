module WBStage_tb();
  reg [4:0] MEMRd;
  reg [31:0] MEMData;
  reg MEMRegWrite;
  reg RegClk;
  wire [4:0] WBRd;
  wire [31:0] WBData;
  wire WBRegWrite;

  WBStage wbs(MEMRd, MEMData, MEMRegWrite, RegClk, WBRd, WBData, WBRegWrite);

  initial begin
    $monitor("%g:%b Rd:%b", $time, RegClk, WBRd);

    MEMRd <= 0; MEMData <= 0; MEMRegWrite <= 0; RegClk <= 0;

    MEMRd <= 'b 11111;
    RegClk <= 1;
    #8;
    RegClk <= 0;
    #8;
  end
endmodule
