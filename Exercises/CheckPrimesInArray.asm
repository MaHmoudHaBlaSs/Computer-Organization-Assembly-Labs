# User will enter array dynamically and the apply the following functions on it
.data
    LengthPrompt: .asciiz "Enter Length of The Array: "
    ArrayPrompt: .asciiz "Enter Elements: \n"
    Space: .asciiz " - "
.text
# ------------------------------- #
# a0 is the number
isPrime:
    li $t0, 2

    check:
    beq $t0, $a0, prime
        div $a0, $t0
        mfhi $t1
        beqz $t1, notPrime
        addi $t0, $t0, 1
    j check
    
    prime:
        li $v0, 1
        j endIsPrime
    notPrime:
        li $v0, 0
endIsPrime:
    jr $ra

# ------------------------------- #
# a0 = array address , a1 = array size in word
countPrimes:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $t0, 0
    move $t1, $a0
    loopArray:
        lw $t2, 0($t1)

        addi $sp, $sp, -12
        sw $t0, 0($sp)
        sw $t1, 4($sp)
        sw $t2, 8($sp)

        move $a0, $t2
        jal isPrime

        lw $t0, 0($sp)
        lw $t1, 4($sp)
        lw $t2, 8($sp)
        addi $sp, $sp, 12

        li $t3, 1
        bne $v0, $t3, skip
            move $a0, $t2 
            li $v0, 1
            syscall # Print number       

            la $a0, Space 
            li $v0, 4
            syscall # Print new line       
        skip:

        addi $t1, $t1, 4
        addi $t0, $t0, 1
    bne $t0, $a1, loopArray

endCountPrimes:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra


# ------------------------------- #

main:
    la $a0, LengthPrompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0 # Array's Length in Word

    sll $s1, $s0, 2 # Array's Length in Byte

    move $a0, $s1
    li $v0, 9
    syscall # the array space is allocated in heap memory 
    move $s2, $v0 # Array address

    la $a0, ArrayPrompt
    li $v0, 4
    syscall

    li $s3, 0 # Byte index
    EnterElement:
        li $v0, 5
        syscall

        add $s4, $s2, $s3
        sw $v0, 0($s4)

        addi $s3, $s3, 4
    bne $s3, $s1, EnterElement

    move $a0, $s2
    move $a1, $s0
    jal countPrimes
    
Exit:
    jr $ra