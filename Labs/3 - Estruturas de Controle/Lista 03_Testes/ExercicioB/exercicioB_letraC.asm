#########################################################
# FaÃ§a um programa que leia o conteÃºdo da posiÃ§Ã£o de 
# memÃ³ria 0x10010000 e 0x10010004 e, armazene o maior 
# deles na posiÃ§Ã£o 0x10010008.
#
#########################################################
.data
	a_2: .word 5		# 0x10010000 
	b_2: .word 4		# 0x10010004
.text 
	lw $t0, a_2
	# neste ponto tem-se $t0 (endereço: 0x10010000 e valor: *escolhido)
	
	lw $t1, b_2	# carregando endereço de memória em $t1
	# neste ponto tem-se $t1 (endereço: 0x10010004 e valor: *escolhido)
	
	bgt $t0, $t1, $t0_maior	# se $t0 > $t1 --> $t0_maior
	#caso $t1 > $t2
	sw $t1, 0x10010008
	j end_3
	
$t0_maior:
	sw $t0, 0x10010008
end_3: