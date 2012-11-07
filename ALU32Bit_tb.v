module ALU32Bit_tb();
  reg [31:0] a, b;
  reg [2:0] op;
  wire [31:0] result;
  wire set, overflow, zero;

  ALU32Bit alu(a, b, op, result, set, zero, overflow);

  initial begin
    $monitor("  %b [%b] %b = %b  O:%b  S:%h  Z:%b", a, op, b, result, overflow, set, zero);

    $display("Test AND");
    a <= 'h FF0F_FFFF; b <= 'h FFFF_FFFF; op <= 'b 000;
    #1;

    $display("Test AND with invert");
    a <= 'h FFFF_FFFF; b <= 'h 0F00_00F0; op <= 'b 100;
    #1;

    $display("Test OR");
    a <= 'h F0F0_F0F0; b <= 'h 0F0F_0F0F; op <= 'b 001;
    #1;

    $display("Test OR with invert");
    a <= 'h FF00_00FF; b <= 'h 00FF_F000; op <= 'b 101;
    #1;

    $display("Test SUB with neg and neg");
    a <= 'h DEAD_BEEF; b <= 'h DEAD_BEEF; op <= 'b 110;
    #1;

    $display("Test ADD with overflow");
    a <= 'h 7FFF_FFFF; b <= 'h 7FFF_FFFF; op <= 'b 010;
    #1;

    $display("Test ADD with overflow and cout");
    a <= 'h 8000_0000; b <= 'h 8000_0000; op <= 'b 010;
    #1;

    $display("Test SLT with pos and neg");
    a <= 'h 0000_0000; b <= 'h FFFF_FFFF; op <= 'b 111;
    #1;

    $display("Test SLT with neg and pos");
    a <= 'h FFFF_FFFF; b <= 'h 0000_0000; op <= 'b 111;
    #1;

    $display("Test SLT with neg and pos");
    a <= 'h 8000_0000; b <= 'h 0000_0001; op <= 'b 111;
    #1;
  end
endmodule
