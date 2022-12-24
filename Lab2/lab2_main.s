# filename: main.s
# purpose:  test output facilities in print.s and input facilities in read.s


#  spim> re "main.s"
#  spim> re "printf.s"
#  spim> re "read.s"
#  spim> run
#  spim> exit 


.text
.globl  main
.ent  main


main:


############################## Part 1 #####################################

la  $a0,format1  # Load address of format string #1 into $a0
jal printf       # call printf

la  $a0,format2  # load address of format string #2 into $a0
jal printf       # call printf

la  $a0,format3  # load address of format string #3 into $a0
li  $a1, 2021    # load integer as arg 
jal printf       # call printf

############################## Part 2 #####################################

    #first name
li $v0 4         # load immediate with 4 to setup syscall 4 (print_str)
la $a0 fname     # load address of prompt 
syscall

la $a0 fname_buf   # load address of buffer
li $v0 8           # setup syscall 8 (read_string)
syscall            # address of string buffer returned in $a0


    #last name
li $v0 4         # load immediate with 4 to setup syscall 4 (print_str)
la $a0 lname     # load address of prompt 
syscall

la $a0 lname_buf   # load address of buffer
li $v0 8           # setup syscall 8 (read_string)
syscall            # address of string buffer returned in $a0


    #id
li $v0 4      # load immediate with 4 to setup syscall 4 (print_str)
la $a0 id     # load address of prompt 
syscall
    
la $a0 id_buf        # load address of buffer
li $v0 8             # setup syscall 8 (read_string)
syscall              # address of string buffer returned in $a0


li  $v0,10       # 10 is exit system call
syscall

    .end  main

#########################################################################


    .data
    format1: 
    .asciiz "Go\n"        # asciiz adds trailing null byte to string
    format2: 
    .asciiz "CSUB Roadrunners\n"  
    format3: 
    .asciiz "in %d!\n"
    fname_buf: .space 32
    lname_buf: .space 32
    id_buf: .space 8
    fname: .asciiz "firstname: "
    lname: .asciiz "lastname: "
    id: .asciiz "id: "


