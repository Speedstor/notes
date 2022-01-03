- [Chapter 1: Preliminary](#chapter-1-preliminary)
    - [Different computer architecture](#different-computer-architecture)
    - [unix commands for writing os](#unix-commands-for-writing-os)
    - [Assembly Instructions](#assembly-instructions)
        - [ModR/M](#modrm)
        - [SIB](#sib)
    - [Anatomy of a Program](#anatomy-of-a-program)
    - [ELF Program Header](#elf-program-header)
    - [Section header table](#section-header-table)
    - [Important Sections types](#important-sections-types)
    - [Program Header Table](#program-header-table)
    - [Segments vs sections](#segments-vs-sections)
    - [Assembly Examples](#assembly-examples)
    - [gdb Usage](#gdb-usage)
    - [Linginering questions too lazy to know](#linginering-questions-too-lazy-to-know)
<br/>
<br/>
<br/>

# Chapter 1: Preliminary
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
$ objdump -z -M i386,intel -D hello
  # options: -d | displays assembled contents of executable sections 
  #          -D | displays assembly contents of all sections
  #          -M intel | change the assembly into Intel syntax
  #          -M i386 | display aseembly content using 32-bit layout
  #          -z | to show all zer bytes
  #          -S | to better demonstrate the connection between high and low level code
  #          --no-show-raw-insn | omit the opcodes (hex representation of the code)
  
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
- `readelf`
```bash
$ readelf -S hello
  # options: -S | get all the headers from an executable binary
  #          -x <section name|section number> | display a certion section hexdump
  #          -p <section name|section number> | display a certain section strings
  #          -s | display symbol tables
  #          -l | display program header table
  #          -w | prints all debug information
  #          -L | used with -w, it will only display the debug info of line numbers
  #          -i | used with -w, it will only display the debug info of DIEs entries
```
- `gcc`
```bash
$ gcc -masm=intel -m32 -g hello.c -o hello
 # options: -g | compile with debug information
```
- `gdb` debug for c and c++ programs
```bash
$ gdb hello
 # options: 
```

<br/>

### Assembly Instructions
|Instruction Prefiexes | opcode |ModR/M |SIB    | Displacemet   | Immediate|
|---|---|---|---|---|---|
|Prefixes of 1 byteach (optional)|1-, 2-, or 3- byte opcode| 1 byte (if required)| 1 byte (if required)  | Address displacement of 1, 2 or 4 bytesor none| Immediate data of 1, 2 or 4 bytes or none|
##### ModR/M
|Mod    | Reg/Opcode|    R/M|
|---|---|---|
##### SIB
|Scale  | Index     | Base|
|---|---|---|

- `opcode` is a unique number thatidentifies an instruction, each for a mnemonic name, ex. add is 04
  - they can be 1, 2 or 3 bytes long and sometimes includes an additional 3-bit MODR/M
- `ModR/M` specifies operands of an instruction, can be: register, memory location or an immediate value.
  - `mod`(modifier) field, with r/m field for 5 bits of information to encode 32 possible values: 8 registers and 24 addressing modes.
  - `reg/opcode` field encodes either a register operand, or extends the Opcode field with 3 more bits
  - `r/m` field encodes either a *register operand* or can be combined with mod field to *encode an addressing mode*
- reread p.58-61
- `SIB` byte encodes ways to calculate the memory position into an element of an array. 
  - Effective address = scale*index+base
    - index is the offset into an **array**
    - Scale is a factor of Index. Scale can only be 1, 2, 4 or 8; other musts be done manually
    - Base is the starting address
    - `mul` instructions can loop through array with a `n` variable

### Anatomy of a Program
- **ELF**, stands for Executable and Linkable Format, is the content at the very geinning of an executable to provide an operating system necessary information to load into main memory and run the executable.
- ELF binary structure
  1. **ELF header**: the very first section of an executable that describes the file's organization
  2. **Program header table**: an array of fixed-size structures that describes *segments* of an executable
  3. **Section header table**: an array of fixed-size structures that describes *sections* of an executable
  4. **Segments and sections**: the main content of an ELF binary, which are the code and data, divided into chunks of different purposes
     - A *segment* is a composition of zero or more sections and is directly loaded by an operating system at runtime
     - A *section* is a block of binary that is either:
       - actual program code and data that is available in memory when a program runs
       - metadata about othersections used only in the linking process, and dixsappear from the final executable
- the *linker script* is a text file to instruct how a linker should generate a binary
<br/>

### ELF Program Header
- `Magic` 16 bytes that identifies file as ELF executable

|Predefined Values|Class field|Data field| Version| OS/ABI| Padding |
|---|---|---|---|---|---|
|7f 45 4c 46<br/>Mean: 7f ELF|0 - Invalid class<br/>1 - 32-bit objects<br/>2 - 64-bit objects|0 - Invalid Data encoding<br/>1 - Little endian, 2' complement<br/>2 - Big endian, 2's complement|0 - Invalid version<br/>1 - Current version|target OS # for ABI|

- `Type` identifies the object file type<br/>&emsp;0 - No file type<br/>&emsp;1 - Relocatable file<br/>&emsp;2 - Executable file<br/>&emsp;3 - Shared object file<br/>&emsp;4 - Core file<br/>&emsp;9xff00 - Processor specific, lower bound<br/>&emsp;0xffff - Processor specific, upper bound
- `Machine` required architecture value for an ELF file eg. x86_64, MIPS, SPARC, etc. 
- `Version` the version number fo the current object file (not ELF version)
- `Entry point address` where the very frist code to be executed
- `Start of program headers` Offset of the program header table, in bytes. $<$start address$>$ + offset
- `Start of section headers` Offset of the section header table, in bytes.
- `Flags` Hold Processor-specific flags associated with the file. EFLAGS register is set according to this value.
- `Size of this header` The total size oef ELF header's size in bytes.
- `Size of program headers` Size of each program header
- `Number of program headers` The total number of program headers
- `Size of section headers` Size of each section header
- `Number of section headers` The total number of section headers
- `Section header string table index` Specifies the index of section header table that points to the section that holds all null-terminated strings.

### Section header table
- because not all types of code and data have the same purpose, they are divided into smaller chunks. w/ conditions:
  - Every section in an objectfile has exactly one section header describing it. But, section headers may exist that do not have a section. 
  - Each section occupies one contiguous (possibly empty) sequence of bytes within a file.
  - Sections in a file may not overlap
  - An object file may have inactive space. Contents can be neither section nor program (*inactive space*)
  
| | | | | | | |
|---|---|---|---|---|---|---|
|[Nr] (index)|Name|Type|Address |||Offset|
| |Size |EntSize| [Flags](./Appendix.md#section-header-flags-definitions)| Link|Info|Align|

### Important Sections types 
- `.text` holds all the compiled code of a program
- `.data` holds the initialized data of a program
- `.rodata` holds read-only data, such as fixed-size strings in a program
- `.bss` shorts for Block Started by Symbol, holds uninitialized data of a program (allocated only when loaded into main memory)
- other types of sections are needed for dynamic linking, not there yet we
- `SYMTAB` and `DYNSYM` are sections that hold symbol table. *symbol table* is an array of entries that describe symbols in a program. *symbol* is a name assigned to an entity of program
  - symbols definitions of *visibility* and *index* on book page 129
- `STRTAB` holds null-terminated strings, called string table

### Program Header Table
- A *program header table* is an array of program headers that defines the memeory layout of a aprogram at runtime.
- [Program header types](./Appendix.md#program-header-types)


### Segments vs sections
- an OS loads program segments, not sections
- a segment is a collection of sections, sections has more types and more variaty

<br/>

### Assembly Examples
- `jump [0x1234]` -> `ff 26 34 12`
<br/>

### gdb Usage
```bash
(gdb) info target
 # display symbols of the file

(gdb) maint info sections <section names/flags (ex. .text .data .bss CODE)>
 # similar to info target but give more info about sections (file offset, flags...)
 #    section flags are specific to gdb

(gdb) info functions
 # list all function names and their loaded address

(gdb) info variables
 # list all global and static variable names

(gdb) info registers
 # list commonly used registers

(gdb) disassemble /rs main
(gdb) disassemble /rs 'hello.c'::main
 # displays the assembly code of the executable file (here, the main function)
 #    /s includes high-level code source
 #    /r raw instructions in hex are included

(gdb) x/20b main
 # examines the content of a given memory range
 #    /20b prints 20 bytes, starting from main -> /<repeated count><format letter>
 #    <x> main, x could be any of: o (octal)/ x (hex)/ d (decimal)/ u (unsigned decimal)/ 
 #                                 t (binary) / f (float)/ a (memory addresses)/ 
 #                                 i (series of assembly instructions)/ c (array of ASCII chars)/
 #                                 s (string)

(gdb) print <variable, function, register, number, etc>

(gdb) run
(gdb) r
 # runs the program

(gdb) break 3
(gdb) b 3
 # set breakpoint at line 3
(gdb) b main
 # set breakpoint at main function
(gdb) b *0x400526
(gdb) b hello.c:3
 # set breakpoint at line 3 of file of hello.c

(gdb) next
(gdb) n
 # proceeds to the next statement in the program

(gdb) countinue
(gdb) c
 # continue execution up to the next breakpoint or until terminationqweqweqweqwe

(gdb) step
(gdb) s
 # steps into a funciton

(gdb) ni
 # steps through each assembly instruction

(gdb) x/i $eip
 # displays the current instruction in breakpoint

(gdb) si
 # steps into an assembly function

(gdb) until
(gdb) finish

(gdb) bt
 # prints the backtrace of all stack frames (list of currently active functions)

(gdb) up
(gdb) down
 # goes up/down one frame earlier/later the current frame
```

### Linginering questions too lazy to know
- what is `-m32` option in gcc command program