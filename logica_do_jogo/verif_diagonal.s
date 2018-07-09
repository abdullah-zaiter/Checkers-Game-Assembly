.text
li	t0, 0x64
slli	t0, t0, 8
ori	t0, t0, 0x48
mv	a0, t0
##################################################################################################################################################
############						    Verifica se as posicoes em 0(a0) e 1(a0) s�o diagonais 
############		                          recebe				###			    retorna	
############	   a0 -> byte 0 contem a posicao atual, byte 1 contem posicao desejada	###     se (a0==0) n�o � diagonal, se (a0==1) � diagonal
############	  									###		a1 = diferenca em y (y2-y1)
##################################################################################################################################################
verif_diagonal:	andi	t2, a0, 0xFF
		srli	a0, a0, 8
		andi	t3, a0, 0xFF
		andi	t0, t2, 0x1C	# Pega posicao em X da primeira peca (X1)
		srli	t0, t0, 2	
		andi	t1, t3, 0x1C	# Pega posicao em X da segunda peca  (X2)
		srli	t1, t1, 2
		srli	t2, t2, 5	# Pega posicao em Y da primeira peca (Y1)
		srli	t3, t3, 5	# Pega posicao em Y da segunda peca  (Y2)
		sub	t3, t3, t2	# Y2-Y1
		sub	t1, t1, t0	# X2-X1
		div	t0, t3, t1	# (Y2-Y1)/(X2-X1)
		li	t1, 1
		beq	t0, t1, is_diagonal
		li	t1, -1
		beq	t0, t1, is_diagonal
		j	not_diagonal
is_diagonal:	li	a0, 1
		mv	a1, t3
		j	exit_verif_diagonal
not_diagonal:	li	a0, 0
exit_verif_diagonal:	#jr	ra		# Descomentar para funcionar!!!!