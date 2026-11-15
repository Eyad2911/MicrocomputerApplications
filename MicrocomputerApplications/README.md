# MicrocomputerApplications

This folder contains the Verilog RTL design modules and simulation testbenches from the Microcomputer Applications project.

## RTL modules

| File | Module |
|---|---|
| `sources_1/new/pc_reg.v` | Program counter register |
| `sources_1/new/adder.v` | 32-bit adder |
| `sources_1/new/mux2.v` | Parameterized 2:1 multiplexer |
| `sources_1/new/signextension.v` | Sign/zero extension |
| `sources_1/new/registerfile.v` | 32-register file |
| `sources_1/new/alu.v` | 32-bit ALU |

The corresponding testbenches are under `MicrocomputerApplications.srcs/sim_1/new/`.

Target part: `xc7a35tcpg236-1`. The archive records Vivado 2018.2 (64-bit).

The original `.xpr` file and generated cache/log/waveform artefacts are not included in this repository upload.