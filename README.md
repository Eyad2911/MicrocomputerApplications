# Microcomputer Applications

Vivado / Verilog coursework project targeting the Xilinx Artix-7 part `xc7a35tcpg236-1`. The original archive records Vivado 2018.2 (64-bit).

## Included in this repository

- Six RTL modules: ALU, adder, 2:1 mux, PC register, register file, and sign extension.
- Six corresponding Verilog testbenches.
- A project archive summary and project documentation.

## Project files not included in this upload

The original `.xpr` project file and generated Vivado/XSim cache, log, and waveform files from the ZIP have not been transferred. The RTL and testbenches are preserved in their original relative source folders.

To use the HDL in Vivado, create or open a project, select `xc7a35tcpg236-1`, add the files under `MicrocomputerApplications.srcs/sources_1/new/` as design sources, and add the files under `MicrocomputerApplications.srcs/sim_1/new/` as simulation sources.