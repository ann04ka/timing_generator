view wave 
wave clipboard store
wave create -pattern none -portmode input -language vlog /timing_generator/clk_gen 
wave create -pattern none -portmode input -language vlog /timing_generator/reset 
wave create -pattern none -portmode output -language vlog /timing_generator/sync_line_sensor 
wave create -pattern none -portmode output -language vlog /timing_generator/sync_frame_sensor 
wave create -pattern none -portmode output -language vlog /timing_generator/sync_line_interface 
wave create -pattern none -portmode output -language vlog /timing_generator/sync_frame_interface 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/timing_generator/reset 
{wave export -file C:/intelFPGA_lite/20.1/lab_2_0/lab_2_0/simulation/modelsim/tb_tm -starttime 0 -endtime 5000 -format vlog -designunit timing_generator} 
WaveCollapseAll -1
wave clipboard restore
