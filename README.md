Для сенсора: Частота кадров 90 Гц, разрешение 1920х1200

Для интерфейса: Частота кадров 50Гц, разрешение 3840х2160
Тактовые для пикселей сенсора и интерфейса: pllsen - 225 МГц, pllint - 424.6 МГц

input logic clk_gen, // 50 МГц

input logic reset,

  output logic sync_line_sensor,           // сигнал синхронизации по строке СЕНСОРА
  
  output logic sync_frame_sensor,          // сигнал синхронизации по кадру СЕНСОРА
  
  output logic sync_line_interface,        // сигнал синхронизации по строке ИНТЕРФЕЙСА
  
  output logic sync_frame_interface        // сигнал синхронизации по кадру ИНТЕРФЕЙСА
