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

vector: .word 9, 78, 45, -134, 89, 15, 72, 31, 89, 720

.text
	lw $t0, ptr_vector		# endere�o inicial do vetor
	lw $t1, vector_size
	lw $t2, search_value
	lw $t3, result
	
	li $t4, 0 			# contador = 0

loop:
	bge $t4, $t1, end		# Caso i >= Tamanho_vetor -> nao encontrado
	sll $t5, $t4, 2		# Calcula o deslocamento para acessar vetor[i] * 4 bytes
	add $t5, $t0, $t5		# somando offset com o inicio do vetor, vetor[0], vetor[1], vetor[2]
	lw $t6, ($t5)			# carregando vetor[i], no reg $t6
	bne $t6, $t2, skip         	# caso ($t6(Vetor[i]) != Vetor_result), skip
	addi $t3, $t3,1			# caso igual soma 1 no resultado
skip:
	addi $t4, $t4, 1		# i = i+1
	j loop
end:	
	sw $t3, result