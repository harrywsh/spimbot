.data
# syscall constants
PRINT_STRING            = 4
PRINT_CHAR              = 11
PRINT_INT               = 1

# memory-mapped I/O
VELOCITY                = 0xffff0010
ANGLE                   = 0xffff0014
ANGLE_CONTROL           = 0xffff0018

BOT_X                   = 0xffff0020
BOT_Y                   = 0xffff0024

TIMER                   = 0xffff001c

SUBMIT_ORDER 			= 0xffff00b0
DROPOFF 				= 0xffff00c0
PICKUP 					= 0xffff00e0
GET_TILE_INFO			= 0xffff0050
SET_TILE				= 0xffff0058

REQUEST_PUZZLE          = 0xffff00d0
SUBMIT_SOLUTION         = 0xffff00d4

BONK_INT_MASK           = 0x1000
BONK_ACK                = 0xffff0060

TIMER_INT_MASK          = 0x8000
TIMER_ACK               = 0xffff006c

REQUEST_PUZZLE_INT_MASK = 0x800
REQUEST_PUZZLE_ACK      = 0xffff00d8

GET_MONEY               = 0xffff00e4
GET_LAYOUT 				= 0xffff00ec
SET_REQUEST 			= 0xffff00f0
GET_REQUEST 			= 0xffff00f4

GET_INVENTORY 			= 0xffff0040
GET_TURNIN_ORDER 		= 0xffff0044
GET_TURNIN_USERS		= 0xffff0048
GET_SHARED 				= 0xffff004c

GET_BOOST 				= 0xffff0070
GET_INGREDIENT_INSTANT 	= 0xffff0074
FINISH_APPLIANCE_INSTANT = 0xffff0078

puzzle:      .word 0:452

.text
j main
floodfill:
    sub $sp, $sp, 12
    sw $ra, 0($sp)
    sw $a2, 4($sp)
    sw $a3, 8($sp)
    blt $a2, $zero, return_marker
    blt $a3, $zero, return_marker
    lw $t0, 0($a0)                  # $t0 = num_rows
    lw $t1, 4($a0)                  # $t1 = num_cols
    bge $a2, $t0, return_marker
    bge $a3, $t1, return_marker
    lw $t2, 8($a0)                  # char board[][] = puzzle->board;
    mul $t3, $a2, $t1
    add $t3, $t3, $a3               # $t3 = row * num_col + col;
    add $t3, $t3, $t2               # $t3 = &board[row][col];
    lw $t3, 0($t3)                  # $t3 = board[row][col];
    li $t4, '#'
    bne $t3, $t4, return_marker
    sb $a1, 0($t2)                  # board[row][col] = marker;
    addi $a2, $a2, 1
    addi $a3, $a3, 1
    jal floodfill
    addi $a3, $a3, -1
    jal floodfill
    addi $a3, $a3, -1
    jal floodfill

    addi $a2, $a2, -1
    addi $a3, $a3, 2
    jal floodfill
    addi $a3, $a3, -2
    jal floodfill

    addi $a2, $a2, -1
    addi $a3, $a3, 2
    jal floodfill
    addi $a3, $a3, -1
    jal floodfill
    addi $a3, $a3, -1
    jal floodfill

    j return_marker_1
return_marker:
    move $v0, $a1
    lw $a3, 8($sp)
    lw $a2, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 12
	jr	$ra                         # return marker;
return_marker_1:
    addi $v0, $a1, 1
    lw $a3, 8($sp)
    lw $a2, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 12
	jr	$ra                         # return marker + 1;


main:
	# Construct interrupt mask
	li      $t4, 0
	or      $t4, $t4, BONK_INT_MASK # request bonk
	or      $t4, $t4, REQUEST_PUZZLE_INT_MASK	        # puzzle interrupt bit
	or      $t4, $t4, 1 # global enable
	mtc0    $t4, $12
	
	#Fill in your code here

request_puzzle:
    sub $sp, $sp, 20
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $ra, 16($sp)
    la $t0, puzzle
    li $s0, 0
    sw $t0, REQUEST_PUZZLE($0)
