

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
		 	-c \
			-I $(LIBS_INCLUDE_PATH) \
			-L $(LIBS_FOLDER_PATH) \
			-l $(LIBS) \
			-Wall \
		 	-Wextra \
		 	-Werror

LDFLAGS	=	-T link.ld \
			-melf_i386

AS	=	nasm

ASFLAGS	=	-f elf

ELF	=	./iso/boot/kernel.elf

ISO	=	OX.iso

BOLD	=	\033[1m
CYAN	=   \033[36m
GREEN	=   \033[32m
END		=	\033[0m

all: $(LIBS) $(ELF)

$(ELF): $(OBJ)
	@echo "$(BOLD)$(CYAN)"
	ld $(LDFLAGS) $(OBJ) -L $(LIBS_FOLDER_PATH) -l $(LIBS) -o $(ELF)
	@echo "$(END)"

$(LIBS):
	@echo "$(BOLD)$(GREEN)"
	make -C $(LIBS_FOLDER_PATH)
	@echo "$(END)"

$(ISO): all
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

run: $(ISO)
	bochs -f bochsrc.txt -q

%.o: %.s
	@echo "$(BOLD)$(CYAN)"
	$(AS) $(ASFLAGS) $< -o $@
	@echo "$(END)"

%.o: %.c
	@echo "$(BOLD)$(CYAN)"
	$(CC) $(CFLAGS)  $< -o $@
	@echo "$(END)"

clean:
	@echo "$(BOLD)$(CYAN)"
	rm -rf $(OBJ)
	@echo "$(BOLD)$(GREEN)"
	make clean -C $(LIBS_FOLDER_PATH)
	@echo "$(END)"


fclean: clean
	@echo "$(BOLD)$(CYAN)"
	rm -rf $(ELF) $(ISO)
	@echo "$(BOLD)$(GREEN)"
	make fclean -C $(LIBS_FOLDER_PATH)
	@echo "$(END)"

re: fclean all

rerun: re run

.PHONY: clean fclean all re run $(ISO) $(LIBS) $(ELF)
