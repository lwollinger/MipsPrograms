#########################################################
# FaÃ§a um programa que leia o conteÃºdo da posiÃ§Ã£o de 
# memÃ³ria 0x10010000 e armazene-a na posiÃ§Ã£o 0x10010004 
# se ela for positiva, ou 0x10010008 se for negativa.
#
#########################################################

# obs: 	lw -> carregar um valor de uma posição de memória para um registrador
#	sw -> armazenar o conteúdo de um registrador em uma posição de memória
.data 
	a: .word 		# a tem endereço 0x10010000 e valor *escolhido
.text 
	lw $t0, a		# carregando endereço de memória em $t0
	bgez $t0, positivo	# if conteudo $t0 >= 0 --> positivo
	j negativo		# caso contrário jump to negativo

positivo:
	sw $t0, 0x10010004	# Armazena o conteúdo de $t0 na posição de memória 0x10010004
	j end
negativo:
	sw $t0, 0x10010008	# armazenando valor de $t0 no endereço 0x10010008
end: