#########################################################
# Paridade de uma palavra pode ser definida como par ou 
# Ã­mpar, de acordo com a quantidade de bits â€œ1â€? presentes 
# na palavra. Por exemplo, a palavra 0b0110 possui 
# paridade par, pois possui 2 bits ativados, enquanto que 
# a palavra 0b1110 possui paridade Ã­mpar uma vez que possui 
# 3 bits ativados. Projete um programa em linguagem assembly 
# do MIPS para calcular a paridade da palavra presente no 
# endereÃ§o de memÃ³ria 0x10018000. Armazene o valor 0x01 
# caso a paridade seja par, ou 0x02 caso seja Ã­mpar no 
# endereÃ§o de memÃ³ria 0x10018004.
#
# Utilize chamadas de sistemas para inicializar o valor 
# inicial da palavra armazenada no endereÃ§o 0x10018000.
#
#########################################################
.data 
    ptr_string:   .word string	# 0x10010000
    string: .asciiz "itaquaquecetuba"

    contador: .word 0
    par: .word 0x01		# Caso par botar 0x01 em -> 0x10018000
    impar: .word 0x02		# Caso ompar botar 0x02 em -> 0x10018004

.text    
    # Inicializando os contadores
    lw $t0, ptr_string
    lw $t1, contador
    
loop_contador:
	lb $t3, 0($t0)		# lê cada byte da string
	beqz $t3, end_loop	# if (*ptr_string == 0 ) -> end_loop
	andi $t4, $t3, 1	# Verifica se o mais significativo é ativo
	addi $t0, $t0, 1	# Proxima casa da string
	
	beq $t4, 1, ativo	# Caso Bit mais sig == 1 --> ativo 
	j loop_contador
ativo:
	add $t1, $t1, 1	# Soma 1 no contador do ativo
	j loop_contador 
    
end_loop:
    # Determinar a paridade
    li $t2, 2
    div $t2, $t1, $t2      # Divide o contador por 2
    mfhi $t2        # $t2 <- Resto da divisão
    
    # Verificar se o resto é zero (paridade par)
    beqz $t2, paridade_par   # Se o resto for zero, armazena 0x01 para par
    
    

paridade_par:
    
