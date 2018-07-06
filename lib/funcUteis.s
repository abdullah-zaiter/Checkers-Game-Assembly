.data
.eqv _bmpAddress	0x10040	
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

.macro scanInt(%valor) ############# SCAN_INT ############## 
	push(a7)
	li  a7, 5        
    	syscall 
    	la  %valor, 0(a7)
    	pop(a7)
.end_macro

.macro printInt(%valor) ############# PRINT_INT ##############
	push(a7)
	push(a0)
	
	li  a7, 1          
    	mv a0, %valor
    	syscall
    	printString(Auxiliar)
    	pop(a0)
    	pop(a7)
    	
.end_macro

.macro scanChar(%valor) ############# SCAN_CHAR ############## 
	push(a7)
	li  a7, 12           
    	syscall
    	la  %valor, 0(a7)
    	pop(a7)
.end_macro

.macro printChar(%valor) ############# PRINT_CHAR ##############
	push(a7)
	push(a0)
	li  a7,  11          
    	mv a0, %valor
    	syscall 	
    	pop(a0)
    	pop(a7)
.end_macro

.macro printString(%valor)	############# PRINT_STRING ##############
	push(a7)
	push(a0)	
	li a7, 4
	la a0, %valor
	syscall	
	pop(a0)
    	pop(a7)
.end_macro


.macro pause(%valor) ############# pause ##############
	push(a7)
    	push(a0)	
	li a7, 32
	li a0, %valor
	syscall	
	pop(a0)
    	pop(a7)
.end_macro

##Como usar
# addi %reg, zero,RED
# PaintColor(%reg)
.macro PaintColor(%color)
		li a0, ScreenBg
		li a1, ScreenEnd
LOOP:		beq a0, a1, END
		add t2, zero, %color
		sb t2, 0(a0)
		addi a0, a0, 1
		j LOOP
END:
.end_macro

.macro PaintRegion(%color, %xi, %yi, %xf, %yf)
		li t0, 320
		mul t0, %yi, t0			##	Yi * 320
		add t1, t0, %xi 		## 	Yi*320 + Xi
		li	t2, ScreenBg
		add a0, t1, t2	## 	Yi*320 + Xi + Endereço Inicial
		
		li t0, 320
		mul t0, %yf, t0			##	Yi * 320
		add t1, t0, %xf 		## 	Yi*320 + Xi
		li	t2, ScreenEnd
		add a1, t1, t2	## 	Yi*320 + Xi + Endereço Inicial
		
		#li a0, ScreenBg
		#li a1, ScreenEnd
LOOP:		beq a0, a1, END
		add t2, zero, %color
		sb t2, 0(a0)
		addi a0, a0, 1
		j LOOP
END:
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

	pop(%color)
	pop(%x)
	pop(%y)
	pop(%xf)
.end_macro

.macro PaintCol(%color, %x, %y, %yf)
	LOOP:
		push(%color)
		push(%x)
		push(%y)
		push(%yf)
		beq %y, %yf, END
		PaintPixel(%color, %x, %y)
		pop(%yf)
		pop(%y)
		pop(%x)
		pop(%color)
		
		addi %y, %y, 1


		j LOOP
	END:
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
