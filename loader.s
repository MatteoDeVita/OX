global loader ;entry symbol for ELF

MAGIC_NUMBER equ 0x1BADB002 ;magic number constant
FLAG equ 0x0
CHEKSUM equ -MAGIC_NUMBER ;compute control sum (MAGIC_NUMBER + FLAG must be == 0)

section .text:
align 4 ;code must be aligned on 4 bytes
    dd MAGIC_NUMBER ;dd write values in machine code
    dd FLAG
    DD CHEKSUM
.loader:
    mov eax, 0xCAFEBABE ;mov 0xCAFEBABE to eax register
.loop:
    jmp .loop ;infinite loop