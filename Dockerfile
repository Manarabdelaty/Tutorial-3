FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y apt-utils

# Install Yosys
RUN apt-get install -y yosys

# Install IcarusVerilog 10.2+
RUN mkdir -p /share/iverilog
WORKDIR /share/iverilog
RUN curl -sL https://github.com/FPGAwars/toolchain-iverilog/releases/download/v1.2.1/toolchain-iverilog-linux_x86_64-1.2.1.tar.gz | tar -xzf -
