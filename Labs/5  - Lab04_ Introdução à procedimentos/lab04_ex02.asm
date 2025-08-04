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
str1:       .asciiz "MCP22105 is cool"

.text
	print_str("Str1: ")
	print_str_ptr(str1)
	print_str("\n")
	
	## Chamar strlen
	la $a0, str1
	jal strlen
	move $s0, $v0
	
	print_str("A str1 tem ")
	print_int_reg($s0)
	print_str(" caracteres\n")
	
	## Resize str1
	la $a0, str1
	li $a1, 3
	jal strResize
	
	print_str("Str1 ajustada: ")
	print_str_ptr(str1)
	print_str("\n")
	
	## Chamar strlen
	la $a0, str1
	jal strlen
	move $s0, $v0
	print_str("A str1 ajustada tem ")
	print_int_reg($s0)
	print_str(" caracteres\n")
	
	
	
	print_str("Final do programa\n")
	exit

#############################################	
# int strResize(char * str, int size);		
#
#
# diminuir memória da string, lembrar de botar /0 = 0 no final da string
# EX: string [10] -> [0 á 9, 10=/0]
#
#
#  O procedimento deve modificar o tamanho da string
# de acordo com o tamanho especificado pelo parÃ¢metro
# size. O size deve ser sempre menor que o tamanho
# atual da string.
#
#  O procedimento retorna o valor -1, caso o size seja
# maior que o tamanho da string, ou o novo tamanho da
# string, caso contrÃ¡rio, ou seja, o prÃ³prio valor de
# size.
#
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
#############################################

#############################################	
# int strlen(char * str) {
#   int len = 0;
#   while ( *str != 0 ){
#     str = str + 1;
#     len = len + 1;
#   }
#   return len;
#}
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
