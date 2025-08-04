#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# Faça um programa que solicite dois números para o
# usuário e exiba a soma destes dois números
#

#########################################################
.data
mensagem1: .asciiz "Entre com um n�mero: "
mensagem2: .asciiz "Entre com um segundo n�mero: "
resultado: .asciiz "O resultado da soma foi: "

resposta1: .space 10
resposta2: .space 10
.text
	# mensagem 1
	li $v0, 4 
	la $a0, mensagem1
	syscall
	
	# L� resposta 1
	li $v0, 5
	la $a0, resposta1
	syscall
	move $t0, $v0
	
	# mensagem 2
	li $v0, 4 
	la $a0, mensagem2
	syscall
	
	# L� resposta 2
	li $v0, 5
	la $a0, resposta2
	syscall
	move $t1, $v0
	
	add $t0, $t0, $t1
	
	# resultado
	li $v0, 4 
	la $a0, resultado
	syscall
	
	li $v0, 1 
	move $a0, $t0
	syscall
	
	li $v0, 10 
	syscall
	
	
	
	
	

