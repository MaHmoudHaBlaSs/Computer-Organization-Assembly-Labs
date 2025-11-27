# Program to take N and print the equivalent binary => 6  0000 0110
# the idea lays on that we apply AND mask of 1 << num_of_bit wanted to the N
# 6 & (1 << 2) [000 0100] = 1
.data
    space: .asciiz "_"
.text
getBin:
    li $t0, 31
    li $t1, 1
    move $t2, $a0

    for:
        blt $t0, $zero, end
        sllv $t3, $t1, $t0 # Mask
        and $t3, $t2, $t3  # Bit value

        value_check:
            bne $t3, $zero, one
                li $a0, 0
                j end_check
            one:
                li $a0, 1
        
        end_check:
        li $v0, 1
        syscall

        beq $t0, $zero, end

        li $t4, 4
        div $t0, $t4
        mfhi $t4
        bne $t4, $zero, skip
            la $a0, space
            li $v0, 4
            syscall
        
        skip:
        addi $t0, $t0, -1
        
    j for

    end:
        jr $ra

main:
    
    li $v0, 5
    syscall

    move $a0, $v0

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal getBin

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    jr $ra