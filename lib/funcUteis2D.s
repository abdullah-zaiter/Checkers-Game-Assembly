.text

PushAll:
	addi sp, sp, -4
	sw x0, 0(sp)
	addi sp, sp, -4
	sw x1, 0(sp)
	addi sp, sp, -4
	sw x2, 0(sp)
	addi sp, sp, -4
	sw x3, 0(sp)
	addi sp, sp, -4
	sw x4, 0(sp)
	addi sp, sp, -4
	sw x5, 0(sp)
	addi sp, sp, -4
	sw x6, 0(sp)
	addi sp, sp, -4
	sw x7, 0(sp)
	addi sp, sp, -4
	sw x8, 0(sp)
	addi sp, sp, -4
	sw x9, 0(sp)
	addi sp, sp, -4
	sw x10, 0(sp)
	addi sp, sp, -4
	sw x11, 0(sp)
	addi sp, sp, -4
	sw x12, 0(sp)
	addi sp, sp, -4
	sw x13, 0(sp)
	addi sp, sp, -4
	sw x14, 0(sp)
	addi sp, sp, -4
	sw x15, 0(sp)
	addi sp, sp, -4
	sw x16, 0(sp)
	addi sp, sp, -4
	sw x17, 0(sp)
	addi sp, sp, -4
	sw x18, 0(sp)
	addi sp, sp, -4
	sw x19, 0(sp)
	addi sp, sp, -4
	sw x20, 0(sp)
	addi sp, sp, -4
	sw x21, 0(sp)
	addi sp, sp, -4
	sw x22, 0(sp)
	addi sp, sp, -4
	sw x23, 0(sp)
	addi sp, sp, -4
	sw x24, 0(sp)
	addi sp, sp, -4
	sw x25, 0(sp)
	addi sp, sp, -4
	sw x26, 0(sp)
	addi sp, sp, -4
	sw x27, 0(sp)
	addi sp, sp, -4
	sw x28, 0(sp)
	addi sp, sp, -4
	sw x29, 0(sp)
	addi sp, sp, -4
	sw x30, 0(sp)
	addi sp, sp, -4
	sw x31, 0(sp)
	jr ra



PopAll:
	addi sp, sp, 4
	sw x31, 0(sp)
	addi sp, sp, 4
	sw x30, 0(sp)
	addi sp, sp, 4
	sw x29, 0(sp)
	addi sp, sp, 4
	sw x28, 0(sp)
	addi sp, sp, 4
	sw x27, 0(sp)
	addi sp, sp, 4
	sw x26, 0(sp)
	addi sp, sp, 4
	sw x25, 0(sp)
	addi sp, sp, 4
	sw x24, 0(sp)
	addi sp, sp, 4
	sw x23, 0(sp)
	addi sp, sp, 4
	sw x22, 0(sp)
	addi sp, sp, 4
	sw x21, 0(sp)
	addi sp, sp, 4
	sw x20, 0(sp)
	addi sp, sp, 4
	sw x19, 0(sp)
	addi sp, sp, 4
	sw x18, 0(sp)
	addi sp, sp, 4
	sw x17, 0(sp)
	addi sp, sp, 4
	sw x16, 0(sp)
	addi sp, sp, 4
	sw x15, 0(sp)
	addi sp, sp, 4
	sw x14, 0(sp)
	addi sp, sp, 4
	sw x13, 0(sp)
	addi sp, sp, 4
	sw x12, 0(sp)
	addi sp, sp, 4
	sw x11, 0(sp)
	addi sp, sp, 4
	sw x10, 0(sp)
	addi sp, sp, 4
	sw x9, 0(sp)
	addi sp, sp, 4
	sw x8, 0(sp)
	addi sp, sp, 4
	sw x7, 0(sp)
	addi sp, sp, 4
	sw x6, 0(sp)
	addi sp, sp, 4
	sw x5, 0(sp)
	addi sp, sp, 4
	sw x4, 0(sp)
	addi sp, sp, 4
	sw x3, 0(sp)
	addi sp, sp, 4
	sw x2, 0(sp)
	addi sp, sp, 4
	sw x1, 0(sp)
	addi sp, sp, 4
	sw x0, 0(sp)
	jr ra



#a0 = address
checkColor:
    lb t0, 0(a0)
    
