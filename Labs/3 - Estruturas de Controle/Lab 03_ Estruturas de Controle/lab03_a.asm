#########################################################
# Laborat√≥rio 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Lucas Martins Wollinger
#########################################################

#########################################################
# Converta para assembly os trechos de c√≥digo C a seguir
# 
# Fa√ßa a aloca√ß√£o das vari√°veis na mem√≥ria (.data)
#########################################################


#########################################################
# a = 0;
# b = 0;
# 
# do {
#   if ( b % 2 ){
#      a++;
#   }
#   b++;
# } while (a < 10)
#########################################################

.data
a: 	.word 10 	# a = 0;
b:	.word 0		# b = 0;
resposta: .asciiz "O resultado final de A È = "
.text 

	li $t0, 0		# conta o loop
	li $t1, 10		# valor para comparar com 'a' (limite)
	
	lw $t2, a		# carregando valor de a no reg $t2
	lw $t3, b 		# carregando valor de b no reg $t3
loop:
	bgt $t2, $t1, endloop 	# caso (a > 10) finaliza loop
	
	# if ( b % 2 ) a++;
	# 1∞ mÈtodo andi $t4, $t3, 1  --> usa mascara 00001 ou seja muda tudo que È 1 pra 0 e o "resto" ele deixa em 1 se for 1 e zzero se for 0		
	
	# 2∞ forma
	# li $t9, 2
	# div $t3, $t9
	# mfhi $t4
	
	# rem $t4, $t3, 2 -> pega o resto da divis„o de 2
	
	addi $t3, $t3, 1	# se n„o for par, b++
par:
	addi $t2, $t2, 1	# a++

j loop

endloop:
	li $v0, 4
	la $a0, resposta	# carregar mensagem de resultado
	syscall
	
	li $v0, 1
	move $a0, $t2		# mostrando resultado do valor contido em A = $t2
	syscall
	
	li $v0, 10         # Carregar syscall para sair do programa
    	syscall            


#########################################################
# if ( ( a < b ) &&  ( c == d ) ) {
#   a = a * (((c/b) * 2) + 10);
# } else {
#   a = a / ((c+4)/b);
# }
# a++;
#########################################################

.data 
	a: .word 
	b: .word 
	c: .word 
	d: .word 

.text 
	lw $t0, a
	lw $t1, b
	lw $t2, c
	lw $t3, d
	
	sgt $t4, $t0, $t1	# ( a < b )
	seq $t5, $t2, $t3	# ( c == d )
	and $t6 ,$t4, $t5	# ( a < b ) &&  ( c == d )

	bnez  $t6, caso_verdade # se $t6 != 0 --> label (0 = mentira)(1 = verdade)
	
	# else a = a / ((c+4)/b);
	
	addi $t7, $t2, 4	# (c+4)
	div $t7, $t1		# ((c+4)/b
	mflo $t7		
	div $t0, $t7		# a / ((c+4)/b)
	mflo $t7
	add $t0, $t7, $zero	# a = (a / ((c+4)/b)) + 0
	
j end	
	
caso_verdade:
	# a = a * (((c/b) * 2) + 10);
	
	div $t7, $t2, $t3	# (c/b)
	mflo $t7		# carregando resultado
	li $t8, 2		# $t8 = 2
	mul $t7, $t7, $t8	# (c/b) * 2)
	addi $t7, $t7, 10	# ((c/b) * 2) + 10
	
	mul $t0, $t0, $t7	# a = a * (((c/b) * 2) + 10);

end: 
	addi $t0, $t0, 1


#########################################################
# if ( a < 10 ) {
#   b = 20;
#   if ( a <= 5 ){
#     for(int i = 0; i < a; i++) {
#       b += a * i;
#     }
#   } else {
#       while( a-- > 5) {
#         b -= b / a;
#       }
#   }
# }
#########################################################

.data 
#	a: .word 
#	b: .word  
#	i: .word 0

.text 	
	lw $t0, a
	lw $t1, b
	lw $t3, i
	
	# if ( a < 10 )
	li $t2, 10
	blt $t0, $t2, if_1 	# a < 10 --> $t2 (0 ou 1) se for verdade recebo 1
	j end

if_1:
	li $t1, 20 		# b = 20;
	ble $t0, 5, if_2	# if ( a <= 5 ) entra no if
	
	j else			# caso mentira, vai pro else
	
if_2:	
	# for(int i = 0; i < a; i++)
		# b += a * i;
	
	loop:	
		bge $t3, $t0, end_loop	# i >= a
		addi $t3, $t3, 1	# i++
		mul $t5, $t0, $t3 	# $t5 = a * i
		add $t1, $t1, $t5	# b = b + (a * i);
		j loop
	end_loop: 
		j end
	
else:	
#   } else {
#       while( a-- > 5) {
#         b -= b / a; }

	loop_2: 
		addi $t0, $t0, -1 	# a = a - 1 = a--
		ble $t0, 5, end_loop2 	# a <= 5
		div $t5, $t1, $t0	# b / a
		sub $t1, $t1, $t5	# b = b - (b / a)
		j loop_2

end_loop2:
end: 
