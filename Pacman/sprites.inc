.text 0x00430000

#  int colors[8];
#  sprite sprites[20];
#  char sprite[49];
#=============================================================
# void draw_sprite(sprite_id, X, Y){
#       char * ptr_sprite =  sprites[sprite_id];
#       for(int i = 0; i < 49; i++){ 
#			color = colors[*ptr_sprite];
#           sX = i % 7 ;
#			sY = i / 7 ;
#           sX = X + sX;
#           sY = Y + sY;
#        	set_pixel(sX, sY, color)
#           ptr_sprite++;
#       }
# }

# old_stack      40($sp)
#########################
#  empty, 36($sp)
# -----------------------
#  $ra, 32($sp)
# -----------------------
#  $s4, 28($sp)
# -----------------------
#  $s3, 24($sp)
# -----------------------
#  $s2, 20($sp)
# -----------------------
#  $s1, 16($sp)
# -----------------------
#  $s0, 12($sp)
# -----------------------
#  $a2, 8($sp)
# -----------------------
#  $a1, 4($sp)
# -----------------------
#  $a0, 0($sp)
#########################
draw_sprite:
	addiu $sp, $sp -40
	sw $ra, 32($sp)
 	sw $s4, 28($sp)
	sw $s3, 24($sp)
	sw $s2, 20($sp)
	sw $s1, 16($sp)
	sw $s0, 12($sp)


	# char * ptr_sprite =  sprites[sprite_id]; ## $s0
	la  $s0, sprites
	mul $t0, $a0, 49    ## calculo offset
	add $s0, $s0, $t0   ## $s0 <- sprites[sprite_id];
	
	move $s1, $a1  # X - $s1
	move $s2, $a2  # Y - $s2
	
	la   $s3, colors # &colors - s3
	
	li  $s4, 0 ## $s1 - i
	draw_sprite_L0:
		bge $s4, 49, draw_sprite_L0_end
			lb  $t0, 0($s0)    ## $t0 = *ptr_sprite;
			sll $t0, $t0, 2   ## t0 * 4
			add $t0, $t0, $s3 ### t0 = &color[*ptr_sprite]
			lw  $a2, 0($t0)   ### a2 = color[*ptr_sprite]
			
			li  $t0, 7
			div $s4, $t0
			mfhi $a0 # sX = i % 7
			mflo $a1 # sY = i / 7 ;
			add $a0, $s1, $a0 # sX = X + sX;
			add $a1, $s2, $a1 # sY = Y + sY;

			# set_pixel(sX, sY, color)
			jal set_pixel
			
			addi $s0, $s0, 1 # ptr_sprite++;
			
		addi $s4, $s4, 1 # i ++
		j draw_sprite_L0
	draw_sprite_L0_end:
	
	lw $ra, 32($sp)
 	lw $s4, 28($sp)
	lw $s3, 24($sp)
	lw $s2, 20($sp)
	lw $s1, 16($sp)
	lw $s0, 12($sp)
	addiu $sp, $sp 40
    jr   $ra
#=============================================================


# old_stack      16($sp)
#########################
#  $ra, 12($sp)
# -----------------------
#  $a2, 8($sp)
# -----------------------
#  $a1, 4($sp)
# -----------------------
#  $a0, 0($sp)
#=============================================================
# void draw_animated_sprite(animated_sprite*)
draw_animated_sprite:
	addiu $sp, $sp, -16
	sw    $ra, 12($sp)

	lw  $a1, 4($a0) 
	lw  $a2, 8($a0)
	lw  $a0, 0($a0)
	jal draw_sprite

	lw    $ra, 12($sp)
	addiu $sp, $sp, 16
	jr    $ra
#=============================================================

# struct animated_sprite {
# 	int ID;      ## 0
# 	int pos_X;   ## 4
#	int pos_Y;   ## 8
#	int mov_X;   ## 12
#	int mov_Y;   ## 16
# }
#=============================================================
# void apply_movement(animated_sprite* ptr)
apply_movement:
	lw 	$t0, 4($a0)   	## t0 <- ptr.pos_X
	lw  $t1, 12($a0)  	## t1 <- ptr.mov_X
	add $t0, $t0, $t1	## pos_X += mov_X
	sw  $t0, 4($a0)    	## ptr.pos_X <- t0
	
	lw $t0, 8($a0)    	## t0 <- ptr.pos_Y
	lw  $t1, 16($a0)   	## t1 <- ptr.mov_Y
	add $t0, $t0, $t1  	## pos_Y += mov_Y
	sw  $t0, 8($a0)    	## ptr.pos_Y <- t0
	
	jr    $ra
#=============================================================

#=============================================================
# void set_move_animated_sprite(animated_sprite* sp, int vx, int vy)
set_move_animated_sprite:
	sw   $a1, 12($a0)
	sw   $a2, 16($a0)
	jr   $ra
#=============================================================

#=============================================================   
# void stop_animated_sprite(animated_sprite* sp)
stop_animated_sprite:
	sw   $zero, 12($a0)
	sw   $zero, 16($a0)
	jr   $ra
#=============================================================

#=============================================================
# char get_grid_element(column_x, row_y, grid_table*)
get_grid_element:
		## Le o elemento na grid table e retorna.
		# Resolu  o 512x512 
		# a0 = x   
		# a1 = y
		# a2 = grid_table
##################################################
	mul  $a1, $a1, 35   	# Y * 35 = 35[y]
	add  $a1, $a0, $a1   	# (Y * 35) + X
	add  $a2, $a1, $a2	# 
	lb   $v0, 0($a2)	# ler o grid
	addi $v0, $v0, -64	# Tabela ascii
	jr  $ra
#=============================================================

#=============================================================
# draw_grid(width, height, grid_table*)
#	     X 35    Y 35      
draw_grid:

#########################
# old_stack      40($sp)
#########################
# -----------------------
#  <empty> 36($sp)
# -----------------------
#  $ra, 32($sp)
# -----------------------
#  $s4, 28($sp)
# -----------------------
#  $s3, 24($sp)
# -----------------------
#  $s2, 20($sp)
# -----------------------
#  $s1, 16($sp)
# -----------------------
#  $s0, 12($sp)
# -----------------------
#  $a2, 8($sp)
# -----------------------
#  $a1, 4($sp)
# -----------------------
#  $a0, 0($sp)
#########################
	addiu $sp, $sp, -40
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	sw $s2, 20($sp)
	sw $s3, 24($sp)
	sw $s4, 28($sp)
	sw $ra, 32($sp)

	move $s0, $a0	# $s0 = width
	move $s1, $a1	# $s1 = height
	move $s2, $a2   # $s2 = grid_table*
	
	li   $s3, 0     # row
LOOP_ROW: 
	beq $s3, $s1, LOOP_ROW_end		# if(row == height)
	
	li $s4, 0    # col		
	LOOP_COL:
		beq $s4, $s0, LOOP_COL_end	# if(col == width)
	
		move $a0, $s4   # row inicialmente 0 -> $a0 = 0..1..2..3
		move $a1, $s3   # col
		move $a2, $s2   # grid_table*
		jal get_grid_element	# chama a fun  o get_grid_element
		
		# me retorna em v0 = o ponteiro grid_table*(ascii)
	
		move $a0, $v0		# salvar grid_table* $a2 = $v0
		mul  $a1, $s4, 7	# dX * 7
		mul  $a2, $s3, 7	# dY * 7
		jal draw_sprite		# draw_sprite -> a0(grid), a1(X), a2(Y)
	
		addi $s4, $s4, 1	# x++
		j LOOP_COL
	
	LOOP_COL_end:
	addi $s3, $s3, 1		# y++
	j LOOP_ROW

