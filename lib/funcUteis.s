.data
.eqv _bmpAddress	0x10040	
.eqv endPiece		0x00001553

#.eqv ScreenBegin 0xFF000000#0xFF002C00
#0xFF025800
BLACK:			.word	0x00000000 # BLACK
WHITE:			.word	0x00ffffff # WHITE
RED:		.word	0x00B22222 # RED
BLUE:			.word   0x00008B8B # BLUE
GREY:			.word   0x00696969 # GREY

#           X   	Y   	Cor 	EH_DAMA?
Dama:.word 	32,		68,		-1,		0,
	     	32,		84,		-1,		0,
	      	32,		100,	-1,		0,
	      	32,		116,	-1,		0,
	      	40,		60,		-1,		0,
	      	40,		76,		-1,		0,
	      	40, 	92,		-1,		0,
	      	40, 	108, 	-1, 	0,
	      	48, 	68, 	-1, 	0,
	      	48, 	84, 	-1, 	0,
	      	48, 	100, 	-1, 	0,
	      	48, 	116, 	-1, 	0,     #FIM DO PRIMEIRO JOGADOR
	      	  	
	      	72, 	60, 	1, 		0,
	      	72, 	76, 	1, 		0,
	      	72, 	92, 	1, 		0,
	      	72, 	108, 	1, 		0,
	      	80, 	68, 	1, 		0,
	      	80, 	84, 	1, 		0,
	      	80, 	100, 	1, 		0,
	      	80, 	116, 	1, 		0,
	      	88, 	60, 	1, 		0,
	      	88, 	76, 	1, 		0,
	      	88, 	92, 	1, 		0,
	      	88, 	108, 	1, 		0      #FIM DO SEGUNDO JOGADOR   	      		      	   	      	   	      		      	   	      	          		      	   	      	   	      		      	   	      	    

.text
######################################################################################
#
#############################	LISTA DE MACROS
#
#push()
#pop()
#scanInt()
#printInt()
#scanChar()
#printChar()
#printString()
#pause()
#
#
#PaintColor()
#PaintRegion(%color, %xi, %yi, %xf, %yf)
#PrintBoard()
######################################################################################
.macro push(%valor) ############# PUSH ##############
	addi sp, sp, -4
	sw %valor, 0(sp)
.end_macro

.macro pop(%valor) ############# POP ##############
	lw %valor, 0(sp)
	addi sp, sp,4
.end_macro

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
.macro PaintSquare(%color, %x, %y, %yf)
    add s5, zero, %x
	LOOP:
		beq %y, %yf, END
    	PaintLine(%color, %x, %y, %yf)
		addi %y, %y, 1 
		add %x, zero, s5		
		j LOOP
	END:
.end_macro

.macro PrintPiece(%pos, %type)
	add a1, zero, %pos 
	li t3, endPiece
	add a2, a1, t3
	addi a4, a1, 19
	#la a0, blue
	add a0, zero, %type
	addi a2, a2, 1
LOOP:	bge a1, a2, END
	lb a3, 0(a0)
	sb a3, 0(a1)
	bne a1, a4, CONTINUE
	SOMA320:
		addi a1, a1, 301
		addi a4, a4, 320
	CONTINUE:
		addi a0, a0, 4
		addi a1, a1, 1
		j LOOP
END:
.end_macro


.macro PrintPieceRed(%pos)
	
	add a1, zero, %pos 
	
	li t3, endPiece
	add a2, a1, t3
	
	addi a4, a1, 19
	la a0, red
	addi a2, a2, 1
LOOP:	bge a1, a2, END
	lb a3, 0(a0)
	sb a3, 0(a1)
	bne a1, a4, CONTINUE
	SOMA320:
		addi a1, a1, 301
		addi a4, a4, 320
	CONTINUE:
		addi a0, a0, 4
		addi a1, a1, 1
		j LOOP
END:
.end_macro

#Imprime o tabuleiro
.macro PrintBoard()
	la a0, board2
	li a1, ScreenBg
	li a2, ScreenEnd
	addi a2, a2, 1
	
LOOP:	beq a1, a2, END
	lb a3, 0(a0)
	sb a3, 0(a1)
	addi a0, a0, 4
	addi a1, a1, 1
	j LOOP
END:
.end_macro
