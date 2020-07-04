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

- Local Installtion. 
Invoke yosys shell by typing: ``yosys`` in your terminal. 

- Docker Installation.

### OpenSTA

### Iverilog



