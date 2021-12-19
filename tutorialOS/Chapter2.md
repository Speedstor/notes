# Groundwork

### x86 Boot Process
1. POST process
2. CPU program counter set to the address FFFF:0000h for executing BIOS (Basic Input/Output System)
3. The BIOS checks all available storage devices if any device is bootable
   1. by examining the last two bytes of the first sector whether it has the boot record signature of 0x55, 0xAA.
4. If storage sector is bootable, the BIOS loads the first sector to the address 7C00h, set the program counter to that address
5. let the CPU executing code from there

- the first sector is called Master Boot Record (MBR)
- the program inthe first sector is called MBR Bootloader
- A service in BIOS boot is a group of routines that controls a particular hardware device, or returns information of the current system

### Boot process
1. BIOS transfers control the MBR bootloader by jumping to 0000:7c00h, where bootloader is assumed to exist already.
2. Setup machine environment for booting by properly initialize segment registers to enable flat memory model
3. Load the kernel:
   1. Read kernal from disk
   2. Save it somewhere in the main memory
   3. Jump to the starting code address of the kernel and execute
4. If error occurs, print a message to notify users something went wrong and halt