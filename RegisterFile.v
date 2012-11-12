module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData,
                    RegWrite, Clk, ReadData1, ReadData2);
  input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
  input [31:0] WriteData;
  input RegWrite, Clk;
  output reg [31:0] ReadData1, ReadData2;

  // 31 cells with 31 bits each
  reg [31:0] tab[31:0];

  // Zero all the cells
  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1)
      tab[i] <= 0;
  end

  always @(posedge Clk) begin
    if (RegWrite)
      // This must be a blocking assignment so writes are propogated in the same
      // cycle.
      tab[WriteRegister] = WriteData;

    ReadData1 <= tab[ReadRegister1];
    ReadData2 <= tab[ReadRegister2];
  end
endmodule
