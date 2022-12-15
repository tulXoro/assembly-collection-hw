#
# CSC 256 Final Project
# Name: Timothy Lor
# Date: December 3, 2022
# Description: A video game translated from C++
#
#=======================================================
	.data
x:	.word	0:4	# x-coordinates of 4 robots
y:	.word	0:4	# y-coordinates of 4 robots

str1:	.asciiz	"Your coordinates: 25 25\n"
str2:	.asciiz	"Enter move (1 for +x, -1 for -x, 2 for + y, -2 for -y):"
str3:	.asciiz	"Your coordinates: "
sp:	.asciiz	" "
endl:	.asciiz	"\n"
str4:	.asciiz	"Robot at "
str5:	.asciiz	"AAAARRRRGHHHHH... Game over\n"

#i	$s0
#myX	$s1
#myY	$s2
#move	$s3
#status	$s4
#temp,pointers	$s5,$s6
	.text
#	.globl	inc
#	.globl	getNew

main:	li	$s1,25		#  myX = 25
	li	$s2,25		#  myY = 25
	li	$s4,1		#  status = 1

	la	$s5,x
	la	$s6,y

	sw	$0,($s5)	#  x[0] = 0; y[0] = 0;
	sw	$0,($s6)
	sw	$0,4($s5)	#  x[1] = 0; y[1] = 50;
	li	$s7,50
	sw	$s7,4($s6)
	sw	$s7,8($s5)	#  x[2] = 50; y[2] = 0;
	sw	$0,8($s6)
	sw	$s7,12($s5)	#  x[3] = 50; y[3] = 50;
	sw	$s7,12($s6)

	la	$a0,str1	#  cout << "Your coordinates: 25 25\n";
	li	$v0,4
	syscall

	bne	$s4,1,main_exitw	#  while (status == 1) {
main_while:
	la	$a0,str2	#    cout << "Enter move (1 for +x,
	li	$v0,4		#	-1 for -x, 2 for + y, -2 for -y):";
	syscall

	li	$v0,5		#    cin >> move;
	syscall
	move	$s3,$v0

	bne	$s3,1,main_else1#    if (move == 1)
	add	$s1,$s1,1	#      myX++;
	b	main_exitif
main_else1:
	bne	$s3,-1,main_else2	#    else if (move == -1)
	add	$s1,$s1,-1	#      myX--;
	b	main_exitif
main_else2:
	bne	$s3,2,main_else3	#    else if (move == 2)
	add	$s2,$s2,1	#      myY++;
	b	main_exitif
main_else3:	bne	$s3,-2,main_exitif	#    else if (move == -2)
	add	$s2,$s2,-1	#      myY--;

main_exitif:	la	$a0,x		#    status = moveRobots(&x[0],&y[0],myX,myY);
	la	$a1,y
	move	$a2,$s1
	move	$a3,$s2
	jal	moveRobots
	move	$s4,$v0

	la	$a0,str3	#    cout << "Your coordinates: " << myX
	li	$v0,4		#      << " " << myY << endl;
	syscall
	move	$a0,$s1
	li	$v0,1
	syscall
	la	$a0,sp
	li	$v0,4
	syscall
	move	$a0,$s2
	li	$v0,1
	syscall
	la	$a0,endl
	li	$v0,4
	syscall

	la	$s5,x
	la	$s6,y
	li	$s0,0			#    for (i=0;i<4;i++)
main_for:	la	$a0,str4	#      cout << "Robot at " << x[i] << " "
	li	$v0,4			#           << y[i] << endl;
	syscall
	lw	$a0,($s5)
	li	$v0,1
	syscall
	la	$a0,sp
	li	$v0,4
	syscall
	lw	$a0,($s6)
	li	$v0,1
	syscall
	la	$a0,endl
	li	$v0,4
	syscall
	add	$s5,$s5,4
	add	$s6,$s6,4
	add	$s0,$s0,1
	blt	$s0,4,main_for

	beq	$s4,1,main_while
				#  }
