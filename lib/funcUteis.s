.data
.eqv _bmpAddress	0x10040	
.eqv ScreenBegin 0xFF000000#0xFF002C00
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
#PrintBoard()
#ClearBoard
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

##Como usar
# a0 X inicial 
# a1 Y inicial 
# a2 cor
ClearBoard:
	push(ra)
	push(a0)
	push(a1)
	push(a2)
	push(a3)

		lw t0, BLACK		#Carrega a Cor
		li t1, 76800		#65536 Pixels do Display 163845536		#65536 Pixels do Display 16384

	StartCLoop:

		addi t1, t1, -4
        li t3, ScreenBegin
		add t2, t1, t3
		sw t0, 0(t2)
		beqz t1, EndCLoop
		j StartCLoop

	EndCLoop:
	
		pop(a3)
		pop(a2)
		pop(a1)
		pop(a0)
		pop(ra)
		jr ra
end:
