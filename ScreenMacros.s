# Defines
.include "SYSTEMv11.s"
.include "funcUteis.s"
.include "parametros.s"

#_____________________________________________________________________________________________
	#Macro para debug
	.macro printf(%num)
		li a7, 1
		mv a0, %num
		ecall
	.end_macro
#_____________________________________________________________________________________________
	# Macro para desenhar o tabuleiro
	.macro 	PrintBoard
		li t0, ScreenBg
		li t3, ScreenHeight
		li t4, ScreenWidth

		li t1, 8
		div t2, t4, t1		# t2 = numero de colunas do "quadrado"
		div t1, t3, t1		# t1 = numero de linhas do "quadrado"
		
		blt t1, t2, SELECT1
		mv t1, t2
		j SELECT2
SELECT1:	mv t2, t1
SELECT2:

		li t2, 8
		mul t2, t2, t1		# t2 = largura do tabuleiro
		

		li t3, ScreenEnd
		addi t0, t0, -1		# Como a primeira parte do loop � adicionar 1 a t0, para pegar a primeira posicao inicial se subtrai 1 antes de entrar no loop
BOARD_LOOP:	addi t0, t0, 1		# Faz t0 ir para a proxima posicao de memoria
		bge t0, t3, END_BOARD	# Checa se t0 chegou ao final da tela
		GetScreenPos(t0, t5, t4)
		
		bge t5, t2, MENU	# Checa se esta nos limites de altura do tabuleiro
		bge t4, t2, MENU	# Checa se esta nos limites de largura do tabuleiro
		
		div t5, t5, t1		# t5 = qual posicao em linha esta
		div t4, t4, t1		# t4 = qual posicao em coluna esta

		add t5, t5, t4		
		li t4, 2
		rem t5, t5, t4		# checa se t5+t4 eh impar (1) ou par (0)
		beq t5, zero, PAINT_COLOR1
		li t4, DARKBROWN
		sb t4,0(t0)
		j BOARD_LOOP
PAINT_COLOR1:	li t4, LIGHTBROWN
		sb t4,0(t0)
		j BOARD_LOOP
		
MENU:		li t4, BLUE
		sb t4, 0(t0)
		j BOARD_LOOP
		
END_BOARD:
	.end_macro

#___________________________________________________________________________________________
	.macro GetScreenPos(%pos, %regLine, %regCol)
		li %regLine, ScreenBg
		sub %regLine, %pos, %regLine		# %regLine = posicao do vetor da tela
		li %regCol, ScreenWidth
		div %regLine, %regLine, %regCol			# %regLine = linha da tela

		li a0, ScreenBg
		mul %regCol, %regCol, %regLine
		add %regCol, %regCol, a0
		sub %regCol, %pos, %regCol
		
	#O seguinte trecho evita o uso do registrador a0, mas torna o algoritmo de printar o tabuleiro extremamente lento
#		li %regCol, ScreenBg
#		sub %regCol, %pos, %regCol
#		addi %regCol, %regCol, -ScreenWidth
#NEG_TEST:	blt %regCol, zero, END
#		addi %regCol, %regCol, -ScreenWidth
#		j NEG_TEST

#END:		addi %regCol, %regCol, ScreenWidth

	.end_macro
	
	.macro GetMemoryPos(%line, %col, %regPos)
		li %regPos, ScreenWidth
		mul %regPos, %line, %regPos
		addi %regPos, %regPos, -ScreenWidth
		add %regPos, %regPos, %col
		li a0, ScreenBg
		add %regPos, %regPos, a0
	.end_macro
#___________________________________________________________________________________________
	.macro Circle (%radius, %line, %col, %color)
		li s0, 2
		mv t0, %line
		addi t4, t0, %radius
		addi t0, t0, -%radius		
		mv t1, %col
		addi t5, t1, %radius		# t4 e t5 possuem a posicao final do quadrado no qual o circulo esta inscrito
		addi t1, t1, -%radius		# t0 e t1 possuem a posicao inicial do quadrado no qual o circulo esta inscrito
		li t2, ScreenWidth
		GetMemoryPos(t0, t1, t0)	# t0 agora possui o endereco de memoria da posicao inicial do quadrado mencionado
		GetMemoryPos(t4, t5, t4)	# t4 agora possui o endereco de memoria da posicao final do quadrado mencionado
	
LOOP1_CIRCLE:	bge t0, t4, END_CIRCLE		# t0 eh a posicao em memoria sendo pintada
		GetScreenPos(t0, t1, zero)	# t1 possui a linha sendo pintada
		mul t1, t1, t2
		add t1, t1, %col			# t1 possui a ultima coluna que sera pintada 
		addi, t1, t1, %radius
		li t3, ScreenBg
		add t1, t1, t3				# t1 possui a posicao em memoria da ultima coluna (da atual linha) a ser pintada
