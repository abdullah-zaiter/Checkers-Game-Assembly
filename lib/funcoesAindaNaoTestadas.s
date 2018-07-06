
# a0 X inicial
# a1 Y inicial
# a2 cor
# a3 Y final
# s3 se é rainha (1|0)

PrintCirculo:
	push(ra)
	push(a0)
	push(a1)
	push(a2)
	push(a3)
	push(s3)
	
	addi a0, a0, 1
	addi a1, a1, 3
	addi a3, a1, 1
	jal Vertical

	addi a0, a0, 5
	jal Vertical

	addi a0, a0, -6
	addi a1, a1, -3
	
	addi a0, a0, 2
	addi a1, a1, 2
	addi a3, a1, 3
	jal Vertical
	
	addi a0, a0, 3
	jal Vertical

	addi a0, a0, -5
	addi a1, a1, -2
	
	addi a0, a0, 3
	addi a1, a1, 1
	addi a3, a1, 5
	jal Vertical

	addi a0, a0, 1
	jal Vertical
	
	addi a0, a0, -4
	addi a1, a1, -1

	pop(s3)
    li t0, 1	
	beq s3, t0, PrintKing
	
RetornoPrintKing:
	
	pop(a3)
	pop(a2)
	pop(a1)
	pop(a0)
	pop(ra)
	
	jr ra
	
PrintKing:
	push(a0)
	push(a1)
	push(a2)
	push(a3)
	push(s3)
	lw a2, BLACK

	addi a0, a0, 2
	addi a1, a1, 3
	addi a3, a1, 1
	jal Vertical
	
	addi a0, a0, 3
	jal Vertical

	addi a0, a0, -5
	addi a1, a1, -3
	
	addi a0, a0, 3
	addi a1, a1, 2
	addi a3, a1, 3
	jal Vertical

	addi a0, a0, 1
	jal Vertical
	
	addi a0, a0, -4
	addi a1, a1, -3

	pop(s3)
	pop(a3)
	pop(a2)
	pop(a1)
	pop(a0)

	j RetornoPrintKing


# a0 X inicial 
# a1 Y inicial 
# a2 cor

Pixel:		
	push(ra)
	push(a0)
	push(a1)
	push(a2)
	push(a3)
    li t0, 7
	sll t0, a1, t0   #Multiplicando Y por 64 (tamanho da tela)
    
    li t1, 1
    mulhu a0, a0, t1
    mulhu t0, t0, t1

	add a7, a0, t0
    li t1, 2
	sll a7, a7, t1

    li t3, ScreenBegin
    add t2, t1, t3
	
    add a7, a7, t2
	#sw a2, (a7) # Desenha a cor no local correto
    sb a2, 0(a7)

	pop(a3)
	pop(a2)
	pop(a1)
	pop(a0)
	pop(ra)
	jr ra

# a0 X inicial
# a1 Y inicial
# a2 cor
# a3 X final
Horizontal:
	push(ra)
	push(a0)
	push(a1)
	push(a2)
	push(a3)
		
		sub t6, a3, a0
		mv t1, a0

	LoopHorizontal:

		add a0, t1, t6
		jal Pixel
		addi t6, t6, -1
		bge t6, zero, LoopHorizontal
	
	pop(a3)
	pop(a2)
	pop(a1)
	pop(a0)
	pop(ra)	
		
		jr ra

# a0 X inicial
# a1 Y inicial
# a2 cor
# a3 Y final

Vertical:
	
	push(ra)
	push(a0)
	push(a1)
	push(a2)
	push(a3)
	
		sub t6, a3, a1
		mv t1, a1

	VerticalLoop:

		add a1, t1, t6
		jal Pixel
		addi t6, t6, -1
		bge t6, zero, VerticalLoop
	pop(a3)
	pop(a2)
	pop(a1)
	pop(a0)
	pop(ra)
	jr ra
