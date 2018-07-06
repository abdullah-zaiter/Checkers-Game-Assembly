# Teste dos syscalls 1xx que usam o SYSTEMv1.s
# Conectar o BitMap Display e o KD MMIO para executar
# na DE1-SoC e no Rars deve ter o mesmo comportamento sem alterar nada!

.include "lib/macros.s"


.data
msg1: .string "Menu"
buffer: .string "                                "

.text
	M_SetEcall(exceptionHandling)	# Macro de SetEcall
	jal PRINTSTR1	
	li a7, 10
	ecall
	
			
# CLS Clear Screen
CLS:	li a0,0x07
	li a7,148
	ecall
	ret
				
# syscall print string
PRINTSTR1: li a7,104
	la a0,msg1
	li a1,0
	li a2,0
	li a3,0xFF0000FF
	ecall
	ret
	




.include "lib/SYSTEMv11.s"
