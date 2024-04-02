`timescale 1ns / 1ns
module timing_generator_tb;

  // Parameters
  localparam int bit_cnt_pix_sensor = 12;
  localparam int bit_cnt_line_sensor = 12;
  localparam int bit_cnt_pix_interface = 12;
  localparam int bit_cnt_line_interface = 12;

  //Ports
  logic clk_gen = 0;
  logic reset;
  logic sync_line_sensor;
  logic sync_frame_sensor;
  logic sync_line_interface;
  logic sync_frame_interface;

  timing_generator #(
      .bit_cnt_pix_sensor(bit_cnt_pix_sensor),
      .bit_cnt_line_sensor(bit_cnt_line_sensor),
      .bit_cnt_pix_interface(bit_cnt_pix_interface),
      .bit_cnt_line_interface(bit_cnt_line_interface)
  ) timing_generator_inst (
      .clk_gen(clk_gen),
      .reset(reset),
      .sync_line_sensor(sync_line_sensor),
      .sync_frame_sensor(sync_frame_sensor),
      .sync_line_interface(sync_line_interface),
      .sync_frame_interface(sync_frame_interface)
  );

  always #1000 clk_gen = !clk_gen;
   assign #400 reset = 1;
//   assign #600 reset = 0;
//  initial begin
//    reset = 1;
//    #10;
//    reset = 0;
//  end
endmodule
