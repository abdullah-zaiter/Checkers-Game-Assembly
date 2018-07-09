.globl main
main: j main1
# Defines
.include "lib/pushPop.s"
.include "lib/param.s"
.include "lib/mapping2D.s"
.include "lib/funcUteis.s"
.include "lib/funcUteis2D.s"
.include "lib/userUtils.s"
.include "logica_do_jogo/player1_moves_certo.s"
.text
# Limites da tela
main1:
    jal PrintBackGround
	PrintBoard()
    li a2, RED
    jal initTabuleiro
    #j userToJose #retorna a0 = 0x000000yx
    maincontinue:
    #a0 = pos inicial do quadrado na memoria
    #a2 = cor ERASE
	jal human_move
    j EXIT

.include "lib/SYSTEMv11.s"

EXIT:
    j EXIT
