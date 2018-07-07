.data
	ally_pieces: 	.byte 0x40 0x48 0x50 0x58 0x24 0x2C 0x34 0x3C 0x00 0x08 0x10 0x18
	enemy_pieces:	.byte 0x64 0xAC 0xB4 0xBC 0xC0 0xC8 0xD0 0xD8 0xE4 0xEC 0xF4 0xFC
.text

##################################################################################################################################################
############	Rotina de movimenta��o do jogador humano (tem que alterar pra botar na placa - ver systemv11.s -)
##################################################################################################################################################
human_move:	addi	sp, sp, -4
		sw	ra, 0(sp)
		li	a7, 5	
		ecall
		add	t0, a0, zero
		slli	t0, t0, 3
		li	a7, 5
		ecall
		or	t0, t0, a0
		slli	t0, t0, 2	# Fim da leitura da posicao atual da pe�a (contido em t0)
		li	a7, 5
		ecall
		add	t1, a0, zero
		slli	t1, t1, 3
		li	a7, 5
		ecall
		or	t1, t1, a0
		slli	t1, t1, 2	# Fim da leitura da posicao desejada da peca (contido em t1)
	################################# FIM da primeira parte #####################################
		addi	sp, sp, -8
		sw	t0, 0(sp)
		sw	t1, 4(sp)
		la	a1, ally_pieces
		mv	a0, t0
		jal	ra, verif_vetor			# Testa se posicao atual possui peca em ally_pieces
		lw	t0, 0(sp)
		lw	t1, 4(sp)
		addi	sp, sp, 8
		beq	a0, zero, invalid_move
		lb	t0, 0(a1)		# Carrega a posicao atual da peca da memoria (para saber se � rainha)
		mv	t4, a1
		mv	a0, t1
		slli	a0, a0, 8
		or	a0, a0, t0		# Carrega em 0(a0) posicao atual da peca, e em 1(a0) a posicao desejada
		addi	sp, sp, -8
		sw	t0, 0(sp)
		sw	t1, 4(sp)
		jal	ra, verif_diagonal
		lw	t0, 0(sp)
		lw	t1, 4(sp)
		addi	sp, sp, 8
		beq	a0, zero, invalid_move	# Se a0==0, os pontos nao estao em diagonal
		li	t3, 1
		beq	a1, t3, diag_adj	# Se a distancia em Y for 1, � diagonalmente adjacente
		addi	t3, t3, 1
		beq	a1, t3, diag_adj2	# Se a distancia em Y for 2, � diagonal pulando uma casa (poss�vel ataque ao inimigo)
		andi	t2, t0, 0x1
		beq	t2, zero, invalid_move	# Se nao for rainha, a peca nao pode pular mais de duas casas na diagonal
		j	verif_queen
diag_adj:	mv	a0, t1			# Rotina caso a posicao destino seja diagonalmente adjacente
		la	a1, ally_pieces
		addi	sp, sp, -8
		sw	t0, 0(sp)
		sw	t1, 4(sp)
		jal	ra, verif_vetor		# Verifica se alguma peca em ally_pieces esta na posicao destino
		lw	t0, 0(sp)
		lw	t1, 4(sp)
		addi	sp, sp, 8
		bne	a0, zero, invalid_move
		mv	a0, t1
		la	a1, enemy_pieces
		addi	sp, sp, -8
		sw	t0, 0(sp)
		sw	t1, 4(sp)
		jal	ra, verif_vetor		# Verifica se alguma peca em enemy_pieces esta na posicao destino
		lw	t0, 0(sp)
		lw	t1, 4(sp)
		addi	sp, sp, 8
		bne	a0, zero, invalid_move
		andi	t0, t0, 0x3		# Tratamento para salvar a peca com nova posicao no vetor ally_pieces
		or	t0, t0, t1
		sb	t0, 0(t4)		# Guarda em ally_pieces na posicao desejada
		lw	ra, 0(sp)
		addi	sp, sp, 4
		#jr	ra
		j EXIT
