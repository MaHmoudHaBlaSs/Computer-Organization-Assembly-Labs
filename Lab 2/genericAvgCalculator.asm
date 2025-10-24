# Calculating Average

.data 
    prompt: .asciiz "How many numbers: "
    entering1: .asciiz "Enter number "
    entering2: .asciiz " : "
    result1: .asciiz "Result is: Quotient = "
    result2: .asciiz " Remainder = "
    newLine: .asciiz "\n"
.text
    main:
        li $v0, 4
        la $a0, prompt
        syscall
        
        li $v0, 5
        syscall
        move $t0, $v0

        li $v0, 4
        la $a0, newLine
        syscall

        blez $t0, exit
        
        move $t2, $zero # Temp index
        move $t1, $zero
    loop:
        beq $t0, $t2, avg

        li $v0, 4
        la $a0, entering1
        syscall

        li $v0, 1
        move $a0, $t2
        syscall

        li $v0, 4
        la $a0, entering2
        syscall

        li $v0, 5
        syscall
        add $t1, $t1, $v0

        addi $t2, $t2, 1
        j loop

    avg:
        div $t1, $t0
        mfhi $t1
        mflo $t0

        li $v0, 4
        la $a0, result1
        syscall
    
        li $v0, 1
        move $a0, $t0
        syscall

        li $v0, 4
        la $a0, result2
        syscall
    
        li $v0, 1
        move $a0, $t1
        syscall

        li $v0, 4
        la $a0, newLine
        syscall

    exit:
        li $v0, 10
        syscall