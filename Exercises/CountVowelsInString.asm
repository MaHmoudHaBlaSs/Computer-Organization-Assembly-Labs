# For a string given count how many vowels (a e i o u A E I O U)
.data
    str: .asciiz "Hello World"

.text
count_vowels:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    move $t0, $zero # vowels
    la   $t1, str   # string address

    for:
        lb $t2, 0($t1)
        beq $t2, $zero, end_count

        addi $sp, $sp, -8
        sw $t0, 0($sp)
        sw $t1, 4($sp)

        move $a0, $t2
        jal is_vowel

        lw $t0, 0($sp)
        lw $t1, 4($sp)
        addi $sp, $sp, 8

        beq $v0, $zero, skip
            addi $t0, $t0, 1
        skip:
        addi $t1, $t1, 1 # next character address
        
    j for
        
    end_count:
        lw $ra, 0($sp)
        addi $sp, $sp, 4

        move $v0, $t0
        jr $ra


is_vowel:
    li $t0, 97
    beq $a0, $t0, vowel
    li $t0, 101
    beq $a0, $t0, vowel
    li $t0, 105
    beq $a0, $t0, vowel
    li $t0, 111
    beq $a0, $t0, vowel
    li $t0, 117
    beq $a0, $t0, vowel
    li $t0, 65
    beq $a0, $t0, vowel
    li $t0, 69
    beq $a0, $t0, vowel
    li $t0, 73
    beq $a0, $t0, vowel
    li $t0, 79
    beq $a0, $t0, vowel
    li $t0, 85
    beq $a0, $t0, vowel
    
    not_vowel:
        li $v0, 0
        jr $ra
    vowel:
        li $v0, 1
        jr $ra


main: 
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal count_vowels

    move $a0, $v0
    li $v0, 1
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    jr $ra