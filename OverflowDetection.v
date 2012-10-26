`timescale 1ns / 1ps

module OverflowDetection(a, b, op, result, overflow);
  input a, b;
  input [2:0] op;
  input result;
  output overflow;

  wire bval;

  assign bval = b ^ op[2];
  assign overflow =  a &  bval & ~result |
                    ~a & ~bval &  result;
endmodule
