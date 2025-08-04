# B[f+g] = A[i] / (A[j] - B[j])

# Mapeamento dos registradores:
# f: $t0, g: $t1, i: $t2, j: $t3
# Endereço base A: $s0, Endereço base B: $s1

.text 
	sll $t4, $t3, 2		# $t4 = j * 2^2 -> offset
	add $t5, $t4, $s1	# $t5 = &B[j]
	lw $t5, 0($t5)		# $t5 = B[j]
	
	add $t4, $t4, $s0	# $t4 = &A[j]
	lw $t4, 0($t4)		# $t4 = A[j]
	
	sub $t4, $t4, $t5	# $t4 = (A[j] - B[j])
	
	sll $t5, $t2, 2		# $t5 = i * 4
	add $t5, $t5, $s0	# $t5 = &A[i]
	lw $t5, 0($t5)		# $t5 = A[i]
	
	div $t5, $t4	# $t4 = A[i] / (A[j] - B[j])
	mflo $t4
	
	add $t5, $t0, $t1	# $t5 = f+g
	sll $t5, $t5, 2		# $t5 = (f+g) * 4
	add $t5, $t5, $s1	# $t5 = &B[f+g]
	
	sw $t5, 0($t4)		# B[f+g] = A[i] / (A[j] - B[j])
	
	

	
.data

	a: .word 3
	
.text 
	lw $s0, a
	
	blt $s0, 7, if_case
	add $t0, $s0, $s0
	sw $t0, 0($s1)
	j end_case
	
	if_case:
	addi $t0, $s0, 7
	sw $t0, 0($s1)
	
	end_case:	
	
