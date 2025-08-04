#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Lucas Martins Wollinger
#########################################################


#########################################################
# Faça um programa que imprime a cadeia de caracteres
# "Hello World!" em linguagem assembler para o MIPS
#
.data
frase: .asciiz "Hello World!"
.text
	li $v0, 4 	#imprimir cadeia de caractere
	la $a0, frase 	#carregando endere�o do label
	syscall 
	
	li $v0, 10
	syscall
	# em help -> syscall ta escrito tudo.

# $v0, 4 --> diz para o registrador que vai receber uma string 
# $a0, label -> s� syscall s� mostra na tela oque est� no $a0
#########################################################



