.data
.eqv endPiece		0x00001553

.text

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
##################3D
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

#Registrador temporario na primeira entrada, registrador de saida na segunda
.macro getPosicao(%userInput, %return)
	add t0,zero, %userInput
    slli t0, t0, 4
    li t1, AddressBegin
    add t0, t0, t1
    lw %return, 0(t0)
.end_macro


.macro THEEND()
    j ENDMAIN
.end_macro
    ENDMAIN: j ENDMAIN
    
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