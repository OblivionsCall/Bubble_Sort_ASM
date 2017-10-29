#################################################################################
#
#	Bubble Sort Function for an array of integers
#	OblivionsCall (Chris Hand)
#	
#	This Function is an implementation of bubble sort in MIPS Assembly
#
#	Use:
# 		$a0 - Array to be sorted
# 		$a1 - Integer length of array (Number of elements)
# 		$v0 - Sorted Array
#
#	Registers $t0-9 are used and not saved
#
################################################################################

.text
	Bubble_Sort_Function:	
	# Move array to $t0 and set maximum for 'i'
	move $t0, $a0
	addi $t3, $a1, -1
	
	# Set up for 'i', initialized with full array
	li $t7, 0
	move $t5, $t0
	
	i_Loop:
		# Exit Loop if 'i' is at last element of array
		beq $t7, $t3, i_Loop_Exit
		
		lw $t1, ($t5)
		
		# Set up 'j' Loop
		addi $t8, $t7, 1
		add $t6, $t5, 4
		
		j_Loop:
			bgt $t8, $t3, j_Loop_Exit
			lw $t2, ($t6)
			
			ble $t1, $t2, j_Loop_Increment
			
			sw $t1, ($t6)
			sw $t2, ($t5)
			lw $t1, ($t5)
			
			j_Loop_Increment:
				addi $t8, $t8, 1
				addi $t6, $t6, 4
				j j_Loop
		
		
		j_Loop_Exit:
			addi $t7, $t7, 1
			addi $t5, $t5, 4
			j i_Loop
	
	i_Loop_Exit:
		move $v0, $t0
		jr $ra
