# Defines

.include "lib/SYSTEMv11.s"
.include "lib/funcUteis.s"
.include "lib/funcUteis2D.s"
.include "lib/param.s"
.include "lib/board.s"
.include "lib/pieces.s"
.include "lib/mapping.s"
.include "logica_do_jogo/player1_moves_certo.s"


.text
# Limites da tela
.globl main
main:
    PrintBoard()
    la t1, blue #Escolhe a cor, blue ou red
    initPosicoes(t1)
    
    addi a1, zero, 0x00000032
    getPosicao(a1, a1)
    la a0, blue
    jal PrintCerto

    addi a1, zero, 0x00000041
    getPosicao(a1, a1)
    la a0, red
    jal PrintCerto



    #addi t0, zero, 0x00000032
    #getPosicao(t0, t2)
    #la t1, blue #Escolhe a cor, blue ou red
    #PrintPiece(t2, t1)
    #la t5, board
    #li t3, MinusBg
    #and t4, t2, t3
    #add t5, t5, t4
    #addi t0, zero, 0x00000032
    #getPosicao(t0, t2)
    #PrintPiece(t2, t5)



    

#main:
#	 PrintBoard()
#    #li t1, TRANSPARENT
#    #PaintColor(t1)
#    la t1, blue #Escolhe a cor, blue ou red
#    initPosicoes(t1)
#    #addi t0, zero, 0x00000041
#    #getPosicao(t0, t2)
#    jal human_move
#    jal PegaAsParada
#    jal random_move
#    jal PegaAsParada
    
            




