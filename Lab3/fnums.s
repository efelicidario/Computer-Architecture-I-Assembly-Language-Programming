# Factorial example from Appendix A, pp A-27 to A-29 (on CD)                        
#                                                                                   
# This implements the following program:                                            
#                                                                                   
# int main() {                                                                      
#     printf("The factorial of 5 is %d\n", fact(5));                                
# }                                                                                 
# int fact(int n) {                                                                 
#   if (n < 1)                                                                      
#       return 1;                                                                   
#   else                                                                            
#       return n * fact(n-1);                                                       
# }                                                                                 
#                                                                                   
.text                                                                             
.globl main    # Start execution at main                                          
.ent main      # Begin the definition of main                                     

main:                                                                               
# The book makes use of frame pointers in this example.                           
# As described on page A-27, by convention a frame is 24 bytes                    
# to store a0 - a3 and ra. This includes 4 bytes of padding.                      
# To save fp, another 8 bytes are added (4 for fp and 4 for                       
# padding), making the frame 32 bytes long. Even though a0-a3                     
# are not saved to the stack, space is still reserved on the                      
# stack for them.                                                                 

addi  $sp, $sp, -32  # Stack frame is 32 bytes long                               
sw  $ra, 0($sp)     # Save return address                                         




la  $a0, fib3   # Load address of fib3                                            
li $v0, 4       # Command to print a string                                       
syscall         # Execute                                                         

la $a0, buffer  # Load the Buffer into the system                                 
li $v0, 5       # Receive input from the user as integer                          
syscall         # Execute                                                         

move $a0, $v0   # Move input into $a0                                             
move $t7, $v0   # Move contents into a temporary register                         

jal  fibo        # Call factorial function                            #This is where you left off 
move $t0, $v0   # move result to t0                                               



# display stuff now                                               
la $a0, fib     # address of msg                                                  
li $v0, 4       # syscall 1=print string                                          
syscall                                                                           

move $a0, $t7   # Move fact result to $a0 to display it                           
li   $v0, 1     # syscall 1=print int                                             
syscall                                                                           

la $a0, fib2                                                                      
li $v0, 4                                                                         
syscall                                                                           

move $a0, $t0  #Move result to display                                            
li   $v0, 1                                                                       
syscall                                                                           




li  $a0, 10     # ascii LF char                                                   
li  $v0, 11     # syscall 1=print char                                            
syscall                                                                           

# Since the function calls are done, restore the return address                   
# and frame pointer.                                                              

lw  $ra, 0($sp)    # Restore return address                                       

addi  $sp, $sp, 32  # Pop stack frame                                             

li  $v0, 10    # 10 is the code to exiting the program                            
syscall        # Execute the exit                                                 

.end main                                                                         

.rdata                                                                         
fib: .asciiz "Fibonacci Number  "                                                   
fib2: .asciiz " is "                                                                
buffer: .space 2                                                                    
fib3: .asciiz "Find the Fibonacci number of: "                                

.text      # Another segment of instructions                                      
.ent fibo  # Begin the definition of the fact function                            

fibo:                                                                               
# As above, create a 32 byte frame to store a0-a3, ra and fp.                     
# For the fact procedure, a0 will be saved in offset 28 from the                  
# sp (offset 0 from the fp).                                                      

beqz $a0, zero                                                                
beq $a0, 1 , one                                                               
bgt $a0, 1 , fibonacci                                                        
jr $ra                                                                            

fibonacci:                                                                    
    addi $sp, $sp, -32                                                                
    sw   $ra, 0($sp)                                        
sw   $a0, 4($sp)   


    add $a0, $a0, -1
    jal fibo
    lw $a0, 4($sp)
sw $v0, 8($sp)

    add $a0, $a0, -2
    jal fibo

lw $t0, 8($sp)

    add $v0, $t0, $v0

    j exit

    zero:
    li $v0, 0
    j $ra

    one:
    li $v0, 1
    j $ra

    exit:
    lw $ra, 0($sp)    #Restore
    addi $sp, $sp, 32 #Pop
    jr $ra            #Return to caller function
    .end fibo                                     

