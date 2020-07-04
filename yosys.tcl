yosys -import

# Usage: yosys_generic.tcl <RTL-verilog> <top-module> <liberty-file> <output-name>

# read verilog
read_verilog [lindex $argv 0]

# check hierarchy & set top module
hierarchy -check -top [lindex $argv 1]

# translate processes (always blocks)
procs; opt;

# detect and optimize FSM encodings
fsm; opt;

# implement memories (arrays)
memory; opt;

# convert to gate logic
techmap; opt;

# flatten
flatten; opt;

# mapping flip-flops to mycells.lib
dfflibmap -liberty [lindex $argv 2]

# mapping logic to mycells.lib
abc -liberty [lindex $argv 3]

# print gate count
stat

# cleanup
opt_clean -purge

write_verilog -noattr -noexpr [lindex $argv 4]

