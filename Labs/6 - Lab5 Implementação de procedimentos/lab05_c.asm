#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: Lucas Martins Wollinger
#########################################################


#########################################################
# Implemente como procedimento para ordenar um vetor de
# inteiros na memória. O procedimento de ordenação utilizado
# pode ser o BubbleSort, conforte o algoritmo abaixo:
#
# void bubble(int* v, int size) {
#	int i; # t0
#	int j; # t1
#	int aux;
#	int k = size - 1 ; # t2
#
#   for(i = 0; i < size; i++) {
#      for(j = 0; j < k; j++) {
#         if(v[j] > v[j+1]) {
#             aux = v[j];
#             v[j] = v[j+1];
#             v[j+1] = aux;
#         }
#      }
#      k--;
#   }
# }
#
# Além do procedimento, implemente também um código para
# testar a função implementada
#
#########################################################]
.include "macros.inc"
.text 0x00400000
init:
	la $sp, 0x7FFFEFFC
	jal main
	exit
.include "string.inc"

.data
vetor:  .word 45,3,7,89,32,76
.data 0x10010020
vetorB: .word 78,2,6,90,124,76,34,71

.text

#-----------
# ($a0) old_stk -> 16($sp)
#-----------
# <empty>      -> 12($sp)
#-----------
#   $ra        -> 8($sp)
#-----------
#   $a1        -> 4($sp)
#-----------
#   $a0        -> 0($sp)
#############################################
main:
	addiu $sp, $sp, -16
	sw    $ra, 8($sp)

	la  $a0, vetor
	li  $a1, 6	
	jal bubble
	
	la  $a0, vetorB
	li  $a1, 8	
	jal bubble

	lw    $ra, 8($sp)
	addiu $sp, $sp, 16
	jr $ra


#########################################################
# void bubble(int* v, int size) {
#	int i; # t0
#	int j; # t1
#	int aux;
#	int k = size - 1 ; # t2
#
#   for(i = 0; i < size; i++) {
#      for(j = 0; j < k; j++) {
#         if(v[j] > v[j+1]) {
#             aux = v[j];
#             v[j] = v[j+1];
#             v[j+1] = aux;
#         }
#      }
#      k--;
#   }
# }
########################################################
bubble:
   # i = $t0
   # j = $t1
   # k = size - 1 = $t2
   # aux = $t3
   
   # $a0 = v
   # $a1 = size
   
   li $t0, 0				# i = 0
   li $t1, 0				# j = 0
   addi $t2, $a1, -1		# k = size -1

bubble_L0:
	bge $t0, $a1, bubble_L0_end
	li $t1, 0				# j = 0
	bubble_L1:
		bge $t1, $t2, bubble_L1_end
			#Acessando o v[j] e v[j+1]
			sll $t5, $t1, 2   # j * 4
			add $t5, $t5, $a0 # &v[j]
			lw  $t3, 0($t5)   # t3 <- v[j]
			lw  $t4, 4($t5)   # t4 <- v[j+1]
			#bubble_IF0:
			ble $t3, $t4, bubble_IF0_end
				sw  $t3, 4($t5)   # v[j+1] <- t3 (v{j})
				sw  $t4, 0($t5)   # v[j] <- t4 (v[j+1])
			bubble_IF0_end:
		addi $t1, $t1, 1	# j++
		j bubble_L1
	bubble_L1_end:
	addi $t2, $t2, -1    # k--
	addi $t0, $t0, 1		# i++
	j bubble_L0
bubble_L0_end: 
 
   jr $ra
