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

add wave -position end  sim:/counter_tb/N
add wave -noupdate -divider input_signal
add wave -position end -color orchid sim:/counter_tb/clk
add wave -position end  sim:/counter_tb/reset
add wave -position end  sim:/counter_tb/enable
add wave -position end -unsigned -color yellow sim:/counter_tb/modul

add wave -noupdate -divider internal_signal
add wave -position end -unsigned -color yellow sim:/counter_tb/counter_inst/q_in

add wave -noupdate -divider output_signal
add wave -position end  sim:/counter_tb/c_out
add wave -position end -unsigned -color yellow sim:/counter_tb/q_out



run -all



