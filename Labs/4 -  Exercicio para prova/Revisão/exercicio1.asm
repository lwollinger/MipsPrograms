#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# i: $s0, j: $s1
# Endereço base dos vetores: A: $s2 e B: $s3
#########################################################

#########################################################
# B[8] = A [i-j]
#

sub $t0, $s0, $s1		# $t0 = i-j
sll $t1, $t0, 2			# $t1 = [i-j] * 4(2^2*offset)
add $t1, $t1, $s2		# $t1 = &A[i-j]
lw $s4, 0($t1)			# $s4 = A[i-j]

sw $s4, 32($s3)


#########################################################

# Mapeamento dos registradores:
# i: $s0, j: $s1
# Endereço base dos vetores: A: $s2 e B: $s3
#########################################################
# B[32] = A[i] + A[j]

	sll $t0, $s0, 2		# offset de i * 4
	add $t0, $t0, $s2	# $t0 =  &A[i]
	lw $t0, 0($t0)		# $t0 =  A[i]
	
	sll $t1, $s1, 2		# offset de j * 4
	add $t1, $t1, $s2	# $t1 =  &A[j]
	lw $t1, 0($t1)		# $t1 =  A[j]
	
	add $t2, $t0, $t1	# A[i] + A[j]
	
	sw $t2, 128($s3)	# 32*4bytes = 128
	