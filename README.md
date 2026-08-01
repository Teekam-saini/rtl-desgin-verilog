# RTL Design Verilog

This repository contains digital design modules implemented in Verilog for learning, experimentation, and simulation purposes. It includes basic logic gates, flip-flops, multiplexers, and top-level modules.

---

## Folder Structure

- `rtl/` - Verilog RTL modules
  - `gates/` - Basic logic gates (AND, OR, MUX, etc.)
  - `flip_flops/` - Flip-flop modules (D-FF, D-FF with enable, async reset)
- `tb/` - Testbenches for verifying RTL modules
- `sim/` - Simulation output files (`.vcd`)
- `docs/` - Documentation, block diagrams, or notes

---

## How to Simulate

### Example: AND Gate

```bash
# Compile RTL and Testbench
iverilog -o sim/and_gate.vvp rtl/gates/and_gate.v tb/tb_and_gate.v

# Run simulation
vvp sim/and_gate_tb.vvp

# Optional: view waveform
gtkwave sim/and_gate.vcd
