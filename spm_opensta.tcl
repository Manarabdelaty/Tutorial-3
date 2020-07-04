read_liberty data/Tech/osu035/osu035_stdcells.lib 
read_verilog data/Netlists/spm.netlist.v
link_design top
create_clock -name clk -period 2 {clk}
set_input_delay -clock clk 0 {mc mp start}
set_output_delay -clock clk 0 {done prod}
report_checks
