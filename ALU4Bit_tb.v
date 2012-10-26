`timescale 1ns / 1ps

module ALU4Bit_tb();
  reg [3:0] a, b;
  reg [2:0] op;
  wire [3:0] result;
  wire cout;
  wire G, P;
  wire set;
  wire overflow;

  ALU4Bit alu(a, b, op, result, cout, G, P, set, overflow);

  initial begin
    $monitor("    %b [%b] %b = R: %b   O: %b   C: %b   S: %b", a, op, b, result, overflow, cout, set);

    $display("Test AND with b-inverse");
    a <= 'b 1111; b <= 'b 0010; op <= 'b 100;
    #1;

    $display("Test ADD with overflow (7 + 7)");
    a <= 'b 0111; b <= 'b 0111; op <= 'b 010;
    #1;

    $display("Test unsigned ADD with overflow and cout");
    a <= 'b 1000; b <= 'b 1000; op <= 'b 010;
    #1;

    $display("Test ADD with pos and neg (-7 + 7)");
    a <= 'b 1001; b <= 'b 0111; op <= 'b 010;
    #1;

    $display("Test SUB with overflow (-7 - 7)");
    a <= 'b 1001; b <= 'b 0111; op <= 'b 110;
    #1;

    $display("Test SUB with neg and neg (-7 - -7)");
    a <= 'b 1001; b <= 'b 1001; op <= 'b 110;
    #1;

    $display("Test SLT with 0 and 1 (0 < 1)");
    a <= 'b 0000; b <= 'b 0001; op <= 'b 111;
    #1;

    $display("Test SLT with 1 and 0 (0 not< 1)");
    a <= 'b 0001; b <= 'b 0000; op <= 'b 111;
    #1;

    $display("Test SLT wih -7 and -1 (-7 < -1)");
    a <= 'b 1001; b <= 'b 1111; op <= 'b 111;
    #1;

    $display("Test SLT with -1 and -7 (-1 not< -7)");
    a <= 'b 1111; b <= 'b 1001; op <= 'b 111;
    #1;

    $display("Test SLT with -1 and 0 (-1 < 0)");
    a <= 'b 1111; b <= 'b 0000; op <= 'b 111;
    #1;

    // $display("Test ADD with all possible inputs");
    // op <= 2;
    // a <= 0;

    // repeat (15) begin
    //   b <= 0;
    //   #1;

    //   repeat (15) begin
    //     b <= b + 1;
    //     #1;
    //   end

    //   a <= a + 1;
    //   #1;
    // end

    $finish;
  end
endmodule