wait_request:
    bne $s0, 1, wait_request
    # jal move_right
    sub $sp, $sp, 4
    sw $ra, 0($sp)
    la  $a0, puzzle  
    li  $s0, 0      # col counter
    li  $v0, 'A'
    lw  $s1, 0($a0) # NUM_ROWS
    lw  $s2, 4($a0) # NUM_COLS
outer_loop:
    bge $s0, $s1, end_outer

    li  $s3, 0      # row counter
inner_loop:
    bge $s3, $s2, end_inner
    la  $a0, puzzle  
    move    $a1, $v0
    move    $a2, $s0
    move    $a3, $s3
    jal floodfill           # Test floodfill


    add $s3, $s3, 1
    j   inner_loop
end_inner:
    add $s0, $s0, 1
    j   outer_loop
end_outer:
    sw $a0, 0($t1)
    sw $t1, SUBMIT_SOLUTION($0)
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    add $sp, $sp, 20
infinite_puzzle:
    lw $t2, GET_MONEY($0)
    bge $t2, 500, infinite
    j request_puzzle
infinite:
	j infinite

move_right:
    lw $t1, BOT_X($0)
move_right_loop:
    lw $t2, BOT_X($0)
    sub $t2, $t2, $t1
    beq $t2, 10, move_right_return
    li $t0, 1
    sw $0, ANGLE($0)
    sw $t0, ANGLE_CONTROL($0)
    li $t0, 10
    sw $t0, VELOCITY($0)
    j move_right_loop
move_right_return:
    li $t0, 0
    sw $t0, VELOCITY($0)
    jr $ra

.kdata
chunkIH:    .space 32
non_intrpt_str:    .asciiz "Non-interrupt exception\n"
unhandled_str:    .asciiz "Unhandled interrupt type\n"
.ktext 0x80000180
interrupt_handler:
.set noat
        move      $k1, $at        # Save $at
.set at
        la        $k0, chunkIH
        sw        $a0, 0($k0)        # Get some free registers
        sw        $v0, 4($k0)        # by storing them to a global variable
        sw        $t0, 8($k0)
        sw        $t1, 12($k0)
        sw        $t2, 16($k0)
        sw        $t3, 20($k0)
		sw $t4, 24($k0)
		sw $t5, 28($k0)

        mfc0      $k0, $13             # Get Cause register
        srl       $a0, $k0, 2
        and       $a0, $a0, 0xf        # ExcCode field
        bne       $a0, 0, non_intrpt



interrupt_dispatch:            # Interrupt:
    mfc0       $k0, $13        # Get Cause register, again
    beq        $k0, 0, done        # handled all outstanding interrupts

    and        $a0, $k0, BONK_INT_MASK    # is there a bonk interrupt?
    bne        $a0, 0, bonk_interrupt

    and        $a0, $k0, TIMER_INT_MASK    # is there a timer interrupt?
    bne        $a0, 0, timer_interrupt

	and 	$a0, $k0, REQUEST_PUZZLE_INT_MASK
	bne 	$a0, 0, request_puzzle_interrupt

    li        $v0, PRINT_STRING    # Unhandled interrupt types
    la        $a0, unhandled_str
    syscall
    j    done

bonk_interrupt:
	sw 		$0, BONK_ACK
    #Fill in your code here
    j       interrupt_dispatch    # see if other interrupts are waiting

request_puzzle_interrupt:
	sw 		$0, REQUEST_PUZZLE_ACK
	#Fill in your code here
    li $s0, 1
	j	interrupt_dispatch

timer_interrupt:
	sw 		$0, TIMER_ACK
	#Fill in your code here
    j        interrupt_dispatch    # see if other interrupts are waiting

non_intrpt:                # was some non-interrupt
    li        $v0, PRINT_STRING
    la        $a0, non_intrpt_str
    syscall                # print out an error message
    # fall through to done

done:
    la      $k0, chunkIH
    lw      $a0, 0($k0)        # Restore saved registers
    lw      $v0, 4($k0)
	lw      $t0, 8($k0)
    lw      $t1, 12($k0)
    lw      $t2, 16($k0)
    lw      $t3, 20($k0)
	lw $t4, 24($k0)
	lw $t5, 28($k0)
.set noat
    move    $at, $k1        # Restore $at
.set at
    eret
