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
    li t1, TRANSPARENT
    PaintColor(t1)
    
    li t0, RED
    li t1, 100 #x
    li t2, 100 #y
    li t3, 200 #xf
    li t4, 200 #yf
    PaintLine(t0,t1,t2,t3)
    #PaintSquare(s0,s1,s2,s3)

#  LOOP:
#      beq s2, s3, END
#      PaintLine(s0,s1,s2,s3)
#      addi s2, s2, 1
#      li s1, 100 #x
#      j LOOP
#END:
        




