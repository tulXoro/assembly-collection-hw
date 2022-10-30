#
# CSC 256 Assignment 3
# Name: Timothy Lor
# Date: September 13, 2022
# Description: Adds and subtracts numbers
#

main:
	.data
out_1:	.asciiz	"Please input the value of variable a:"	# out_1 = "~"
out_2: 	.asciiz "Please input the value of variable b:"	# out_2 = "~"
out_3:	.asciiz "The larger of the two a,b is "
	.text
								
	li	$v0,4						# cout << type_string
	la	$a0,out_1					# load out_1 to out
	syscall
	
int_a:	li	$v0,5						# cin >> type_int
	syscall
	move	$s0,$v0						# store val of int_a
	
	li	$v0,4						# cout << type_string
	la	$a0,out_2					# load out_2 to out
	syscall
	 
int_b:	li	$v0,5						# cin >> type_int
	syscall				
	move	$s1,$v0						# store val of int_b
	
	bgt	$s0,$s1,a_big					# compare a and b
	move	$t0,$s1						# then store whichever one
a_big:	move	$t0,$s0						# is bigger into $t0

	li	$v0,4						# print string
	la	$a0,out_3
	syscall
	
	li	$v0,1						# print value that is bigger
	move	$a0,$t0
	syscall
