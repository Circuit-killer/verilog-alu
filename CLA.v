`timescale 1ns / 1ps

module CLA(g0, p0, g1, p1, g2, p2, g3, p3, cin, C1, C2, C3, C4, G, P);
  input g0, p0, g1, p1, g2, p2, g3, p3;
  input cin;
  output C1, C2, C3, C4;
  output G, P;

  assign P = p0 & p1 & p2 & p3;
  assign G = g3 | g2 & p3 | g1 & p2 & p3 | g0 & p1 & p2 & p3;

  // C_{i+1} = g_i + C_i*P_i
  assign C1 = g0 | cin & p0;
  assign C2 = g1 | C1 & p1;
  assign C3 = g2 | C2 & p2;
  assign C4 = g3 | C3 & p3;
endmodule
