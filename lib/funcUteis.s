
#BLACK:			.word	0x00000000 # BLACK
#WHITE:			.word	0x00ffffff # WHITE
#	
#
#BLUE:			.word   0x00008B8B # BLUE
#
#
#GREY:			.word   0x00696969 # GREY
#
#	#.eqv RED 0x07
#	.eqv DARKRED 0x03
#	.eqv PURPLE 0x42
#
#	#.eqv BLUE 0xC0
#	.eqv BestBLUE 0xd1
#	.eqv DARKBLUE 0xc0
#	.eqv CYAN 0x48
.text

#deve ser usado com registradores sX (tX nao funcionam)
.macro PaintSquare(%pos, %size, %color)

	li a0, %pos
	li a1, %size
	li a2, %color
    
	jal ra, PaintSquare
    
.end_macro

.macro PaintSquareReg(%pos, %size, %color)

	mv a0, %pos
	li a1, %size
	li a2, %color
    
	jal ra, PaintSquare
    
.end_macro



#Imprime o tabuleiro
.macro PrintBoard()
		li a3, 8#linhas
		li a4, 8#colunas
LOOP:		beq a3, zero, PRINTCOORD
LOOPLINE:	beq a4, zero, JUMPLINE
		li t0, 2
		add t1, a3, a4
		rem t0, t1, t0
		addi a4, a4, -1
		beq t0, zero, PAINT_COLOR1
		
		li t0, BoardBg
		li t1, BoardTileSize
		mul t1, t1, a4
		add t0, t0, t1
		
		li t1, BoardTileSize
		mul t3, t1, a3
		sub t1, t3, t1
		li t2, 320
		mul t1, t1, t2
		add t0, t0, t1
		
		PaintSquareReg(t0, BoardTileSize, DARKBROWN)
		j LOOPLINE
		
PAINT_COLOR1:	li t0, BoardBg
		li t1, BoardTileSize
		mul t1, t1, a4
		add t0, t0, t1
		
		li t1, BoardTileSize
		mul t3, t1, a3
		sub t1, t3, t1
		li t2, 320
		mul t1, t1, t2
		add t0, t0, t1
		
		PaintSquareReg(t0, BoardTileSize, LIGHTBROWN)
		j LOOPLINE
		
JUMPLINE:	addi a3, a3, -1
		li a4, 8
		j LOOP
		
	# Rotina para imprimir as coordenadas do tabuleiro
PRINTCOORD:
		li a7, 104	# rotina de imprimir string na tela
		la a0, chars
		li a1, 30
		li a2, 8
		li a3, WHITE
		mv a4, a0
		
		li a5, 8
PRINTCHARLOOP:	beq a5, zero, PRINTNUM		
		jal exceptionHandling
		
		addi a4, a4, 2	#proxima letra
		mv a0, a4	#o valor de a0 eh alterado na funcao de printar string
		
		addi a5, a5, -1
		addi a1, a1, 25	# proxima posicao da letra
		
		j PRINTCHARLOOP

PRINTNUM:
		li a7, 101	# rotina de imprimir numero na tela
		li a0, 1
		li a1, 8
		li a2, 30
		li a3, WHITE
		li a4, 9
		li a5, 1
		
PRINTNUMLOOP:	beq a0, a4, END
		jal exceptionHandling
		
		addi a5, a5, 1	# proximo numero impresso
		mv a0, a5
		
		addi a2, a2, 25	#proxima posicao do numero
		
		j PRINTNUMLOOP
		
		
END:
.end_macro



#a0 = pos inicial do quadrado na memoria
#a1 = tamanho do quadrado
#a2 = cor
PaintSquare:
	addi sp, sp, -4
    sw ra, 0(sp)
    jal pushFunct

	add t0, a0, a1
	mv t1, a1
	li t2, -1
	mul t2, t2, a1

PaintSquare_Loop:	
	beq t1, zero, PaintSquare_End
	
PaintSquare_LoopLine:
	beq a0, t0, PaintSquare_JumpLine
	sb a2, 0(a0)
	addi a0, a0, 1
	j PaintSquare_LoopLine
	
PaintSquare_JumpLine:
	addi t0, t0, 320
	add a0, t0, t2
	addi t1, t1, -1
	j PaintSquare_Loop
	
PaintSquare_End:
	jal popFunct
    jr ra
	