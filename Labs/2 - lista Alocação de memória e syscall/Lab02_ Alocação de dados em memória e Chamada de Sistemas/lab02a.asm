#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: Lucas Wollinger
#########################################################

#########################################################
# Considere o seguinte programa em linguagem 
# Assembly do MIPS
#
#    .data 0x10010400 # segmento de dados
    #  palavra1: .word 13 --> 0x10010400
    #  palavra2: .word 0x15 --> 0x10010404
#
# Indique, em hexadecimal, os endereços de memória dos 
# símbolos palavra1 e palavra2
##########################################################


#########################################################
# Considere o seguinte programa em linguagem 
# Assembly do MIPS
#
#    .data 0x10010800 # segmento de dados
#
#      variavel_a: .word 13 --> 0x10010800
#      nums:       .word 2(0x10010804), 6(0x10010808), 8(0x10010812), 5(0x10010816), 98(0x10010820), 74(0x10010824), 28
# 	
 	nums: 74 se encontra no endere�o .data 0x10010824
#
# Indique, em hexadecimal, o endereço do elemento com o
# valor 74 do vetor nums
##########################################################


#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# i: $s3, j: $s4
# Endereço base dos vetores: A: $s6 e B: $s7
#########################################################

#########################################################
# B[8] = A [i-j]
#	
#	para acessar o conteudo do vetor

	sub $t0, $s3, $s4	# t0 <- i-j
	sll $t0, $t0, 2		# to falando que quando eu definir uma posi��o ex: 
				# A[4]= 4(posi��o que eu quero) * 4bytes 
				
	add $t0, $t0, $s6	# t0 <- &A[i-j] (endere�o de A[i-j] 
	lw $s6, 0($t0) 		# $t0 <- vai receber o valor do A{i-j}
		
	sw $s0, 32($s7)		# B[8] <- $s0
#	
#	
#	
#########################################################


#########################################################
# B[32] = A[i] + A[j]
#				
	sll $t0, $s3, 2		# $t0 = (i)posi��o * 4(offset 4 bytes)
	add $t0, $t0, $s6	# $t0 <- &A[i]
	lw $s0, 0($t0)		# $s0 = A[i]
	
	
	sll $t1, $s4, 2 	# $t1 = (i)posi��o * 4(offset 4 bytes)
	add $t1, $t1, $s6	# $t1 <- &A[j]
	lw $s1, 0($t1)		# $s1 = A[j]
	
	add $s0, $s0, $s1	# $s0 = (A[i] + A[j])
	
	sw $s0, 128($s7) # (4bytes) * (32_endere�o) = 128	# B[32] = $s0 (A[i] + A[j])
#
#
#########################################################






