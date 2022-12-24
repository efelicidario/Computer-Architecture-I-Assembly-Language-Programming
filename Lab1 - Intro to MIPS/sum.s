# Edmund Tyler Felicidario
# Feb 11, 2021
# CMPS 2240-62
# Lab 1 - Intro. to MIPS


.data
num1: .asciiz "First number: "
num2: .asciiz "Second number: "
sum: .asciiz "Sum: "
newline: .asciiz "\n"

.text
main:

                        # first number

li $v0, 4               # system call to print string
la $a0, num1            # prints address of string "num1"
syscall

li $v0, 5               # syscall to read in integer
syscall  
               
move $t0, $v0           # move the number read into $t0

                        # second number

li $v0, 4               # second system call to print second string
la $a0, num2            # prints address of string "num2"
syscall

li $v0, 5               #syscall to read in second integer
syscall

move $t1, $v0           #move the number read in to $t1

li $v0, 4               # syscall to print third string
la $a0, sum             # prints address of string "sum"
syscall

add $a0, $t1, $t0       # add the values in $t0 and $t1 and store them into $a0
li $v0, 1               # syscall to print integer in $v0
syscall

li $v0, 4               # syscall to print fourth string
la $a0, newline         # prints string "newline" (for OCD purposes)
    syscall

li $v0, 10              # exit
syscall

