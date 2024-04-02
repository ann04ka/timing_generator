`timescale 1ns / 1ns
module tb_tm  ; 

parameter sync_width_line_interface  = 8 ;
parameter active_line_interface  = 1200 ;
parameter total_line_interface  = 1252 ;
parameter front_porch_pix_interface  = 8 ;
parameter back_porch_pix_interface  = 40 ;
parameter front_porch_line_sensor  = 37 ;
parameter back_porch_line_sensor  = 6 ;
parameter bit_cnt_pix_sensor  = 12 ;
parameter blank_total_pix_sensor  = 80 ;
parameter back_porch_pix_sensor  = 40 ;
parameter front_porch_pix_sensor  = 8 ;
parameter blank_total_line_interface  = 52 ;
parameter bit_cnt_line_interface  = 12 ;
parameter front_porch_line_interface  = 38 ;
parameter back_porch_line_interface  = 6 ;
parameter blank_total_pix_interface  = 80 ;
parameter blank_total_line_sensor  = 51 ;
parameter bit_cnt_line_sensor  = 12 ;
parameter bit_cnt_pix_interface  = 12 ;
parameter sync_width_pix_interface  = 32 ;
parameter active_pix_interface  = 1920 ;
parameter total_pix_interface  = 2000 ;
parameter sync_width_line_sensor  = 8 ;
parameter total_line_sensor  = 2211 ;
parameter active_line_sensor  = 2160 ;
parameter total_pix_sensor  = 3920 ;
parameter active_pix_sensor  = 3840 ;
parameter sync_width_pix_sensor  = 32 ; 
  wire  /*logic*/  sync_line_interface   ; 
  wire  /*logic*/  sync_frame_sensor   ; 
  wire  /*logic*/  sync_line_sensor   ; 
  wire  /*logic*/  sync_frame_interface   ; 
  wire  [7:0] img1_light   ; 
  wire img_enable;
  reg    reset   ; 
  reg    clk_gen   ; 
  timing_generator    #(bit_cnt_pix_sensor, bit_cnt_line_sensor, bit_cnt_pix_interface, bit_cnt_line_interface)
   DUT  ( 
      .sync_line_sensor (sync_line_sensor ) ,
      .sync_frame_sensor (sync_frame_sensor ) ,
		.sync_line_interface (sync_line_interface ) ,
      .sync_frame_interface (sync_frame_interface ) ,
		.img_enable(img_enable),
		.img1_light(img1_light),
      .reset (reset ) ,
      .clk_gen (clk_gen )
		); 



// "Constant Pattern"
// Start Time = 0 ps, End Time = 1 ns, Period = 0 ps

  initial
  begin
  clk_gen = 0;
	#10 ;
	reset  = 1'b0  ;
	repeat (50000) begin
		#10 clk_gen = ~clk_gen;
	end
  end
//  initial
//	#10000 $stop;
endmodule
