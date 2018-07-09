.data
	ally_pieces: 	.byte 0xA0 0xA8 0xB0 0xB8 0xC4 0xCC 0xD4 0xDC 0xE0 0xE8 0xF0 0xF8
	enemy_pieces:	.byte 0x04 0x0C 0x14 0x1C 0x20 0x28 0x30 0x38 0x44 0x4C 0x54 0x5C
	#ally_pieces: 	.byte 0xA0 0xA8 0xB0 0xB8 0x64 0x6C 0x74 0x7C 0xE0 0xE8 0xF0 0xF8
	#enemy_pieces:	.byte 0x84 0x0C 0x14 0x1C 0x20 0x28 0x30 0x38 0x44 0x4C 0x54 0x5C
.text

##################################################################################################################################################
############	Rotina de movimenta��o do jogador humano (tem que alterar pra botar na placa - ver systemv11.s -)
##################################################################################################################################################
human_move:	
		addi sp, sp, -4
    	sw ra, 0(sp)
    	#jal pushFunct

		addi	sp, sp, -4
		sw	ra, 0(sp)
		
		#li	a7, 5	
		#ecall
		li a7, 12
		li t5, 0xFFFFFFCF
		li s4, 0xFFFFFFCF
		jal exceptionHandling
		add a0, a0, t5 #a0 = 0x0000000y
		mv s3, a0
		add	t0, a0, zero
		slli	t0, t0, 3
		
		#li	a7, 5
		#ecall
		li a7, 12
		li t6, 0xFFFFFF9F
		li s4, 0xFFFFFF9F
		jal exceptionHandling
		add a0 , a0, t6	#a1 = 0x0000000x
		mv s3, a0
		or	t0, t0, a0
		slli	t0, t0, 2	# Fim da leitura da posicao atual da pe�a (contido em t0)
		
		#li	a7, 5
		#ecall
		li a7, 12
		li t5, 0xFFFFFFCF
		li s4, 0xFFFFFFCF
		jal exceptionHandling
		
		add a0, a0, t5 #a0 = 0x0000000y
		mv s3, a0

		add	t1, a0, zero
		slli	t1, t1, 3
		
		#li	a7, 5
		#ecall
		li a7, 12
		li t6, 0xFFFFFF9F
		li s4, 0xFFFFFF9F
		jal exceptionHandling
		add a0 , a0, t6	#a1 = 0x0000000x
		mv s3, a0
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
		lbu	t0, 0(a1)		# Carrega a posicao atual da peca da memoria (para saber se � rainha)
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
		li	t3, -1
		beq	a1, t3, diag_adj	# Se a distancia em Y for 1, � diagonalmente adjacente
		addi	t3, t3, -1
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
		slli	t6, t0, 5
		bne	t6, zero, not_queen1
		ori	t0, t0, 0x1		# Seta bit de rainha se chegar ao outro lado do tabuleiro
not_queen1:	sb	t0, 0(t4)		# Guarda em ally_pieces na posicao desejada
		lw	ra, 0(sp)
		addi	sp, sp, 4
		j EXIT_human_move
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
		addi	t5, t5, -1
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
		
		lbu	t2, 0(t5)
		ori	t2, t2, 0x2		# Mata a peca inimiga
		slli	t6, t0, 5
		bne	t6, zero, not_queen2
		ori	t0, t0, 0x1		# Seta bit de rainha se chegar ao outro lado do tabuleiro
not_queen2:	sb	t2, 0(t5)
		
		andi	t2, t0, 0x3
		or	t1, t1, t2
		sb	t1, 0(t4)
		
		j EXIT_human_move
		
verif_queen:	j EXIT_human_move		# Rotina caso a peca atual seja uma rainha (Falta implementar!!!!!)


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
		#j	human_move
EXIT_human_move:sw	ra, 0(sp)
		addi	sp, sp, 4
		#jal popFunct
    	jr ra
		



#PegaAsParada:
#	
#	addi sp, sp, -4
#    sw ra, 0(sp)
#    jal pushFunct
#	
#	la t0, ally_pieces
#	li t1, 12
#	LoopPegaAsParada: beq t1, zero, SaiLoopPegaAsParada 
#		lbu t2, 0(t0)
#		andi t3, t2, 0x2
#		bne t3, zero, invalid
#		andi t3, t2, 0x1C
#		srli t3, t3, 2
#		andi t4, t2, 0xE0
#		srli t4, t4, 5
#		slli t4, t4 4
#		or t4, t4, t3 
#		getPosicao(t4, s5)
#		la t6, blue
#		
#		
#		#PrintPiece(s5, t6)
#	invalid:
#		addi t0, t0, 1
#		addi t1, t1, -1
#		j LoopPegaAsParada
#	SaiLoopPegaAsParada:
#    	jal popFunct
#    	jr ra
