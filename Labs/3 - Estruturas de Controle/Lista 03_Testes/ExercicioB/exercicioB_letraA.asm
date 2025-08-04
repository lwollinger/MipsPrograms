#########################################################
# Faça um programa que leia o conteúdo da posição de 
# memória 0x10010000 e armazene-a na posição 0x10010004 
# se ela for positiva, ou 0x10010008 se for negativa.
#
#########################################################

# obs: 	lw -> carregar um valor de uma posi��o de mem�ria para um registrador
#	sw -> armazenar o conte�do de um registrador em uma posi��o de mem�ria
.data 
	a: .word 		# a tem endere�o 0x10010000 e valor *escolhido
.text 
	lw $t0, a		# carregando endere�o de mem�ria em $t0
	bgez $t0, positivo	# if conteudo $t0 >= 0 --> positivo
	j negativo		# caso contr�rio jump to negativo

positivo:
	sw $t0, 0x10010004	# Armazena o conte�do de $t0 na posi��o de mem�ria 0x10010004
	j end
negativo:
	sw $t0, 0x10010008	# armazenando valor de $t0 no endere�o 0x10010008
end: