#Registradores sX
#   s1 = Cor Aliado
#   s2 = Cor Inimigo
#   s3 = DEBUG

.globl main
main: j main1
# Defines
.include "lib/pushPop.s"
.include "lib/param.s"
.include "lib/mapping2D.s"
.include "lib/funcUteis.s"
.include "lib/funcUteis2D.s"
.include "lib/userUtils.s"
.include "logica_do_jogo/player1_moves_queen_promotion.s"
.include "lib/init2DMapeamento.s"

.text
# Limites da tela
main1:
    jal PrintBackGround
	jal PrintBoard
    li a2, GREEN
    jal initTabuleiro
    #j userToJose #retorna a0 = 0x000000yx
    maincontinue:
    #a0 = pos inicial do quadrado na memoria
    #a2 = cor ERASE
    #1 jogada - humano
	    jal human_move
	    jal PrintBoard
        jal updateAlly
        jal updateEnemy
    #2 jogada - máquina
        jal human_move
	    jal PrintBoard
        jal updateAlly
        jal updateEnemy

    j EXIT

.include "lib/SYSTEMv11.s"

EXIT:
    j EXIT
