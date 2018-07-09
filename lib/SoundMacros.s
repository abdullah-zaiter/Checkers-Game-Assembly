#Instrumentos
.eqv PIANO 0
.eqv BRASS 58
.eqv TESTE 58
.eqv CHEERS 126

#Notas
.eqv TONE_C1 24
.eqv TONE_CS1 25
.eqv TONE_D1 26
.eqv TONE_DS1 27
.eqv TONE_E1 28
.eqv TONE_F1 29
.eqv TONE_FS1 30
.eqv TONE_G1 31
.eqv TONE_GS1 32
.eqv TONE_A1 33
.eqv TONE_AS1 34
.eqv TONE_B1 35
.eqv TONE_C2 36
.eqv TONE_CS2 37
.eqv TONE_D2 38
.eqv TONE_DS2 39
.eqv TONE_E2 40
.eqv TONE_F2 41
.eqv TONE_FS2 42
.eqv TONE_G2 43
.eqv TONE_GS2 44
.eqv TONE_A2 45
.eqv TONE_AS2 46
.eqv TONE_B2 47
.eqv TONE_C3 48
.eqv TONE_CS3 49
.eqv TONE_D3 50
.eqv TONE_DS3 51
.eqv TONE_E3 52
.eqv TONE_F3 53
.eqv TONE_FS3 54
.eqv TONE_G3 55
.eqv TONE_GS3 56
.eqv TONE_A3 57
.eqv TONE_AS3 58
.eqv TONE_B3 59
.eqv TONE_C4 60
.eqv TONE_CS4 61
.eqv TONE_D4 62
.eqv TONE_DS4 63
.eqv TONE_E4 64
.eqv TONE_F4 65
.eqv TONE_FS4 66
.eqv TONE_G4 67
.eqv TONE_GS4 68
.eqv TONE_A4 69
.eqv TONE_AS4 70
.eqv TONE_B4 71
.eqv TONE_C5 72
.eqv TONE_CS5 73
.eqv TONE_D5 74
.eqv TONE_DS5 75
.eqv TONE_E5 76
.eqv TONE_F5 77
.eqv TONE_FS5 78
.eqv TONE_G5 79
.eqv TONE_GS5 80
.eqv TONE_A5 81
.eqv TONE_AS5 82
.eqv TONE_B5 83
.eqv TONE_C6 84
.eqv TONE_CS6 85
.eqv TONE_D6 86
.eqv TONE_DS6 87
.eqv TONE_E6 88
.eqv TONE_F6 89
.eqv TONE_FS6 90
.eqv TONE_G6 91
.eqv TONE_GS6 92
.eqv TONE_A6 93
.eqv TONE_AS6 94
.eqv TONE_B6 95
.eqv TONE_C7 96
.eqv TONE_CS7 97
.eqv TONE_D7 98
.eqv TONE_DS7 99
.eqv TONE_E7 100
.eqv TONE_F7 101
.eqv TONE_FS7 102
.eqv TONE_G7 103
.eqv TONE_GS7 104
.eqv TONE_A7 105
.eqv TONE_AS7 106
.eqv TONE_B7 107

#Macros
.macro Sound(%note, %duration, %instrument, %volume)
	li a7, 33
	li a0, %note
	li a1, %duration
	li a2, %instrument
	li a3, %volume
	jal exceptionHandling
.end_macro

.macro WinMusic()
	Sound(TONE_C4, 5000, CHEERS, 120)
.end_macro

.macro LoseMusic()
	Sound(TONE_B5, 500, PIANO, 120)
	Sound(TONE_AS5, 500, PIANO, 120)
	Sound(TONE_DS5, 2400, PIANO, 120)
	
	Sound(TONE_GS5, 600, PIANO, 120)
	Sound(TONE_B5, 600, PIANO, 120)
	Sound(TONE_CS6, 1500, PIANO, 120)
	Sound(TONE_GS5, 2100, PIANO, 120)
	
	Sound(TONE_B5, 1200, PIANO, 120)
	
	Sound(TONE_AS5, 600, PIANO, 120)
	Sound(TONE_B5, 600, PIANO, 120)
	Sound(TONE_CS6, 600, PIANO, 120)
	Sound(TONE_FS5, 600, PIANO, 120)
	Sound(TONE_DS6, 2100, PIANO, 120)
	
	Sound(TONE_CS6, 1800, PIANO, 120)
.end_macro
	
.macro JurassicParkMusic()
	Sound(TONE_AS4, 500, BRASS, 100)
	Sound(TONE_F5, 900, BRASS, 120)
	
	Sound(TONE_AS4, 500, BRASS, 100)
	Sound(TONE_G5, 900, BRASS, 120)
	
	Sound(TONE_G5, 250, BRASS, 120)
	Sound(TONE_A5, 250, BRASS, 120)
	Sound(TONE_AS5, 750, BRASS, 120)
	
	Sound(TONE_AS5, 250, BRASS, 120)
	Sound(TONE_A5, 500, BRASS, 120)
	Sound(TONE_F5, 500, BRASS, 120)
	Sound(TONE_G5, 1250, BRASS, 120)
	
	Sound(TONE_AS5, 500, BRASS, 120)
	Sound(TONE_A5, 500, BRASS, 120)
	Sound(TONE_F5, 500, BRASS, 120)
	Sound(TONE_FS5, 750, BRASS, 120)
	
	Sound(TONE_D5, 400, BRASS, 120)
	Sound(TONE_G5, 250, BRASS, 120)
	Sound(TONE_A5, 250, BRASS, 120)
	Sound(TONE_AS5, 400, BRASS, 120)
	Sound(TONE_AS4, 750, BRASS, 120)
	
	Sound(TONE_C5, 400, BRASS, 120)
	Sound(TONE_D5, 400, BRASS, 120)
	Sound(TONE_D5, 750, BRASS, 120)
	
	Sound(TONE_CS5, 1000, BRASS, 120)
.end_macro
	