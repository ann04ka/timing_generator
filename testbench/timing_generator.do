# -------------------------------------------------------------------------------
#   создание  кнопок с фиксированным временем симуляции
_add_menu main controls right SystemButtonFace black RUN_1uS   {run 1000000000}
_add_menu main controls right SystemButtonFace blue RUN_10uS   {run 10000000000}
_add_menu main controls right SystemButtonFace red  RUN_100uS  {run 100000000000}
_add_menu main controls right SystemButtonFace green RUN_1mS   {run 1000000000000}
_add_menu main controls right SystemButtonFace magenta  RUN_10mS   {run 10000000000000}
_add_menu main controls right SystemButtonFace yellow  RUN_100mS   {run 100000000000000}
# -------------------------------------------------------------------------------
#   возможные вариантов цветов
#   для  счетчиков             -color cyan
#   для  тактовых сигналов     -color orchid
#   для  логических сигнлов    -color red
#   для  шин данных            -color yellow
# -------------------------------------------------------------------------------
# для задания формата данных по умолчанию 
# -binary
# -decimal
# -unsigned
# -hexadecimal
# -ascii
# -time
# -float32
# -float64
# -------------------------------------------------------------------------------
# добавление разделителей для лучшего восприятия временных диаграмм

add wave -position end -color orchid sim:/timing_generator_tb/timing_generator_inst/clk_gen

add wave -noupdate -divider счетчики_для_сенсора

add wave -position end -color orchid sim:/timing_generator_tb/timing_generator_inst/clk_sensor
add wave -position end -unsigned -color cyan sim:/timing_generator_tb/timing_generator_inst/cnt_pix_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/cnt_pix_sensor_end
add wave -position end -unsigned -color cyan sim:/timing_generator_tb/timing_generator_inst/cnt_line_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/cnt_line_sensor_end

add wave -noupdate -divider счетчики_для_интерфейса
add wave -position end -color orchid sim:/timing_generator_tb/timing_generator_inst/clk_interface
add wave -position end -unsigned -color cyan sim:/timing_generator_tb/timing_generator_inst/cnt_pix_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/cnt_pix_interface_end
add wave -position end -unsigned -color cyan sim:/timing_generator_tb/timing_generator_inst/cnt_line_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/cnt_line_interface_end



add wave -noupdate -divider синхронизация_для_сенсора
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/h_active_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/h_blank_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/h_sync_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/v_active_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/v_blank_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/v_sync_sensor

add wave -noupdate -divider синхронизация_для_интерфейса
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/h_active_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/h_blank_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/h_sync_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/v_active_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/v_blank_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/v_sync_interface


add wave -noupdate -divider output_signal
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/sync_line_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/sync_frame_sensor
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/sync_line_interface
add wave -position end  sim:/timing_generator_tb/timing_generator_inst/sync_frame_interface
# run -all



