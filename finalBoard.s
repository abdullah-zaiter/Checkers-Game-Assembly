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
    
    li t0,B3
    PrintPieceBlue(t0)
    li t0,D3
    PrintPieceBlue(t0)
    li t0,F3
    PrintPieceBlue(t0)
    li t0,H3
    PrintPieceBlue(t0)
    li t0,A2
    PrintPieceBlue(t0)
    li t0,C2
    PrintPieceBlue(t0)
    li t0,E2
    PrintPieceBlue(t0)
    li t0,G2
    PrintPieceBlue(t0)
    li t0,B1
    PrintPieceBlue(t0)
    li t0,D1
    PrintPieceBlue(t0)
    li t0,F1
    PrintPieceBlue(t0)
    li t0,H1
    PrintPieceBlue(t0)    

    
    li t0,A8
    PrintPieceRed(t0)
    li t0,C8
    PrintPieceRed(t0)
    li t0,E8
    PrintPieceRed(t0)
    li t0,G8
    PrintPieceRed(t0)
    li t0,B7
    PrintPieceRed(t0)
    li t0,D7
    PrintPieceRed(t0)
    li t0,F7
    PrintPieceRed(t0)
    li t0,H7
    PrintPieceRed(t0)
    li t0,A6
    PrintPieceRed(t0)
    li t0,C6
    PrintPieceRed(t0)
    li t0,E6
    PrintPieceRed(t0)
    li t0,G6
    PrintPieceRed(t0)
            




