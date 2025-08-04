##############################################################################
#
#     Utilizando os procedimentos implementados no exercÃ­cio anterior
# implemente um programa que solicita ao usuÃ¡rio uma frase, e em seguida,
# apresenta apenas a primeira palavra da frase digitada com todas as letras
# maiÃºsculas.
#
#     Exemplo, se o usuÃ£rio digitar "Bom dia!", o programa deverÃ¡ 
# imprimir "BOM"
#
##############################################################################

.macro print_str_ptr (%ptr)
  li $v0, 4
  la $a0, %ptr
  syscall
.end_macro

.macro print_str (%str)

.data
mStr: .asciiz %str

.text
   li $v0, 4
   la $a0, mStr
   syscall
.end_macro

.macro print_int_reg (%reg)
  move $a0, %reg
  li $v0, 1
  syscall
.end_macro

.macro get_str (%ptr, %max_size)
  li $v0, 8
  la $a0, %ptr
  li $a1, %max_size
  syscall
.end_macro

.macro get_int(%reg)
	li $v0, 5
	syscall
	move %reg, $v0
.end_macro

.macro exit
   li $v0, 10
   syscall
.end_macro



.data
str_len:    .word 0
str_buffer: .space 1024
str1:       .asciiz "MCP22105 is cool"

.text

	print_str("Digite uma frase: ")
	get_str(str_buffer, 1024)
	
	print_str("VocÃª digitou: ")
	print_str_ptr(str_buffer)
	
	## Chamar strlen
	la $a0, str_buffer
	jal strlen
	sw $v0, str_len
	
	print_str("A string digitada tem ")
	lw  $t0, str_len
	print_int_reg($t0)
	print_str(" caracteres\n")

	## Chamando função Search ' '
	la $a0, str_buffer
	li $a1, ' '
	jal strSearch
	move $s0, $v0
	
	print_str("O espaÃ§o estÃ¡ no Ã­ndice: ")
	print_int_reg($s0)
	print_str("\n")

	## Resize str1
	la $a0, str_buffer
	add $a1, $zero, $s0		# valor da posição onde está o primeiro espaço
	jal strResize
	
	print_str("Str1 ajustada: ")
	print_str_ptr(str_buffer)
	print_str("\n")

	# Fazer a conversÃ£o da string para caracteres maiÃºsculos
	la	$a0, str_buffer
	li	$a1, 1
	jal	changeCase
	print_str("MaiÃºsculo: ")
	print_str_ptr(str_buffer)
	print_str("\n")
	
	print_str("Final do programa\n")
	exit

#############################################
strlen:
	li $v0, 0 # len = 0
	strlen_L0:
		lb   $t0, 0($a0)
		beq  $t0, $zero, strlen_L0_exit
		addi $a0, $a0, 1
		addi $v0, $v0, 1
		j strlen_L0
	strlen_L0_exit:
	jr $ra
#############################################

strSearch:
	# a0 -> string
 	# a1 -> letra que deve procurar -> 'P'
 	# $t1 -> Contador
 	loop:
 	   lb $t0, 0($a0)
 	   beq $t0, $zero, nao_encontrado	# quando /0 nao encontrou
 	      beq $a1, $t0, exit_loop		# Caso letra igual ao que desejado, sair
 	   addi $t1, $t1, 1			# contador++      
 	   addi $a0, $a0, 1   			# adiciona +1 ao $a0
 	j loop
 	
 	#retorna valor do procedimento = -1
 	nao_encontrado:
	   addi $v0, $zero, -1			# Retorna quando não encontrou a 'letra' desejada
	   j end
	   
	exit_loop:
	   move $v0, $t1			# retorna a posição onde a 'letra' encontrada está
	   
	end:   
 	jr $ra
#############################################

strResize:
	# $a0 = str1 (ponteiro para a string)
	# $a1 = tamanho desejado

	# Calcular o tamanho atual da string
	la $t0, 0($a0)  		# Preserva o endereço original da string
	add $t5, $t5, $s0
	
	While_count:
	    lb $t1, 0($t0)
	    beqz $t1, Exit_while
	       addi $t0, $t0, 1		# str++   
	j While_count

	Exit_while:
	# Verificar se o tamanho desejado é maior que o atual
	    bgt $a1, $t5, size_maior
	
	# Ajustar o tamanho da string
	    add $t0, $a0, $a1		# Calcula o endereço da nova terminação
	    sb $zero, 0($t0) 		# Insere o terminador nulo na posição desejada
	    move $v0, $a1			# Retorna o novo tamanho da string
	    j exit
	
	size_maior:
	   li $v0, -1	# Retorna -1 se o tamanho desejado for maior que o tamanho atual
	
	exit:
	jr $ra
#############################################################################

changeCase:
	## recebo da main 
	## char *str -> a0 - string
	## bool type -> a1 - 0(minus), 1(maius)
	
	## $t1 = Min
	## $t2 = Max
	## $t3 = offset 32
	
	bnez $a1, Minuscula		# if $a1 == 0 -> minus
	li $t1, 64
	li $t2, 91
	li $t3, 32
	j While_change
	
	Minuscula:
	li $t1, 96
	li $t2, 123
	li $t3, -32
					
					
	While_change:
	lb $t0, 0($a0)			# bit a bit
	beqz $t0, While_exit		# Quando if (string == /0) -> exit
	   sgt $t4, $t0, $t1		# letra < (min) 
	   sgt $t5, $t2, $t0		# letra < (max) 
	   and $t4, $t4, $t5		# min < letra < max
	   ## caso and == 1 entra no if
	   beqz $t4, else
	     add $t0, $t0, $t3		# letra + offset
	     sb $t0, 0($a0)		# *str = letra + offset
	
	else:
	addi $a0, $a0, 1		# str++
	j While_change
	
	While_exit:
	jr $ra
#############################################



