module IFStage(
  input Branch,
  input Jump,
  input Stall,
  input [31:0] BranchOffset,
  input [25:0] JumpAddress,
  input Clk,
  output reg [31:0] Inst
);
  initial begin
    pc <= 0; Inst <= 0;
  end

  reg [31:0] pc;

  wire [31:0] mem;
  InstructionMemory im(pc, Clk, mem);

  // Go to the next word.
  wire [31:0] pc_next = pc + 1;

  always @(negedge Clk) begin
    // Run one ticks after IDStage (four after WBStage).
    #4;

    // Keep the current PC and instruction if stalling.
    if (!Stall) begin
      if (Jump)
        // Don't need to multiply by two because JumpAddress is a word address.
        pc <= {pc_next[31:28], JumpAddress};
      else if (Branch)
        // Don't need to multiply by two because BranchOffset is a word address.
        pc <= pc_next + BranchOffset;
      else
        pc <= pc_next;

      if (Branch || Jump)
        // Discard the current instruction if branching or jumping.
        Inst <= 0;
      else
        Inst <= mem;
    end
  end
endmodule
