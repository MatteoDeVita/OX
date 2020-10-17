

CC	=	gcc

SRC	=	$(wildcard *.c)

OBJ	=	$(SRC:.c=.o) loader.o

CFLAGS	=	-m32 \
			-nostdlib \
			-nostdinc \
			-fno-builtin \
			-fno-stack-protector \
         	-nostartfiles \
		 	-nodefaultlibs \
		 	-Wall \
		 	-Wextra \
		 	-Werror \
		 	-c

LDFLAGS	=	-T link.ld -melf_i386

AS	=	nasm

ASFLAGS	=	-f elf

ELF	=	kernel.elf

all: $(ELF)

$(ELF): $(OBJ)
	ld $(LDFLAGS) $(OBJ) -o $(ELF)

os.iso: $(ELF)
	mv $(ELF) iso/boot/$(ELF)
	genisoimage -R                              \
				-b boot/grub/stage2_eltorito    \
				-no-emul-boot                   \
				-boot-load-size 4               \
				-A os                           \
				-input-charset utf8             \
				-quiet                          \
				-boot-info-table                \
				-o os.iso                       \
				iso

run: os.iso
	bochs -f bochsrc.txt -q

%.o: %.c
	$(CC) $(CFLAGS)  $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o $(ELF) os.iso