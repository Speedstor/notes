; A Simple Bootloader

org 0x7c00
bits 16
start: jmp boot

;; constant and variable definitions
msg db "Welcome to my Operating System!", 0ah, 0dh, 0ah, 0

boot:
    cli ;no interrupts
    cld ; all that we need to init

    ;mov al, 65
    ;call PrintCharacter
    mov si, msg
    call PrintString
    hlt ; hlt the system

PrintCharacter:
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    ret

PrintString:
next_character:
    mov al, [SI]
    inc si
    or al, al
    jz exit_function
    call PrintCharacter
    jmp next_character
exit_function:
    ret 
    ;jmp $
;; We have to be 512 bytes. Clear the rest of the bytes with 0
times 510 - ($-$$) db 0
dw 0xAA55