LOOP_ROW_end:

	lw $s0, 12($sp)
	lw $s1, 16($sp)
	lw $s2, 20($sp)
	lw $s3, 24($sp)
	lw $s4, 28($sp)
	lw $ra, 32($sp)
	addiu $sp, $sp, 40
	jr   $ra

#=============================================================

# struct mov_vector {
#    int valid;
#    int mov_x;
#    int mov_y;
# }
#########################
# old_stack ($a0)  8($sp)
#########################
#  < empty >       4($sp)
# -----------------------
#  $ra             0($sp)
#=============================================================
# process_input(mov_vector *)
process_input:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)     # save return address ($ra)
	sw $a0, 8($sp)     # save process_input parameter ($a0)

	jal get_nonblocking_char
	beq $v0, -1, process_input_exit
	
	bne $v0, ' ', process_input_a
	li $t0, 0 # mov_x
	li $t1, 0 # mov_y
	j 	process_input_end
	
process_input_a:
	bne $v0, 'a', process_input_s
	li $t0, -1 # mov_x
	li $t1, 0 # mov_y
	j 	process_input_end
	
process_input_s:
	bne $v0, 's', process_input_w
	li $t0, 0 # mov_x
	li $t1, 1 # mov_y
	j 	process_input_end
	
process_input_w:
	bne $v0, 'w', process_input_d
	li $t0, 0 # mov_x
	li $t1, -1 # mov_y
	j 	process_input_end
		
process_input_d:
	bne $v0, 'd', process_input_exit
	li $t0, 1 # mov_x
	li $t1, 0 # mov_y	
	
process_input_end:
	lw $a0, 8($sp) # restauro valor do $a0
	sw $t0, 4($a0) # seta mov_x
	sw $t1, 8($a0) # seta mov_y
	li $t0, 1
	sw $t0, 0($a0) # seta valid
	
process_input_exit:
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	jr   $ra
#=============================================================

#########################
# old_stack ($a1)  20($sp)
# ------------------------
# old_stack ($a0)  24($sp)
#########################
#  $ra             20($sp)
# -----------------------
#  $s1            16($sp)
# -----------------------
#  $s0            12($sp)
# -----------------------
#  $a2             8($sp)
# -----------------------
#  $a1             4($sp)
# -----------------------
#  $a0             0($sp)
#=============================================================   
# void try_change_movement(animated_sprite* sp, mov_vector* mv)

# Divide a grid por 7 e verifica se tem resto 0 ou !=0, isto implica se tem parede ou não.
# Verifica se ta alinhado ou não.
# Animeted sprit e change moviment tem que estar alinhados.

try_change_movement:
    lw $t0, 0($a1)             # Carrega 'valid' do vetor de movimento
    beqz $t0, try_change_movement_end  # Se 'valid' for 0, não faz nada

    lw $t1, 4($a0)             # Carrega pos_X do sprite
    lw $t2, 8($a0)             # Carrega pos_Y do sprite

    div $t0, $t1, 7            # Divide pos_X por 7 para alinhar com a grid
    mfhi $t0                   # Resto da divisão
    bnez $t0, try_change_movement_end  # Se pos_X não estiver alinhado, sai

    div $t0, $t2, 7            # Divide pos_Y por 7 para alinhar com a grid
    mfhi $t0                   # Resto da divisão
    bnez $t0, try_change_movement_end  # Se pos_Y não estiver alinhado, sai

    # O sprite está alinhado
    # Criando pilha
    addiu $sp, $sp, -24
    sw $a0, 24($sp)
    sw $a1, 28($sp)
    sw $s0, 12($sp)
    sw $s1, 16($sp)
    sw $ra, 20($sp)
    
    lw $t0, 4($a0)            # Carrega pos_X do sprite
    lw $t1, 8($a0)            # Carrega pos_Y do sprite
    
    div $a0, $t0, 7            # Converte pos_X para grid X
    div $a1, $t1, 7            # Converte pos_Y para grid Y
    
    #mandar pra verificar a grid Get_grid_element
    add $a0, $a0, $s0          # Nova posição X na grid
    add $a1, $a1, $s1          # Nova posição Y na grid
    la  $a2, grid              # Carrega a grid
    jal get_grid_element       # Obtém o elemento da grid na nova posição

    blt $v0, 5, change_movement  # Se não for parede, permite o movimento
    j skip_00  # Caso contrário, termina sem mudança

