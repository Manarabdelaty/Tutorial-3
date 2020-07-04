# Tutorial-3 

A simple tutorial on how to use Yosys and OpenSTA prepared for digital design 2 course at AUC (Summer 2020). 

## Dependecies
- Yosys
- OpenSTA
- Icarus Verilog
- GTKWave

## Installing 

If you are working on Ubuntu/macOS, it is easier to install the tools locally on your machine. If you want to avoid the hassle, you could use the docker image. 

### macOS

Use Homebrew. 

``
  brew install Yosys
``

### Ubuntu

Use apt. 

``
sudo apt-get install yosys
``

### Both

If you want to install openSTA locally check the instructions provided at OpenSTA. But, again, it is recommended to install it using docker to avoid the dependencies. 

First, you need to have docker installed. Check Docker's website.

Then, run the following command

``
docker run -it -v $(pwd):/data openroad/opensta
``

This will pull opensta docker image if it doesn't exist locally on your machine. 

## Usage

### Yosys

 Invoke yosys shell by typing: ``yosys`` in your terminal. 
 Run tcl synthesis script by using `tcl` command. 
 `` 
    tcl <filename>
 ``

### OpenSTA

### Iverilog

`` iverilog <testbench> <netlist> -o <vvpfile> [-Tmin/typ/max] [-gspecify]``

- `-Tmin/typ/max` flag: select min, typ or max times from min:typ:max expressions.
- `-gspecify` flag: Iveirlog by defualt performs zero delay simulations. In order to account for the delays specified in the cell models file, we need to use this flag to enable specify block support. 


## Tutorial

1. Run Yosys synthesis script for the SPM multiplier. Invoke yosys shell first ``yosys``. Then run the tcl script to generate the synthesized netlist,
```
  tcl yosys.tcl
```
This step will generate the SPM's synthesized netlist inside the Netlists folder. 

2. Run the gate level simulations using iverilog, 

```
iverilog RTL/SPM/top_tb.v Netlists/spm.netlist.v -o spm.vvp -Ttyp -gspecify
```
Then, run vvp.

```
  vvp spm.vvp
```

To view the waveform, use GTKWave. 
```
  gtkwave spm.vcd
```

3. 
