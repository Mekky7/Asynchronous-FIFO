vlib work
vlog -f src_files.list
vsim -voptargs="+acc" work.TB
add wave -position insertpoint sim:/TB/*
run -all



 