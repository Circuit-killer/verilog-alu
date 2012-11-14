module RegisterFile_tb();
  reg [4:0] ReadRegister1, ReadRegister2, WriteRegister;
  reg [31:0] WriteData;
  reg RegWrite, Clk;
  wire [31:0] ReadData1, ReadData2;

  RegisterFile rf(ReadRegister1, ReadRegister2, WriteRegister, WriteData,
    RegWrite, Clk, ReadData1, ReadData2);

  // Run a 4-tick clock.
  initial begin
    Clk <= 0;
    forever #4 Clk <= ~Clk;
  end

  initial begin
    $display("T:Clk\tWrite\t\tRead 1\t\tRead 2");
    $monitor("%3d:%b\t%h:%h\t%h:%h\t%h:%h", $time, Clk, WriteRegister, WriteData,
      ReadRegister1, ReadData1, ReadRegister2, ReadData2);

    ReadRegister1 <= 0; ReadRegister2 <= 0; WriteRegister <= 0; WriteData <= 0;
    RegWrite <= 0;

    #4;
    $display("Test write and read in the same cycle");
    WriteRegister <= 16;
    WriteData <= 'h DEAD_DAD5;
    RegWrite <= 1;
    ReadRegister1 <= 16;

    #4;
    ReadRegister1 <= 0; ReadRegister2 <= 0; WriteRegister <= 0; WriteData <= 0;
    RegWrite <= 0;

    #4;
    $display("Test write and read in separate cycles");
    WriteRegister <= 31;
    WriteData = 'h DEAD_BEEF;
    RegWrite <= 1;

    #4;
    ReadRegister1 <= 0; ReadRegister2 <= 0; WriteRegister <= 0; WriteData <= 0;
    RegWrite <= 0;

    #4;
    ReadRegister1 = 31;

    #4;
    ReadRegister1 <= 0; ReadRegister2 <= 0; WriteRegister <= 0; WriteData <= 0;
    RegWrite <= 0;

    $finish;
  end
endmodule
