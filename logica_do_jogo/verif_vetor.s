.data
	ally_pieces: 	.byte 0x40 0x48 0x50 0x58 0x24 0x2C 0x34 0x3C 0x00 0x08 0x10 0x18
	enemy_pieces:	.byte 0xA4 0xAC 0xB4 0xBC 0xC0 0xC8 0xD0 0xD8 0xE4 0xEC 0xF4 0xFC
.text
li	a0, 0x20
la	a1, ally_pieces

##################################################################################################
############		Verifica se a posicao em 0(a0) esta no vetor comecando em a1
############		       recebe			###		retorna	
############	   a0 -> byte 0 contem a posicao	###     (contem posicao)?(a0=1):(a0=0)
############	 a1 -> endereco do inicio do vetor	###	a1 = posicao no vetor
##################################################################################################
verif_vetor:	li	t0, 12
		addi	a1, a1, 11
for_verif_pos:	beq	t0, zero, not_found
		lb	t1, 0(a1)
		andi	t2, t1, 0x2		
		bne	t2, zero, dead_piece	# testa se peca esta morta (bit 2)
		andi	t2, t1, 0xFC		# pega posicoes X e Y
		beq	a0, t2, found_pos	# se t2==a0, encontrou peca nessa posicao
dead_piece:	addi	t0, t0, -1
		addi	a1, a1, -1
		j	for_verif_pos
found_pos:	li	a0, 1
		j	exit_verif_vetor
not_found:	li	a0, 0
exit_verif_vetor:#jr	ra			# descomentar para funcionar