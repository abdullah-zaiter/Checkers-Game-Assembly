#Registradores sX
#   s1 = Cor Aliado
#   s2 = Cor Inimigo
#   s3~s11 = DEBUG

.globl main
main: j main1
# Defines
.include "lib/pushPop.s"
.include "lib/param.s"
.include "lib/mapping2D.s"
.include "lib/funcUteis.s"
.include "lib/funcUteis2D.s"
.include "logica_do_jogo/player1_moves_queen_promotion.s"
.include "logica_do_jogo/random_move_better.s"
.include "lib/init2DMapeamento.s"
.include "lib/SoundMacros.s"


.text
# Limites da tela
main1:
    jal MainMenu
    
	JurassicParkMusic()
    jal PrintBackGround
	jal PrintBoard
    li a2, GREEN
    jal initTabuleiro
    
    maincontinue:
    #a0 = pos inicial do quadrado na memoria
    #a2 = cor ERASE
    #1 jogada - humano
	    jal human_move
	    jal PrintBoard
        jal updateAlly
        jal updateEnemy
    #2 jogada - máquina
        jal random_move
	    jal PrintBoard
        jal updateAlly
        jal updateEnemy

    j EXIT

.include "lib/SYSTEMv11.s"

EXIT:
    j EXIT
