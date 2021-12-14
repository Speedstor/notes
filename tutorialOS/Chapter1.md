# Preliminary

### Different computer architecture
<!--
##### x86 architecture
modern computers have motherboards with a environment typically with:
- a slot or more for CPU
- a chipset of two ships which are the Northbridge and Southbridge chips
  - Northbridge chip is responsible for the high-performance communication between CPU, main memory and the graphic card
  - Southbridge chip is responsible for the communication with I/O devices and other devices that are not performance sensitive
- solts for memory sticks
- a slot or more for graphic cards
- generic slots for other devices, eg. network card, sound card
- ports for I/O devices, e.g. keyboard, mouse, USB
-->
- execution environment - an environment that provides the facility to make code executable
- Intel Q35 Chipset (2007)
  - use QEMU to emulate a Q35 system
- x86 Execution Environment


### unix commands for writing os
- `objdump` is a program that display information about object files -> find file type
- section is a block of memory that conatains program code or data
- data sections such as .data and .bss, debug sections, etc, are not displayed
```bash
$ objdump -M i386,intel -D hello
  # options: -d | displays assembled contents of executable sections 
  #          -D | displays assembly contents of all sections
  #          -M intel | change the assembly into Intel syntax
  #          -M i386 | display aseembly content using 32-bit layout
```
- `nasm`stands for Netwide Assembler, and is a prgroam that assembly machine code into binary
```bash
$ nasm -f bin test.asm -o test
  # options: -f | specififes the file format of output file, ex elf=, bin
```
- `hd` is hexdump
```bash
$ hd test
```

### 
