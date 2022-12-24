# Makefile for nasm/yasm assembly code in examples for week12

all:	hello-world  sample1 lab12 lab12_opt foo

hello-world: hello-world.asm
	nasm -f elf64 -o hello-world.o hello-world.asm
	ld -o hello-world hello-world.o 

# let gcc spit out the x86 code you need to inline into lab12.c 
foo: foo.c
	gcc -S foo.c         
	as -o foo.o foo.s   
	gcc -o foo foo.s -v 2>out

sample1: sample1.c
	gcc -o sample1 sample1.c

lab12: lab12.c
	gcc -o lab12 lab12.c

lab12_opt: lab12.c
	gcc -D OPTIMIZE -o lab12_opt lab12.c

clean:
	rm -f *.o

veryclean:  
	rm -f *.o
	rm -f hello-world foo sample1 lab12 lab12_opt

