.text
.globl main
main:
    li $s0, 8          # width
    li $s1, 8           # height

    li $t1, 0       # save height
outer:                  # top of outer loop                           |
    li $t0, 0       # save width every outer-loop iteration       |

inner:                  # top of inner loop                |          |
    beq $t0, $t1, if
    b else             #                                  |          |

incr:
    add $t0, $t0, 1    # decrement width counter          |          |
    blt $t0, $s0, inner     # keep looping through columns?    |          |
    jal newline         # newline every new row                       |

    add $t1, $t1, 1    # decrement height counter                    |
    blt $t1, $s1, outer     # keep looping through the rows?              |
    jal newline         # newline at program end
    li   $v0, 10        # exit
    syscall

newline:                # newline function
    li $v0, 11          # 11 = show character
    li $a0, 10          # 10 = ascii newline
    syscall             #
    jr $ra              # return to $ra address

if:
li $v0, 11
li $a0, '.'
syscall
li $v0, 4
la $a0, space
syscall
b incr

else:
li $v0, 11
li $a0, '@'
syscall
li $v0, 4
la $a0, space
syscall
b incr

.data
space: .asciiz " "
