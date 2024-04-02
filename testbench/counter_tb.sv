
module counter_tb;

  // Parameters
  localparam N = 8;

  //Ports
  logic clk=0;
  logic reset=0;
  logic enable=0;
  logic [(N-1):0] modul;
  logic c_out;
  logic [(N-1):0] q_out;

  assign modul = 200;
  counter #(
      .N(N)
  ) counter_inst (
      .clk(clk),
      .reset(reset),
      .enable(enable),
      .modul(modul),
      .c_out(c_out),
      .q_out(q_out)
  );

  always #5  clk = ! clk ;
  always #50  enable = ! enable ;
  always #500  reset = ! reset ;

endmodule
