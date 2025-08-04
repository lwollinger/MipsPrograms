#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# Uma cadeia de caracteres (string) é definida como um 
# conjunto de bytes, ordenados de forma consecutiva na 
# memória, terminada por um caractere nulo (byte 0). Faça 
# um programa que receba o endereço do início de uma string 
# e calcule o seu tamanho (número de caracteres). O 
# endereço da string é armazenado no endereço 0x10010000. 
# Armazene o resultado no endereço de memória 0x10010004.
#
#########################################################
.data
	ptr_string:   .word string	# 0x10010000
	string_size:  .word 0		# 0x10010004
	string: .asciiz "Eu amo linguagens formais"
.text
	lw $t0, ptr_string
	lw $t1, string_size
	

loop:
	lb $t2, 0($t0)
	beqz $t2, loop_end
	  addi $t1, $t1, 1 ## string_size++
	  addi $t0, $t0, 1 ## ptr_string++
	j loop
loop_end:
	sw $t1, string_size
	
###
#     while( *ptr_string != 0){
#	string_size++; 
#	ptr_string++;   
#     }
	
	
	
	
	
	
	
	
	
	
	
