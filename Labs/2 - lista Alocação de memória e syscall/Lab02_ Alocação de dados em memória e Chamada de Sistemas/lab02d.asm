#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# Faça um programa no MARS, utilizando as chamadas de 
# sistema que implementa um papagaio :)
#
# O programa imprime no terminal a mesma frase que
# foi digitada pelo usuário.
#
#  # Diga alguma coisa que eu irei dizer também!
#  # Entre com o seu texto: ...
#  # O seu texto é: ...
#
#########################################################
.data 
mensagem: .asciiz "Entre com o seu texto: "
resposta: .asciiz "O texto digitado foi: "
entrada_string:
.text
	#mostra na tela a mensagem acima
	li $v0, 4		# Carrega c�gido syscall para ler string
	la $a0, mensagem	# Endere�o da mensagem
	syscall 		# Imprimir
	
	li $v0, 8              # Carrega o c�digo syscall para ler string
    	la $a0, entrada_string  # $a0 = address of input buffer
    	li $a1, 16		# $a1 = maximum number of characters to read
    	syscall 
	
	li $v0, 4		# print string
	la $a0, resposta	# Endere�o da mensagem
	syscall			# chamada
	
	li $v0, 4		# avisando ao registrador $v0 que print string
	la $a0, entrada_string	# Endere�o da mensagem
	syscall			# chamada

	li $v0, 10
	syscall
	

	
