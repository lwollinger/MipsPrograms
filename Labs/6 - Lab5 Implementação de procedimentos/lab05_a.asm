#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# O fatorial de um número pode ser calculado através de 
# um procedimento recursivo, conforme definido abaixo:
#
# unsigned int fatorial(unsigned int n){ 
#     if(n == 0) {
#         return 1; 
#     } else {
#         return n * fatorial(n-1); 
#     }
# }
#
# Implemente a função fatorial apresentada acima, 
# e faça um programa que irá apresentar o fatorial dos 
# primeiros 10 números naturais. Utilize as chamadas de 
# sistema para a entrada e saída de dados. O código deve 
# ser implementado seguindo a convenção de chamada de 
# procedimento estudada em sala de aula.
#########################################################
.include "macros.inc"
.text 0x00400000
init:
	la $sp, 0x7FFFEFFC
	jal main
	exit
.include "string.inc"

#-----------
# ($a0) old_stk -> 16($sp)
#-----------
#   $ra         -> 12($sp)
#-----------
#   $s1         -> 8($sp)
#-----------
#   $s0         -> 4($sp)
#-----------
#   $a0         -> 0($sp)
#############################################
main:
	addiu $sp, $sp, -16		# Stack Point 
	sw    $s0, 4($sp)		# $s0 -> 4($sp)
	sw    $s1, 8($sp)		# $s1 -> 8($sp)
	sw    $ra, 12($sp)		# $ra -> 12($sp)	Return Adress

	li $s0, 11			# $s0 = 11
main_L0:
	beqz $s0, main_L0_end		# if ($s0 == 0) , endloop 
	addi $s0, $s0, -1
	
	print_str("fatorial(")
	print_intReg($s0)
	print_str(") = ")		# Printa o Valor Atual do fatorial
	
	move $a0, $s0			# &a0 <= $s0 = Valor Atual de $a0 para mandar para fun��o
	jal  fatorial			# Chama fatorial -> Mandou int n => $s0
	move $s1, $v0
	
	print_intReg($s1)
	print_str("\n")
	
	j main_L0			# Retorna ao inicio do Loop

main_L0_end:
  lw	$ra, 12($sp)
  lw    $s1, 8($sp)
  lw    $s0, 4($sp)
	addiu $sp, $sp, 16
	jr $ra
############################################

# prev_stack ($a0) |  8	
#======================
#   $ra            |  4	  <- Return adress
#----------------------
#   $a0            |  0   <- $sp
#======================

fatorial:
   addiu $sp, $sp, -8		# Crio nova Pilha
   sw $ra, 4($sp)		# Armazeno valor de retorno $ra na pilha
   sw $a0, 8($sp)		# Armazeno $a0 na pilha
   
   li $v0, 1 			# $v0 = 1 -> valor de Ret

      
   beqz $a0, fatorial_if_end	# if (n==0), fatorial_if_end
   	addi $a0, $a0, -1	# n = (n-1)
   	jal fatorial		# chama proximo fatorial
   	lw  $a0, 8($sp)		# restaura o valor do $a0 original
   	mul $v0, $a0, $v0	# 
   
   fatorial_if_end:
   lw $ra, 4($sp)		
   addiu $sp, $sp, 8	
   		
   jr $ra
######################
# unsigned int fatorial(unsigned int n){ 
#     unsigned int ret;
#     if(n == 0) {
#         ret = 1; 
#     } else {
#         ret = n * fatorial(n-1); 
#     }
#		  return ret;
# }
#
#############################################
