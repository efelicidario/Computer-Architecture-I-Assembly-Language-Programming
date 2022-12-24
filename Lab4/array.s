.text

main:
li $s2, 1
li $s3, 60
la $t0, array
li $s4, 1
li $s5, 30
la $t1, array

loop: bgt $s2, $s3, array2
    li $v0, 1
    sw $s2, ($t0)
lw $a0, ($t0)
    syscall
    addi $t0, $t0, 4
    addi $s2, $s2, 2
    li $v0, 4
    la $a0, space
    syscall
    b loop

    array2:
    addi $v0, $zero, 4  # print_string syscall
    la $a0, newline       # load address of the string
    syscall

    loop2: bgt $s4, $s5, done
lw $a0, ($t1)
    li $a1, 3
    div $a0, $a1
    mfhi $a2        #holds remainder
    beqz $a2, print
    li $a1, 7
    div $a0, $a1
    mfhi $a2
    beqz $a2, print

    label: 
    addi $s4, $s4, 1
    addi $t1, $t1, 4

    li $v0, 4
    la $a0, space

    b loop2

    print: 
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, space
    syscall
    b label

    done:
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall

    .data
    array: .space 120
    newline: .asciiz "\n"
    space: .asciiz " "
