# Defines

.text
.globl main
main:
	j main1
.include "lib/funcUteis.s"
.include "lib/param.s"
.include "lib/mapping2D.s"
.include "lib/funcUteis2D.s"
.include "logica_do_jogo/player1_moves_certo.s"
.include "lib/userUtils.s"
.include "lib/pushPop.s"



# Limites da tela
main1:
	PrintBoard()
    li a2, RED
    jal initTabuleiro
    
	#j userToJose #retorna a0 = 0x000000yx
    maincontinue:


    j EXIT



.include "lib/SYSTEMv11.s"
EXIT:
    j EXIT
