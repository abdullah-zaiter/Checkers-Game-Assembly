	.data
		PI6: .float 0.7854
	.text
#____________________________________________________________________________________________________________________________________
	# Macros
	
	.macro sin(%angle, %result)
		#a0 = n; a1 = (2n+1); a2 = (-1)^n; a3 = angle^(2n+1) e depois a3 = (2n+1)!; a4 = auxiliar1; a5 = auxiliar2
		fmv.s %result, %angle		#result comeca com o angulo (para quando n=0)
		li a0, 5			#somatoria com N=10
LOOP:		beq a0, zero, ENDLOOP

		li a1, 2
		mul a1, a1, a0			#a1 = 2*n
		addi a1, a1, 1			#a1 = 2*n+1
		
		li a4, -1
		pot(a4, a0, a2)		#a2 = (-1)^n
		
		fpot(%angle, a1, fa0)		#fa0 = angle^(2n+1)
		
		fcvt.s.w fa1, a2
		fmul.s fa0, fa0, fa1			#a2 = ((-1)^n)*(angle^(2n+1))
		
		fat(a1, a3)			#a3 = (2n+1)!
		
		fcvt.s.w fa1, a3
		fdiv.s fa0, fa0, fa1		#fa0 = ( ((-1)^n)*(angle^(2n+1)) ) / (2n+1)!
		
		fadd.s %result, %result, fa0	#somando um termo da somatoria
		addi a0, a0, -1			#proximo termo da somatoria
		j LOOP
		
		#Depois do loop, o resultadoŽeh o seno. cos = sqrt(1 - sen^2)
ENDLOOP:	#fmul.s %result, %result, %result	#result = sen^2

		#li a0, 1
		#fcvt.s.w fa0, a0
		#fsub.s %result, fa0, %result	#result = 1 - sen^2
		
		#fsqrt.s %result, %result	#result = sqrt(1 - sen^2) = cos
		
	.end_macro



	.macro cos(%angle, %result)
		addi sp, sp, -8
		sw t0, 0(sp)
		fsw ft0, 4(sp)
	
		sin(%angle, %result)
		
		fmul.s %result, %result, %result
				
		li t0, 1
		fcvt.s.w ft0, t0
		
		fsub.s %result, ft0, %result
		fsqrt.s %result, %result
		
		lw t0, 0(sp)
		flw ft0, 4(sp)
		addi sp, sp, 8
		
	.end_macro
	
	
	.macro tg(%angle, %result)
		addi sp, sp, -12
		sw t0, 0(sp)
		fsw ft0, 4(sp)
		fsw ft1, 8(sp)
		
		sin(%angle, %result)
		fmv.s ft0, %result
		
		li t0, 1
		fcvt.s.w ft1, t0
		fmul.s ft0, %result, %result
		fsub.s ft0, ft1, ft0
		fsqrt.s ft0, ft0
		
		fdiv.s %result, %result, ft0
	
		lw t0, 0(sp)
		flw ft0, 4(sp)
		flw ft1, 8(sp)
		addi sp, sp, 12
		
	.end_macro
	
	
	
	.macro fat(%num, %result)
		addi sp, sp, -4
		sw t0, 0(sp)
	
		mv t0, %num
		mv %result, %num
		beq %num, zero, ZERO
LOOP:		addi t0, t0, -1
		beq t0, zero, END
		mul %result, %result, t0
		j LOOP
ZERO:		li %result, 1
		j END
		
END:		lw t0, 0(sp)
		addi sp, sp, 4
	.end_macro
	
	.macro pot(%num, %pot, %result)
		addi sp, sp, -4
		sw t0, 0(sp)
		
		li %result, 1
		mv t0, %pot
LOOP:		beq t0, zero, END
		mul %result, %result, %num
		addi t0, t0, -1
		j LOOP
		
END:		lw t0, 0(sp)
		addi sp, sp, 4
	.end_macro
	
	.macro fpot(%fnum, %pot, %fresult)
		addi sp, sp, -4
		sw t0, 0(sp)
		
		li t0, 1
		fcvt.s.w %fresult, t0
		mv t0, %pot
LOOP:		beq t0, zero, END
		fmul.s %fresult, %fresult, %fnum
		addi t0, t0, -1
		j LOOP
		
END:		lw t0, 0(sp)
		addi sp, sp, 4
	.end_macro
#____________________________________________________________________________________________________________________________________
		
		la t0, PI6
		flw ft0, 0(t0)
		tg(ft0, fs0)
		
		