diag_adj2:	andi	t2, t0, 0x1C				# Rotina caso a posicao destino seja diagonal pulando uma casa
		andi	t3, t1, 0x1C
		blt	t2, t3, soma1		# Se a peca pular para a direita (X1<X2) soma 1 em X para encontrar casa intermediaria, senao sub 1
		j	sub1
	soma1:	li	t2, 1
		j	gogo
	sub1:	li	t2, -1
	gogo:	andi	t3, t0, 0x1C	# Pega posicao X
		andi	t5, t0, 0xE0	# Pega posicao Y
		srli	t3, t3, 2
		add	t3, t3, t2	# soma (1) ou (-1) para achar casa intermediaria (peca a ser atacada)
		slli	t3, t3, 2
		srli	t5, t5, 5
		addi	t5, t5, 1
		slli	t5, t5, 5
		or	t3, t3, t5
		mv	a0, t3
		la	a1, enemy_pieces
		addi	sp, sp, -8
		sw	t0, 0(sp)
		sw	t1, 4(sp)
		jal	ra, verif_vetor
		mv	t5, a1			# t5 guarda o endereco da peca atacada
		lw	t0, 0(sp)
		lw	t1, 4(sp)
		addi	sp, sp, 8
		beq	a0, zero, invalid_move	# Fim da verificacao se existe peca inimiga a ser pulada
		
		mv	a0, t1			# Inicio checagem se posicao final esta vazia (t1)
		la	a1, ally_pieces
		addi	sp, sp, -8
		sw	t0, 0(sp)
		sw	t1, 4(sp)
		jal	ra, verif_vetor		# Verifica se alguma peca em ally_pieces esta na posicao destino
		lw	t0, 0(sp)
		lw	t1, 4(sp)
		addi	sp, sp, 8
		bne	a0, zero, invalid_move
		mv	a0, t1
		la	a1, enemy_pieces
		addi	sp, sp, -8
		sw	t0, 0(sp)
		sw	t1, 4(sp)
		jal	ra, verif_vetor		# Verifica se alguma peca em enemy_pieces esta na posicao destino
		lw	t0, 0(sp)
		lw	t1, 4(sp)
		addi	sp, sp, 8
		bne	a0, zero, invalid_move	# Fim da checagem se posicao final esta vazia
		
		lb	t2, 0(t5)
		ori	t2, t2, 0x2		# Mata a peca inimiga
		sb	t2, 0(t5)
		
		andi	t2, t0, 0x3
		or	t1, t1, t2
		sb	t1, 0(t4)
		
		j EXIT
		
verif_queen:	j EXIT				# Rotina caso a peca atual seja uma rainha (Falta implementar!!!!!)


##################################################################################################################################################
############		Verifica se a posicao em 0(a0) esta no vetor comecando em a1
############		       recebe			###		retorna	
############	   a0 -> byte 0 contem a posicao	###     (contem posicao)?(a0=1):(a0=0)
############	 a1 -> endereco do inicio do vetor	###	a1 = posicao no vetor
##################################################################################################################################################
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
exit_verif_vetor:	jr	ra			# descomentar para funcionar

##################################################################################################################################################
############						    Verifica se as posicoes em 0(a0) e 1(a0) s�o diagonais 
############		                          recebe				###			    retorna	
############	   a0 -> byte 0 contem a posicao atual, byte 1 contem posicao desejada	###     se (a0==0) n�o � diagonal, se (a0==1) � diagonal
############	  									###		a1 = diferenca em y (y2-y1)
##################################################################################################################################################
verif_diagonal:	andi	t2, a0, 0xFF
		srli	a0, a0, 8
		andi	t3, a0, 0xFF
		andi	t0, t2, 0x1C	# Pega posicao em X da primeira peca
		srli	t0, t0, 2	
		andi	t1, t3, 0x1C	# Pega posicao em X da segunda peca
		srli	t1, t1, 2
		srli	t2, t2, 5	# Pega posicao em Y da primeira peca
		srli	t3, t3, 5	# Pega posicao em Y da segunda peca
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
exit_verif_diagonal:	jr	ra		# Descomentar para funcionar

invalid_move:	##### MOSTRA MSG DE ERRO E REPETE TURNO ####
		j	human_move
EXIT:
