# filename: calc.s

.data
newline: 
    .asciiz "\n"
usage_stmt:
    .asciiz   "\nUsage: spim -f gcd.s <int> <operand> <int2>\n"
even1: 
    .asciiz "EVEN\n"
odd1: 
    .asciiz "ODD\n"

.text
.globl main

main:

  # grab command line stuff - a0 is arg count and a1 points to list of args
  move $s0, $a0
  move $s1, $a1

  # zero out these registers just to be safe
  move $s2, $zero
  move $s3, $zero
  move $s4, $zero
     
  # check if less than three arguments are given
  li $t0, 4 
  blt $a0, $t0, exit_on_error
     
  # parse the first number
  lw $a0, 4($s1)
  jal atoi
  move $s2, $v0
     
  # parse the second number
  lw $a0, 12($s1)
  jal atoi
  move $s3, $v0
  
  #
  lw $t0, 8($s1)
  lb $a0, ($t0)
  beq $a0, 43, addition
  beq $a0, 45, subtraction
  beq $a0, 42, multiply
  j done

addition:
  add $a0, $s2, $s3
  li $v0, 1
  syscall
  li $t0, 2
  div $a0, $t0
  mfhi $t2
  beq $t2, 0, even
  beq $t2, 1, odd
  j done

subtraction:
  sub $a0, $s2, $s3
  li $v0, 1
  syscall
  li $t0, 2
  div $a0, $t0
  mfhi $t2
  beq $t2, 0, even
  beq $t2, 1, odd
  j done

multiply:
  mul $a0, $s2, $s3
  li $v0, 1
  syscall
  li $t0, 2
  div $a0, $t0
  mfhi $t2
  beq $t2, 0, even
  beq $t2, 1, odd
  j done

even:
  la $a0, newline
  li $v0, 4
  syscall
  la $a0, even1
  li $v0, 4
  syscall
  j done

odd:
  la $a0, newline
  li $v0, 4
  syscall
  la $a0, odd1
  li $v0, 4
  syscall

done:
  # move the result from t0 to v0 to print it

  la $a0, newline     
  li $v0, 4
  syscall
 
  li $v0, 10  # 10=exit
  syscall


exit_on_error:
  li $v0, 4
  la $a0, usage_stmt     # print usage_stmt statement and exit
  syscall
  li $v0, 10             # 10=exit
  syscall


# --------- ATOI FUNCTION 
atoi:
    move $v0, $zero
     
    # detect sign
    li $t0, 1
    lbu $t1, 0($a0)
    bne $t1, 45, digit
    li $t0, -1
    addu $a0, $a0, 1

digit:
    # read character
    lbu $t1, 0($a0)
     
    # finish when non-digit encountered
    bltu $t1, 48, finish
    bgtu $t1, 57, finish
     
    # translate character into digit
    subu $t1, $t1, 48
     
    # multiply the accumulator by ten
    li $t2, 10
    mult $v0, $t2
    mflo $v0
     
    # add digit to the accumulator
    add $v0, $v0, $t1
     
    # next character
    addu $a0, $a0, 1
    b digit

finish:
    mult $v0, $t0
    mflo $v0
    jr $ra
#----------------------------------------

