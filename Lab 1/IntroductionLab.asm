# Introduction Lab
.data 
    # Label: is simply a name that represents a memory address, when we declare a label
    # we are giving a name to a specific location in memory where data is stored
    # .asciiz is a directive to allocate data [.word, .byte, .text, .byte, ...]

    hello: .asciiz "\nHello World\n"
    format: .asciiz "\nName: Mahmoud Gamal\nID: 0xffff\nCoure: CSE21-Computer-Organization"
    ending: .asciiz "\nAre you satisfied...\nY/N?\n"

.text
    main:
        service:
            # ---- Printing Hello World ---- #

            li $v0, 4 # 4 for printing 
            la $a0, hello # Load memory address of hello lable inside a0 regiter
            syscall # System Call

            # When invoking syscall the CPU will look at v0 to know the required service
            # Then looking at a0, a1, a2, a3 to get the arguments
            # It might return a value usually in v0 then gives control back to the program

            # ---- Print Simple Text Format ---- #
            # Name:   Your Name
            # ID:     Your ID
            # Course: CSE321-Computer-Organization

            li $v0, 4
            la $a0, format
            syscall

            li $v0, 4
            la $a0, ending
            syscall

            li $v0, 12 # 12 is operation number for reading character
            syscall # Wait for input character

            move $t0, $v0
            # if N jump for main else end
            li $t1, 'Y'
            beq $t0, $t1, is_satisfied # branch on equal if t0 equals t1 go to is_satisfied else skip to not_satisfied
            j not_satisfied # j is used for jump between labels

    is_satisfied: 
        j end_program 

    not_satisfied:
        li $t0, 0 # Clearing temp register
        j service 

    end_program:
        li $v0, 10 # 10 for exit
        syscall # System Call
