

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
.macro PaintSquare(%pos, %size, %color)

	li a0, %pos
	li a1, %size
	li a2, %color
    
	jal ra, PaintSquare
    
.end_macro

.macro PrintPiece(%pos, %type)
  add a1, zero, %pos 
  li t3, endPiece
  add a2, a1, t3
  addi a4, a1, 19
  #la a0, blue
  add a0, zero, %type
  addi a2, a2, 1
LOOP:  bge a1, a2, END
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

#a0 = type(color)///a1 = pos/// 
PrintCerto:
	push(ra)
		li t3, endPiece
		add a2, a1, t3
		addi a4, a1, 19
		addi a2, a2, 1
	LOOP_PrintCerto:	bge a1, a2, END_PrintCerto
		lb a3, 0(a0)
		sb a3, 0(a1)
		bne a1, a4, CONTINUE_PrintCerto
		SOMA320_PrintCerto:
			addi a1, a1, 301
			addi a4, a4, 320
		CONTINUE_PrintCerto:
			addi a0, a0, 4
			addi a1, a1, 1
			j LOOP_PrintCerto
	END_PrintCerto:
		pop(ra)
		jr ra
	

#Imprime o tabuleiro
.macro PrintBoard()
	la a0, board
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

#Registrador temporario na primeira entrada, registrador de saida na segunda
.macro getPosicao(%userInput, %return)
	add t0,zero, %userInput
    slli t0, t0, 4
    li t1, AddressBegin
    add t0, t0, t1
    lw %return, 0(t0)
.end_macro

#inicializa todas as posições de 
.macro initPosicoes(%color)
	add t1, %color, zero
	li t0, A8
	li t2,AddressA8
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, C8
	li t2,AddressC8
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, E8
	li t2,AddressE8
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, G8
	li t2,AddressG8
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, B7
	li t2,AddressB7
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, D7
	li t2,AddressD7
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, F7
	li t2,AddressF7
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, H7
	li t2,AddressH7
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, A6
	li t2,AddressA6
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, C6
	li t2,AddressC6
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, E6
	li t2,AddressE6
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, G6
	li t2,AddressG6
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, B5
	li t2,AddressB5
	sw t0, 0(t2)
	li t0, D5
	li t2,AddressD5
	sw t0, 0(t2)
	li t0, F5
	li t2,AddressF5
	sw t0, 0(t2)
	li t0, H5
	li t2,AddressH5
	sw t0, 0(t2)
	li t0, A4
	li t2,AddressA4
	sw t0, 0(t2)
	li t0, C4
	li t2,AddressC4
	sw t0, 0(t2)
	li t0, E4
	li t2,AddressE4
	sw t0, 0(t2)

	la t0, blue
	bne t1, t0, RED
	BLUE:
		la t1, red
		j CONTINUE
	RED:
		la t1, blue
	CONTINUE:
	li t0, B3
	li t2,AddressB3
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, D3
	li t2,AddressD3
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, F3
	li t2,AddressF3
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, H3
	li t2,AddressH3
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, A2
	li t2,AddressA2
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, C2
	li t2,AddressC2
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, E2
	li t2,AddressE2
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, G2
	li t2,AddressG2
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, B1
	li t2,AddressB1
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, D1
	li t2,AddressD1
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, F1
	li t2,AddressF1
	sw t0, 0(t2)
	PrintPiece(t0, t1)

	li t0, H1
	li t2,AddressH1
	sw t0, 0(t2)
	PrintPiece(t0, t1)
	END:	

.end_macro

.macro THEEND()
    j ENDMAIN
.end_macro
    ENDMAIN: j ENDMAIN
    

#a0 = pos inicial do quadrado na memoria; a1 = tamanho do quadrado; a2 = cor
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
	
	