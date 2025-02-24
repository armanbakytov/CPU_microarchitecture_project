# Digital Design Project

A complete digital design project implementing a simple CPU microarchitecture as part of the Digital Design lab assignment. This project uses SystemVerilog for design, Icarus Verilog for simulation, and GTKWave for waveform visualization.

## Overview

This project consists of several interconnected modules that together form a basic CPU. Each unit is responsible for a specific function, allowing for modular design and easy testing.

## Unit Descriptions

1. **Arithmetic Logic Unit (ALU)**
   - **Function:** Performs arithmetic and logical operations.
   - **Operations:**
     - **AND (00):** Computes bitwise AND of two 8-bit inputs.
     - **OR (01):** Computes bitwise OR of two 8-bit inputs.
     - **Addition (10):** Adds two 8-bit numbers.
     - **Subtraction (11):** Subtracts the second 8-bit number from the first.
   - **Output:** Produces an 8-bit result along with a Zero flag (set when the result is zero).

2. **Register File**
   - **Function:** Provides storage for 16 8-bit registers.
   - **Features:**
     - The register at address 0 is permanently set to 0.
     - Supports simultaneous reading from two registers.
     - Data can be written into registers (except register 0) on a clock edge when write_enable is asserted.
     - Continuously outputs the contents of register 15 as `cpu_out`.

3. **Combined ALU and Register File (reg_file_alu)**
   - **Function:** Integrates the ALU and register file into a single module.
   - **Features:**
     - Incorporates a 2-to-1 multiplexer that selects between the second register output and an external immediate value as the ALU’s second operand.
     - Enables operations using either data stored in the register file or an immediate constant.

4. **Instruction Memory (ROM)**
   - **Function:** Stores the machine code program.
   - **Features:**
     - Contains 256 words, each 24 bits wide.
     - Loads machine code from a text file (`program.txt`) using the `$readmemh` system task.
     - Outputs instructions asynchronously based on the provided program counter (PC) address.

5. **Program Counter (PC)**
   - **Function:** Generates the address for the next instruction.
   - **Features:**
     - An 8-bit register that automatically increments (PC+1) each clock cycle.
     - Supports branching by selecting an immediate address input when a branch is taken.
     - Includes an active-high reset to initialize the PC to 0x00.

6. **Combined Instruction Memory and Program Counter (instruction_memory_pc)**
   - **Function:** Integrates the instruction memory with the program counter.
   - **Features:**
     - Fetches the correct instruction from the ROM based on the current PC value.
     - Simplifies the design by combining instruction fetching and PC management in one module.

7. **Control Unit**
   - **Function:** Decodes the opcode of an instruction and generates appropriate control signals.
   - **Features:**
     - Uses a 4-bit opcode to produce control outputs such as RegWrite, ALUSrc, ALUControl, and Branch.
     - Implements the decoding logic typically with a case statement for clear, combinational control logic.

8. **Complete CPU (Top-Level Module)**
   - **Function:** Integrates all the above modules to create a working CPU.
   - **Features:**
     - Connects the ALU, register file, instruction memory, program counter, and control unit.
     - Executes a simple machine code program (e.g., to compute the binary logarithm of a value).
     - The final output (`cpu_out`) is expected to reflect the computed result (log₂(32) = 5).

## How to Run the Project

1. **Prerequisites:**
   - Install **Icarus Verilog** for simulation.
   - Install **GTKWave** for waveform viewing.

2. **Compile the Project:**
   - Navigate to the project root directory.
   - Compile using the following command (replace `<top_module>` with your testbench module name):
     ```bash
     iverilog -g2012 -o simulation_out -s <top_module> src/*.sv tb/*.sv
     ```

3. **Run the Simulation:**
   - Execute the simulation with:
     ```bash
     vvp simulation_out
     ```

4. **View Waveforms:**
   - Open the generated VCD file in GTKWave:
     ```bash
     gtkwave simulation.vcd
     ```

## Contributing

Contributions are welcome! Please fork the repository, make improvements, and submit a pull request. For any issues or suggestions, open an issue in the repository.

## License

This project is licensed under the MIT License.

## Acknowledgements

Special thanks to the ELEC0010 teaching team for their guidance and support throughout this lab assignment.

Happy designing and coding!
