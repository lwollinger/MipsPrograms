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

.macro li.d %reg, %imm
   li $at, %imm
   mtc1 $at, %reg
   cvt.d.w %reg, %reg
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

.data

media:   .float 6.0
divisor: .float 3.75

msg1: .asciiz "Entre com um valor: "
msg2: .asciiz "A média é : "
nl:   .asciiz "\n"
aprovado: .asciiz "Aprovado\n"
reprovado: .asciiz "Reprovado\n"

.text

print_strPtr(msg1)
getInt($s0)

print_strPtr(msg1)
getInt($s1)

print_strPtr(msg1)
getInt($s2)

mtc1 $s0, $f0
mtc1 $s1, $f2
mtc1 $s2, $f4

cvt.s.w $f0,$f0
cvt.s.w $f2,$f2
cvt.s.w $f4,$f4

cvt.d.s $f10, $f0
cvt.d.s $f12, $f2
cvt.d.s $f14, $f4

add.s $f6, $f0, $f2
add.s $f6, $f6, $f4

li.s $f8, 3

# li $t0, 0x40700000 ## carrega 3.75
# mtc1 $t0, $f8
#lwc1 $f8, divisor

div.s $f6, $f6, $f8

print_strPtr(msg2)
printFloat($f6)
print_strPtr(nl)

add.d $f16, $f10, $f12
add.d $f16, $f16, $f14
li.d $f18, 3
div.d $f16, $f16, $f18

print_strPtr(msg2)
printDouble($f16)
print_strPtr(nl)

lwc1 $f0, media
c.lt.s 1, $f6, $f0

bc1t 1, else
	print_strPtr(aprovado)
	j if_end
else:
	print_strPtr(reprovado)
if_end:









