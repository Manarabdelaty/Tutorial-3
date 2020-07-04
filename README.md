# Tutorial-3 

A simple tutorial on how to use Yosys and OpenSTA prepared for digital design 2 course at AUC (Summer 2020). 

## Dependecies
- Yosys
- OpenSTA
- Icarus Verilog
- GTKWave
- Tcl

## Installing 

If you are working on Ubuntu/macOS, it is easier to install the tools locally on your machine with the exception of OpenSTA. If you want to avoid the hassle, you could use the docker image. 

### macOS

Use Homebrew. 

``
  brew install Yosys tcl-tk	
``

### Ubuntu

Use apt. 

``
sudo apt-get install yosys tcl-dev
``

### Both

If you want to install openSTA locally check the instructions provided at [OpenSTA](https://github.com/The-OpenROAD-Project/OpenSTA). But, again, it is recommended to install it using docker to avoid the dependencies. 

First, you need to have docker installed. Check [Docker's website](https://docs.docker.com/get-docker/).

Then, run the following command

``
docker pull openroad/opensta
``

This will pull opensta docker image if it doesn't exist locally on your machine. 

## Usage

### Yosys

 Invoke yosys shell by typing: ``yosys`` in your terminal.
 
 Run tcl synthesis script by using `tcl` command. 
 `` 
    tcl <filename>
 ``
 
Check [Yosys command reference](http://www.clifford.at/yosys/documentation.html)

### Iverilog

`` iverilog <testbench> <netlist> -o <vvpfile> [-Tmin/typ/max] [-gspecify]``

To run the gate level netlist simulation, we will use these two flags :

- `-Tmin/typ/max` flag: select min, typ or max times from min:typ:max expressions.
- `-gspecify` flag: Iveirlog by defualt performs zero delay simulations. In order to account for the delays specified in the cell models file, we need to use this flag to enable specify block support. 

Check [Iverilog flags](https://linux.die.net/man/1/iverilog)

### OpenSTA

First run OpenSTA using docker, 

``
docker run -it -v $(pwd):/data openroad/opensta
``

Using `-v <host-folder>:<docker-folder>` option mounts the current directory to `data` directory inside the docker container.

## Tutorial

First, clone this repo ``git clone https://github.com/Manarabdelaty/Tutorial-3.git`` , then navigate to the ``Tutorial-3`` folder by `` cd Tutorial-3``

1. Run Yosys synthesis script for the SPM multiplier. Invoke yosys shell first ``yosys``. Then run the tcl script to generate the synthesized netlist,

``
  tcl spm.tcl
``
This step will generate the SPM's synthesized netlist inside the Netlists folder. 

2. Run the gate level simulations using iverilog, 

``
iverilog RTL/SPM/top_tb.v Netlists/spm.netlist.v -o spm.vvp -Ttyp -gspecify
``

Then, run vvp.

``
  vvp spm.vvp
``

To view the waveform, use GTKWave. 
``
  gtkwave spm.vcd
``

3. Run OpenSTA,

``
docker run -it -v $(pwd):/data openroad/opensta
``

Read liberty file, 
``
read_liberty data/Tech/osu035/osu035_stdcells.lib 
``

Read synthesized netlist,

``
read_verilog data/Netlists/spm.netlist.v
``

Set top module, 

``
link_design top
``

Set the clock period,

``
create_clock -name clk -period 10 {clk}
``

Set input delays reltive to the clock,

``
set_input_delay -clock clk 0 {mc mp start}
``

Generate timing report,

``
report_checks
``
