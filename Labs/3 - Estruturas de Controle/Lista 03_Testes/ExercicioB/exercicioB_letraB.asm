#########################################################
# FaÃ§a um programa que teste se o conteÃºdo da posiÃ§Ã£o de 
# memÃ³ria 0x10010000 e 0x10010004 sÃ£o iguais e, em caso 
# positivo, armazene o valor na posiÃ§Ã£o 0x10010008.
#
#########################################################
.data 
	a: .word 5
	b: .word 5
.text 
	lw $t0, a		# carregando endereço de memória em $t0
	lw $t1, b		# carregando endereço de memória em $t1
	
	beq $t0, $t1, igual 	# if conteudo $t0 == $t1 --> igual
	j end_2
igual:
	sw $t0, 0x10010008	# Armazena o conteúdo de $t0 na posição de memória 0x10010008
end_2:
