#########################################################
# Realize a conversÃ£o das expressÃµes abaixo considerando
# que os valores das variÃ¡veis jÃ¡ estÃ£o carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# f: $t0, g: $t1, h: $t2, i: $t3, j: $t4
# EndereÃ§o base A: $s0, EndereÃ§o base B: $s1
#########################################################

# OBS INICIAL: O idiota aqui nem se tocou que o exercicio não era sobre Ponto Flutuante
# Mas serviu como revisão :)


######################################
# f = ((g+1) * h) - 3
.data 
	msg: .asciiz "O resultado do exercicio 1 é: "
	f: .word 1
	g: .word 2
	h: .word 3
	i: .word 
	j: .word

.macro print_strPtr (%ptr)
	li $v0, 4
	la $a0, %ptr
	syscall
.end_macro

.macro printFloat(%reg)
    mov.s $f12, %reg
	li $v0, 2
	syscall
.end_macro

.macro li.s %reg, %imm
   li $at, %imm
   mtc1 $at, %reg
   cvt.s.w %reg, %reg
.end_macro

.text 
	lw $t0, f
	lw $t1, g
	lw $t2, h
	lw $t3, i
	lw $t4, i
	
	mtc1 $t0, $f0		# f -> Move to Cooprocessor
	mtc1 $t1, $f2		# g -> Move to Cooprocessor
	mtc1 $t2, $f4		# h -> Move to Cooprocessor
	mtc1 $t3, $f6		# i -> Move to Cooprocessor
	mtc1 $t4, $f8		# j -> Move to Cooprocessor
	
	cvt.s.w $f0, $f0	# Convert to single precision
	cvt.s.w $f2, $f2
	cvt.s.w $f4, $f4
	cvt.s.w $f6, $f6
	cvt.s.w $f8, $f8
	
	# f = ((g+1) * h) - 3
	
	li.s $f10, 1		# carregando valor em $f10 com macro
	#	sem macro
	# li $t4, 1
	# mct1 $t4, $f(qualquer)
	# cvt.s.w $f(escolhido), $f(escolhido)
	
	add.s $f0, $f2, $f10	# f = (g+1)
	mul.s $f0, $f0, $f4	# f = (g+1)*h
	li.s $f10, -3		
	add.s $f0, $f0, $f10	# f = [(g+1)*h] - 3
	
	print_strPtr(msg)
	printFloat($f0)
	

######################################
# f = (h*h + 2) / f - g

# Só resentando os valores dos registradores
.data 
	msg1: .asciiz "O resultado do exercicio 2 é: "
	f1: .word 1
	g1: .word 2
	h1: .word 3
	i1: .word 4
	j1: .word 5

.text 
	lw $t0, f1
	lw $t1, g1
	lw $t2, h1
	lw $t3, i1
	lw $t4, j1
	
	mtc1 $t0, $f0		# f -> Move to Cooprocessor
	mtc1 $t1, $f2		# g -> Move to Cooprocessor
	mtc1 $t2, $f4		# h -> Move to Cooprocessor
	mtc1 $t3, $f6		# i -> Move to Cooprocessor
	mtc1 $t4, $f8		# j -> Move to Cooprocessor
	
	cvt.s.w $f0, $f0	# Convert to single precision
	cvt.s.w $f2, $f2
	cvt.s.w $f4, $f4
	cvt.s.w $f6, $f6
	cvt.s.w $f8, $f8
	
	# f = (h*h + 2) / f - g
	
	mul.s $f4, $f4, $f4	# h = h*h
	li.s $f10, 2		# Carregando em $f10 o valor 2
	add.s $f4, $f4, $f10	# h = (h*h) + 2
	sub.s $f0, $f0, $f2	# f = f-g
	div.s $f0, $f4, $f0 	# f =  h[(h*h) + 2] / f[f-g]
	
	print_strPtr(msg1)
	printFloat($f0)

######################################
# B[i] = 2 * A[i] 

.data 
    msg2: .asciiz "O resultado do exercicio 3 é: "
    i2: .word 2
    A: .word 1, 2, 3, 4, 5    # Exemplo de array A
    B: .space 5              # Espaço para array B (5 elementos * 4 bytes)
	
.text 
main:
    lw $t3, i2       # Carregar o valor de i
    
    # Carregar endereços base de A e B
    la $s0, A
    la $s1, B
    
    # Calcular o endereço de A[i] e B[i]
    sll $t5, $t3, 2      # $t5 = i * 4 (deslocamento de 4 bytes para cada elemento)
    add $t6, $t5, $s0    # $t6 = endereço de $A[i]
    add $t5, $t5, $s1    # $t5 = endereço de $B[i]
    lw $s0, 0($t6)       # $s0 = A[i]
    lw $s1, 0($t5)       # $s1 = B[i]

    # Multiplicar por 2
    li $t7, 2
    mul $t7, $t7, $s0    # $t6 = 2 * A[i]

    # Armazenar o resultado em B[i]
    sw $t7, 0($s1)       # B[i] = 2 * A[i]



######################################
# B[f+g] = A[i] / (A[j] - B[j])

# Mapeamento dos registradores:
# f: $t0, g: $t1, h: $t2, i: $t3, j: $t4
# EndereÃ§o base A: $s0, EndereÃ§o base B: $s1
.data
	msg3: .asciiz "O resultado do exercicio 4 é: "
	
.text 
	sll $t5, $t3, 2      	# $t5 = i * 4 (deslocamento de 4 bytes para cada elemento)
    	add $t5, $t5, $s0    	# $t5 = endereço de $A[i]
    	lw $s3, 0($t5)       	# $s3 = A[i] 
    	
    	sll $t5, $t4, 2      	# $t5 = j * 4 (deslocamento de 4 bytes para cada elemento)
    	add $t6, $t5, $s0    	# $t6 = endereço de $A[j]
    	lw $s4, 0($t6)		# $s4 = A[j]
 	
    	add $t5, $t5, $s1	# $t5 = endereço de $B[j]
    	lw $s5, 0($t5)		# $s5 = B[j]
    	
    	sub $s4, $s4, $s5	# $s4 = (A[j] - B[j])
	div $s3, $s4		# A[i] / (A[j] - B[j])
	mflo $s4		# $t4 = A[i] / (A[j] - B[j])
	
    	add $t5, $t0, $t1	# $t5 = f+g
    	sll $t5, $t5, 2		# $t5 = ($t5) * 4
    	add $t5, $t5, $s1 	# $t5 = endereço de $B[f+g]
    	
    	sw  $s4, 0($t5)		# B[f+g] = $s4 

	
	
