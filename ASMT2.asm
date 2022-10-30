#
# CSC 256 Assignment 1
# Name: Timothy Lor
# Date: September 13, 2022
# Description: Adds and subtracts numbers
#

main:	
	li 	$s0,0 		# v=0
	li 	$s1,1		# w=1
	li 	$s2,2		# x=2 
	li	$s3,3		# y=3
	li 	$s4,5		# z=5
	
	move	$s1,$s4		# w = z;
	add	$s0,$s1,$s2	# v = w + x;
	sub	$s3,$s1,$s2	# y = w - x;
	subi	$s4,$s4,1	# z = z - 1;