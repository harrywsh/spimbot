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
appliance0:  .byte 1
appliance1:  .byte 1
layout:      .byte 0:225

.text
j main

get_appliance:
    la $t0 layout
    sw $t0 GET_LAYOUT
    lw $t1 BOT_X
    bgt $t1 150 search_right
    lb $t1 32($t0)
    la $t2 appliance1
    sb $t1 0($t2)
    lb $t1 35($t0)
    la $t2 appliance0
    sb $t1 0($t2)
    jr $ra
search_right:
    lb $t1 39($t0)
    la $t2 appliance0
    sb $t1 0($t2)
    lb $t1 42($t0)
    la $t2 appliance1
    sb $t1 0($t2)
    jr $ra

main:
    li  $t9, '#' #!!!!!!!warning: don't use t9
	# Construct interrupt mask
	li      $t4, 0
	or      $t4, $t4, BONK_INT_MASK # request bonk
	or      $t4, $t4, REQUEST_PUZZLE_INT_MASK	        # puzzle interrupt bit
	or      $t4, $t4, 1 # global enable
	mtc0    $t4, $12
	
	#Fill in your code here
    jal get_appliance
    lw      $t0, BOT_X
    blt     $t0, 150, run_left
    jal move_south
    jal move_south
    jal move_west
    jal move_south
    la  $t0, puzzle
    sw  $t0, REQUEST_PUZZLE
    ##move west to start
    li      $t0, 10
    sw      $t0, VELOCITY
    sw      $0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    ##end move
    j       start
run_left:
    jal move_south
    jal move_south
    jal move_east
    jal move_south
    la  $t0, puzzle
    sw  $t0, REQUEST_PUZZLE
    ##move west to start
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t0, 180
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    ##end move
start:
    li      $t7, 4 ### reserve t7!!!
infinite:
    j infinite

#####movement
move_east:
    lw      $t1, BOT_X
    #li     $t0, 0
    sw      $0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
move_east_loop:
    # lw      $t2, VELOCITY
    # beqz    $t2, move_end
    lw      $t2, BOT_X
    sub     $t2, $t2, $t1
    blt     $t2, 20, move_east_loop
move_end:
    sw      $0, VELOCITY
    jr      $ra

move_west:
    lw      $t1, BOT_X
    li      $t0, 180
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
move_west_loop:
    # lw      $t2, VELOCITY
    # beqz    $t2, move_end
    lw      $t2, BOT_X
    sub     $t2, $t1, $t2
    blt     $t2, 20, move_west_loop
    j		move_end

move_north:
    lw      $t1, BOT_Y
    li      $t0, 270
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
move_north_loop:
    # lw      $t2, VELOCITY
    # beqz    $t2, move_end
    lw      $t2, BOT_Y
    sub     $t2, $t1, $t2
    blt     $t2, 20, move_north_loop
    j		move_end

move_south:
    lw      $t1, BOT_Y
    li      $t0, 90
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
move_south_loop:
    # lw      $t2, VELOCITY
    # beqz    $t2, move_end
    lw      $t2, BOT_Y
    sub     $t2, $t2, $t1
    blt     $t2, 20, move_south_loop
    j		move_end
######


.kdata
chunkIH:    .space 48
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
    lw      $t0, BOT_X
    blt     $t0, 150, bonk_left
bonk_right:
    lw      $a0, BOT_X      # X coordinate @a0
    beq     $a0, 160, right_else_counter
    beq     $t7, -1, start_work
right_bins:
    sw      $t0, PICKUP
    sw      $t0, PICKUP
    sw      $t0, PICKUP
    sw      $t0, PICKUP
    ##move west to start
    li      $t0, 180
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j		end_bonk
right_else_counter:
    sw      $0, DROPOFF
    li      $t0, 1
    sw      $t0, DROPOFF
    li      $t0, 2
    sw      $t0, DROPOFF
    li      $t0, 3
    sw      $t0, DROPOFF
    addi    $t7, -1
    beqz    $t7, right_go_next
    ##move east
    sw      $0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j		end_bonk
right_go_next:
    lw      $a1, BOT_Y      # Y coordinate @a0
    bge     $a1, 170, right_return_appliance
    li      $t0, 33
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, 4
    j       end_bonk
