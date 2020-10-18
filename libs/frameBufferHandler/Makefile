CC	=	gcc

INCLUDE_PATH	=	include/

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
			-I $(INCLUDE_PATH)			 

LIB	=	lib_frameBufferHandler.a

SRC	=	$(wildcard src/*.c)

OBJ	=	$(SRC:.c=.o)

all: $(LIB)

$(LIB): $(OBJ)
	ar rcs $(LIB) $(OBJ)

clean:
	rm -rf $(OBJ)

fclean: clean
	rm -rf $(LIB)

re: fclean all

.PHONY: clean fclean all re
