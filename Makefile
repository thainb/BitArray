ifndef CC
	CC = gcc
endif

ifdef DEBUG
	CFLAGS := -DDEBUG=1 --debug -g
else
	CFLAGS := -O3
endif

CFLAGS := $(CFLAGS) -Wall -Wextra -I.

OBJS = lookup3.o bit_array.o
SRCS = lookup3.c bit_array.c

bitarr: $(OBJS)
	ar -csru libbitarr.a bit_array.o lookup3.o

dev: bitarr
	cd dev; make

lookup3.o: lookup3.c
	$(CC) $(CFLAGS) -c $< -o $@

bit_array.o: bit_array.c
	$(CC) $(CFLAGS) -c $< -o $@

all: bitarr dev
	cd dev; make all
	cd examples; make all

clean:
	rm -rf libbitarr.a *.o *.dSYM *.greg
	cd dev; make clean
	cd examples; make clean

# Comment this line out to keep .o files
.INTERMEDIATE: $(OBJS)
.PHONY: all clean
