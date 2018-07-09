.data
    .eqv largura 320

.text




#a0 = getPos(0x000000yx)
#a2 = meia largura da peça
#t1 = variavel auxiliar
#retorna a0 = cor
checkColor:
    add t1, zero, a0
    add t1, t1, a2 #t1 <- orig + meia largura
    li t0, largura #t0 <- 320
    mul t0, t0, a2  #t0 <- 320 * meia largura
    add t1, t1, t0 #t1 <- orig + meia largura + (320 * meia largura)
    lb a0, 0(t1)
    jr ra


#a1 = 0x000000yx
#retorna a0 = posicao na memoria de imagem
getPos:
    addi sp, sp, -4
    sw ra, 0(sp)

    add t5,zero, a1 
    slli t5, t5, 4 # t5 = 0x00000yx0  
    li t6, AddressHashTableBg
    add t5, t5, t6  #t5 = 0x????0yx0
    lw a0, 0(t5) #retorna posicao 0x????0yx0 para a0

    jr ra



##a0 = 0x000000yx
##a1 = color
#initPos:
#    jal PushAll
#    
#    add t1, a1, zero
#	
#    li a0, A8 #calcular
#	li t2,AddressA8
#	sw a0, 0(t2)
#	jal EscrevePeca #a0 = pos, a1 = color
#    #============================= repetir pra todas as peças (24 vezes)
#
#    jal PopAll
#    jr ra

#a0 = pos inicial do quadrado na memoria
#a2 = cor
PrintBackGround:
    li a0, ScreenBg
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct

    li a2, BLACK

    #a1 = tamanho do quadrado
    li a1, 320
    jal PaintSquare

    jal popFunct
    jr ra

#a0 = pos inicial do quadrado na memoria
#a2 = cor
PrintPiece:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushAll

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    jal PaintSquare

    jal popAll
    jr ra


#a0 = pos inicial do quadrado na memoria
PrintPieceBLUEKing:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushAll

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    #a2 = cor
    li t0, YELLOW
	add a2, zero, t0
    jal PaintSquare

    jal popAll
    jr ra

#a0 = pos inicial do quadrado na memoria
PrintPieceRedKing:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushAll

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    #a2 = cor
    li t0, PURPLE
	add a2, zero, t0
    jal PaintSquare

    jal popAll
    jr ra

updateAlly:
	addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct
	
	la t0, ally_pieces
	li t1, 12
	LoopPegaAsParada: beq t1, zero, SaiLoopPegaAsParada 
		lbu t2, 0(t0)
		andi t3, t2, 0x2
		bne t3, zero, Einvalid
		andi t3, t2, 0x1C
		srli t3, t3, 2
		andi t4, t2, 0xE0
		srli t4, t4, 5
		slli t4, t4 4
		or t4, t4, t3 
		add a0, zero, t4
		add a1, zero, a0
		
		#jal getPos
			add t5,zero, a1 
    		slli t5, t5, 4 # t5 = 0x00000yx0  
    		li t6, AddressHashTableBg
    		add t5, t5, t6  #t5 = 0x????0yx0
    		lw a0, 0(t5) #retorna posicao 0x????0yx0 para a0
		#getPosicao(t4, s5) #t4 = 0x000000yx, s5 = address
		add a2, zero, s1
		#li a2, GREEN#DEBUG
        add s3, zero, a0
		jal PrintPiece	
	Einvalid:
		addi t0, t0, 1
		addi t1, t1, -1
		j LoopPegaAsParada
	SaiLoopPegaAsParada:
    	jal popFunct
    	jr ra



updateEnemy:
	addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct
	
	la t0, enemy_pieces
	li t1, 12
	ELoopPegaAsParada: beq t1, zero, SaiELoopPegaAsParada 
		lbu t2, 0(t0)
		andi t3, t2, 0x2
		bne t3, zero, invalid
		andi t3, t2, 0x1C
		srli t3, t3, 2
		andi t4, t2, 0xE0
		srli t4, t4, 5
		slli t4, t4 4
		or t4, t4, t3 
		add a0, zero, t4
		add a1, zero, a0
		
		#jal getPos
			add t5,zero, a1 
    		slli t5, t5, 4 # t5 = 0x00000yx0  
    		li t6, AddressHashTableBg
    		add t5, t5, t6  #t5 = 0x????0yx0
    		lw a0, 0(t5) #retorna posicao 0x????0yx0 para a0
		#getPosicao(t4, s5) #t4 = 0x000000yx, s5 = address
		add a2, zero, s2
        jal PrintPiece
	invalid:
		addi t0, t0, 1
		addi t1, t1, -1
		j ELoopPegaAsParada
	SaiELoopPegaAsParada:
    	jal popFunct
    	jr ra

