
.macro WinMusic()
	li a7, 31
	li a0, 60
	li a1, 5000
	li a2, 126
	li a3, 120
	jal exceptionHandling
.end_macro

.macro LoseMusic()
	li a7, 31
	li a0, 83
	li a1, 500
	li a2, 73
	li a3, 120
	jal exceptionHandling
	li a7, 32
	li a0, 450
	jal exceptionHandling
	li a7, 31
	li a0, 82
	jal exceptionHandling
	li a7, 32
	li a0, 450
	jal exceptionHandling
	li a7, 31
	li a0, 75
	li a1, 2000
	jal exceptionHandling
	li a7, 32
	li a0, 1950
	jal exceptionHandling
.end_macro
	
	
	
main:	
	LoseMusic()
j EXIT
.include "SYSTEMv11.s"
EXIT: