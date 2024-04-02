module horizontal_pix #( 
	parameter int N=12
)  (
	 input logic clk,
	 input logic [(N-1):0] sync_width_pix,
    input logic [(N-1):0] back_porch_pix,
	 input logic [(N-1):0] front_porch_pix,
    input logic [(N-1):0] active_pix,
	 
	 output logic h_active_sensor,
    output logic h_blank_sensor,
    output logic h_sync_sensor);
	 
	 counter #(
      .N(N)
  ) cnt_pix_sensor_q (
      
      .clk(clk),  // тактовый сигнал
      .reset(reset),  // сигнал сброса.
      .enable(enable),  // сигнал разрешения работы блока. Если 1 - то работает ВСЕ
      .modul(total_pix_sensor), // модуль пересчета - т.е. до какого числа будет вестись сч
      .q_out(cnt_pix_sensor),  // выходная шина счетчика
      .c_out(cnt_pix_sensor_end)    // сигнал переплнения, когда выходная шина = модулю
  );
	 
	 
	 
