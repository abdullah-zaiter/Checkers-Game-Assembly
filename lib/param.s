   .data
    # Limites da tela
	.eqv ScreenBg 0xFF000000
	.eqv ScreenEnd 0xFF012C00
	.eqv ScreenHeight 240
	.eqv ScreenWidth 320
	
	# Limites do tabuleiro
	.eqv BoardBg 0xFF001914
	.eqv BoardTileSize 25

	#tamanho Peças
	.eqv pieceSize 15

    .eqv SizePixels 80000 # depende de ScreenWidth e ScreenHeight
		
	# Cores
	.eqv BLACK 0x00
	.eqv WHITE 0xFF

	.eqv RED 0x07
	.eqv DARKRED 0x03
	.eqv PURPLE 0x42

	.eqv GREEN 0x38
	.eqv YELLOW	0x2f
	.eqv DARKGREEN 0x08

	.eqv BLUE 0xC0
	.eqv BestBLUE 0xd1
	.eqv DARKBLUE 0xc0
	.eqv CYAN 0x48

	.eqv BROWN 0x13
	.eqv LIGHTBROWN 0x66
	.eqv DARKBROWN 0x0A

	
	.eqv TRANSPARENT 0xc7

    .eqv _bmpAddress	0x10040

	
