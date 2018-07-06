#Rotina de teste para alterar tela com comando no teclado

	#Cores
	.eqv RED 0x07
	.eqv GREEN 0x38
	.eqv BLUE 0xc0
	
	#Dados da tela
	.eqv ScreenBg 0xff000000
	.eqv ScreenEnd 0xff012c00

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
	
		li a7, 12	#read int
LOOP:		ecall
		li a1, 'r'
		beq a0, a1, PAINTR
		li a1, 'g'
		beq a0, a1, PAINTG
		li a1, 'b'
		beq a0, a1, PAINTB
		j LOOP
		
PAINTR:		PaintRed()
		j LOOP
PAINTG:		PaintGreen()
		j LOOP
PAINTB:		PaintBlue()
		j LOOP

END:
