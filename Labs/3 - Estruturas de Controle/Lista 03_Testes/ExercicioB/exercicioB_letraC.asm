#########################################################
# Faça um programa que leia o conteúdo da posição de 
# memória 0x10010000 e 0x10010004 e, armazene o maior 
# deles na posição 0x10010008.
#
#########################################################
.data
	a_2: .word 5		# 0x10010000 
	b_2: .word 4		# 0x10010004
.text 
	lw $t0, a_2
	# neste ponto tem-se $t0 (endere�o: 0x10010000 e valor: *escolhido)
	
	lw $t1, b_2	# carregando endere�o de mem�ria em $t1
	# neste ponto tem-se $t1 (endere�o: 0x10010004 e valor: *escolhido)
	
	bgt $t0, $t1, $t0_maior	# se $t0 > $t1 --> $t0_maior
	#caso $t1 > $t2
	sw $t1, 0x10010008
	j end_3
	
$t0_maior:
	sw $t0, 0x10010008
end_3: