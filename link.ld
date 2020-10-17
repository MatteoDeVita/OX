ENTRY(loader) /*Entry point name*/

SECTIONS {
    . = 0x00100000; /* Code must be loaded from 1 Mo because inferior adresses are used by GRUB and I/O actions mapped in memory*/

    .text ALIGN (0x1000) : /*Align on 4 bytes*/
    {
        *(.text) /*every rodata sections, in read-only mode, of all files */
    }

    .rodata ALIGN (0x1000) :
    {
        *(.rodata*)
    }

    .data ALIGN (0x1000) :
    {
        *(.data)
    }

    .bss ALIGN (0x1000) :
    {
        *(COMMON)
        *(.bss)
    }
}
