.text
li	a0, 0x20
la	a1, ally_pieces

##################################################################################################
############		Verifica se a posicao em 0(a0) esta no vetor comecando em a1
############		       recebe			###		retorna	
############	   a0 -> byte 0 contem a posicao	###     (contem posicao)?(a0=1):(a0=0)
############	 a1 -> endereco do inicio do vetor	###	a1 = posicao no vetor
##################################################################################################
verif_vetor_rand:	

		addi sp, sp, -4
    	sw ra, 0(sp)
		jal pushAll

		li	t0, 12
		addi	a1, a1, 11
for_verif_pos_rand:	beq	t0, zero, not_found_rand
		lb	t1, 0(a1)
		andi	t2, t1, 0x2		
		bne	t2, zero, dead_piece_rand	# testa se peca esta morta (bit 2)
		andi	t2, t1, 0xFC		# pega posicoes X e Y
		beq	a0, t2, found_pos_rand	# se t2==a0, encontrou peca nessa posicao
dead_piece_rand:	addi	t0, t0, -1
		addi	a1, a1, -1
		j	for_verif_pos_rand
found_pos_rand:	li	a0, 1
		j	exit_verif_vetor_rand
not_found_rand:	li	a0, 0
exit_verif_vetor_rand:
		lw	ra, 0(sp)
		addi	sp, sp, 4
		jal popAll
		jr	ra			# descomentar para funcionar