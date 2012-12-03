module IFStage_tb();
  reg Branch;
  reg Jump;
  reg Stall;
  reg [31:0] BranchOffset;
  reg [25:0] JumpAddress;
  reg Clk;
  wire [31:0] Inst;

  IFStage ifs(Branch, Jump, Stall, BranchOffset, JumpAddress, Clk, Inst);

  initial begin
    $monitor("%g:%d\t%h", $time, Clk, Inst);

    Branch <= 0; Jump <= 0; Stall <= 0; BranchOffset <= 0; JumpAddress <= 0;

    // Start the clock high since module registers are zeroed at first.
    Clk <= 1;
    #1;
    Clk <= ~Clk;
    #1;
    Clk <= ~Clk;
    #1;
    Clk <= ~Clk;
    #1;

    $finish;
  end
endmodule
