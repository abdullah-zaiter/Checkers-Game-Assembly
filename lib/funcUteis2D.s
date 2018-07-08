.data
    .eqv largura 320

.text


PushAll:
	addi sp, sp, -4
	sw x0, 0(sp)
	addi sp, sp, -4
	sw x1, 0(sp)
	addi sp, sp, -4
	sw x2, 0(sp)
	addi sp, sp, -4
	sw x3, 0(sp)
	addi sp, sp, -4
	sw x4, 0(sp)
	addi sp, sp, -4
	sw x5, 0(sp)
	addi sp, sp, -4
	sw x6, 0(sp)
	addi sp, sp, -4
	sw x7, 0(sp)
	addi sp, sp, -4
	sw x8, 0(sp)
	addi sp, sp, -4
	sw x9, 0(sp)
	addi sp, sp, -4
	sw x10, 0(sp)
	addi sp, sp, -4
	sw x11, 0(sp)
	addi sp, sp, -4
	sw x12, 0(sp)
	addi sp, sp, -4
	sw x13, 0(sp)
	addi sp, sp, -4
	sw x14, 0(sp)
	addi sp, sp, -4
	sw x15, 0(sp)
	addi sp, sp, -4
	sw x16, 0(sp)
	addi sp, sp, -4
	sw x17, 0(sp)
	addi sp, sp, -4
	sw x18, 0(sp)
	addi sp, sp, -4
	sw x19, 0(sp)
	addi sp, sp, -4
	sw x20, 0(sp)
	addi sp, sp, -4
	sw x21, 0(sp)
	addi sp, sp, -4
	sw x22, 0(sp)
	addi sp, sp, -4
	sw x23, 0(sp)
	addi sp, sp, -4
	sw x24, 0(sp)
	addi sp, sp, -4
	sw x25, 0(sp)
	addi sp, sp, -4
	sw x26, 0(sp)
	addi sp, sp, -4
	sw x27, 0(sp)
	addi sp, sp, -4
	sw x28, 0(sp)
	addi sp, sp, -4
	sw x29, 0(sp)
	addi sp, sp, -4
	sw x30, 0(sp)
	addi sp, sp, -4
	sw x31, 0(sp)
	jr ra



PopAll:
	addi sp, sp, 4
	sw x31, 0(sp)
	addi sp, sp, 4
	sw x30, 0(sp)
	addi sp, sp, 4
	sw x29, 0(sp)
	addi sp, sp, 4
	sw x28, 0(sp)
	addi sp, sp, 4
	sw x27, 0(sp)
	addi sp, sp, 4
	sw x26, 0(sp)
	addi sp, sp, 4
	sw x25, 0(sp)
	addi sp, sp, 4
	sw x24, 0(sp)
	addi sp, sp, 4
	sw x23, 0(sp)
	addi sp, sp, 4
	sw x22, 0(sp)
	addi sp, sp, 4
	sw x21, 0(sp)
	addi sp, sp, 4
	sw x20, 0(sp)
	addi sp, sp, 4
	sw x19, 0(sp)
	addi sp, sp, 4
	sw x18, 0(sp)
	addi sp, sp, 4
	sw x17, 0(sp)
	addi sp, sp, 4
	sw x16, 0(sp)
	addi sp, sp, 4
	sw x15, 0(sp)
	addi sp, sp, 4
	sw x14, 0(sp)
	addi sp, sp, 4
	sw x13, 0(sp)
	addi sp, sp, 4
	sw x12, 0(sp)
	addi sp, sp, 4
	sw x11, 0(sp)
	addi sp, sp, 4
	sw x10, 0(sp)
	addi sp, sp, 4
	sw x9, 0(sp)
	addi sp, sp, 4
	sw x8, 0(sp)
	addi sp, sp, 4
	sw x7, 0(sp)
	addi sp, sp, 4
	sw x6, 0(sp)
	addi sp, sp, 4
	sw x5, 0(sp)
	addi sp, sp, 4
	sw x4, 0(sp)
	addi sp, sp, 4
	sw x3, 0(sp)
	addi sp, sp, 4
	sw x2, 0(sp)
	addi sp, sp, 4
	sw x1, 0(sp)
	addi sp, sp, 4
	sw x0, 0(sp)
	jr ra






#a0 = getPos(0x000000yx)
#a2 = meia largura da peça
#t1 = variavel auxiliar
#retorna a0 = cor
checkColor:
    add t1, zero, a0
    add t1, t1, a2 #t1 <- orig + meia largura
    li t0, largura #t0 <- 320
    mul t0, t0, a2  #t0 <- 320 * meia largura
    add t1, t1, t0 #t1 <- orig + meia largura + (320 * meia largura)
    lb a0, 0(t1)
    jr ra


#a0 = 0x000000yx
#retorna a0 = posicao na memoria de imagem
getPos:
    add t0,zero, a0 
    slli t0, t0, 4 # t0 = 0x00000yx0  
    li t1, AddressBegin
    add t0, t0, t1  #t0 = 0x????0yx0
    lw a0, 0(t0) #retorna posicao 0x????0yx0 para a0
    jr ra


#a0 = 0x000000yx
#a1 = color
initPos:
    jal PushAll
    
    add t1, a1, zero
	
    li a0, A8 #calcular
	li t2,AddressA8
	sw a0, 0(t2)
	jal EscrevePeca #a0 = pos, a1 = color
    #============================= repetir pra todas as peças (24 vezes)

    jal PopAll
    jr ra