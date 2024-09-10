# Calculadora Ponto Flutuante
# Aluno: Lucas Wollinger


.macro print_strPtr (%ptr)
	li $v0, 4
	la $a0, %ptr
	syscall
.end_macro

.macro exit
  li $v0, 10
  syscall
.end_macro

.macro li.s %reg, %imm
   li $at, %imm
   mtc1 $at, %reg
   cvt.s.w %reg, %reg
.end_macro

.macro getInt(%reg)
   li $v0, 5
   syscall
   move %reg, $v0
.end_macro

.macro printFloat(%reg)
   mov.s $f12, %reg
   li $v0, 2
   syscall
.end_macro 

.macro printDouble(%reg)
    mov.d $f12, %reg
	li $v0, 3
	syscall
.end_macro

.macro mensagem_escolha_precisao()
    print_strPtr (msg_inicial)
    print_strPtr (pula_linha)
    print_strPtr (msg_opcao_precisao)	# mensagem opção (1) - simples / (2) - dupla
    getInt(Escolha_precisao)
.end_macro

.macro precisao()

    # Escolha de precisão
    beq Escolha_precisao, 1, precisao_simples		# Caso 1 -> label precisao simples
    beq Escolha_precisao, 2, precisao_dupla		# Caso 2 -> label precisao dupla
    
	precisao_simples:
    		print_strPtr(msg_num1)
			getInt(valor_escolhido)		# armazena em $t0 o num

			# converte
			mtc1 valor_escolhido, $f0
			cvt.s.w $f0,$f0

		label_operacao_simples:
			beq Escolha_switch, 1, op_soma_s
			beq Escolha_switch, 2, op_sub_s
			beq Escolha_switch, 3, op_mul_s
			beq Escolha_switch, 4, op_div_s

			op_soma_s:	
				add.s $f6, $f6, $f0		# $f6 (acumulador)
				j end_macro_precisao		# $f0 (Num)
			op_sub_s:	
				sub.s $f6, $f6, $f0
				j end_macro_precisao
			op_mul_s:	
				mul.s $f6, $f6, $f0
				j end_macro_precisao
			op_div_s:	
				div.s $f6, $f6, $f0
				j end_macro_precisao
	

	precisao_dupla:
		print_strPtr(msg_num1)
			getInt(valor_escolhido)

			# converte
			mtc1 valor_escolhido, $f0
			cvt.d.w $f10, $f0

		label_operacao_dupla:
			beq Escolha_switch, 1, op_soma_d
			beq Escolha_switch, 2, op_sub_d
			beq Escolha_switch, 3, op_mul_d
			beq Escolha_switch, 4, op_div_d

			op_soma_d:	
				add.d $f6, $f6, $f10
				j end_macro_precisao
			op_sub_d:	
				sub.d $f6, $f6, $f10
				j end_macro_precisao
			op_mul_d:	
				mul.d $f6, $f6, $f10
				j end_macro_precisao
			op_div_d:	
				div.d $f6, $f6, $f10
				j end_macro_precisao


end_macro_precisao:
### Resultado em $f6 = acumulador
.end_macro

