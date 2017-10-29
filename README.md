# Bubble_Sort_ASM
Implementation of a Bubble Sort in MIPS ASM with test suite

Use
$a0 - Address of the array to be sorted
$a1 - Integer length of array
$v0 - Address where the sorted array is placed after the function runs (This is the same as the address passed in so it can be ignored if the user wishes)

Conventions are followed in this function. As such it utilizes the $t0-9 registers and does not save their contents.
