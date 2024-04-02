module timing_generator #(
    parameter int bit_cnt_pix_sensor = 12,
    parameter int bit_cnt_line_sensor = 12,
    parameter int bit_cnt_pix_interface = 12,
    parameter int bit_cnt_line_interface = 12
) (  // часть где объявляются входные/выходные сигналы.
     // Формат данных logic являтеся эквавилентом REG и WIRE в verilog
    input logic clk_gen,
    input logic reset,
    output logic sync_line_sensor,           // сигнал синхронизации по строке СЕНСОРА
    output logic sync_frame_sensor,          // сигнал синхронизации по кадру СЕНСОРА
    output logic sync_line_interface,        // сигнал синхронизации по строке ИНТЕРФЕЙСА
    output logic sync_frame_interface,        // сигнал синхронизации по кадру ИНТЕРФЕЙСА
	 output logic img_enable,
	 output logic img1_light
	 );
  // объявление внутренних сигналов  / параметров
  // !!!!!!!!!!! нужно прописать свои параметра - количество ПИКСЕЛЕЙ и СТРОК !!!!!!!!!!!!!!!!
  localparam int total_pix_sensor       = 3920; // общее количество пикселей в строке для СЕНСОРА
    localparam int active_pix_sensor      = 3840; // активное количество пикселей для СЕНСОРА
    localparam int back_porch_pix_sensor  = 40; // задний участок пикселей гашения для СЕНСОРА
    localparam int sync_width_pix_sensor  = 32; // длительность синхроимпульса в пикселях для СЕНСОРА
    localparam int front_porch_pix_sensor = 8; // передний участок пикселей гашения для СЕНСОРА
    localparam int blank_total_pix_sensor = 80; // общее количество пикселей гашения для СЕНСОРА
    localparam int total_line_sensor        = 2211; // общее количество строк в строке для СЕНСОРА
    localparam int active_line_sensor       = 2160; // активное количество строк для СЕНСОРА
    localparam int back_porch_line_sensor   = 6; // задний участок строк гашения для СЕНСОРА
    localparam int sync_width_line_sensor   = 8; // длительность синхроимпульса в пикселях для СЕНСОРА
    localparam int front_porch_line_sensor  = 37; // передний участок строк гашения для СЕНСОРА
    localparam int blank_total_line_sensor  = 51; // общее количество строк гашения для СЕНСОРА
    localparam int total_pix_interface        = 2000; // общее количество пикселей в строке для ИНТЕРФЕЙСА
    localparam int active_pix_interface       = 1920; // активное количество пикселей для ИНТЕРФЕЙСА
    localparam int back_porch_pix_interface   = 40; // задний участок пикселей гашения для ИНТЕРФЕЙСА
    localparam int sync_width_pix_interface   = 32; // длительность синхроимпульса в пикселях для ИНТЕРФЕЙСА
    localparam int front_porch_pix_interface  = 8; // передний участок пикселей гашения для ИНТЕРФЕЙСА
    localparam int blank_total_pix_interface  = 80; // общее количество пикселей гашения для ИНТЕРФЕЙСА
    localparam int total_line_interface       = 1252; // общее количество строк в строке для ИНТЕРФЕЙСА
    localparam int active_line_interface      = 1200; // активное количество строк для ИНТЕРФЕЙСА
    localparam int back_porch_line_interface  = 6; // задний участок строк гашения для ИНТЕРФЕЙСА
    localparam int sync_width_line_interface  = 8; // длительность синхроимпульса в пикселях для ИНТЕРФЕЙСА
    localparam int front_porch_line_interface = 38; // передний участок строк гашения для ИНТЕРФЕЙСА
    localparam int blank_total_line_interface = 52; // общее количество строк гашения для ИНТЕРФЕЙСА
  ////////////////////////////////////////////////////
  logic enable;
  // сигналы счетчиков сенсора
  logic clk_sensor;
  logic [(bit_cnt_pix_sensor-1):0] cnt_pix_sensor;
  logic cnt_pix_sensor_end;
  logic [(bit_cnt_line_sensor-1):0] cnt_line_sensor;
  logic cnt_line_sensor_end;
  // сигналы счетчиков сенсора
  logic clk_interface;
  logic [(bit_cnt_pix_interface-1):0] cnt_pix_interface;
  logic cnt_pix_interface_end;
  logic [(bit_cnt_line_interface-1):0] cnt_line_interface;
  logic cnt_line_interface_end;
  // сигналы синхронизации, гашения и актиных частей кадра
  logic h_active_sensor;
  logic h_blank_sensor;
  logic h_sync_sensor;
  logic v_active_sensor;
  logic v_blank_sensor;
  logic v_sync_sensor;
  logic h_active_interface;
  logic h_blank_interface;
  logic h_sync_interface;
  logic v_active_interface;
  logic v_blank_interface;
  logic v_sync_interface;
  logic light;
