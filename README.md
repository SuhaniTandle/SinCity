#  Overview

This project implements a **CORDIC (COordinate Rotation DIgital Computer)** algorithm 
in **Verilog HDL**, synthesized using **Xilinx Vivado**.

---

##  Features
- Fully synthesizable CORDIC engine in Verilog  
- Uses iterative rotation mode for sine and cosine computation  
- Implements datapath with: **barrel shifter** and **adder/subtractor** modules, precomputed **atan lookup table**
- Operates on Q2.14 fixed-point format  
- Parameterizable iteration depth (default = 12)  
- Provides cos(θ) and sin(θ) outputs for any input angle θ
- Contains simulated ROM storing precomputed cosine values (sacred constants)

---

##  Mathematical Principle

CORDIC uses iterative rotations:  
x_{i+1} = x_i - d_i (y_i >> i)  
y_{i+1} = y_i + d_i (x_i >> i)  
z_{i+1​} ​= z_i ​− d_i (​atan(2^−i))​


---

## Implementation modules

| Module                 | Description                                                            |
| ---------------------- | ---------------------------------------------------------------------- |
| **barrel_shifter.v**   | Performs arithmetic right-shifts (divide by 2ⁱ) with sign extension    |
| **adder_subtractor.v** | Performs signed addition/subtraction with overflow and carry detection |
| **cordic.v**           | Integrates shifter + adder + LUT into an iterative CORDIC engine       |
| **cordic_tb.v**        | Testbench that compares computed sine/cosine with math library values  |
