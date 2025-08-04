#########################################################
# LaboratÃ³rio 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# FaÃ§a um programa que receba dois endereÃ§os de memÃ³ria 
# (fonte e destino) (0x10010000, 0x10010004), alÃ©m da 
# quantidade de posiÃ§Ãµes de memÃ³ria (bytes) que devem 
# ser copiados (0x10010008), e faÃ§a a transferÃªncia dos 
# dados presentes no endereÃ§o de fonte, para o endereÃ§o 
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
	lw $t0, fonte			# copia o conteúdo de uma palavra em memória para um registrador
	lw $t1, destino
	lw $t2, tamanho
	
loop: 
	lb $t3, 0($t0)			# Offset byte a byte do dados.
	blez $t2, loop_end		# while (tam >= 0).
	   sb $t3, 0($t1)		# armazena o byte no espaço de destino.
	  	li  $v0, 4           	# print string
    		move $a0, $t1 		# Move o byte para o destino e chama syscall	
    		syscall			
	   addi $t0, $t0, 1 		# Avança pro proximo espaço.
	   addi $t1, $t1, 1		# incrementando o vetor destino
	   addi $t2, $t2, -1		# Tamanho--. tam = 28
	j loop    
	
	# fazer a condição de controle do tamanho *******
	
loop_end:
	sw $t2, tamanho			# Salva no registrador tamanho quantidade byte
    	
