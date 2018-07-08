.text
userToJose:
	
	#firstLetter (y)
	li a7, 12
	jal exceptionHandling
	li t0, 0xFFFFFFCF
	add a0, a0, t0 #a0 = 0x0000000y
		#Push (a0)
		addi sp, sp, -4
		sw a0, 0(sp)
	#add s0, zero, a0#debug

	#secondLetter (x)
	li a7, 12
	jal exceptionHandling
	li t1, 0xFFFFFF9F
	add a1 , a0, t1	#a1 = 0x0000000x
		#Pop (a0)
		lw a0, 0(sp) #restora a0 = 0x0000000y
		addi sp, sp, 4
	#add s1, zero, a1#debug

	slli t0, a0, 4
	add a0, t0, a1
	#colocaPraEndereco:# passa a0 = 0x000000yx
	j maincontinue



