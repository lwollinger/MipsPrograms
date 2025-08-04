#########################################################
# if ( ( a < b ) &&  ( c == d ) ) {
#   a = a * (((c/b) * 2) + 10);
# } else {
#   a = a / ((c+4)/b);
# }
# a++;
#########################################################

.data 
	a: .word 5
	b: .word 6
	c: .word 4
	d: .word 1

.text 
	lw $t0, a
	lw $t1, b
	lw $t2, c
	lw $t3, d
	
	sgt $t4, $t0, $t1	# ( a < b )
	seq $t5, $t2, $t3	# ( c == d )
	and $t6 ,$t4, $t5	# ( a < b ) &&  ( c == d )

	bnez  $t6, caso_verdade # se $t6 != 0 --> label (0 = mentira)(1 = verdade)
	
	# else a = a / ((c+4)/b);
	
	addi $t7, $t2, 4	# (c+4)
	div $t7, $t1		# ((c+4)/b
	mflo $t7		
	div $t0, $t7		# a / ((c+4)/b)
	mflo $t7
	add $t0, $t7, $zero	# a = (a / ((c+4)/b)) + 0
	
j end	
	
caso_verdade:
	# a = a * (((c/b) * 2) + 10);
	
	div $t7, $t2, $t3	# (c/b)
	mflo $t7		# carregando resultado
	li $t8, 2		# $t8 = 2
	mul $t7, $t7, $t8	# (c/b) * 2)
	addi $t7, $t7, 10	# ((c/b) * 2) + 10
	
	mul $t0, $t0, $t7	# a = a * (((c/b) * 2) + 10);

end: 
	addi $t0, $t0, 1

