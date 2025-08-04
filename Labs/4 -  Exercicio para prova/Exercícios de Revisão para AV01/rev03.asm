#########################################################
# Qual Ã© o valor do registrador $s0 apÃ³s a execuÃ§Ã£o das 
# instruÃ§Ãµes abaixo? O registrador $s1 possui o valor 
# 0x0000FEFE. Apresente a sua resposta em hexadecimal.
#########################################################

 addi $s1, $0, 65278
#########################################################
	add  $s0, $0, $0	# $s0 = 0
LOOP:	
	beq  $s1, $0,  DONE	# $s1 == 0 --> DONE
	andi $t0, $s1, 0x01	# vai verificar se é 0 ou 1 no final
	beq  $t0, $0, SKIP	# se t0 == 0 --> skip
	addi $s0, $s0, 1	# $t0 != 0 -> $s0 = $s0 + 1 ""Contador""
SKIP:
	srl	 $s1, $s1, 1	# vai deslocar todos os bits para a direita %2
	j    LOOP
DONE:

# O programa vai contar quantos ciclos levou para que o numero em $s1 leva para chegar a zero


#########################################################

#########################################################
	addi $t0, $0, 12	# $t0 = 12
	sll  $t0, $t0, 4	# $t0 = $t0 * 2^4(offset)
	xori $t0, $t0, 10	# operação XOR bit a bit entre 192 e 10 (Binários) = 202
	sll  $t0, $t0, 8	# $t0 = 202 * 2^8 = 51712
	xori $t0, $t0, 255	# 1100100100000000 (51712) XOR 0000000011111111(255) = 1100100111111111(65535
	and  $s0, $s1, $t0	
#########################################################


