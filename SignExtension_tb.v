module SignExtension_tb();
  reg [15:0] a;
  wire [31:0] result;

  SignExtension se(a, result);

  initial begin
    $monitor("    %b => %b", a, result);

    $display("Test sign extension with MSB 1");
    a <= 'b 1000_0000_0000_0000;
    #1;

    $display("Test zero extension with MSB 0");
    a <= 'b 0111_1111_1111_1111;
    #1;
  end
endmodule
