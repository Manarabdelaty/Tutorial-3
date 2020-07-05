# Read Liberty file
read_liberty data/Tech/nangate/NangateOpenCellLibrary_typical.lib
# Read Design
read_verilog data/Netlists/spm.netlist.v
# Set top module
link_design top
# set clock period
create_clock -name clk -period 1.55 {clk}
# set input delay
set_input_delay -clock clk 0.1 {mc mp start}
# set output delay
set_output_delay -clock clk 0.1 {done prod}
# set load capactiance
set_load 1.7 {done prod}
# generate timing reports 
report_checks
