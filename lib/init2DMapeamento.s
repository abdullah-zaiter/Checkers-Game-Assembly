 # a2 = cor
initTabuleiro:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal pushFunct

	li t5, BLUE
	li t6, RED

	beq a2, t6, startBLUE  # se cor init = RED
	j startRED
	startBLUE:
		li a2, BLUE
		li s1, RED
		li s2, BLUE
		j continueTab
	startRED:  # t1 continua verde, aliado = vermelho
		li a2, RED
		li s2, RED
		li s1, BLUE
	continueTab:

	li a0, pieceB1#t0 = posicao de memoria visual
	li t2, AddressB1#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceD1#t0 = posicao de memoria visual
	li t2, AddressD1#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceF1#t0 = posicao de memoria visual
	li t2, AddressF1#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceH1#t0 = posicao de memoria visual
	li t2, AddressH1#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceA2#t0 = posicao de memoria visual
	li t2, AddressA2#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceC2#t0 = posicao de memoria visual
	li t2, AddressC2#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceE2#t0 = posicao de memoria visual
	li t2, AddressE2#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceG2#t0 = posicao de memoria visual
	li t2, AddressG2#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceB3#t0 = posicao de memoria visual
	li t2, AddressB3#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceD3#t0 = posicao de memoria visual
	li t2, AddressD3#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceF3#t0 = posicao de memoria visual
	li t2, AddressF3#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceH3#t0 = posicao de memoria visual
	li t2, AddressH3#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceA4#t0 = posicao de memoria visual
	li t2, AddressA4#t2 = posicao memoria hash
	sw a0, 0(t2)
	li a0, pieceC4#t0 = posicao de memoria visual
	li t2, AddressC4#t2 = posicao memoria hash
	sw a0, 0(t2)
	li a0, pieceE4#t0 = posicao de memoria visual
	li t2, AddressE4#t2 = posicao memoria hash
	sw a0, 0(t2)
	li a0, pieceG4#t0 = posicao de memoria visual
	li t2, AddressG4#t2 = posicao memoria hash
	sw a0, 0(t2)
	li a0, pieceB5#t0 = posicao de memoria visual
	li t2, AddressB5#t2 = posicao memoria hash
	sw a0, 0(t2)
	li a0, pieceD5#t0 = posicao de memoria visual
	li t2, AddressD5#t2 = posicao memoria hash
	sw a0, 0(t2)
	li a0, pieceF5#t0 = posicao de memoria visual
	li t2, AddressF5#t2 = posicao memoria hash
	sw a0, 0(t2)
	li a0, pieceH5#t0 = posicao de memoria visual
	li t2, AddressH5#t2 = posicao memoria hash
	sw a0, 0(t2)


	beq a2, t6, turnBLUE  # se cor = RED =>
	j REDdy
	turnBLUE:
	    	li a2, BLUE
	    	j continueTab2
	REDdy:
	    	li a2, RED
	continueTab2:

	li a0, pieceA6#t0 = posicao de memoria visual
	li t2, AddressA6#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceC6#t0 = posicao de memoria visual
	li t2, AddressC6#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceE6#t0 = posicao de memoria visual
	li t2, AddressE6#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceG6#t0 = posicao de memoria visual
	li t2, AddressG6#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceB7#t0 = posicao de memoria visual
	li t2, AddressB7#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceD7#t0 = posicao de memoria visual
	li t2, AddressD7#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceF7#t0 = posicao de memoria visual
	li t2, AddressF7#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceH7#t0 = posicao de memoria visual
	li t2, AddressH7#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceA8#t0 = posicao de memoria visual
	li t2, AddressA8#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceC8#t0 = posicao de memoria visual
	li t2, AddressC8#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceE8#t0 = posicao de memoria visual
	li t2, AddressE8#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	li a0, pieceG8#t0 = posicao de memoria visual
	li t2, AddressG8#t2 = posicao memoria hash
	sw a0, 0(t2)


	jal PrintPiece

	jal popFunct
	jr ra
