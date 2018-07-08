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
PrintPieceGreen:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    #a2 = cor
    li t0, GREEN
	add a2, zero, t0
    jal PaintSquare

    jal popFunct
    jr ra

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
PrintPieceRed:
    
    addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct

    #a0 = pos inicial do quadrado na memoria
    #a1 = tamanho do quadrado
    li a1, 15
    #a2 = cor
    li t0, RED
	add a2, zero, t0
    jal PaintSquare

    jal popFunct
    jr ra

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
	