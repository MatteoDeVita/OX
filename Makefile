

CC	=	gcc

SRC	=	$(wildcard *.c)

OBJ	=	$(SRC:.c=.o) loader.o

LIBS_INCLUDE_PATH	=	./libs/frameBufferHandler/include

LIBS_FOLDER_PATH	=	./libs/frameBufferHandler

LIBS	=	_frameBufferHandler

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
		 	-c \
			-I $(LIBS_INCLUDE_PATH) \
			-L $(LIBS_FOLDER_PATH) \
			-l $(LIBS)

LDFLAGS	=	-T link.ld \
			-melf_i386

AS	=	nasm

ASFLAGS	=	-f elf

ELF	=	./iso/boot/kernel.elf

BOLD	=	\033[1m
CYAN		=   \033[36m
GREEN	=   \033[32m
END		=	\033[0m

all: $(LIBS) $(ELF)

$(ELF): $(OBJ)
	@echo "$(BOLD)$(CYAN)"
	ld $(LDFLAGS) $(OBJ) -L $(LIBS_FOLDER_PATH) -l $(LIBS) -o $(ELF)

$(LIBS):
	@echo "$(BOLD)$(GREEN)"
	make -C $(LIBS_FOLDER_PATH)

os.iso: $(ELF)
	genisoimage -R                              \
				-b boot/grub/stage2_eltorito    \
				-no-emul-boot                   \
				-boot-load-size 4               \
				-A OX                           \
				-input-charset utf8             \
				-quiet                          \
				-boot-info-table                \
				-o OX.iso                       \
				iso

run: os.iso
	bochs -f bochsrc.txt -q

%.o: %.s
	@echo "$(BOLD)$(CYAN)"
	$(AS) $(ASFLAGS) $< -o $@

%.o: %.c
	@echo "$(BOLD)$(CYAN)"
	$(CC) $(CFLAGS)  $< -o $@

clean:
	rm -rf *.o $(ELF) os.iso

.PHONY: clean fclean all re
