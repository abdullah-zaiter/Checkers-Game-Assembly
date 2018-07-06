#Rotina de teste para alterar tela com comando no teclado

	#Cores
	.eqv RED 0x05
	.eqv DARKRED 0x03
	.eqv PURPLE 0x42
	
	.eqv GREEN 0x38
	.eqv DARKGREEN 0x08
	
	.eqv BLUE 0xd1
	.eqv DARKBLUE 0xc0
	.eqv GYAN 0x48

	#Dados da tela
	.eqv ScreenBg 0xff000000
	.eqv ScreenEnd 0xff012c00

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
	
		li a7, 12	#read int
LOOP:		ecall
		li a1, 'r'
		addi a2, zero ,RED
		beq a0, a1, PAINT
		
		li a1, 't'
		addi a2, zero , DARKRED
		beq a0, a1, PAINT
		
		li a1, 'g'
		addi a2, zero , GREEN
		beq a0, a1, PAINT
		
		li a1, 'h'
		addi a2, zero , DARKGREEN
		beq a0, a1, PAINT

		li a1, 'b'
		addi a2, zero , BLUE
		beq a0, a1, PAINT

		li a1, 'n'
		addi a2, zero , DARKBLUE
		beq a0, a1, PAINT
	

PAINT:	PaintColor(a2)
		j LOOP














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





PAINTR:		PaintRed()
		j LOOP
PAINTG:		PaintGreen()
		j LOOP
PAINTB:		PaintBlue()
		j LOOP

END:


