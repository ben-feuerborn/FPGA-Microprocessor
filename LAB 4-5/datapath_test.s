.data

.text
main:
    add $t0, $zero, $zero   # (display: 0, 0)       t0 = 0
    nop
    nop
    nop
    nop
    nop
    addi $t1, $t0, 6        # (display: 24, 6)      t1 = 6
    nop
    nop
    nop
    nop
    nop
    addi $t2, $t0, 10       # (display: 48, 10)     t2 = 10
    nop
    nop
    nop
    nop
    nop
    sub $t0, $t2, $t1       # (display: 72, 4)      t0 = 10 - 6 = 4
    nop
    nop
    nop
    nop
    nop
    mul $t2, $t0, $t1       # (display: 96, 24)     t2 = 4 * 6 = 24
    nop
    nop
    nop
    nop
    nop
    and $t2, $t0, $t1       # (display: 120, 4)     t2 = 4 && 6 = 100 && 110 = 100
    nop
    nop
    nop
    nop
    nop
    andi $t3, $t0, 7        # (display: 144, 4)     t3 = 4 && 7 = 100 && 111 = 100
    nop
    nop
    nop
    nop
    nop
    or $t4, $t0, $t1        # (display: 168, 6)     t4 = 4 || 6 = 100 || 110 = 110
    nop
    nop
    nop
    nop
    nop
    ori $t5, $t0, 11        # (display: 192, 15)    t5 = 4 || 11 = 0100 || 1011 = 1111
    nop
    nop
    nop
    nop
    nop
    xor $t6, $t0, $t1       # (display: 216, 2)     t6 = 4 XOR 6 = 100 XOR 110 = 010
    nop
    nop
    nop
    nop
    nop
    xori $t7, $t0, 10       # (display: 240, 14)    t7 = 4 XOR 10 = 0100 XOR 1010 = 1110
    nop
    nop
    nop
    nop
    nop
    nor $t8, $t0, $t0       # (display: 264, 3)     t8 = 4 NOR  = 100 NOR 100 = 011
    nop
    nop
    nop
    nop
    nop
    sll $t2, $t2, 2         # (display: 288, 16)    t2 = 4 << 2 = 16
    nop
    nop
    nop
    nop
    nop
    srl $t3, $t3, 1         # (display: 312, 2)     t3 = 4 >> 1 = 2
    nop
    nop
    nop
    nop
    nop
branch_1:
    beq $t0, $t0, branch_2  # (display: ?, 0)
    nop
    nop
    nop
    nop
    nop
branch_3:
    slti $t9, $t4, 10       # (display: 360, 1)     t9 = 6 < 10
    nop
    nop
    nop
    nop
    nop
    j exit                  # (display: ?, 0)
    nop
    nop
    nop
    nop
    nop
branch_2:
    slt $t9, $t2, $t3       # (display: 336, 0)     t9 = 16 < 2
    nop
    nop
    nop
    nop
    nop
    bne $t0, $t1, branch_3  # (display: ?, 0)
    nop
    nop
    nop
    nop
    nop
exit:
    sw $t1, 4($s0)          # (display: ?, 0)
    nop
    nop
    nop
    nop
    nop
    lw $t2, 0($s0)          # (display: ?, 0)