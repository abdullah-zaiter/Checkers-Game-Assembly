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
    #li t1, WHITE
    #PaintColor(t1)
    la t1,blue
    li t0,B3
    PrintPiece(t0, t1)
    li t0,D3
    PrintPiece(t0, t1)
    li t0,F3
    PrintPiece(t0, t1)
    li t0,H3
    PrintPiece(t0, t1)
    li t0,A2
    PrintPiece(t0, t1)
    li t0,C2
    PrintPiece(t0, t1)
    li t0,E2
    PrintPiece(t0, t1)
    li t0,G2
    PrintPiece(t0, t1)
    li t0,B1
    PrintPiece(t0, t1)
    li t0,D1
    PrintPiece(t0, t1)
    li t0,F1
    PrintPiece(t0, t1)
    li t0,H1
    PrintPiece(t0, t1)    

    la t1, red
    li t0,A8
    PrintPiece(t0, t1)
    li t0,C8
    PrintPiece(t0, t1)
    li t0,E8
    PrintPiece(t0, t1)
    li t0,G8
    PrintPiece(t0, t1)
    li t0,B7
    PrintPiece(t0, t1)
    li t0,D7
    PrintPiece(t0, t1)
    li t0,F7
    PrintPiece(t0, t1)
    li t0,H7
    PrintPiece(t0, t1)
    li t0,A6
    PrintPiece(t0, t1)
    li t0,C6
    PrintPiece(t0, t1)
    li t0,E6
    PrintPiece(t0, t1)
    li t0,G6
    PrintPiece(t0, t1)
            




