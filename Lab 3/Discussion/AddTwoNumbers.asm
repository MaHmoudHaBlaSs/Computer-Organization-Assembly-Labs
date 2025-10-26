# Simple Program to Add Two Numbers
main:
    addi $sp, $sp, -4 
    sw $ra, 0($sp)  

    li $a0, 15
    li $a1, 13

    jal add_two_nums # Jump and Link to the function
                     # $ra <- saves the next instruction to be executed (PC + 4) 
                     # Pc <- first instruction in the function
    move $t2, $v0 # Receive the return value

    li $v0, 1
    move $a0, $t2 
    syscall

    li $v0, 10
    syscall

    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    jr $ra # returns to the caller function (OS provided)

add_two_nums:
    # Allocate space in stack
    addi $sp, $sp, -4 
    # Saves return address in case the current function call another function
    # That will overwrite the $ra and lost the main return address.
    sw $ra, 0($sp)  

    addu $v0, $a0, $a1

    lw $ra, 0($sp) # Loading the return address
    addi $sp, $sp, 4 # Deallocating the space taken

    jr $ra




