#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: Lucas Martins Wollinger
#########################################################
# prev_stack ($a0) |  8	
#======================
#   $ra            |  4	  <- Return adress
#----------------------
#   $a0            |  0   <- $sp
#======================

q_perfeito:
   addiu $sp, $sp, -8		# Crio nova Pilha
   sw $ra, 4($sp)			# Armazeno valor de retorno $ra na pilha
   sw $a0, 8($sp)			# Armazeno $a0 na pilha
   
   li $v0, 0
   
   beqz $a0, q_perfeito_if_end 
      addi $a0, $a0, -1		# n = (n-1)
      jal q_perfeito		# q_perfeito(n-1)
      lw  $a0, 8($sp)		# restaura o valor do $a0 original
      mul $t0, $a0, 2		# $t0 = 2*n
      sub $t0, $t0, -1		# $t0 = 2*n - 1
      mul $v0, $a0, $v0		# return [q_perfeito(n-1)] + (2*n - 1)      

q_perfeito_if_end:		# Retornando 
   lw $ra, 4($sp)
   addiu $sp, $sp, 8	
   		
   jr $ra
#########################################################
# Um número é dito quadrado perfeito, se puder ser escrito 
# como o quadrado de um número natural (Ex. 1, 4, 9, 16, 25). 
# É possível (embora não muito prático) calcular o quadrado 
# perfeito de um número natural de forma recursiva, conforme 
# o algoritmo abaixo:
#
# int q_perfeito(int n){ 
#     if(n == 0) {
#         return n; 
#     } else {
#         return q_perfeito(n-1) + 2*n - 1; 
#     }
# }
#
# Implemente a função do quadrado perfeito apresentada acima, 
# e faça um programa que irá apresentar os valores do quadrado 
# perfeito dos primeiros 10 números naturais. Utilize as chamadas 
# de sistema para a entrada e saída de dados. O código deve ser 
# implementado seguindo a convenção de chamada de procedimento 
# estudada em sala de aula.
#########################################################

