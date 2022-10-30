#
# CSC 256 Assignment 6
# Name: Timothy Lor
# Date: October 28, 2022
# Description: Translated C++ code
#
#Please ignore the slashes... I used them to mark what I have translated
#int main(){ 			/
#int result = 0;		/
#for (i=1,i<3,i++){		/
#result = result+callee(i);	/
#}				/
#}				/
#int callee(int x){		/
#int v=0;  int y=2*x;		/
#v = leaf(y) +y;		/
#return v;			/
#}				/
#int leaf(int arg1){		/
#{int u; 			/
#  u = arg1*arg1 ;		/
#   return u;			/
#}				/
	.data
	.text
main:	
	li	$s0,0		#int result = 0
	li	$s1,1		#i = 1
	
for:	bge	$s1,3,exit_for	#while(i<3)
	move	$a0,$s1		#pass i as an arg
	jal	callee		##call callee
	add	$s0,$s0,$v0	#result+=caller()
	
	add	$s1,$s1,1	##i++
	j	for		#restart loop

callee:	addi	$sp,$sp,-12	##allocate space for 2 integers
	sw	$s1,($sp)	#make space for int y
	sw	$s0,4($sp)	#make space for int v
	sw	$ra,8($sp)	##end allocation
	
	li	$s0,0		#int v = 0
	mul	$s1,$a0,2	#int y=x*2
	
	move	$a0,$s1		#pass y as an arg
	jal	leaf		#call leaf
	
	add	$s0,$v0,$s1	#v = leaf(y) + y
	
	move 	$v0,$s0		#return v
	
	lw	$ra,8($sp)	##deallocate space
	lw	$s0,4($sp)
	lw	$s1,($sp)	##end deallocation
	addi	$sp,$sp,12
	jr	$ra		#return
	
leaf:	addi	$sp,$sp,-8	##allocate space for 1 int
	sw	$s0,($sp)	#make space for int u
	sw	$ra,4($sp)	##end allocation
	
	li	$s0,0		#int u
	mul	$s0,$a0,$a0	#u = arg*arg
	
	move	$v0,$s0		#return u
	
	lw	$ra,4($sp)	##deallocate space
	lw	$s0,($sp)
	addi	$sp,$sp,8	##end deallocation
	jr	$ra		#return

exit_for:
	
	
