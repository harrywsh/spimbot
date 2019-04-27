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
    li  $t9, '#' #!!!!!!!warning: don't use t9
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
        sw        $ra, 32($k0)
        sw        $a1, 36($k0)
        sw        $a2, 40($k0)
        sw        $a3, 44($k0)        # can be deleted if not used
        ###warning: reserve $t0-$t5 for solving puzzle!!!!!!

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
    la  $a0, puzzle
    sw  $a0, REQUEST_PUZZLE
    #######
        li      $a1, 'A'
        li      $a2, 0

        lw      $t4, 0($a0)
        lw      $t5, 4($a0)

        move    $t8, $a0    #warning: reserve $t8!!!
        
i_outer_loop:
        beq     $a2, $t4, i_outer_end

        li      $a3, 0
i_inner_loop:
        beq     $a3, $t5, i_inner_end
        lb      $t0, 8($t8)
        bne     $t0, $t9, else1
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $t8, $t8, 1
        add     $a3, $a3, 1
        beq     $a3, $t5, i_inner_end
        j       else2
else1:
        add     $t8, $t8, 1
        add     $a3, $a3, 1
        # unrolling
        beq     $a3, $t5, i_inner_end
        lb      $t0, 8($t8)
        bne     $t0, $t9, else2
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
else2:
        add     $t8, $t8, 1
        add     $a3, $a3, 1

        j       i_inner_loop
i_inner_end:

        add     $a2, $a2, 1
        j       i_outer_loop
i_outer_end:
    ########
    sw  $a0, SUBMIT_SOLUTION
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
    lw      $a1, 36($k0)
    lw      $a2, 40($k0)
    lw      $a3, 44($k0)        # can be deleted if not used
.set noat
    move    $at, $k1        # Restore $at
.set at
    eret

floodfill:
    mul     $t2, $a2, $t5
    add     $t2, $t2, $a3
    add     $t2, $t2, $a0
    lb      $t3, 8($t2)
    bne $t3, $t9, return_short
    bltz $a2, return_short
    bltz $a3, return_short
    beq $a2, $t4, return_short
    beq $a3, $t5, return_short

    sb $a1, 8($t2)                  # board[row][col] = marker;

    sub $sp, $sp, 12
    sw $ra, 0($sp)
    sw $a2, 4($sp)
    sw $a3, 8($sp)

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

return_marker_1:
    addi $v0, $a1, 1
    lw $a3, 8($sp)
    lw $a2, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 12
	jr	$ra                         # return marker + 1;
return_marker:
    move $v0, $a1
    lw $a3, 8($sp)
    lw $a2, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 12
	jr	$ra                         # return marker;
return_short:
    move $v0, $a1
    jr	$ra