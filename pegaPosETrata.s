
	li a7, 12
	li t0, 48
	jal exceptionHandling
	sub t0, a0, t0
	addi t0, t0, 0xFFFFFFFF
	li t1, 0xFFFFFF9F
	li a7, 12
	jal exceptionHandling
	add t1 , a0, t1
	j exit 
.include "lib/SYSTEMv11.s"
exit: