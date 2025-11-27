# Reads N from user and computes the sum: 1 + 2 + 3 + ... + N
.data



.text
sum:
    li $t0, 1
    move $t1, $zero
    for: 
        slt $t2, $a0, $t0
        bne $t2, $zero, end_for 

        addu $t1, $t1, $t0
        addi $t0, $t0, 1

        j for

    end_for:
        move $v0, $t1
        jr $ra


end_sum:

main:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 5
    syscall
    
    move $a0, $v0
    jal sum

    move $a0, $v0
    li $v0, 1
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    jr $ra
