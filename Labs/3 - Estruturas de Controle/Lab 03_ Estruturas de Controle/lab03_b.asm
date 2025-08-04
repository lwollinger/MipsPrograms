#########################################################
# LaboratÃ³rio 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# FaÃ§a um programa que leia o conteÃºdo da posiÃ§Ã£o de 
# memÃ³ria 0x10010000 e armazene-a na posiÃ§Ã£o 0x10010004 
# se ela for positiva, ou 0x10010008 se for negativa.
#
#########################################################

# obs: 	lw -> carregar um valor de uma posição de memória para um registrador
#	sw -> armazenar o conteúdo de um registrador em uma posição de memória
.data 
	a: .word 6
.text 
	lw $t0, a	# carregando endereço de memória em $t0
	# neste ponto tem-se $t0 (endereço: 0x10010000 e valor: 5)
	
	bgez $t0, positivo	# if conteudo $t0 >= 0 --> positivo
	j negativo		# caso contrário jump to negativo

positivo:
	sw $t0, 0x10010004	# Armazena o conteúdo de $t0 na posição de memória 0x10010004
	j end
negativo:
	sw $t0, 0x10010008	# armazenando valor de $t0 no endereço 0x10010008
end:

#########################################################
# FaÃ§a um programa que teste se o conteÃºdo da posiÃ§Ã£o de 
# memÃ³ria 0x10010000 e 0x10010004 sÃ£o iguais e, em caso 
# positivo, armazene o valor na posiÃ§Ã£o 0x10010008.
#
#########################################################

.text 
	li $t0, 6
	sw $t0, 0x10010000	#carrega o conteudo de $t0 no endereço 0x10010000
	lw $t0, 0x10010000	# carregando endereço de memória em $t0
	# neste ponto tem-se $t0 (endereço: 0x10010000 e valor: *escolhido)
	
	li $t1, 6
	sw $t1, 0x10010004	#carrega o conteudo de $t1 no endereço 0x10010004
	lw $t1, 0x10010004	# carregando endereço de memória em $t1
	# neste ponto tem-se $t1 (endereço: 0x10010004 e valor: *escolhido)
	
	beq $t0, $t1, igual 	# if conteudo $t0 == $t1 --> igual
	j end_2
igual:
	sw $t0, 0x10010008	# Armazena o conteúdo de $t0 na posição de memória 0x10010008
end_2:



#########################################################
# FaÃ§a um programa que leia o conteÃºdo da posiÃ§Ã£o de 
# memÃ³ria 0x10010000 e 0x10010004 e, armazene o maior 
# deles na posiÃ§Ã£o 0x10010008.
#
#########################################################
.data
	a_2: .word 5
	b_2: .word 4
.text 
	lw $t0, a_2
	# neste ponto tem-se $t0 (endereço: 0x10010000 e valor: *escolhido)
	
	lw $t1, b_2	# carregando endereço de memória em $t1
	# neste ponto tem-se $t1 (endereço: 0x10010004 e valor: *escolhido)
	
	bgt $t0, $t1, $t0_maior	# se $t0 > $t1 --> $t0_maior
	#caso $t1 > $t2
	sw $t1, 0x10010008
	j end_3
	
$t0_maior:
	sw $t0, 0x10010008
end_3:

#########################################################
# FaÃ§a um programa que leia 3 notas dos endereÃ§os 
# 0x10010000, 0x10010004 e 0x10010008 e, sabendo que a 
# mÃ©dia Ã© 7, armazene 1 no endereÃ§o 0x1001000C caso ele 
# esteja aprovado ou no endereÃ§o 0x10010010 caso ele 
# esteja reprovado.
#
#########################################################
.data
a: .word 2       # A tem endereço 0x10010000
b: .word 9       # B tem endereço 0x10010004
c: .word 9       # C tem endereço 0x10010008

.text
    li $t4, 1           # adicionando 1 ao reg $t4 para resultado
    
    lw $t0, a           # carregando valor de A em $t0
    lw $t1, b           # carregando valor de B em $t1
    lw $t2, c           # carregando valor de C em $t2
    
    add $t0, $t0, $t1   # ($t0 = $t0 + $t1)
    add $t0, $t0, $t2   # ($t0 = $t0 + $t2) --> nota total
    
    li $t3, 3           # Média para dividir por 3
    div $t0, $t3        # NF = Média/3
    
    mflo $t3            # Nota final atribuída a $t3
    
    bge $t3, 7, aprovado    # Se média >= 7 --> aprovado
    sw $t4, 0x10010010      # Caso reprovou --> Armazena o valor de $t3 no endereço 0x10010010
    j end_4

aprovado:
    sw $t4, 0x1001000C      # Armazena o valor de $t3 no endereço 0x1001000C
end_4:

