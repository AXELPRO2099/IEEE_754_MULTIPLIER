# IEEE 754 Floating-Point Multiplier

## Overview

This repository contains a Verilog implementation of a single-precision (32-bit) floating-point multiplier compliant with the IEEE 754 standard. The design performs multiplication operations on 32-bit floating-point numbers.

## Features

- Fully compliant with IEEE 754 single-precision format
- Handles all special cases:
  - Normalized numbers
  - Denormalized numbers
  - Zero values (signed zeros)
  - Infinity operations
  - NaN (Not a Number) propagation
- Proper rounding (round to nearest even)
- Synthesizable Verilog code
- Optimized 24-bit mantissa multiplication (23-bit + hidden bit)

## Files

- `top.v`: Main module implementing the floating-point multiplier
- `tb.v`: Comprehensive testbench for functional verification

### Simulation

1. Open the project in Vivado
2. Add both `top.v` and `tb.v` to your project
3. Run behavioral simulation to verify functionality

### Synthesis

1. Set `top.v` as the top module
2. Run synthesis and implementation for your target FPGA/ASIC

## Implementation Details

The multiplier architecture includes:

1. Sign bit calculation (XOR operation)
2. Exponent addition with bias adjustment
3. 24-bit mantissa multiplication (including hidden bit)
4. Result normalization
5. Rounding logic
6. Special case handling:
   - Multiplication by zero
   - Infinity operations
   - NaN propagation
   - Overflow/underflow detection

## Testing

The testbench (`tb.v`) includes comprehensive test cases for:

- Normal number multiplication
- Operations with ±0
- Overflow/underflow scenarios
- NaN propagation
- Infinity arithmetic
- Denormal number handling
- Rounding verification

## Performance

The design is optimized for:
- Area efficiency (mantissa multiplier implementation)
- Correct IEEE 754 compliance
- Full range of single-precision operations

## Acknowledgments

- IEEE 754 Floating-Point Arithmetic Standard
- Vivado Design Suite for simulation and synthesis
