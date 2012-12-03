module DataMemory_tb();
  reg [31:0] Address;
  reg [31:0] WriteData;
  reg MemRead, MemWrite, Clk;
  wire [31:0] ReadData;

  DataMemory dm(Address, WriteData, MemRead, MemWrite, Clk, ReadData);

  initial begin
    Clk <= 0;
    forever #4 Clk <= ~Clk;
  end

  initial begin
    $display("T:Clk\tAddress\tWrite\t\tRead");
    $monitor("%3d:%b\t%h\t%h\t%h", $time, Clk, Address, WriteData,
      ReadData);

    Address <= 0; WriteData <= 0; MemRead <= 0; MemWrite <= 0;

    #4;
    $display("Test zeroing");
    Address <= 0;
    MemRead <= 1;

    #4;
    MemRead <= 0;

    #4;
    $display("Test write");
    Address <= 127;
    WriteData <= 'h DAD5_B00B;
    MemWrite <= 1;

    #4;
    WriteData <= 0;
    MemWrite <= 0;

    #4;
    $display("Test read");
    Address <= 127;
    MemRead <= 1;

    #4;
    MemRead <= 0;

    $finish;
  end
endmodule
