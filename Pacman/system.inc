.include "macros.inc"
.include "stdlib.inc"
.include "pacman.inc"
.include "sprites.inc"
.include "ringbuffer.inc"
.include "kernel.inc"

.eqv STACK_INIT 0x7FFFEFFC

.data
.align 2
key_rb: .space 28

.text 0x00400000 ## System Init Code
init:
	la $sp, STACK_INIT
	
	jal main
	syscall_exit
  		
.text 0x00420000  ## System lib
#=============================================================
# void enable_int
enable_int:

	jr 		$ra
#=============================================================

#=============================================================
# void disable_int
disable_int:

	jr 		$ra
#=============================================================

#=============================================================
# void enable_irq(int irq_num)
enable_irq:

	jr 		$ra
#=============================================================

#=============================================================
# void disable_irq(int irq_num)
disable_irq:

	jr 		$ra
#=============================================================

#=============================================================
# void enable_keyboard_int
enable_keyboard_int:

	jr 		$ra	
#=============================================================

#=============================================================
# void set_pixel(X, Y, color)
set_pixel:
   la  $t0, FB_PTR
   mul $a1, $a1, FB_XRES 
   #sll $a1, $a1, 8 ## Otimização, multiplica por 2^8 (256)
   add $a0, $a0, $a1
   sll $a0, $a0, 2
   add $a0, $a0, $t0
   sw  $a2, 0($a0)
   jr  $ra
#=============================================================

#=============================================================
# char getchar();
getchar:
	la $t0, 0xFFFF0000
getchar_L0:
	lw $t1, 0($t0)     	# load control register (0xffff0000)
	andi $t1, $t1, 1    # isolate the bit ready
	beqz $t1, getchar_L0
	lb $v0, 4($t0)      # read data register (0xffff0004)
    jr $ra
#=============================================================

#=============================================================
# int get_nonblocking_char();
get_nonblocking_char:
	li $v0, -1 # return -1 if no char available
	la $t0, 0xFFFF0000
	lw $t1, 0($t0)     	# load control register (0xffff0000)
	andi $t1, $t1, 1    # isolate the bit ready
	beqz $t1, get_nonblocking_char_end
	lb $v0, 4($t0)      # read data register (0xffff0004)
get_nonblocking_char_end:
    jr $ra
#=============================================================


#=============================================================
# void putchar(char value);
putchar:
	la $t0, 0xFFFF0008
putchar_L0:
	lw $t1, 0($t0)     	# load control register (0xffff0000)
	andi $t1, $t1, 1    # isolate the bit ready
	beqz $t1, putchar_L0
	sb $a0, 4($t0)      # write data register (0xffff0004)
    jr $ra
#=============================================================
