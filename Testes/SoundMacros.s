Main:	jal ra, Lose
	j End

WinMus:	li a7, 31
	li a0, 60
	li a1, 1800
	li a2, 126
	li a3, 120
	ecall
	ecall
	ecall
	ecall
	ecall
	ecall
	ecall
	ecall
	ecall
	ret

Lose:	li a7, 31
	li a0, 83
	li a1, 500
	li a2, 73
	li a3, 120
	ecall
	li a7, 32
	li a0, 450
	ecall
	li a7, 31
	li a0, 82
	ecall
	li a7, 32
	li a0, 450
	ecall
	li a7, 31
	li a0, 75
	li a1, 2000
	ecall
	li a7, 32
	li a0, 1950
	ecall
	ret
	
End:
