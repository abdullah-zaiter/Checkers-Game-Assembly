# Defines

.include "lib/funcUteis.s"
.include "lib/param.s"
.include "lib/funcUteis2D.s"
.include "lib/board.s"
.include "lib/pieces.s"
.include "logica_do_jogo/player1_moves_certo.s"
.include "lib/mapping2D.s"
.include "lib/userUtils.s"
.include "lib/pushPop.s"



.text
# Limites da tela
.globl main
main:
	PrintBoard()
	#j userToJose #retorna a0 = 0x000000yx
    maincontinue:
    li a0, pieceB1
    jal PrintPieceGreenKing

    li a0, pieceH1
    jal PrintPieceGreen

    li a0, pieceA2
    jal PrintPieceRed

    li a0, pieceD3
    jal PrintPieceRedKing



.include "lib/SYSTEMv11.s"
