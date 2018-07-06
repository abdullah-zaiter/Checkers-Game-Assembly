# Defines

.include "lib/SYSTEMv11.s"
.include "lib/funcUteis.s"
.include "lib/param.s"
.include "lib/board.s"


.text
# Limites da tela
.globl main
main:
	PrintBoard()
	li s0, 0xff000fff