change_movement:
    # Movimenta o sprite para a nova posição
    lw $a0, 24($sp)
    lw $a1, 28($sp)
    	
    lw $t0, 4($a1)
    lw $t1, 8($a1)
    
    # Reseta o campo 'valid' para 0 após mover
    sw $zero, 0($a1)

    # Chama a função set_move_animated_sprite
    move $a1, $t0
    move $a2, $t1
    jal  set_move_animated_sprite

skip_00:
    lw $s0, 12($sp)
    lw $s1, 16($sp)
    lw $ra, 20($sp)
    addiu $sp, $sp, 24

try_change_movement_end:
    jr   $ra
#=============================================================

#=============================================================
# bool check_movement(animated_sprite*)

# 	struct animated_sprite {
# 	int ID;      ## 0
# 	int pos_X;   ## 4
#	int pos_Y;   ## 8
#	int mov_X;   ## 12
#	int mov_Y;   ## 16
# }

	## Converte posi  o pixel para posicao grid
	## Lembrete - se resto divisao == 0, est  alinhado
	
	## Se n o est  alinhado, pode se mover.
	## Retorna verdadeiro
	
	## Calculo nova posicao somando vetor movimento
	## com posi  o do grid e pego elemento do grid
	## para ver se n o   parede.
	
	## Se n o   parede retorna verdadeiro
	
	## Se for parede, para o sprite (stop_animated_sprite)
	## e retorna falso.
#########################################
check_movement:
	
	addiu $sp, $sp, -40
	
	sw $ra, 32($sp)
	sw $s4, 28($sp)
	sw $s3, 24($sp)
	sw $s2, 20($sp)
	sw $s1, 16($sp)
	sw $s0, 12($sp)
	sw $a2, 8($sp)
	sw $a1, 4($sp)
	sw $a0, 0($sp)

	
	lw $s0, 4($a0)			# X
	lw $s1, 8($a0)			# Y
	lw $s2, 12($a0)			# mov_X
	lw $s3, 16($a0)			# mov_Y
	
	move $s4, $a0
	
	# Vai verificar se a grid ta alinhado
	#######
	li $t9, 7
 	
 	div $s0, $t9	
 	mfhi $a0			# Verifica se está alinhado com a grid
 	bnez $a0, check_movement_end	# Caso esteja diferente de 0 -> check_movement_end
 	mflo $a0			# Busca a pos_X
 	div $s1, $t9
 	mfhi $a1			# Verifica se está alinhado com a grid
 	bnez $a1, check_movement_end
 	mflo $a1			# Busca a pos_Y
	#####
	
	# Verifica a nova posição após aplicar o movimento
	add $a0, $a0, $s2  	# soma pos_X com mov_X
	add $a1, $a1, $s3  	# soma pos_Y com mov_Y
	la  $a2, grid		# carrego o grid
	jal get_grid_element	
	
	blt $v0, 5, check_movement_end
	
	move $a0, $s4
	jal stop_animated_sprite
	
check_movement_end:
	
		
	lw $ra, 32($sp)
	lw $s4, 28($sp)
	lw $s3, 24($sp)
	lw $s2, 20($sp)
	lw $s1, 16($sp)
	lw $s0, 12($sp)
	lw $a2, 8($sp)
	lw $a1, 4($sp)
	lw $a0, 0($sp)
	
	addiu $sp, $sp, 40
	
	jr   $ra
#=============================================================

