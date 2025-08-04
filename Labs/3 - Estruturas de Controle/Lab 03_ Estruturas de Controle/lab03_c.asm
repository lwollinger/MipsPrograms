#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno:  Lucas Martins Wollinger
#########################################################
# OBS INICIAL
# Suponha que $t0 contenha o endere�o inicial do vetor e $t5 contenha o �ndice 'i'

# Calcula o deslocamento para acessar vector[i]
# sll $t6, $t5, 2         # Multiplica o �ndice pelo tamanho de uma palavra (4 bytes)
# Calcula o endere�o de vector[i]
# add $t6, $t6, $t0       # Adiciona o deslocamento ao endere�o inicial do vetor
# Carrega o valor de vector[i] no registrador $t8
# lw $t8, ($t6)           # Carrega o conte�do do endere�o calculado em $t6 para $t8

#########################################################
# Faça um programa para buscar um determinado valor em um 
# array de inteiros. O endereço inicial do vetor está 
# armazenado no endereço de memória 0x10010000, o tamanho 
# do vetor está no endereço 0x10010004 e valor que será 
# pesquisado está no endereço 0x10010008. Caso o valor 
# seja encontrado, escreva 0x01 no endereço 0x1001000C, 
# caso contrário, escreva 0x00.
#
#########################################################
.data
ptr_vector:   .word vector	# 0x10010000
vector_size:  .word 10		# 0x10010004
search_value: .word 89		# 0x10010008
result:	      .word 0		# 0x1001000C

vector: .word 9, 78, 45, -134, 89, 15, 72, 31, 8, 720

# implementacao 01
#
# result = 0;
# for (int i = 0; i < vector_size; i++) {
#    if( vector[i] == search_value) {
#	    result = 1;
#	    break;
#    }
# }

###### JEITO 1 #######
.text
	lw $t0, ptr_vector		# endere�o inicial do vetor
	lw $t1, vector_size
	lw $t2, search_value
	lw $t3, result
	
	li $t4, 0 			# contador = 0

loop:
	bge $t4, $t1, nao_encontrado	# Caso i >= Tamanho_vetor -> nao encontrado
	sll $t5, $t4, 2			# Calcula o deslocamento para acessar vetor[i] * 4 bytes
	add $t5, $t0, $t5		# somando offset com o inicio do vetor, vetor[0], vetor[1], vetor[2]
	lw $t6, ($t5)			# carregando vetor[i], no reg $t6
	beq $t6, $t2, encontrado	# caso $t6(Vetor[i]) = Vetor_result 
	addi $t4, $t4, 1		# i = i+1
	j loop
	
nao_encontrado:	
	li $t3, 0			# carrega valor "0" no endere�o 
	j end
encontrado:
	li $t3, 1
end:	
	sw $t3, result
	
######	JEITO 2 ######
.text
	lw $t0, ptr_vector		# endere�o inicial do vetor
	lw $t1, vector_size
	lw $t2, search_value
	lw $t3, result   		# result

loop:
	beqz $t1, end	# Caso i >= Tamanho_vetor -> nao encontrado
	addi $t1, $t1, -1
	lw   $t4, ($t0)
	addi $t0, $t0, 4		# ptr++
	beq  $t4, $t2, encontrado	# caso $t6(Vetor[i]) = Vetor_result 
	j loop
encontrado:
	li $t3, 1
end:	
	sw $t3, result
	


#########################################################
# Faça um programa para contar o número de elementos 
# encontrados em um array de inteiros. O endereço inicial 
# do vetor está armazenado no endereço de memória 0x10010000, 
# o tamanho do vetor está no endereço 0x10010004 e valor que 
# será contado está no endereço 0x10010008. Armazene no 
# endereço 0x1001000C o número de elementos encontrados 
# na procura.
#
#########################################################

.data
ptr_vector:   .word vector	# 0x10010000
vector_size:  .word 10		# 0x10010004
search_value: .word 89		# 0x10010008
result:	      .word 0		# 0x1001000C

vector: .word 9, 78, 45, -134, 89, 15, 72, 31, 8, 720

.text
	lw $t0, ptr_vector		# endere�o inicial do vetor
	lw $t1, vector_size
	lw $t2, search_value
	lw $t3, result
	
	li $t4, 0 			# contador = 0

loop:
	bge $t4, $t1, end	# Caso i >= Tamanho_vetor -> nao encontrado
	sll $t5, $t4, 2			# Calcula o deslocamento para acessar vetor[i] * 4 bytes
	add $t5, $t0, $t5		# somando offset com o inicio do vetor, vetor[0], vetor[1], vetor[2]
	lw $t6, ($t5)			# carregando vetor[i], no reg $t6
	beq $t6, $t2, encontrado	# caso ($t6(Vetor[i]) == Vetor_result )
	addi $t4, $t4, 1		# i = i+1
	j loop
	
encontrado:
	addi $t3, $t3,1
	j loop
end:	
	sw $t3, result
