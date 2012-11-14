module ALU16Bit(a, b, cin, less, op, result, cout, G, P, set, overflow, zero);
  input [15:0] a, b;
  input cin, less;
  input [2:0] op;
  output [15:0] result;
  output cout, G, P, set, overflow, zero;

  wire g0, p0, g1, p1, g2, p2, g3, p3;
  wire C1, C2, C3;
  wire [3:0] zeroes;
  supply0 gnd;

  assign zero = zeroes[3] & zeroes[2] & zeroes[1] & zeroes[0];

  ALU4Bit alu1(a[3:0],   b[3:0],   cin, less, op, result[3:0],,   g0, p0,,,     zeroes[0]);
  ALU4Bit alu2(a[7:4],   b[7:4],   C1,  gnd,  op, result[7:4],,   g1, p1,,,     zeroes[1]);
  ALU4Bit alu3(a[11:8],  b[11:8],  C2,  gnd,  op, result[11:8],,  g2, p2,,,     zeroes[2]);
  ALU4Bit alu4(a[15:12], b[15:12], C3,  gnd,  op, result[15:12],, g3, p3, set,, zeroes[3]);

  OverflowDetection ovf(a[15], b[15], op, result[15], overflow);
  CLA cla(g0, p0, g1, p1, g2, p2, g3, p3, cin, C1, C2, C3, cout, G, P);
endmodule
