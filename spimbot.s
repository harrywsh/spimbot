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
#struct puzzle {
#	unsigned num_rows;
#	unsigned num_cols;
#   unsigned char unsolved_puzzle[num_rows][num_cols];
#   unsigned char puzzle_bitmap[num_rows][ceil(num_cols/8)];
#} puzzle;

# char floodfill (Puzzle* puzzle, char marker, int row, int col) {
#       if (row < 0 || col < 0) {
#             return marker;
#       }
#       if (row >= puzzle->NUM_ROWS || col >= puzzle->NUM_COLS) {
#               return marker;
#       }
#       char ** board = puzzle->board;
#       if (board[row][col] != â€™#â€™) {
#               return marker;
#       }
#       board[row][col] = marker;
#       floodfill(puzzle, marker, row + 1, col + 1);
#       floodfill(puzzle, marker, row + 1, col + 0);
#       floodfill(puzzle, marker, row + 1, col - 1);
#       floodfill(puzzle, marker, row, col + 1);
#       floodfill(puzzle, marker, row, col - 1);
#       floodfill(puzzle, marker, row - 1, col + 1);
#       floodfill(puzzle, marker, row - 1, col + 0);
#       floodfill(puzzle, marker, row - 1, col - 1);
#       return marker + 1;
# }
# void islandfill(Puzzle* puzzle) {
#       char marker = â€™Aâ€™;
#       for (int i = 0; i < puzzle->NUM_ROWS; i++) {
#             for (int j = 0; j < puzzle->NUM_COLS; j++) {
#                     marker = floodfill(puzzle,marker,i,j);
#             }
#       }
# }

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

# void islandfill(Puzzle* puzzle) {
#       char marker = â€™Aâ€™;
#       for (int i = 0; i < puzzle->NUM_ROWS; i++) {
#             for (int j = 0; j < puzzle->NUM_COLS; j++) {
#                     marker = floodfill(puzzle,marker,i,j);
#             }
#       }
# }

islandfill:
        sub     $sp, $sp, 64
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)
        sw      $s1, 8($sp)
        sw      $s2, 12($sp)
        sw      $s3, 16($sp)
        sw      $s4, 20($sp)
        sw      $s5, 24($sp)
        sw      $t0, 28($sp)
        sw      $t1, 32($sp)
        sw      $t2, 36($sp)
        sw      $t3, 40($sp)
        sw      $t4, 44($sp)
        sw      $t5, 48($sp)
        sw      $a0, 52($sp)
        sw      $a1, 56($sp)
        sw      $a2, 60($sp)

        move    $s0, $a0
        li      $s1, 'A'
        li      $s2, 0

        lw      $s4, 0($a0)
        lw      $s5, 4($a0)

i_outer_loop:
        bge     $s2, $s4, i_outer_end

        li      $s3, 0
i_inner_loop:
        bge     $s3, $s5, i_inner_end

        #                     marker = floodfill(puzzle,marker,i,j);
        move    $a0, $s0
        move    $a1, $s1
        move    $a2, $s2
        move    $a3, $s3
        jal     floodfill
        move    $s1, $v0

        # move    $a0, $s0
        # jal     print_board

        add     $s3, $s3, 1
        j       i_inner_loop
i_inner_end:

        add     $s2, $s2, 1
        j       i_outer_loop
i_outer_end:
        lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        lw      $s3, 16($sp)
        lw      $s4, 20($sp)
        lw      $s5, 24($sp)
        lw      $t0, 28($sp)
        lw      $t1, 32($sp)
        lw      $t2, 36($sp)
        lw      $t3, 40($sp)
        lw      $t4, 44($sp)
        lw      $t5, 48($sp)
        lw      $a0, 52($sp)
        lw      $a1, 56($sp)
        lw      $a2, 60($sp)
        add     $sp, $sp, 64
        jr      $ra


# # print board ##################################################
# #
# # argument $a0: board to print
# .globl print_board
# print_board:
#     sub         $sp, $sp, 20
#     sw          $ra, 0($sp)     # save $ra and free up 4 $s registers for
#     sw          $s0, 4($sp)     # i
#     sw          $s1, 8($sp)     # j
#     sw          $s2, 12($sp)    # the address
#     sw          $s3, 16($sp)    # the line number
#     move        $s2, $a0
#     li          $s0, 0          # i
# pb_loop1:
#     li          $s1, 0          # j
# pb_loop2:

#     lw          $t0, 0($s2)     # NUM_ROWS
#     lw          $t1, 4($s2)     # NUM_COLS

#     mul         $t2, $s0, $t1   # i * NUM_COLS
#     add         $t2, $t2, $s1   # i * NUM_COLS + j
#     add         $t2, $t2, 8
#     add         $t2, $t2, $s2


#     lb          $a0, 0($t2)     # num = &board[i][j]
#     li          $v0, 11
#     syscall
#     j           pb_cont
# pb_cont:
#     add         $s1, $s1, 1     # j++
#     blt         $s1, 8, pb_loop2
#     li          $v0, 11         # at the end of a line, print a newline char.
#     li          $a0, '\n'
#     syscall

#     add         $s0, $s0, 1     # i++
#     blt         $s0, 8, pb_loop1
#     lw          $ra, 0($sp)     # restore registers and return
#     lw          $s0, 4($sp)
#     lw          $s1, 8($sp)
#     lw          $s2, 12($sp)
#     lw          $s3, 16($sp)
#     add         $sp, $sp, 20
#     jr          $ra


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
    move $a0, $t0
    jal islandfill
    sw $t0, SUBMIT_SOLUTION($0)
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
