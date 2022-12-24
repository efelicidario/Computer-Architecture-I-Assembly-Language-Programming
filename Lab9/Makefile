# CMPS 2240 Lab 9
# Makefile for nasm assembly code in /code/lab9

all: lab9

lab9: lab9.asm 
	nasm -f elf64 -g -F dwarf lab9.asm    # -g -F dwarf adds debugging stuff
	gcc -o lab9  lab9.o -lc

clean:
	rm -f *.o
	rm -f lab9
