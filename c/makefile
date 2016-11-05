CC := gcc
CPPFLAGS += -D_XOPEN_SOURCE=700
CFLAGS += -std=c99 -pedantic -Wall -Wextra -Os
LDFLAGS += -lcrypto

SRC := 01.c 02.c 03.c 04.c 05.c
OBJ := ${SRC:.c=}

all: ${OBJ}

clean:
	@rm -f ${OBJ}
