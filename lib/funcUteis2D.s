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


#a0 = 0x000000yx
#retorna a0 = posicao na memoria de imagem
#getPos:
#    add t0,zero, a0 
#    slli t0, t0, 4 # t0 = 0x00000yx0  
#    li t1, AddressBegin
#    add t0, t0, t1  #t0 = 0x????0yx0
#    lw a0, 0(t0) #retorna posicao 0x????0yx0 para a0
#    jr ra
#
#
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
PrintPiece:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    jal PaintSquare

    jal popFunct
    jr ra


#a0 = pos inicial do quadrado na memoria
PrintPieceGreenKing:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    #a2 = cor
    li t0, YELLOW
	add a2, zero, t0
    jal PaintSquare

    jal popFunct
    jr ra

#a0 = pos inicial do quadrado na memoria
PrintPieceRedKing:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    #a2 = cor
    li t0, PURPLE
	add a2, zero, t0
    jal PaintSquare

    jal popFunct
    jr ra
	
#a2 = cor
initTabuleiro:
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct
    
    li t5, GREEN
    	li t6, RED
    
    beq a2, t6, startGREEN  # se cor init = RED
    j startRED
    startGREEN:
    	li a2, GREEN
    	j continueTab
    startRED:  # t1 continua verde, aliado = vermelho
    	li a2, RED
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
    
    beq a2, t6, turnGREEN  # se cor = RED =>
    j REDdy
    turnGREEN:
        	li a2, GREEN
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
    

