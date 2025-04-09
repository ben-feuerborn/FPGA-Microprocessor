# Exercise 2
#  Max Score: 9 points
#
# Students: 
#	Jacob Missbrenner (33%)
#	Benjamin Feuerborn (33%)
#	Nomar Vazquez (33%)
#
# 'count_occurence.a' - count the occurrences of a specific character in string 
# "str". Indexed addressing is used to access the array elements.
#  MAX Score: 15 points
# Expected Outcome:- 
# The following string will be printed on the console,
# "Count is 6"
#
# Questions:-
# 1. Briefly describe the purposes of the registers, $t0, $t1, $t2, and $t3.
#		$t0 - holds the currently indexed character from str to be compared with letter we're looking for
#		$t1 - current index of char within string, increments until a null character is fetched
#		$t2 - increments whenever an 'e' is found in the string, counts total number of 'e'
#		$t3 - holds char, the character we are searching for in str
#
# 2. Currently, the program is stuck in an infinite loop. Make use of 
#    breakpoints to locate, and correct the error.
#		add operation in con was incrementing with respect to $t2 and not $t1
#		add $t1, $t2, 1 -> add $t1, $t1, 1

	.text

	.globl main

main:	

	li      $t1, 0          # initialize register $t1 to '0'
	li      $t2, 0          # initialize register $t2 to '0'
	lb      $t3, char       # initialize register $t3 to 'char'

loop:

    lb      $t0, str($t1)	# fetch a character in 'str'
	beqz    $t0, strEnd	    # if a null character is fetched, exit the loop
	bne     $t0, $t3, con   # branches to 'con' if registers $t0, and $t3 are not the same
	add     $t2, $t2, 1	    # increment register $t2

con:	

    add     $t1, $t1, 1	    # increase indexing register $t1
	j       loop	       	# continues the loop

strEnd:

	la      $a0, ans        # load $a0 with the address of the string, 'ans'
	li      $v0, 4	        # trap code, '4', refers to 'print_string' system call
	syscall                 # execute the system call

	move    $a0, $t2        # move the integer to print from register $t2->$a0
	li      $v0, 1	        # trap code, '1', refers to 'print_int' system call
	syscall		            # execute the system call

	la      $a0, endl	    # load $a0 with the address of the string, 'ans'
	li      $v0, 4	        # trap code, '4', refers to 'print_string' system call
	syscall                 # execute the system call

	li      $v0, 10         # terminate the program
	syscall


	.data

str:	.asciiz "abceebceebeebbacacb"
char:	.asciiz "e"
ans:	.asciiz "Count is "
endl:	.asciiz "\n"