.data 	

    .eqv Escolha_switch $s0
    .eqv Escolha_precisao $s1
    .eqv valor_escolhido $s2
    .eqv Acumulador $s3
    
			### Mensagens Usadas ###
	msg_inicial: .asciiz "*Bem Vindo a Calculadora de Precisão*"
	msg_opcao_precisao: .asciiz "Deseja precisão simples(1) ou dupla(2)?: "
	
	msg_soma: .asciiz "O resultado parcial da soma é: "
	msg_sub: .asciiz "O resultado parcial da subtração é: "
	msg_mul: .asciiz "O resultado parcial da multiplicação é: "
	msg_div: .asciiz "O resultado parcial da divisão é: "
	msg_acumulador: .asciiz "Resultado Parcial Zerado!"
	msg_saida: .asciiz "Programa Finalizado!"
	
	msg_opcao: .asciiz "Escolhas uma opção: "
	msg_num1: .asciiz "Entre com um número: "
    	msg_erro: .asciiz "Erro, não existe essa opção! Tente novamente"
   	
   	result_final: .asciiz "Resultado Final: "
   	pula_linha: .asciiz "\n"
    	
    	
    	msg_switch: .asciiz "**Calculadora**"
    	msg1: .asciiz "Caso 1 - Soma números"
    	msg2: .asciiz "Caso 2 - Subtrai números"
    	msg3: .asciiz "Caso 3 - Multiplica números"
    	msg4: .asciiz "Caso 4 - Divide números"
    	msg5: .asciiz "Caso 5 - Sair do Programa"
    	msg6: .asciiz "Caso 6 - Zerar Acumulador"
    	
    	# Vetor de Switch
    	jump_table: .word default_case, case_1, case_2, case_3, case_4, case_5, case_6

.text

main:

    mensagem_escolha_precisao()

	loop_switch:
    		print_strPtr (pula_linha)
    		print_strPtr (pula_linha)
    		print_strPtr (msg_switch)
    		print_strPtr (pula_linha)
    		print_strPtr (msg1)
    		print_strPtr (pula_linha)
    		print_strPtr (msg2)
    		print_strPtr (pula_linha)
    		print_strPtr (msg3)
    		print_strPtr (pula_linha)
    		print_strPtr (msg4)
    		print_strPtr (pula_linha)
    		print_strPtr (msg5)
    		print_strPtr (pula_linha)
    		print_strPtr (msg6)
    		print_strPtr (pula_linha)
    
    print_strPtr (msg_opcao)
    	getInt(Escolha_switch)

      
    # switch
    bgtu Escolha_switch, 9, default_case
    la  $t3, jump_table		## jump_table é meu vetor do switch
    sll $t2, Escolha_switch, 2 	## $t0 * 4
    add $t2, $t2, $t3		## &jump_table[i]
    lw  $t2, 0($t2)		## carrega t2 o endereço da jump_table		
    jr  $t2			## Jump to registrador $t2

        
default_case:
    print_strPtr (msg_erro)
    print_strPtr (pula_linha)
    j loop_switch

case_1:
    precisao()
    print_strPtr(msg_soma)
    beq $t1, 1, print_simple_soma 	# caso $t1 == 1 ->  print_simple
    	
    printDouble($f6)			# caso contrario -> float duplo
    	j loop_switch
    print_simple_soma:			# label float simples
    	printFloat($f6)
    	j loop_switch

case_2:
    precisao()
    print_strPtr(msg_sub)
    beq $t1, 1, print_simple_sub 	# caso $t1 == 1 ->  print_simple
    
    printDouble($f6)			# caso contrario -> float duplo
    	j loop_switch
    print_simple_sub:			# label float simples
    	printFloat($f6)
    	j loop_switch

case_3:
    precisao()
    print_strPtr(msg_mul)
    beq $t1, 1, print_simple_mul 	# caso $t1 == 1 ->  print_simple
    
    printDouble($f6)			# caso contrario -> float duplo
    	j loop_switch
    print_simple_mul:			# label float simples
    	printFloat($f6)
    	j loop_switch
    
case_4:
    precisao()
    print_strPtr(msg_div)
    beq $t1, 1, print_simple_div 	# caso $t1 == 1 ->  print_simple
    
    printDouble($f6)			# caso contrario -> float duplo
    	j loop_switch
    print_simple_div:			# label float simples
    	printFloat($f6)
    	j loop_switch
    
case_5:
    print_strPtr (pula_linha)
    print_strPtr (result_final)
    printFloat($f6)
    print_strPtr (pula_linha)
    print_strPtr (msg_saida)
    print_strPtr (pula_linha)
    j end_switch
    
case_6:
    li.s $f6, 0
    print_strPtr (pula_linha)
    print_strPtr (msg_acumulador)
    j loop_switch

end_switch:
    exit()

