.data

failMsg:    .asciiz "Test case failed!!\n\n"
passMsg:    .asciiz "Test case passed!!\n\n"

excpected:  .asciiz "\tExcepected =\t"
result:     .asciiz "\tResult =\t\t"

newLine:    .asciiz "\n"

test1:   .asciiz "Test fib(0)\n"
test2:   .asciiz "Test fib(1)\n"
test3:   .asciiz "Test fib(2)\n"
test4:   .asciiz "Test fib(3)\n"
test5:   .asciiz "Test fib(4)\n"
test6:   .asciiz "Test fib(5)\n"
test7:   .asciiz "Test fib(6)\n"

.text

#=====================================================
# Fibonacci Function
#   Parameters: $a0 -> n
#   Return:     $v0 -> fib(n)
#=====================================================
# ---------------------- Iterative Fib ------------------------ #
fib_iterative:
    li $t0, 1
    li $t1, 0 # fib(0) = 0
    li $t2, 1 # fib(1) = 1
    li $t3, 0 # cumulative result

    for:
        bgt $t0, $a0, end_for

        addu $t3, $t1, $t2
        move $t1, $t2
        move $t2, $t3
        addi $t0, $t0, 1
        j for

    end_for:
        move $v0, $t3

end_fib_iterative:
    jr $ra

# ---------------------- Recursive Fib ------------------------ #
# $s1 contains the address of the array / $a0 contains the fib num
fib:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $t0, 4
    mul  $t0, $a0, $t0
    addi $t0, $t0, -4   # number address shift in the array
    add  $t0, $t0, $s1 # exact address of the number in the array [shift + address]
    lw   $t1, 0($t0)   # get the data from array (fib data)

    bne $t1, $zero, end_fib_recursive

    addi $sp, $sp, -12 
    sw   $t0, 4($sp)
    sw   $a0, 0($sp)

    addi $a0, $a0, -1
    jal fib
    sw $v0, 8($sp)

    addi $a0, $a0, -1
    jal fib
    move $t3, $v0 # fib(n-2)

    lw   $a0, 0($sp)
    lw   $t0, 4($sp)
    lw   $t2, 8($sp) # fib(n-1)
    addi $sp, $sp, 12      

    add $t2, $t2, $t3 # fib(n-1) + fib(n-2)
    sw $t2, 0($t0)

end_fib_recursive:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    lw $v0, 0($t0)

    jr $ra
# ---------------------------- Helper Function --------------------- #
# $a0 is the size of array in bytes / $a1 is the array address
initialize_zeros:
    li $t0, 0

    for_init:
        beq $t0, $a0, end_for
        add $t1, $t0, $a1
        sw $zero, 0($t1)
        addi $t0, $t0, 4
    end_for_init:
        jr $ra

main:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li $s2, 6 # max array size in test cases
    mul $s0, $s2, 4
    sub $sp, $sp, $s0 # stores n spaces (Array)
    move $s1, $sp # $s1 carry the address of the array

    # ========= test fib(1) =========
    move $a0, $s0 # $a0 is the size of array
    move $a1, $s1 # $a1 is the array address
    jal initialize_zeros
    li $s3, 1
    sw $s3, 0($s1)

    li $a0, 1
    jal fib

    li $a0, 1
    move $a1, $v0
    la $a2, test2
    jal assertNotEqual

    # ========= test fib(2) =========
    move $a0, $s0 # $a0 is the size of array
    move $a1, $s1 # $a1 is the array address
    jal initialize_zeros
    li $s3, 1
    sw $s3, 0($s1)
    sw $s3, 4($s1)

    li $a0, 2
    jal fib

    li $a0, 1
    move $a1, $v0
    la $a2, test3
    jal assertNotEqual

    # ========= test fib(3) =========
    move $a0, $s0 # $a0 is the size of array
    move $a1, $s1 # $a1 is the array address
    jal initialize_zeros
    li $s3, 1
    sw $s3, 0($s1)
    sw $s3, 4($s1)

    li $a0, 3
    jal fib

    li $a0, 2
    move $a1, $v0
    la $a2, test4
    jal assertNotEqual

    # ========= test fib(4) =========
    move $a0, $s0 # $a0 is the size of array
    move $a1, $s1 # $a1 is the array address
    jal initialize_zeros
    li $s3, 1
    sw $s3, 0($s1)
    sw $s3, 4($s1)

    li $a0, 4
    jal fib

    li $a0, 3
    move $a1, $v0
    la $a2, test5
    jal assertNotEqual

    # ========= test fib(5) =========
    move $a0, $s0 # $a0 is the size of array
    move $a1, $s1 # $a1 is the array address
    jal initialize_zeros
    li $s3, 1
    sw $s3, 0($s1)
    sw $s3, 4($s1)

    li $a0, 5
    jal fib

    li $a0, 5
    move $a1, $v0
    la $a2, test6
    jal assertNotEqual

    # ========= test fib(6) =========
    move $a0, $s0 # $a0 is the size of array
    move $a1, $s1 # $a1 is the array address
    jal initialize_zeros
    li $s3, 1
    sw $s3, 0($s1)
    sw $s3, 4($s1)

    li $a0, 6
    jal fib

    li $a0, 8
    move $a1, $v0
    la $a2, test7
    jal assertNotEqual

    
    add $sp, $sp, $s0 # free allocated space for dynamic programming algorithm

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra


#================================================================================
# assertNotEqual
#   Parameters: $a0 -> expected, $a1 -> result, $a2 -> testNumberMsg
#   Return:     ----
#================================================================================
assertNotEqual:

    move $t0, $a0
    
    li $v0, 4
    move $a0, $a2
    syscall

    la $a0, excpected
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    la $a0, result
    syscall

    li $v0, 1
    move $a0, $a1
    syscall

    li $v0, 4
    la $a0, newLine
    syscall

    bne $t0, $a1, printFail

    la $a0, passMsg
    syscall

    j return

printFail:
    la $a0, failMsg
    syscall

return:
    jr $ra