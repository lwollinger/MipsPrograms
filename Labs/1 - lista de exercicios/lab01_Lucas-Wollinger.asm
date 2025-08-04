#########################################################
# Laboratório 01 - MCP22105
# Expressões Aritméticas e Lógicas
#
# Aluno: Lucas Martins WOllinger
#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# a: $t0, b: $t1, c: $t2, d: $t3, res: $t4
#########################################################

######################################
# res = a + b + c

add $t0, $t0, $t1  # a = a+b
add $t4, $t0,$t2  # res = (a+b) + C


######################################
# res = a - b - c

sub $t0, $t0, $t1  # a = (a-b)
add $t4, $t0,$t2   # res = (a-b) - c

######################################
# res = a * b - c

mul $t0, $t0, $t1  # a = a * b 
sub $t4, $t0, $t2  # res = (a*b) - c

######################################
# res = a * (b + c)

add $t1, $t1, $t2
mul $t4, $t0, $t1

######################################
# res = a + (b - 5)

li $t5, 5
sub $t4, $t1,$t5  # res = b-5
add $t4, $t0, $t4


######################################
# res = ((b % 2) == 0)
li $t4, 2
div $t1, $t4
mfhi $t4
seq  $t4, $t4, $zero

######################################
# res = (a < b) && (((a+b) % 3) == 2)

add $t4, $t0, $t1 	# res = a+b
li $t5, 3		# $t5 = 3
div $t4, $t5		# res = rest % 3
mfhi $t4		# buscando resto res = resto
li $t5, 2		# $t5 = 2
seq $t4, $t4, $t5 	# res == 2
slt $t5, $t0, $t1	# $t5 = a < b
and $t4, $t5, $t4	# res = $t5 && res


######################################
# res = (a >= b) && (c != d)

sne $t4, $t2, $t3 	#res = (c != d)
sge $t5, $t0, $t1	#$t5 = (a >= b)
and $t4, $t5, $t4	# res = (a >= b) && (c != d)

######################################
# res = (((a/2)+1) > b) || (d == (b-a))

sub $t4, $t1, $t0	# res = (b-a)
seq $t4, $t3, $t4	# res = (d == (b-a)

li $t5, 2		# $t5 = 2
div $t0, $t5 		# (a/2)
mflo $t5		# $t5 = divisao

addi $t5, $t5, 1	# $t5 = ((a/2)+1)
sgt $t5, $t5, $t1	# $t5 = (((a/2)+1) > b)

or $t4, $t4, $t5 	# res($t4) = $t5 {(((a/2)+1) > b)} || {(d == (b-a)}($t4))





