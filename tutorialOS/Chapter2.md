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

### Linux Program/Commands
- `nasm` (Netwide Assembler)
```bash
$ nasm -f bin bootloader.asm -o bootloader
 # options: -f <format> | format of outputing the file
 #          -o <outFile> | name of the file to output to
```
- `dd` (copy and convert) [dd because cc is already used by C compiler]
```bash
$ dd if=/dev/zero of=disk.img bs=512 count=2880   # create a 1.4MB floppy disk
$ dd conv=notrunc if=bootloader of=disk.img bs=512 count=1 seek=0
 # params:  if=FILE | read from FILE instead of stdin
 #          of=FILE | write to FILE instead of stdin
 #          bs=BYTES | read and write up to BYTES bytes at a time (default: 512); overrides ibs and obs
 #          count=N | copy only N input blocks
 #          conv=CONVS | conver the file as per the comma separated symbol list
 #          conv=notrunc | preserves the original size of the floppy disk
 #          seek=SECTOR | the sector of the floppy disk we are writing 
```
- `qemu-system-i386` (linux virtual machine emulator)
```bash
$ qemu-system-i386 -machine q35 -fda disk.img -gdb tcp::26000 -S
 # options: -machine q35 | emulates a q35 machine model from Inetl
 #          -machine help | list all supported emulated machines from QEMU
 #          -fda <disk img> | use disk.img as a floppy disk image
 #          -gdb tcp:26000 | allows gdb to connect to the virtual machine for remote debugging through a tcp socket with port 26000
 #          -S | waits for gdb to connect before starting to run the disk OS
```
- `gdb`
```bash
(gdb) set architecture i8086
 # set current architecture to i8086, set when running in 16-bit mode

(gdb) target remote localhost:26000
 # connect to remote gdb instance

(gdb) layout asm
(gdb) layout reg
 # viewing the assembly code and registers together in split view
```

### Makefile Example
```Makefile
BUILD_DIR=build
BOOTLOADER=$(BUILD_DIR)/bootloader/bootloader.o
OS=$(BUILD_DIR)/os/sample.o
DISK_IMG=disk.img

all: bootdisk

.PHONY: bootdisk bootloader os

bootloader:
  make -C bootloader

os:
  make -C os

bootdisk: bootloader os
   dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
   dd conv=notrunc if=$(BOOTLOADER) of=$(DISK_IMG) bs=512 count=1 seek=0
   dd conv=notrunc if=$(OS) of=$(DISK_IMG) bs=512 count=1 seek=1
```

### Helpful Websites for Assembly, *BIOS services*, etc.
http://www.ablmcc.edu.hk/~scy/CIT/8086_bios_and_dos_interrupts.htm#int10h_0Eh
https://www.viralpatel.net/taj/tutorial/hello_world_bootloader.php
