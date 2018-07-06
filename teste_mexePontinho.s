#Rotina de teste para alterar tela com comando no teclado

	#Cores
	.eqv RED 0x07
	.eqv GREEN 0x38
	.eqv BLUE 0xc0
	.eqv WHITE 0xff
	
	#Dados da tela
	.eqv ScreenBg 0xff000000
	.eqv ScreenEnd 0xff012c00

.macro PaintWhite()
		li a0, ScreenBg
		li a1, ScreenEnd
LOOP:		beq a0, a1, END
		li a2, WHITE
		sb a2, 0(a0)
		addi a0, a0, 1
		j LOOP
END:
	.end_macro

	.macro PaintRed()
		li a0, ScreenBg
		li a1, ScreenEnd
LOOP:		beq a0, a1, END
		li a2, RED
		sb a2, 0(a0)
		addi a0, a0, 1
		j LOOP
END:
	.end_macro
	
		.macro PaintBlue()
		li a0, ScreenBg
		li a1, ScreenEnd
LOOP:		beq a0, a1, END
		li a2, BLUE
		sb a2, 0(a0)
		addi a0, a0, 1
		j LOOP
END:
	.end_macro
	
		.macro PaintGreen()
		li a0, ScreenBg
		li a1, ScreenEnd
LOOP:		beq a0, a1, END
		li a2, GREEN
		sb a2, 0(a0)
		addi a0, a0, 1
		j LOOP
END:
	.end_macro
		PaintWhite()
		li s0, 0xff000fff
		li a7, 12	#read int
LOOP:		ecall		
		li a1, 'w'			#Famoso switch case pros valores lidos do teclado. Se nao selecioanr nada, continua no loop
		beq a0, a1, MV1
		li a1, 'a'
		beq a0, a1, MV2
		li a1, 's'
		beq a0, a1, MV3
		li a1, 'd'
		beq a0, a1, MV4
		j LOOP
		
MV1:		li a1, WHITE
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		addi s0, s0, -320
		li a1, RED
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		j LOOP
		
MV2:		li a1, WHITE
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		addi s0, s0, -1
		li a1, RED
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		j LOOP
		
MV3:		li a1, WHITE
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		addi s0, s0, 320
		li a1, RED
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		j LOOP
		
MV4:		li a1, WHITE
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		addi s0, s0, 1
		li a1, RED
		sb a1, 320(s0)
		sb a1, -320(s0)
		sb a1, 0(s0)
		sb a1, 1(s0)
		sb a1, -1(s0)
		j LOOP

END:
