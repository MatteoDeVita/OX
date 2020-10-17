global loader ;entry symbol for ELF
extern main

MAGIC_NUMBER    equ 0x1BADB002 ;magic number constant
FLAG            equ 0x0
CHEKSUM         equ -MAGIC_NUMBER ;compute control sum (MAGIC_NUMBER + FLAG must be == 0)
KERNEL_STACK_SIZE equ 4096

section .bss
align 4
kernel_stack:
    resb KERNEL_STACK_SIZE ; reserve kernel stack


section .text:
align 4 ;code must be aligned on 4 bytes
    dd MAGIC_NUMBER ;dd write values in machine code
    dd FLAG
    dd CHEKSUM

loader:
    mov eax, 0xCAFEBABE ;mov 0xCAFEBABE to eax register
    mov esp, kernel_stack + KERNEL_STACK_SIZE ;mov esp to the begining of the stack
    call main

.loop:
    jmp .loop ;infinite loop
