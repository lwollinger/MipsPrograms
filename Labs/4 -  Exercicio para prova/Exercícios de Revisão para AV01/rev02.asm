#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# a: $s0, b: $s1, c: $s2, d: $s3
#########################################################

#########################################################
# if (a != b) {
#    a = b;
#    if( c < 3 ){
#      a++;
#    } else {
#      for(int i = 3; i < 15; i += 2) {
#         b += i;
#      }
#    }
# }
#########################################################

.text
    beq  $s0, $s1, end	# if (a == b) -> else
        move $s0, $s1		# a = b
	
    	bge $s2, 3, else	# if( c >= 3 )-> else
	    addi $s0, $s0, 1	# a++
	    j end
	
else:
    li $t0, 3			# int i = 3  
loop: 
    bge $t0, 15, end		# i >= 15 -> end
    	add $t0, $t0, 2
    	add $s1, $s1, $t0
	j loop
end:
