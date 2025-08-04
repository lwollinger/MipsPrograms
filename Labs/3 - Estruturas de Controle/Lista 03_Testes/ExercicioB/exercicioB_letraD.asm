#########################################################
# FaÃ§a um programa que leia 3 notas dos endereÃ§os 
# 0x10010000, 0x10010004 e 0x10010008 e, sabendo que a 
# mÃ©dia Ã© 7, armazene 1 no endereÃ§o 0x1001000C caso ele 
# esteja aprovado ou no endereÃ§o 0x10010010 caso ele 
# esteja reprovado.
#
#########################################################
.data
a: .word 2       # A tem endereço 0x10010000
b: .word 9       # B tem endereço 0x10010004
c: .word 9       # C tem endereço 0x10010008

.text
    li $t4, 1           # adicionando 1 ao reg $t4 para resultado
    
    lw $t0, a           # carregando valor de A em $t0
    lw $t1, b           # carregando valor de B em $t1
    lw $t2, c           # carregando valor de C em $t2
    
    add $t0, $t0, $t1   # ($t0 = $t0 + $t1)
    add $t0, $t0, $t2   # ($t0 = $t0 + $t2) --> nota total
    
    li $t3, 3           # Média para dividir por 3
    div $t0, $t3        # NF = Média/3
    
    mflo $t3            # Nota final atribuída a $t3
    
    bge $t3, 7, aprovado    # Se média >= 7 --> aprovado
    sw $t4, 0x10010010      # Caso reprovou --> Armazena o valor de $t3 no endereço 0x10010010
    j end_4

aprovado:
    sw $t4, 0x1001000C      # Armazena o valor de $t3 no endereço 0x1001000C
end_4:
