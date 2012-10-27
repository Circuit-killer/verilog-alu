module ALU4Bit(a, b, cin, less, op, result, cout, G, P, set, overflow, zero);
  input [3:0] a, b;
  input cin, less;
  input [2:0] op;
  output [3:0] result;
  output cout, G, P, set, overflow, zero;

  wire g0, p0, g1, p1, g2, p2, g3, p3;
  wire C1, C2, C3;
  supply0 low;

  assign zero = ~result[3] & ~result[2] & ~result[1] & ~result[0];

  ALU1Bit alu1(a[0], b[0], cin, less, op, result[0],, g0, p0,);
  ALU1Bit alu2(a[1], b[1], C1,  low,  op, result[1],, g1, p1,);
  ALU1Bit alu3(a[2], b[2], C2,  low,  op, result[2],, g2, p2,);
  ALU1Bit alu4(a[3], b[3], C3,  low,  op, result[3],, g3, p3, set);

  OverflowDetection ovf(a[3], b[3], op, result[3], overflow);
  CLA cla(g0, p0, g1, p1, g2, p2, g3, p3, cin, C1, C2, C3, cout, G, P);
endmodule