right_return_appliance:
    #### get INGREDIENT first
    li $a0, 0
    jal     fetch_item
    li      $t0, 280
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    j       end_bonk
    
bonk_left:
    lw      $a0, BOT_X      # X coordinate @a0
    beq     $a0, 139, left_else_counter
    beq     $t7, -1, start_work
left_bins:
    sw      $t0, PICKUP
    sw      $t0, PICKUP
    sw      $t0, PICKUP
    sw      $t0, PICKUP
    ##move east to start
    sw      $0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j		end_bonk
left_else_counter:
    sw      $0, DROPOFF
    li      $t0, 1
    sw      $t0, DROPOFF
    li      $t0, 2
    sw      $t0, DROPOFF
    li      $t0, 3
    sw      $t0, DROPOFF
    addi    $t7, -1
    beqz    $t7, left_go_next
    ##move west
    li      $t0, 180
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j		end_bonk
left_go_next:
    lw      $a1, BOT_Y      # Y coordinate @a0
    bge     $a1, 170, left_return_appliance
    li      $t0, 147
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, 4
    j       end_bonk
left_return_appliance:
    #### get INGREDIENT first
    li $a0, 0
    jal     fetch_item
    li      $t0, 260
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    j		end_bonk
start_work:
end_bonk:
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
        add     $a3, $a3, 1
        beq     $a3, $t5, i_inner_end_long
        j       else2
else1:
        add     $a3, $a3, 1
        # unrolling
        beq     $a3, $t5, i_inner_end_long
        lb      $t0, 9($t8)
        bne     $t0, $t9, else2
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
else2:
        add     $t8, $t8, 2
        add     $a3, $a3, 1

        j       i_inner_loop
i_inner_end_long:
        add     $t8, $t8, 1
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

#######
move_back_10:
    lw      $t1, BOT_Y
    lw      $t2, BOT_X
    li      $t0, 180
    sw      $t0, ANGLE
    sw      $0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
move_back_loop:
    lw      $t0, ANGLE
    beq     $t0, 90, move_set_y
    beq     $t0, 270, move_set_y
    lw      $t3, BOT_X
    move    $t0, $t2
    j       move_judge
move_set_y:
    lw      $t3, BOT_Y
    move    $t0, $t1
move_judge:
    blt     $t3, $t0, move_not_swap
    move    $t4, $t3
    move    $t3, $t0
    move    $t0, $t4
move_not_swap:
    sub     $t4, $t0, $t3
    bge     $t4, 10, move_back_endloop
    j		move_back_loop    
move_back_endloop:
    sw      $0, VELOCITY
    jr      $ra
#######

####################################################################################
# grab ingredients needed to the appointed appliance                               #
#                                                                                  #
# behaves according to the position of bot (left half/ right half)                 #
# @param $a0: the destination appliance, 0 for the one nearer from shared counter, #
# 1 for the one farther from shared counter.                                       #
####################################################################################
fetch_item:
    beq $a0, 1, farther_app
    la $t0, appliance0
    lb $t0, 0($t0)
    j choose_ing
farther_app:
    la $t0, appliance1
    lb $t0, 0($t0)
choose_ing:
    beq $t0, 4, app_oven
    beq $t0, 5, app_sink
    beq $t0, 6, app_chop
    j return_fetch
app_oven:
    li $t1, 2
    sll $t1, $t1, 16
    sw $t1, PICKUP
    sw $t1, PICKUP
    sw $t1, PICKUP
    sw $t1, PICKUP
    j return_fetch
app_sink:
    li $t1, 3
    sll $t1, $t1, 16              # pick unwashed tomato
    add $t1, $t1, 1
    sw $t1, PICKUP
    sw $t1, PICKUP
    li $t1, 5
    sll $t1, $t1, 16              # pick unwashed unchopped tomato
    sw $t1, PICKUP
    sw $t1, PICKUP
    j return_fetch
app_chop:
    li $t1, 4
    sll $t1, $t1, 16              # pick unchopped onion
    sw $t1, PICKUP
    sw $t1, PICKUP
    li $t1, 5
    sll $t1, $t1, 16              # pick unchopped lettuce
    add $t1, $t1, 1
    sw $t1, PICKUP
    sw $t1, PICKUP
return_fetch:
    jr $ra