LOOP2_CIRCLE:	bge t0, t1, CIRC_END_LOOP
		GetScreenPos(t0, t5, t6)
		sub %line, zero, %line
		sub %col, zero, %col
		add t5, t5, %line
		add t6, t6, %col
		sub %line, zero, %line
		sub %col, zero, %col
		mul t5, t5, t5
		mul t6, t6, t6
		add t5, t5, t6
		fcvt.s.w f0, t5
		fsqrt.s f0, f0
		fcvt.w.s t5, f0				# t5 = distancia do ponto em questao ate o centro do circulo
		li t6, %radius
		bge t5, t6, NO_JUMP
NO_JUMP:	li t3, %color
		sb t3, 0(t0)
		addi s0, s0, 1
		printf(s0)
CIRC_END_LINE:	addi t0, t0, 1
		j LOOP2_CIRCLE
	
CIRC_END_LOOP:	add t0, t0, t2		# pula uma linha de t0
		addi t0, t0, -%radius
		addi t0, t0, -%radius			# volta pra primeira coluna do quadrado onde o circulo esta inscrito
		j LOOP1_CIRCLE
	
END_CIRCLE:
	.end_macro
#_______________________________________________________________________________________________________

	.macro InsertPiece (%i, %j, %color)
		
		# Checa se os valores fornecidos sao coerentes com o tabuleiro
		li t0, 8
		li t1, %i
		bgt t1, t0, InsPieceEnd
		li t1, %j
		bgt t1, t0, InsPieceEnd
		
		li t0, ScreenHeight
		li t1, ScreenWidth
		blt t0, t1, SELECT1	# determina qual a dimensao do tabuleiro, em pixels
		mv t0, t1
		j SELECT2
SELECT1:	mv t1, t0
SELECT2:

		li t1, 8
		div t0, t0, t1		# t0 = tamanho em pixels de um quadrado do tabuleiro
		
		li t1, 2
		div t1, t0, t1		# t1 = valor de meio quadrado
		
		#Determinacao da coluna de pixels no centro do quadrado
		li t3, %j
		mul t3, t3, t0
		sub t3, t3, t1		# t3 = coluna do centro do circulo
		
		#Determinacao da linha de pixels no centro do quadrado
		li t4, %i
		mul t4, t4, t0
		sub t4, t4, t1		# t4 = linha do centro do circulo
		
		Circle(14, t4, t3, %color)
		

InsPieceEnd:	
	.end_macro
#_______________________________________________________________________________________________________

.globl main
main:
	# Rotina de teste
		PrintBoard
		li a7, 1
		li a0, 30
		ecall
		li t1, 100
		li t2, 100	

		li a0, 0
		li a1, 50
		li a2, BLACK
		li a3, 100
		li s3, 1
		jal PrintCirculo
		
		#jal PrintCirculo

		#Circle(20, t1, t2, WHITE)	
		#InsertPiece(1, 1, BLACK)
		#InsertPiece(2, 1, BLACK)
		#InsertPiece(5, 2, BLACK)
		#InsertPiece(9, 1, BLACK)
		#InsertPiece(1, 5, BLACK)
		#InsertPiece(6, 4, BLACK)
		#InsertPiece(7, 6, BLACK)
		#InsertPiece(2, 8, BLACK)
		#InsertPiece(1, 4, BLACK)
		
#		Circle (14, 14, 45, s2)
#		Circle (14, 14, 105, s2)
#		Circle (14, 14, 165, s2)
#		Circle (14, 14, 225, s2)
#		Circle (14, 44, 15, s2)
#		Circle (14, 44, 75, s2)
#		Circle (14, 44, 135, s2)
#		Circle (14, 44, 195, s2)
#		Circle (14, 74, 45, s2)
#		Circle (14, 74, 105, s2)
#		Circle (14, 74, 165, s2)
#		Circle (14, 74, 225, s2)
#		White(s2)
#		Circle (14, 225, 15, s2)
#		Circle (14, 225, 75, s2)
#		Circle (14, 225, 135, s2)
#		Circle (14, 225, 195, s2)
#		
#		
#		Circle (14, 195, 45, s2)
#		Circle (14, 195, 105, s2)
#		Circle (14, 195, 165, s2)
#		Circle (14, 195, 225, s2)
#		
#		Circle (14, 165, 15, s2)
#		Circle (14, 165, 75, s2)
#		Circle (14, 165, 135, s2)
#		Circle (14, 165, 195, s2)
