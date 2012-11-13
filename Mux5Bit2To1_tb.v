module Mux5Bit2To1_tb();
  reg [4:0] a, b;
  reg op;
  wire [4:0] result;

  Mux5Bit2To1 mux(a, b, op, result);

  initial begin
    $monitor("    %b [%b] %b = %b", a, op, b, result);

    a <= 'b 01010; b <= 'b 11011;

    $display("Test mux with op 0");
    op <= 0;
    #1;

    $display("Test mux with op 1");
    op <= 1;
    #1;
  end
endmodule
