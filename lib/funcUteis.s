.data
.eqv _bmpAddress	0x10040	
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

#deve ser usado com registradores sX ou aX (tX nao funcionam)
.macro PaintPixel(%color, %x, %y)
		push(%color)
		push(%x)
		push(%y)
		li t0, 320
		mul t0, %y, t0			##	Yi * 320
		add t1, t0, %x 		## 	Yi*320 + Xi
		li	t2, ScreenBg
		add a0, t1, t2	## 	Yi*320 + Xi + Endereço Inicial
		pop(%y)
		pop(%x)
		pop(%color)
		add a1, zero, %color
		sb	a1, 0(a0)

.end_macro

.macro PaintLine(%color, %x, %y, %xf)
	LOOP:
		push(%color)
		push(%x)
		push(%y)
		push(%xf)
		beq %x, %xf, END
		PaintPixel(%color, %x, %y)
		pop(%xf)
		pop(%y)
		pop(%x)
		pop(%color)
		addi %x, %x, 1
		j LOOP
	END:
		pop(%xf)
		pop(%y)
		pop(%x)
		pop(%color)
.end_macro

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
LOOP:		beq a3, zero, END
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
		
		PaintSquareReg(t0, BoardTileSize, LIGHTBROWN)
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
		
		PaintSquareReg(t0, BoardTileSize, DARKBROWN)
		j LOOPLINE
		
JUMPLINE:	addi a3, a3, -1
		li a4, 8
		j LOOP
END:
.end_macro



#a0 = pos inicial do quadrado na memoria
#a1 = tamanho do quadrado
#a2 = cor
PaintSquare:
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
	ret
	
	