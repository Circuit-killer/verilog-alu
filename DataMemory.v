module DataMemory(Address, WriteData, MemRead, MemWrite, Clk, ReadData);
  parameter SLOT_SIZE = 32 - 1;
  parameter NUM_SLOTS = 32 - 1;

  input [31:0] Address;
  input [SLOT_SIZE:0] WriteData;
  input MemRead, MemWrite, Clk;
  output reg [SLOT_SIZE:0] ReadData;

  reg [SLOT_SIZE:0] tab[NUM_SLOTS:0];

  integer i;
  initial begin
    // Zero all the cells.
    for (i = 0; i <= NUM_SLOTS; i = i + 1)
      tab[i] <= 0;

    // Load some data.
    tab[8] <= 'h dead_dad5;
    tab[20] <= 'h beef_b00b;
  end

  always @(posedge Clk) begin
    if (MemWrite) begin
      $display("MEM[%b] = %b", Address, WriteData);
      tab[Address] = WriteData;
    end

    if (MemRead)
      ReadData <= tab[Address];
  end
endmodule
