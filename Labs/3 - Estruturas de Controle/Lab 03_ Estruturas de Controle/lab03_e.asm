#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# Faça um programa que receba dois endereços de memória 
# (fonte e destino) (0x10010000, 0x10010004), além da 
# quantidade de posições de memória (bytes) que devem 
# ser copiados (0x10010008), e faça a transferência dos 
# dados presentes no endereço de fonte, para o endereço 
# de destino.
#
#########################################################
.data 
fonte:		.word dados		# 0x10010000
destino:	.word dados2	# 0x10010004
tamanho:	.word 28			# 0x10010008
	
dados: .asciiz "Eu adoro microprocessadores"

.data 0x10010100
dados2: .space 40

.text
	lw $t0, fonte			# copia o conte�do de uma palavra em mem�ria para um registrador
	lw $t1, destino
	lw $t2, tamanho
	
loop: 
	lb $t3, 0($t0)			# Offset byte a byte do dados.
	blez $t2, loop_end		# while (tam >= 0).
	   sb $t3, 0($t1)		# armazena o byte no espa�o de destino.
	  	li  $v0, 4           	# print string
    		move $a0, $t1 		# Move o byte para o destino e chama syscall	
    		syscall			
	   addi $t0, $t0, 1 		# Avan�a pro proximo espa�o.
	   addi $t1, $t1, 1		# incrementando o vetor destino
	   addi $t2, $t2, -1		# Tamanho--. tam = 28
	j loop    
	
	# fazer a condi��o de controle do tamanho *******
	
loop_end:
	sw $t2, tamanho			# Salva no registrador tamanho quantidade byte
    	
