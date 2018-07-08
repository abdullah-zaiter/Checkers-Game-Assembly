.text
.macro push(%label)
	addi	sp, sp, -4
	sw	%label, 0(sp)
.end_macro
.macro pop(%label)
	lw	%label, 0(sp)
	addi	sp, sp, 4
.end_macro
##################################################################################################################################################
############					Rotina de movimentação aleatoria do BOT 
##################################################################################################################################################
random_move: 	push(ra)
		li	a7, 41
		ecall			# a0 recebe numero random
		li	t0, 12		
		remu	t4, a0, t0	# t4 recebe (numero random)%12
		
	rand2:	li	a7, 41
		ecall
		li	t1, 2
		rem	t5, a0, t1	# t5 recebe (numero random)%2
		beq	t5, zero, rand2
		la	t0, enemy_pieces
		add	t0, t0, t4 	# Pega byte na posicao t4, do vetor enemy_pieces
		mv	t4, t0
		lbu	t1, 0(t0)
		andi	t2, t1, 0x2
		beq	t2, zero, random_move	# Se a peca possui bit de invalido==1, repete rotina random_move
		
		andi	t2, t1, 0x1C 	# Pega posicao X
		srli	t2, t2, 2
		add	t2, t2, t5	# t2 <- X+R2
		mv	t6, t2		# Salva o t2 em t6
		andi	t3, t1, 0xE0	# Pega posicao Y
		addi	t3, t3, 1	# y+=1
		slli	t3, t3, 3
		or	t3, t3, t2
		slli	t5, t3, 2	# t5 possui posicao desejada (a ser analisada)
		mv	t6, t1
		mv	a0, t5
		la	a1, enemy_pieces
		jal	verif_vetor
		beq	a0, zero, invalid_Rmove	# Se tem peca amiga (do BOT) no espaco destino, move eh invalido
		mv	a0, t5
		la	a1, ally_pieces		# Verifica se tem peca inimiga na casa de destino
		jal	verif_vetor
		beq	a0, zero, casa_vazia	# Se nao houver peca amiga nem inimiga na posicao desejada, substitui a posicao da peca
						# Se houver peca inimiga, verifica se eh possivel comer ela
		
		
casa_vazia:	andi	t6, t6, 0x3		# Verifica se eh rainha
		or	t0, t6, t5		
		sb	t0, 0(t4)		# Substitui a posicao da peca atual pela posicao desejada
		j	Exit_Random_Move
		
invalid_Rmove:	jal	zero, random_move
Exit_Random_Move:	pop(ra)
		.include "verif_vetor.s"
		
