module ALU32Bit(a, b, op, result, set, zero, overflow);
  input [31:0] a, b;
  input [2:0] op;
  output [31:0] result;
  output set, zero, overflow;

  wire carry;
  wire [1:0] zeroes;
  supply0 gnd;

  assign zero = zeroes[1] & zeroes[0];

  ALU16Bit alu1(a[15:0],  b[15:0],  op[2], set, op, result[15:0], carry,,,,, zeroes[0]);
  ALU16Bit alu2(a[31:16], b[31:16], carry, gnd, op, result[31:16],,,, set,,  zeroes[1]);

  OverflowDetection ovf(a[31], b[31], op, result[31], overflow);
endmodule
