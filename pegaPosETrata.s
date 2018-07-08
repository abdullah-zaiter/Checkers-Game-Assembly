
	li a7, 12
	li s0, 0xFFFFFFCF
	jal exceptionHandling
	add s0, a0, s0
	li s1, 0xFFFFFF9F
	li a7, 12
	jal exceptionHandling
	add s1 , a0, s1
	j exit 
.include "lib/SYSTEMv11.s"
exit:	j exit