//  logic img_enable;
  // начало основного блока
  assign enable = reset;
//  reset <= ~reset;
  ////////////////////////////////////////////////////////////
  //  установка PLL
  intpll intpll(
		.areset(reset),
      .inclk0(clk_gen), 
      .c0(clk_interface), // частота интерфкйса 
      .locked(locked)   
  );
   pllsen senpll(
		.areset(reset),
      .inclk0(clk_gen), 
      .c0(clk_sensor), // частота сенсера
      .locked(locked)   
  );
  ////////////////////////////////////////////////////////////
  //  формирования сигналов для сенсора
  ////////////////////////////////////////////////////////////
  //  счетчик пикселей
  counter #(
      .N(bit_cnt_pix_sensor)
  ) cnt_pix_sensor_q (
      .clk(clk_sensor),  // тактовый сигнал
      .reset(reset),  // сигнал сброса.
      .enable(enable),  // сигнал разрешения работы
      .modul(total_pix_sensor), // модуль пересчета 
      .q_out(cnt_pix_sensor),  // выходная шина счетчика
      .c_out(cnt_pix_sensor_end)    // сигнал переплнения
  );
  //  подсчет строк
counter #(
      .N(bit_cnt_line_sensor) // разрядность счетчика.  Заменить bit_cnt_pix_sensor на необходимую разрядность
  ) cnt_line_sensor_q(
      .clk(cnt_pix_sensor_end),  // тактовый сигнал
      .reset(reset),  // сигнал сброса
      .enable(enable),  // сигнал разрешения работ
      .modul(total_line_sensor), // модуль пересчета 
      .q_out(cnt_line_sensor),  // выходная шина счетчика
      .c_out(cnt_line_sensor_end)    // сигнал переплнения
  );
  ////////////////////////////////////////////////////////////
  // формирвоание сигналов тайминг генератора сенсора
  ////////////////////////////////////////////////////////////
  always_ff @(posedge clk_sensor, posedge reset)
   begin 
		if (reset) begin
        h_active_sensor <= 0; 
        h_sync_sensor <= 1;
        h_blank_sensor <= 0;
    end else
    if (cnt_pix_sensor < sync_width_pix_sensor)  begin     
        h_active_sensor <= 0; 
        h_sync_sensor <= 1;
        h_blank_sensor <= 0;   
    end else if(cnt_pix_sensor >= sync_width_pix_sensor && cnt_pix_sensor < sync_width_pix_sensor + back_porch_pix_sensor) begin
        h_active_sensor <= 0; 
        h_sync_sensor <= 0;
        h_blank_sensor <= 1;   
    end else if(cnt_pix_sensor >= sync_width_pix_sensor + back_porch_pix_sensor && cnt_pix_sensor < total_pix_sensor - front_porch_pix_sensor) begin
        h_active_sensor <= 1; 
        h_sync_sensor <= 0;
        h_blank_sensor <= 0;   
    end else if(cnt_pix_sensor >= total_pix_sensor - front_porch_pix_sensor && cnt_pix_sensor < total_pix_sensor) begin
        h_active_sensor <= 0; 
        h_sync_sensor <= 0;
        h_blank_sensor <= 1;  
    end
	end
	always_ff @(posedge clk_sensor, posedge reset) begin
	if (reset) begin
        v_active_sensor <= 0; 
        v_sync_sensor <= 1;
        v_blank_sensor <= 0;
    end else
    if (cnt_line_sensor < sync_width_line_sensor)  begin
        v_active_sensor <= 0; 
        v_sync_sensor <= 1;
        v_blank_sensor <= 0;
    end else if(cnt_line_sensor >= sync_width_line_sensor && cnt_line_sensor < sync_width_line_sensor + back_porch_line_sensor) begin
        v_active_sensor <= 0; 
        v_sync_sensor <= 0;
        v_blank_sensor <= 1;
    end else if(cnt_line_sensor >= sync_width_line_sensor + back_porch_line_sensor && cnt_line_sensor < total_line_sensor - front_porch_line_sensor) begin
        v_active_sensor <= 1; 
        v_sync_sensor <= 0;
        v_blank_sensor <= 0;
    end else if(cnt_line_sensor >= total_line_sensor - front_porch_line_sensor && cnt_line_sensor < total_line_sensor) begin
        v_active_sensor <= 0; 
        v_sync_sensor <= 0;
        v_blank_sensor <= 1;
    end
	end
 counter #(
      .N(bit_cnt_pix_interface)
  ) cnt_pix_interface_q (
      .clk(clk_interface),  // тактовый сигнал
      .reset(reset),  // сигнал сброса.
      .enable(enable),  // сигнал разрешения работы
      .modul(total_pix_interface), // модуль пересчета 
      .q_out(cnt_pix_interface),  // выходная шина счетчика
      .c_out(cnt_pix_interface_end)    // сигнал переплнения
  );
  //  подсчет строк
counter #(
      .N(bit_cnt_line_interface) // разрядность счетчика.  Заменить bit_cnt_pix_sensor на необходимую разрядность
  ) cnt_line_interface_q(
      .clk(cnt_pix_interface_end),  // тактовый сигнал
      .reset(reset),  // сигнал сброса
      .enable(enable),  // сигнал разрешения работ
      .modul(total_line_interface), // модуль пересчета 
      .q_out(cnt_line_interface),  // выходная шина счетчика
      .c_out(cnt_line_interface_end)    // сигнал переплнения
  );
  ////////////////////////////////////////////////////////////
  // формирвоание сигналов тайминг генератора interface
  ////////////////////////////////////////////////////////////
  always_ff @(posedge clk_interface, posedge reset)
   begin 
		if (reset) begin
        h_active_interface <= 0; 
        h_sync_interface <= 1;
        h_blank_interface <= 0;
    end else
    if (cnt_pix_interface < sync_width_pix_interface)  begin     
        h_active_interface <= 0; 
        h_sync_interface <= 1;
        h_blank_interface <= 0;   
    end else if(cnt_pix_interface >= sync_width_pix_interface && cnt_pix_interface < sync_width_pix_interface + back_porch_pix_interface) begin
        h_active_interface <= 0; 
        h_sync_interface <= 0;
        h_blank_interface <= 1;   
    end else if(cnt_pix_interface >= sync_width_pix_interface + back_porch_pix_interface && cnt_pix_interface < total_pix_interface - front_porch_pix_interface) begin
        h_active_interface <= 1; 
        h_sync_interface <= 0;
        h_blank_interface <= 0;   
    end else if(cnt_pix_interface >= total_pix_interface - front_porch_pix_interface && cnt_pix_interface < total_pix_interface) begin
        h_active_interface <= 0; 
        h_sync_interface <= 0;
        h_blank_interface <= 1;  
    end
	end
	always_ff @(posedge clk_interface, posedge reset) begin
	if (reset) begin
        v_active_interface <= 0; 
        v_sync_interface <= 1;
        v_blank_interface <= 0;
    end else
    if (cnt_line_interface < sync_width_line_interface)  begin
        v_active_interface <= 0; 
        v_sync_interface <= 1;
        v_blank_interface <= 0;
    end else if(cnt_line_interface >= sync_width_line_interface && cnt_line_interface < sync_width_line_interface + back_porch_line_interface) begin
        v_active_interface <= 0; 
        v_sync_interface <= 0;
        v_blank_interface <= 1;
    end else if(cnt_line_interface >= sync_width_line_interface + back_porch_line_interface && cnt_line_interface < total_line_interface - front_porch_line_interface) begin
        v_active_interface <= 1; 
        v_sync_interface <= 0;
        v_blank_interface <= 0;
    end else if(cnt_line_interface >= total_line_interface - front_porch_line_interface && cnt_line_interface < total_line_interface) begin
        v_active_interface <= 0; 
        v_sync_interface <= 0;
        v_blank_interface <= 1;
    end
	end
img1 #(.N(bit_cnt_line_interface))
	image1 (
	.clk(clk_interface),
   .reset(reset),
   .enable(enable),
   .H(active_line_interface),
   .W(active_pix_interface),
   .light(light)
	);
//img2 #(.N(bit_cnt_line_interface))
//	image2 (
//	.clk(clk_interface),
//   .reset(reset),
//   .enable(img_enable),
//   .H(active_line_interface),
//   .W(active_pix_interface),
//   .light(light)
//	);
  ////////////////////////////////////////////////////////////-
  // формирвоание выходных сигналов. Для этого на сигналы OUT port  подать нужные сигналы.
  ////////////////////////////////////////////////////////////-
  assign sync_line_sensor     = h_sync_sensor;
  assign sync_frame_sensor    = v_sync_sensor;
  assign sync_line_interface  = h_sync_interface;
  assign sync_frame_interface = v_sync_interface;   
  assign img_enable = v_active_interface&h_active_interface;
  assign img1_light = light;
  ////////////////////////////////////////////////////////////-
endmodule
