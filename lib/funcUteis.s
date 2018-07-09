
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
PrintBoard:
		
		addi sp, sp, -4
    	sw ra, 0(sp)
    	jal pushAll

		li a3, 8#linhas
		li a4, 8#colunas
LOOP_PrintBoard:		beq a3, zero, PRINTCOORD
LOOP_PrintBoardLINE:	beq a4, zero, JUMPLINE
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
		j LOOP_PrintBoardLINE
		
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
		j LOOP_PrintBoardLINE
		
JUMPLINE:	addi a3, a3, -1
		li a4, 8
		j LOOP_PrintBoard
		
	# Rotina para imprimir as coordenadas do tabuleiro
PRINTCOORD:
		li a7, 104	# rotina de imprimir string na tela
		la a0, chars
		li a1, 30
		li a2, 8
		li a3, WHITE
		mv a4, a0
		
		li a5, 8
PRINTCHARLOOP_PrintBoard:	beq a5, zero, PRINTNUM		
		jal exceptionHandling
		
		addi a4, a4, 2	#proxima letra
		mv a0, a4	#o valor de a0 eh alterado na funcao de printar string
		
		addi a5, a5, -1
		addi a1, a1, 25	# proxima posicao da letra
		
		j PRINTCHARLOOP_PrintBoard

PRINTNUM:
		la a0, nums
		li a1, 8
		li a2, 30
		li a3, WHITE
		mv a4, a0
		li a5, 8
		
PRINTNUMLOOP_PrintBoard:	beq a5, zero, END_PrintBoard
		jal exceptionHandling
		
		addi a4, a4, 2	# proximo numero impresso
		mv a0, a4
		
		addi a5, a5, -1
		addi a2, a2, 25	#proxima posicao do numero
		
		j PRINTNUMLOOP_PrintBoard
		
		
END_PrintBoard:
	jal popAll
    jr ra

#________________________________________________________________________________________________________________
MainMenu:
	mv a4, ra
	li a0, ScreenBg
	li a1, ScreenEnd
	li a2, BROWN
			
MainMenu_PAINT:
	beq a0, a1, MainMenu_MESSAGES
	sb a2, 0(a0)
	addi a0, a0, 1
	j MainMenu_PAINT

MainMenu_MESSAGES:
	
	li a7, 104
	la a0, mainMenuStrings
	mv a4, a0
	li a1, 100
	li a2, 15
	li a3, WHITE
	jal exceptionHandling	# Printa "Checkers Game"
	
	addi a4, a4, 14
	mv a0, a4
	addi a2, a2, 45
	addi a1, a1, -10
	jal exceptionHandling # Printa "Escolha o nivel:"
	
	
	addi a4, a4, 17
	mv a0, a4
	addi a2, a2, 30
	addi a1, a1, 35
	jal exceptionHandling # Printa "nivel 1"
	
	
	addi a4, a4, 8
	mv a0, a4
	addi a2, a2, 20
	jal exceptionHandling # Printa "nivel 2"
	
	mv ra, a4
	ret
#________________________________________________________________________________________________________________
#a0 = pos inicial do quadrado na memoria
#a1 = tamanho do quadrado
#a2 = cor
PaintSquare:
	addi sp, sp, -4
    sw ra, 0(sp)
    jal pushAll

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
	jal popAll
    jr ra
	
	
