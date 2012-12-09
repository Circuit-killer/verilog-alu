module RegisterFile(
  input [4:0] ReadRegister1,
  input [4:0] ReadRegister2,
  input [4:0] WriteRegister,
  input [31:0] WriteData,
  input RegWrite,
  input RegClk,
  output reg [31:0] ReadData1,
  output reg [31:0] ReadData2
);
  parameter NUM_CELLS = 32 - 1;
  reg [31:0] tab[NUM_CELLS:0];

  integer i;
  initial begin
    // Zero all the cells
    for (i = 0; i <= NUM_CELLS; i = i + 1)
      tab[i] <= 0;
  end

  always @(posedge RegClk) begin
    if (RegWrite && WriteRegister) begin
      $display("REG[%b] = %b", WriteRegister, WriteData);

      // This must be a blocking assignment so writes are propogated in the same
      // cycle.
      tab[WriteRegister] = WriteData;
    end

    ReadData1 <= tab[ReadRegister1];
    ReadData2 <= tab[ReadRegister2];
  end
endmodule
