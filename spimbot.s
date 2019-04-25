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

main:
	# Construct interrupt mask
	li      $t4, 0
	or      $t4, $t4, BONK_INT_MASK # request bonk
	or      $t4, $t4, REQUEST_PUZZLE_INT_MASK	        # puzzle interrupt bit
	or      $t4, $t4, 1 # global enable
	mtc0    $t4, $12
	
	#Fill in your code here
    la $t0, puzzle
    sw $t0, REQUEST_PUZZLE
request_puzzle:
    j request_puzzle

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
		sw        $t4, 24($k0)
		sw        $t5, 28($k0)
        sw      $ra, 32($k0)
        sw      $s0, 36($k0)
        sw      $s1, 40($k0)
        sw      $s2, 44($k0)
        sw      $s3, 48($k0)
        sw      $s4, 52($k0)
        sw      $s5, 56($k0)

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
    la  $s0, puzzle
    sw  $s0, REQUEST_PUZZLE
    #######
        li      $s1, 'A'
        li      $s2, 0

        lw      $s4, 0($s0)
        lw      $s5, 4($s0)
        
i_outer_loop:
        bge     $s2, $s4, i_outer_end

        li      $s3, 0
i_inner_loop:
        bge     $s3, $s5, i_inner_end

        # marker = floodfill(puzzle,marker,i,j);
        move    $a0, $s0
        move    $a1, $s1
        move    $a2, $s2
        move    $a3, $s3
        jal     floodfill
        move    $s1, $v0

        add     $s3, $s3, 1
        j       i_inner_loop
i_inner_end:

        add     $s2, $s2, 1
        j       i_outer_loop
i_outer_end:
    ########
    la  $t0, puzzle
    sw  $t0, SUBMIT_SOLUTION
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
	lw      $t4, 24($k0)
	lw      $t5, 28($k0)
    lw      $ra, 32($k0)
    lw      $s0, 36($k0)
    lw      $s1, 40($k0)
    lw      $s2, 44($k0)
    lw      $s3, 48($k0)
    lw      $s4, 52($k0)
    lw      $s5, 56($k0)
.set noat
    move    $at, $k1        # Restore $at
.set at
    eret

floodfill1:
    sub $sp, $sp, 12
    sw $ra, 0($sp)
    sw $a2, 4($sp)
    sw $a3, 8($sp)
    blt $a2, $zero, return_marker
    blt $a3, $zero, return_marker
    lw $t0, 0($a0)          
    lw $t1, 4($a0)
    bge $a2, $t0, return_marker
    bge $a3, $t1, return_marker
    lw      $t0, 0($a0)
    lw      $t1, 4($a0)
    mul     $t2, $a2, $t1
    add     $t2, $t2, $a3
    add     $t2, $t2, $a0
    add     $t2, $t2, 8
    lb      $t3, 0($t2)
    bne $t3, '#', return_marker
    sb $a1, 0($t2)                  # board[row][col] = marker;
    addi $a2, $a2, 1
    addi $a3, $a3, 1
    jal floodfill1
    addi $a3, $a3, -1
    jal floodfill1
    addi $a3, $a3, -1
    jal floodfill1

    addi $a2, $a2, -1
    addi $a3, $a3, 2
    jal floodfill1
    addi $a3, $a3, -2
    jal floodfill1

    addi $a2, $a2, -1
    addi $a3, $a3, 2
    jal floodfill1
    addi $a3, $a3, -1
    jal floodfill1
    addi $a3, $a3, -1
    jal floodfill1

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


floodfill:

#       if (row < 0 || col < 0) {
#             return marker;
#       }
#       if (row >= puzzle->NUM_ROWS || col >= puzzle->NUM_COLS) {
#               return marker;
#       }
        slt     $t0, $a2, 0
        slt     $t1, $a3, 0
        or      $t0, $t1, $t0
        beq     $t0, 0, f_end_if1
        move    $v0, $a1
        jr      $ra
f_end_if1:

        lw      $t0, 0($a0)
        lw      $t1, 4($a0)
        sge     $t0, $a2, $t0
        sge     $t1, $a3, $t1
        or      $t0, $t1, $t0

        beq     $t0, 0, f_end_if2
        move    $v0, $a1
        jr      $ra
f_end_if2:


#       char board[][] = puzzle->board;
#       if (board[row][col] != â€™#â€™) {
#               return marker;
#       }
        lw      $t0, 0($a0)
        lw      $t1, 4($a0)
        mul     $t2, $a2, $t1
        add     $t2, $t2, $a3
        add     $t2, $t2, $a0
        add     $t2, $t2, 8
        lb      $t3, 0($t2)

        beq     $t3, '#', f_endif_3
        move    $v0, $a1
        jr      $ra
f_endif_3:

f_recur:
        sub     $sp, $sp, 48
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)
        sw      $s1, 8($sp)
        sw      $s2, 12($sp)
        sw      $s3, 16($sp)
        sw      $t0, 20($sp)
        sw      $t1, 24($sp)
        sw      $t2, 28($sp)
        sw      $t3, 32($sp)
        sw      $a0, 36($sp)
        sw      $a1, 40($sp)
        sw      $a2, 44($sp)

#       board[row][col] = marker;
        sb      $a1, 0($t2)

        move    $s0, $a0
        move    $s1, $a1
        move    $s2, $a2
        move    $s3, $a3

#       floodfill(puzzle, marker, row + 1, col + 1);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, 1
        add     $a3, $s3, 1
        jal     floodfill

#       floodfill(puzzle, marker, row + 1, col + 0);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, 1
        add     $a3, $s3, 0
        jal     floodfill
#       floodfill(puzzle, marker, row + 1, col - 1);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, 1
        add     $a3, $s3, -1
        jal     floodfill
#       floodfill(puzzle, marker, row, col + 1);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, 0
        add     $a3, $s3, 1
        jal     floodfill
#       floodfill(puzzle, marker, row, col - 1);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, 0
        add     $a3, $s3, -1
        jal     floodfill
#       floodfill(puzzle, marker, row - 1, col + 1);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, -1
        add     $a3, $s3, 1
        jal     floodfill
#       floodfill(puzzle, marker, row - 1, col + 0);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, -1
        add     $a3, $s3, 0
        jal     floodfill
#       floodfill(puzzle, marker, row - 1, col - 1);
        move    $a0, $s0
        move    $a1, $s1
        add     $a2, $s2, -1
        add     $a3, $s3, -1
        jal     floodfill
#       return marker + 1;
        add     $v0, $a1, 1
f_done:
        lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        lw      $s3, 16($sp)
        lw      $t0, 20($sp)
        lw      $t1, 24($sp)
        lw      $t2, 28($sp)
        lw      $t3, 32($sp)
        lw      $a0, 36($sp)
        lw      $a1, 40($sp)
        lw      $a2, 44($sp)
        add     $sp, $sp, 48

        jr      $ra
