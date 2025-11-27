main:
    li $t0, 2

    # switch
    beq $t0, 1, case1
    beq $t0, 2, case2
    beq $t0, 3, case3
    j   default

case1:
    li $a0, 10    
    li $v0, 4   # print 10
    j  end

case2:
    li $a0, 20    
    li $v0, 4   # print 20
    j  end

case3:
    li $a0, 30    
    li $v0, 4   # print 30
    j  end

default:
    li $a0, -1    
    li $v0, 4   # print -1
    
end:
    li   $v0, 10    # exit syscall
    syscall
