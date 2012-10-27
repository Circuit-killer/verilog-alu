module CLA_tb();
  reg g0, p0, g1, p1, g2, p2, g3, p3;
  reg cin;
  wire C1, C2, C3, C4;
  wire G, P;

  CLA cla(g0, p0, g1, p1, g2, p2, g3, p3, cin, C1, C2, C3, C4, G, P);

  initial begin
    $monitor("    P: %b   G: %b   C: %b", P, G, C4);

    $display("Test 1 (from exam)");
    g0 <= 0; g1 <= 1; g2 <= 1; g3 <= 0;
    p0 <= 1; p1 <= 1; p2 <= 1; p3 <= 1;
    cin <= 0;
    #1;

    $display("Test 2 (from exam)");
    g0 <= 0; g1 <= 0; g2 <= 1; g3 <= 0;
    p0 <= 1; p1 <= 1; p2 <= 1; p3 <= 0;
    cin <= 0;
    #1;

    $display("Test 3 (from notes)");
    g0 <= 1; g1 <= 0; g2 <= 0; g3 <= 0;
    p0 <= 0; p1 <= 1; p2 <= 1; p3 <= 1;
    cin <= 0;
    #1;

    $finish;
  end
endmodule
