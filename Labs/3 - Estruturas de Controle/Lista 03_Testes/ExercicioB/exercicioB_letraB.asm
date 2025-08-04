#########################################################
# Faça um programa que teste se o conteúdo da posição de 
# memória 0x10010000 e 0x10010004 são iguais e, em caso 
# positivo, armazene o valor na posição 0x10010008.
#
#########################################################
.data 
	a: .word 5
	b: .word 5
.text 
	lw $t0, a		# carregando endere�o de mem�ria em $t0
	lw $t1, b		# carregando endere�o de mem�ria em $t1
	
	beq $t0, $t1, igual 	# if conteudo $t0 == $t1 --> igual
	j end_2
igual:
	sw $t0, 0x10010008	# Armazena o conte�do de $t0 na posi��o de mem�ria 0x10010008
end_2:
