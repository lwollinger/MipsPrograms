#########################################################
# LaboratÃ³rio 02 - MCP22105
# AlocaÃ§Ã£o de dados em memÃ³ria e Chamada de Sistemas
#
# Aluno: Lucas Martins Wollinger
#########################################################


#########################################################
# FaÃ§a um programa que imprime a cadeia de caracteres
# "Hello World!" em linguagem assembler para o MIPS
#
.data
frase: .asciiz "Hello World!"
.text
	li $v0, 4 	#imprimir cadeia de caractere
	la $a0, frase 	#carregando endereço do label
	syscall 
	
	li $v0, 10
	syscall
	# em help -> syscall ta escrito tudo.

# $v0, 4 --> diz para o registrador que vai receber uma string 
# $a0, label -> só syscall só mostra na tela oque está no $a0
#########################################################



