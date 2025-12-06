.data
    LenMsg: .asciiz "Enter Array Size: "
    EnterArray: .asciiz "Enter the array: \n"
    MinMsg: .asciiz "Minimum Number is: "
    MaxMsg: .asciiz "Maximum Number is: "
    AvgMsg: .asciiz "Average is: "
    newLine: .asciiz "\n"
.text
main:
    # Entering array length
    la $a0, LenMsg
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0 # length

    # Allocating array
    li $t0, 4
    mul $t0, $s0, $t0

    li $v0, 9
    move $a0, $t0 # size in bytes
    syscall
    move $s1, $v0 # s1 is array address in heap

    li $v0, 4
    la $a0, EnterArray
    syscall

    li $t0, 0 # counter 
    move $t1, $s1 # array address

    ArrayFillingLoop:
        beq $t0, $s0, ExitArrayFilling
        
        li $v0, 5
        syscall
        sw $v0, 0($t1)

        addi $t1, $t1, 4
        addi $t0, $t0, 1
        j ArrayFillingLoop

    ExitArrayFilling:

    li $v0, 4
    la $a0, newLine
    syscall

    li $t0, 0
    move $t1, $s1
    li $t2, 0x7FFFFFFF # maximum signed value 011...1

    ArrayMinCalcLoop:
        beq $t0, $s0, ExitArrayMinCalc
        
        lw $t3, 0($t1)
        bgt $t3, $t2, NoNewLess
            move $t2, $t3 # New min
        
        NoNewLess:
        addi $t1, $t1, 4
        addi $t0, $t0, 1
        j ArrayMinCalcLoop

    ExitArrayMinCalc:
        li $v0, 4
        la $a0, MinMsg
        syscall

        li $v0, 1
        move $a0, $t2
        syscall

    li $v0, 4
    la $a0, newLine
    syscall

    li $t0, 0
    move $t1, $s1
    li $t2, 0x80000000 # minimum signed value 100..0

    ArrayMaxCalcLoop:
        beq $t0, $s0, ExitArrayMaxCalc
        
        lw $t3, 0($t1)
        blt $t3, $t2, NoNewMax
            move $t2, $t3 # New max
        
        NoNewMax:
        addi $t1, $t1, 4
        addi $t0, $t0, 1
        j ArrayMaxCalcLoop

    ExitArrayMaxCalc:
        li $v0, 4
        la $a0, MaxMsg
        syscall

        li $v0, 1
        move $a0, $t2
        syscall

    li $v0, 4
    la $a0, newLine
    syscall

    li $t0, 0
    move $t1, $s1
    li $t2, 0 # sum

    ArrayAvgCalcLoop:
        beq $t0, $s0, ExitArrayAvgCalc
        
        lw $t3, 0($t1)
        add $t2, $t2, $t3

        addi $t1, $t1, 4
        addi $t0, $t0, 1
        j ArrayAvgCalcLoop

    ExitArrayAvgCalc:
        li $v0, 4
        la $a0, AvgMsg
        syscall

        div $t2, $s0
        mflo $t2

        li $v0, 1
        move $a0, $t2
        syscall

jr $ra
