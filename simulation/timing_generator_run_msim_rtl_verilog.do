transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/intelFPGA_lite/20.1/lab_2_0/lab_2_0/source {C:/intelFPGA_lite/20.1/lab_2_0/lab_2_0/source/timing_generator.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/20.1/lab_2_0/lab_2_0/source {C:/intelFPGA_lite/20.1/lab_2_0/lab_2_0/source/counter.sv}

