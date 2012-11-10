module OverflowDetection(a, bin, op, result, overflow);
  input a, bin;
  input [2:0] op;
  input result;
  output overflow;

  wire b = bin ^ op[2];
  assign overflow =  a &  b & ~result |
                    ~a & ~b &  result;
endmodule
