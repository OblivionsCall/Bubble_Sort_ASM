#################################################################################
#
#	Bubble Sort Function for an array of integers - Example Program
#	OblivionsCall (Chris Hand)
#	
#	This program initializes an unsorted array, prints it, sorts it,
#	then prints the sorted array.
#
#	Use:
#		Bubble_Sort_Function
#	 		$a0 - Array to be sorted
# 			$a1 - Integer length of array (Number of elements)
# 			$v0 - Sorted Array
#
#		Print_Loop
#			$a0 - Array to be printed
#			$a1 - Integer length of array (Number of elements)
#
#	Registers $t0-9 are used and not saved
#
################################################################################

.data
	array: .word 3, 15, 1, 12, 5
	length: .word 5
	
	space: .asciiz " "
	array_to_sort: .asciiz "Array to sort: "
	sorted_array: .asciiz "Sorted Array: "
	newline: .asciiz "\n"
	
.text
	Main:
		# Loading array and length into #s0-1
		la $s0, array
		lw $s1, length		
		
		# Print statement
		la $a0, array_to_sort
		li $v0, 4
		syscall
		
		# Load Array and Length to argument registers and call Print_Loop
		move $a0, $s0
		move $a1, $s1
		jal Print_Loop
		
		# Sort the Array and store in $s0
		jal Bubble_Sort_Function
		move $s0, $v0
		
		# Print Statement
		la $a0, sorted_array
		li $v0, 4
		syscall
		
		# Print the Array
		move $a0, $s0
		jal Print_Loop		
		
		#End Program
		li $v0, 10
		syscall
		
	Print_Loop:
	# $a0 - Array to be printed
	# $a1 - Integer Length of Array
	
		# Storing some variables for practice
		addi $sp, $sp, -8
		sw $a0, 4($sp)
		sw $s1, 0($sp)
		
		# Copy Array to $t0 and initialize a counter at $t1
		li $t1, 0
		move $t0, $a0
	
		Print_Inner_Loop:
			# Print whatever is in the current cell of the array
			lw $a0, ($t0)
			li $v0, 1
			syscall
			
			# Print a space
			la $a0, space
			li $v0, 4
			syscall
			
			# Increment through the array (4 bytes per) and increment the counter
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			
			# If beyond the end of the array, jump to exit, otherwise Loop
			beq $t1, $s1, Print_Loop_Exit
			j Print_Inner_Loop
			
	Print_Loop_Exit:
		# Print a Newline
		la $a0, newline
		syscall
	
		# Restoring the saved values and Stack Pointer
		lw $s1, ($sp)
		lw $a0, 4($sp)
		addi $sp, $sp, 8
		
		# End Print Function
		jr $ra
		
		
		
	Bubble_Sort_Function:	
	# Move array to $t0 and set maximum for 'i'
	move $t0, $a0
	addi $t3, $a1, -1
	
	# Set up for 'i' Loop, Initialized with full array
	li $t7, 0
	move $t5, $t0
	
	i_Loop:
		# Exit Loop if 'i' is at last element of array
		beq $t7, $t3, i_Loop_Exit
		
		lw $t1, ($t5)
		
		# Set up 'j' Loop, initialized at i + 1
		addi $t8, $t7, 1
		add $t6, $t5, 4
		
		j_Loop:
			# If 'j' is beyond array bounds, exit inner loop
			bgt $t8, $t3, j_Loop_Exit
			
			# Otherwise load the array data into $t2
			lw $t2, ($t6)
			
			# If array[i] < array[j], skip the swap
			ble $t1, $t2, j_Loop_Increment
			
			# Swap array[i] and array[j], reload the data in array[i] to $t1
			sw $t1, ($t6)
			sw $t2, ($t5)
			lw $t1, ($t5)
			
			j_Loop_Increment:
				# increment j and take the inner Loop
				addi $t8, $t8, 1
				addi $t6, $t6, 4
				j j_Loop
		
		
		j_Loop_Exit:
			# increment i and take the outer Loop
			addi $t7, $t7, 1
			addi $t5, $t5, 4
			j i_Loop
	
	i_Loop_Exit:
		# Move the sorted array to $v0 and exit
		move $v0, $t0
		jr $ra
