.data
	array: .word 3, 15, 1, 12, 5
	length: .word 5
	
	space: .asciiz " "
	array_to_sort: .asciiz "Array to sort: "
	sorted_array: .asciiz "Sorted Array: "
	newline: .asciiz "\n"
	
.text
	Main:
		la $s0, array
		lw $s1, length		
		
		la $a0, array_to_sort
		li $v0, 4
		syscall
		
		move $a0, $s0
		move $a1, $s1
		jal Print_Loop
		
		jal Bubble_Sort_Function
		move $s3, $v0
		
		la $a0, sorted_array
		li $v0, 4
		syscall
		
		move $a0, $s3
		jal Print_Loop		
		
		li $v0, 10
		syscall
		
	Print_Loop:
		addi $sp, $sp, -8
		sw $a0, 4($sp)
		sw $s1, 0($sp)
		
		li $t1, 0
		move $t0, $a0
	
		Print_Inner_Loop:
			lw $a0, ($t0)
			li $v0, 1
			syscall
			
			la $a0, space
			li $v0, 4
			syscall
			
			addi $t0, $t0, 4
			addi $t1, $t1, 1
			beq $t1, $s1, Print_Loop_Exit
			j Print_Inner_Loop
			
	Print_Loop_Exit:
		la $a0, newline
		syscall
	
		lw $a1, ($sp)
		lw $a0, 4($sp)
		addi $sp, $sp, 8
	
		jr $ra
		
	Bubble_Sort_Function:
	# $a0 - Array to be sorted
	# $a1 - Integer length of array (Number of elements)
	# $v0 - Sorted Array
	# This is an implementation of a simple Bubble Sort in MIPS Assembly, $t0-9 registers are used and not saved
	
	# Move array to $t0 and set maximum for 'i'
	move $t0, $a0
	addi $t3, $a1, -1
	
	# Set up for 'i', Offset initialized at 0
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