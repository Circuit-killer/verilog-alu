module InstructionMemory(Address, Clk, ReadData);
  parameter SLOT_SIZE = 32 - 1;
  parameter NUM_SLOTS = 32 - 1;

  input [31:0] Address;
  input Clk;
  output reg [SLOT_SIZE:0] ReadData;

  reg [SLOT_SIZE:0] tab[NUM_SLOTS:0];

  integer i;
  initial begin
    // Zero all the cells.
    for (i = 0; i <= NUM_SLOTS; i = i + 1)
      tab[i] <= 0;

    // Load some instructions.
    // add $1, $1, $1
    tab[0] <= 'b 000000_00001_00001_00001_00000_100000;
    // add $2, $1, $1
    tab[1] <= 'b 000000_00001_00001_00010_00000_100000;
    // add $3, $2, $4
    tab[2] <= 'b 000000_00010_00100_00011_00000_100000;
    // beq $3, $3, 8
    tab[3] <= 'b 000100_00011_00011_0000000000000011;
    // j 0
    tab[4] <= 'b 000010_00000000000000000000000000;
    // lw $16, 2($3)
    tab[8] <= 'b 100011_00011_10000_0000000000000010;
    // sw $3, 4($0)
    tab[9] <= 'b 101011_00000_00011_0000000000000100;
    // lw $8, 4($0)
    tab[10] <= 'b 100011_00000_01000_0000000000000100;
  end

  always @(posedge Clk) begin
    ReadData <= tab[Address];
  end
endmodule
