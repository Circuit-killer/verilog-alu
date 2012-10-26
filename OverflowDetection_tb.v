`timescale 1ns / 1ps

module OverflowDetection_tb();
  reg a, b;
  reg [2:0] op;
  reg result;
  wire overflow;

  OverflowDetection ovf(a, b, op, result, overflow);

  initial begin
    $monitor("    a: %b   b: %b   S: %b   O: %b", a, b, result, overflow);

    op <= 'b 010;

    $display("Test all possible ADD inputs");
    a <= 0; b <= 0; result <= 0;
    #1;
    a <= 0; b <= 0; result <= 1;
    #1;
    a <= 0; b <= 1; result <= 0;
    #1;
    a <= 0; b <= 1; result <= 1;
    #1;
    a <= 1; b <= 0; result <= 0;
    #1;
    a <= 1; b <= 0; result <= 1;
    #1;
    a <= 1; b <= 1; result <= 0;
    #1;
    a <= 1; b <= 1; result <= 1;
    #1;

    op <= 'b 110;

    $display("Test all possible SUB inputs");
    a <= 0; b <= 0; result <= 0;
    #1;
    a <= 0; b <= 0; result <= 1;
    #1;
    a <= 0; b <= 1; result <= 0;
    #1;
    a <= 0; b <= 1; result <= 1;
    #1;
    a <= 1; b <= 0; result <= 0;
    #1;
    a <= 1; b <= 0; result <= 1;
    #1;
    a <= 1; b <= 1; result <= 0;
    #1;
    a <= 1; b <= 1; result <= 1;
    #1;

    $finish;
  end
endmodule