main_exitw:	la	$a0,str5	#  cout << "AAAARRRRGHHHHH... Game over\n";
	li	$v0,4
	syscall
	li	$v0,10		#}
	syscall

	#	int moveRobots(int *arg0, int *arg1, int arg2, int arg3)
	#
	#	arg0		base address of array of x-coordinates
	#	arg1		base address of array of y-coordinates
	#	arg2		x-coordinate of human (copy in $s2)
	#	arg3		y-coordinate of human (copy in $s3)
	#	ptrX	
	#	ptrY	
	#	i	
	#	alive		
	#	temp
	#
	#	moveRobots() calls getNew() to obtain the new coordinates
	#	of each robot. The position of each robot is updated.

moveRobots:
	
	sw	$ra, ($sp)
	sw	$s0, -4($sp)
	sw	$s1,-8($sp)
	sw	$s2,-12($sp)
	sw	$s3,-16($sp)
	sw	$s4,-20($sp)
	sw	$s5,-24($sp)
	add	$sp,$sp,-24
	
	#	int i, *ptrX, *ptrY, alive = 1;

	li	$s0, 0		# int i =1
	move	$s1, $a2	# arg3;
	move	$s2, $a3 	# arg4;
	li	$s3, 1		# alive =1
	la	$s4,x	# ptrX = arg0 address
	la	$s5,y	# ptrY = arg1

moveRobotFor:
	
	lw 	$t0, ($s4)
	move 	$a0, $t0
	move 	$a1, $s1
	jal 	getNew
	sw 	$v0,($s4)
	#move 	$s4, $v0 
	
	lw	$t0, ($s5)
	move 	$a0, $t0
	move	$a1, $s2
	jal 	getNew	# getNew called
	sw 	$v0,($s5)
	#move 	$s4, $v0
	
	lw	$t0,($s4)
	lw	$t1,($s5)
	
	bne	$t0,$s1,condition	 
	bne 	$t1,$s2,condition
	li 	$s3,0
	j	break
	
condition:
	add 	$s4,$s4,4	#ptrX++
	add	$s5,$s5,4 	#ptrY++
	add 	$s0,$s0,1	#i++
	blt	$s0,4, moveRobotFor
	
break:
	move    $v0,$s3
	
	lw 	$s5, ($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	lw	$ra, 24($sp)
	add	$sp,$sp,24	
	
	
	jr	$ra

	#	int getNew(int arg0, int arg1)
	#
	#	arg0		one coordinate of robot
	#	arg1		one coordinate of human
	#	temp		distance from robot to human
	#	result		position of robot after movement
	#
	#	Returns new coordinate of robot. If the absolute difference between
	#	the robot coordinate and human coordinate is >=10, the robot
	#	coordinate moves 10 units closer to the human coordinate.
	#	If the absolute difference is < 10, the robot coordinate
	#	moves 1 unit closer to the human coordinate.

getNew:				
								
	sub 	$t0, $a0, $a1		#  temp = arg0 - arg1;
					#  (basically distance)
					
	blt 	$t0, 10, else_if_1	#  if (temp >= 10)
	sub 	$v0, $a0, 10		#	result = arg0 - 10
	b 	return_leaf
	
else_if_1:				#  else if (temp > 0)
					#    result = arg0 - 1;
	ble 	$t0, 0, else_if_2
	sub 	$v0, $a0, 1
	b 	return_leaf
else_if_2:				#  else if (temp == 0)
			                #    result = arg0;
	bne	$t0, 0, else_if_3
	move 	$v0, $a0
	b 	return_leaf
	
else_if_3:				#  else if (temp > -10)
				        #    result = arg0 + 1;
	ble	$t0, -10, else_if_4
	add 	$v0, $a0, 1
	b 	return_leaf
	
else_if_4:				#  else if (temp <= -10)
					#    result = arg0 + 10;
	bgt 	$t0,-10,return_leaf
	add 	$v0,$a0,10
	b 	return_leaf
	
return_leaf:				# return result
	
	jr $ra
