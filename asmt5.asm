#
# CSC 256 Assignment 4
# Name: Timothy Lor
# Date: October 16, 2022
# Description: Outputs the summation of an integer start at 1
#
#=======================================================
#Translate following C++ code to assembly language. Please upload .asm file. Please run it in MARS.
#int x[6];
#int *ptr;
#ptr = &x[0];
#for (i=0;i<6;i++) {
#*ptr =    i;
#ptr++;
#}
main:	
	.data
x:	.word	0:6		# int x[6] (use word because integer is 4 bytes in C)
	.text
	la	$s0,x		# int* pntr = &x[0]
	li 	$s1,0		# i = 0 (assume i is one byte)

for:
	bge	$s1,6,exit	# while ( i < 6 ) <aka for(i<6)>
	sw	$s1,($s0)	# *pntr=i (store word)

	addi	$s0,$s0,4	# pntr++ (add 4 because one int is 4 bytes)	
	addi	$s1,$s1,1	# i++
	j	for		# repeat

exit:
	
