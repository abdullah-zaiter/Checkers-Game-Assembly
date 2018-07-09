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
############					Rotina de movimenta��o aleatoria do BOT 
##################################################################################################################################################
random_move: 	
		
		addi sp, sp, -4
    	sw ra, 0(sp)
		
		push(ra)
		li	a7, 41
		ecall			# a0 recebe numero random
		li	t0, 12		
		remu	t4, a0, t0	# t4 recebe (numero random)%12
		
	rand2:	li	a7, 41
		ecall
		li	t1, 2
		rem	t5, a0, t1	# t5 recebe (numero random)%2
		push(t5)
		beq	t5, zero, rand2
		la	t0, enemy_pieces
		add	t0, t0, t5 	# Pega byte na posicao t4, do vetor enemy_pieces
		mv	t4, t0		# t4 recebe posicao na memoria da peca atual
		lbu	t1, 0(t0)
		andi	t2, t1, 0x2
		beq	t2, zero, random_move	# Se a peca possui bit de invalido==1, repete rotina random_move
		
		andi	t2, t1, 0x1C 	# Pega posicao X
		srli	t2, t2, 2
		add	t2, t2, t5	# t2 <- X+R2
		andi	t3, t1, 0xE0	# Pega posicao Y
		srli	t3, t3, 5
		addi	t3, t3, 1	# y+=1
		slli	t3, t3, 3
		or	t3, t3, t2
		slli	t5, t3, 2	# t5 possui posicao desejada (a ser analisada)
		mv	a0, t5
		la	a1, enemy_pieces
		jal	verif_vetor_rand
		bne	a0, zero, invalid_Rmove	# Se tem peca amiga (do BOT) no espaco destino, move eh invalido
		mv	a0, t5
		la	a1, ally_pieces		# Verifica se tem peca inimiga na casa de destino
		jal	verif_vetor_rand
		beq	a0, zero, casa_vazia	# Se nao houver peca amiga nem inimiga na posicao desejada, substitui a posicao da peca
		pop(t0)				# Se houver peca inimiga, verifica se eh possivel comer ela

		andi	t1, t5, 0x1C
		srli	t1, t1, 2
		add	t1, t1, t0		# t1 <- X+R2
		andi	t2, t5, 0xE0
		srli	t2, t2, 5
		addi	t2, t2, 1		# Y+=1
		srli	t2, t2, 3
		or	t2, t2, t1		#t2 <- (Y)concat(X)
		srli	t2, t2, 2		
		mv	a0, t2
		la	a1, enemy_pieces
		jal	verif_vetor_rand		# Verifica se possui pe�a do BOT na segunda posi��o da diagonal
		bne	a0, zero, invalid_Rmove
		mv	a0, t2
		la	a1, ally_pieces
		jal	verif_vetor_rand
		bne	a0, zero, invalid_Rmove	# Se h� pe�a na segunda casa diagonal, movimento eh invalido
		lbu	t0, 0(t4)
		andi	t0, t0, 0x3
		or	t5, t5, t0
		sb	t5, 0(t4)
		j	Exit_Random_Move
		
casa_vazia:	andi	t6, t6, 0x3		# Verifica se eh rainha
		or	t0, t6, t5		
		sb	t0, 0(t4)		# Substitui a posicao da peca atual pela posicao desejada
		j	Exit_Random_Move
		
invalid_Rmove:	jal	zero, random_move
Exit_Random_Move:	
		pop(ra)
		.include "verif_vetor.s"
		lw	ra, 0(sp)
		addi	sp, sp, 4
    	jr ra

		
