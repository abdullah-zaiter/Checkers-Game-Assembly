# Defines

.include "lib/SYSTEMv11.s"
.include "lib/funcUteis.s"
.include "lib/param.s"
.include "lib/board.s"
.include "lib/pieces.s"
.include "lib/mapping.s"


.text
# Limites da tela
.globl main
main:
	PrintBoard()
    #li t1, TRANSPARENT
    #PaintColor(t1)
    la t1, blue #Escolhe a cor, blue ou red
    initPosicoes(t1)
    addi t0, zero, 0x00000041
    getPosicao(t0, t2)


    
            




