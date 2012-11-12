module DataMemory(Address, WriteData, MemRead, MemWrite, Clk, ReadData);
  input [6:0] Address;
  input [31:0] WriteData;
  input MemRead, MemWrite, Clk;
  output reg [31:0] ReadData;

  // 128 (2^7) cells with 32 bits each
  reg [31:0] tab[127:0];

  integer i;
  initial begin
    for (i = 0; i < 128; i = i + 1)
      tab[i] <= 0;
  end

  always @(posedge Clk) begin
    if (MemWrite)
      tab[Address] = WriteData;

    if (MemRead)
      ReadData <= tab[Address];
  end
endmodule
