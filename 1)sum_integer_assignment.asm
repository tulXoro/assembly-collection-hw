#
# CSC 256 Assignment 4
# Name: Timothy Lor
# Date: October 16, 2022
# Description: Outputs the summation of an integer start at 1
#
#=======================================================
# input an integer and output the sum from 1 to integer
#
# for(int i = 1; i <= input; i++)
# 	sum = sum + i; 
#
#input: $s0
#i    : $t0
#sum  : $t1
.data
out_1: .asciiz "Please input the integer: "
out_2: .asciiz "the sum of the integer is:" 
.text:
	li	$v0,4		# tell sys to cout
	la	$a0,out_1	# set out_1 as arg
	syscall
	li	$v0,5		# cin >> (as integer) input
	syscall
	move	$s0,$v0 	# save integer to $s0 (input)
	 
	li	$t0,1		# int i = 1
for:
	bgt $t0,$s0,out_for	# if i > input: end
	add $t1,$t1,$t0		# sum = sum + i
	addiu $t0,$t0,1		# i++
	j for			# repeat		
        
out_for:
	li	$v0,4
	la	$a0,out_2
	syscall
	li	$v0,1
	move	$a0,$t1
	syscall
