module ALU16Bit_tb();
  reg [15:0] a, b;
  reg [2:0] op;
  wire [15:0] result;
  wire cout, G, P, set, overflow, zero;

  ALU16Bit alu(a, b, op[2], set, op, result, cout, G, P, set, overflow, zero);

  initial begin
    $monitor("  %b [%b] %b = %b  O:%b  C:%b  S:%h  Z:%b", a, op, b, result, overflow, cout, set, zero);

    $display("Test AND");
    a <= 'b 1111_1111_0000_1111; b <= 'b 1111_1111_1111_1111; op <= 'b 000;
    #1;

    $display("Test AND with invert");
    a <= 'b 1111_1111_1111_1111; b <= 'b 0000_0000_1111_0000; op <= 'b 100;
    #1;

    $display("Test OR");
    a <= 'b 1111_0000_1111_0000; b <= 'b 0000_1111_0000_1111; op <= 'b 001;
    #1;

    $display("Test OR with invert");
    a <= 'b 1111_0000_0000_1111; b <= 'b 1111_0000_1111_1111; op <= 'b 101;
    #1;

    $display("Test SUB with neg and neg");
    a <= 'h BEEF; b <= 'h BEEF; op <= 'b 110;
    #1;

    $display("Test ADD with overflow");
    a <= 'b 0111_1111_1111_1111; b <= 'b 0111_1111_1111_1111; op <= 'b 010;
    #1;

    $display("Test ADD with overflow and cout");
    a <= 'b 1000_0000_0000_0000; b <= 'b 1000_0000_0000_0000; op <= 'b 010;
    #1;

    $display("Test SLT with pos and neg");
    a <= 'b 0000_0000_0000_0000; b <= 'b 1111_1111_1111_1111; op <= 'b 111;
    #1;

    $display("Test SLT with neg and pos");
    a <= 'b 1111_1111_1111_1111; b <= 'b 0000_0000_0000_0000; op <= 'b 111;
    #1;

    $display("Test SLT with neg and pos");
    a <= 'b 1000_0000_0000_0000; b <= 'b 0000_0000_0000_0001; op <= 'b 111;
    #1;
  end
endmodule
