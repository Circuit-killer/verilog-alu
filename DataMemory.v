module DataMemory(
  input [31:0] Address,
  input [31:0] WriteData,
  input MemRead,
  input MemWrite,
  input Clk,
  output reg [31:0] ReadData
);
  parameter NUM_CELLS = 32 - 1;
  reg [31:0] tab[NUM_CELLS:0];

  integer i;
  initial begin
    // Zero all the cells.
    for (i = 0; i <= NUM_CELLS; i = i + 1)
      tab[i] <= 0;
  end

  always @(posedge Clk) begin
    if (MemWrite) begin
      $display("MEM[%h] = %b", Address, WriteData);

      // Don't need to worry about memory reads and writes in the same cycle.
      tab[Address] <= WriteData;
    end

    if (MemRead)
      ReadData <= tab[Address];
  end
endmodule
