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
	a: .word 3
	b: .word 4
	i: .word 0

.text 	
	lw $t0, a
	lw $t1, b
	lw $t3, i
	
	# if ( a < 10 )
	li $t2, 10
	blt $t0, $t2, if_1 	# a < 10 --> entra no if
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