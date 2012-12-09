module MEMStage_tb();
  reg EXRegWrite;
  reg EXMemRead;
  reg EXMemWrite;
  reg [4:0] EXRd;
  reg [31:0] EXData;
  reg [31:0] EXALUData;
  reg Clk;
  wire [4:0] MEMRd;
  wire [31:0] MEMData;
  wire MEMRegWrite;

  MEMStage ms(EXRegWrite, EXMemRead, EXMemWrite, EXRd, EXData, EXALUData, Clk,
    MEMRd, MEMData, MEMRegWrite);

  initial begin
    $monitor("%g:%b Data:%b", $time, Clk, MEMData);

    EXRegWrite <= 0; EXMemRead <= 0; EXMemWrite <= 0; EXRd <= 0; EXData <= 0;
    EXALUData <= 0;

    // Simulate writing
    EXMemWrite <= 1;
    EXALUData <= 4;
    EXData <= 'h beef_beef;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;

    // Simulate reading
    EXMemRead <= 1;
    EXMemWrite <= 0;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;

    // Simulate bypass
    EXMemRead <= 0;
    EXALUData <= 'h b00b_b00b;
    Clk <= 1;
    #8;
    Clk <= 0;
    #8;
  end
endmodule
