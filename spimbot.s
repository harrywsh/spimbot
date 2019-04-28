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

MAX_ITERATION           = 6
MAX_TIME                = 8801505

puzzle:      .word 0:452
appliance0:  .byte 1
appliance1:  .byte 1
layout:      .byte 0:225
shared:      .word 0:2
order:       .word 6
score:       .word 2

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
	# Construct interrupt mask
	li      $t4, 0
	or      $t4, $t4, BONK_INT_MASK # request bonk
    or      $t4, $t4, TIMER_INT_MASK	        # timer interrupt bit
	or      $t4, $t4, REQUEST_PUZZLE_INT_MASK	        # puzzle interrupt bit
	or      $t4, $t4, 1 # global enable
	mtc0    $t4, $12
	
	#Fill in your code here
    lw      $t0, BOT_X
    blt     $t0, 150, run_left
# run_right:
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
    jal get_appliance
    li      $t7, MAX_ITERATION ### reserve t7!!!
    li      $t9, '#' #!!!!!!!warning: don't use t9
    li      $s7, 0 ### reserve s7!!!
    li      $s6, 0 ### reserve s6!!!
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

    bnez     $s6, submit

    # li        $v0, PRINT_STRING    # Unhandled interrupt types
    # la        $a0, unhandled_str
    # syscall
    j    done

bonk_interrupt:
	sw 		$0, BONK_ACK
    #Fill in your code here
    lw      $t0, BOT_Y
    bge     $t0, 275, bonk_submit
    lw      $t0, BOT_X
    blt     $t0, 150, bonk_left
bonk_right:
    lw      $a0, BOT_X      # X coordinate @a0
    beq     $a0, 160, right_counter
    beq     $t7, -1, right_start_work
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
    j       interrupt_dispatch    # see if other interrupts are waiting
right_counter:
    sw      $0, DROPOFF
    li      $t0, 1
    sw      $t0, DROPOFF
    li      $t0, 2
    sw      $t0, DROPOFF
    li      $t0, 3
    sw      $t0, DROPOFF
    lw      $t0, TIMER
    blt     $t0, MAX_TIME, right_continue_work
    li      $t0, 90
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch
right_continue_work:
    bltz    $t7, right_return_work
    addi    $t7, -1
    beqz    $t7, right_go_next_bin
    ##move east
    sw      $0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch    # see if other interrupts are waiting
right_go_next_bin:
    lw      $a1, BOT_Y      # Y coordinate @a0
    bge     $a1, 170, right_return_appliance
    li      $t0, 33
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7,  MAX_ITERATION
    j       interrupt_dispatch    # see if other interrupts are waiting
right_return_work:
    xor     $s7, $s7, 1
    move     $a0, $s7
    jal     fetch_item
    bnez    $s7, right_return_work_long
    li      $t0, 342
    j		right_return_work_endif
right_return_work_long:
    li      $t0, 354
right_return_work_endif:
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    j       interrupt_dispatch    # see if other interrupts are waiting
right_return_appliance:
    #### get INGREDIENT first
    li      $a0, 0
    jal     fetch_item
    li      $t0, 280
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    j       interrupt_dispatch    # see if other interrupts are waiting
right_start_work:
    li      $t0, 270
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    add		$t0, $t7, 4
    sw      $t0, DROPOFF
    sw      $0, TIMER
    j       interrupt_dispatch    # see if other interrupts are waiting
#### left    
bonk_left:
    lw      $a0, BOT_X      # X coordinate @a0
    beq     $a0, 139, left_counter
    beq     $t7, -1, left_start_work
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
    j       interrupt_dispatch    # see if other interrupts are waiting
left_counter:
    sw      $0, DROPOFF
    li      $t0, 1
    sw      $t0, DROPOFF
    li      $t0, 2
    sw      $t0, DROPOFF
    li      $t0, 3
    sw      $t0, DROPOFF
    lw      $t0, TIMER
    blt     $t0, MAX_TIME, left_continue_work
    li      $t0, 90
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch
left_continue_work:
    bltz    $t7, left_return_work
    addi    $t7, -1
    beqz    $t7, left_go_next_bin
    ##move west
    li      $t0, 180
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch    # see if other interrupts are waiting
left_go_next_bin:
    lw      $a1, BOT_Y      # Y coordinate @a0
    bge     $a1, 170, left_return_appliance
    li      $t0, 147
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7,  MAX_ITERATION
    j       interrupt_dispatch    # see if other interrupts are waiting
left_return_work:
    xor     $s7, $s7, 1
    move    $a0, $s7
    jal     fetch_item
    bnez    $s7, left_return_work_long
    li      $t0, 198
    j		left_return_work_endif
left_return_work_long:
    li      $t0, 186
left_return_work_endif:
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    j       interrupt_dispatch    # see if other interrupts are waiting
left_return_appliance:
    #### get INGREDIENT first
    li      $a0, 0
    jal     fetch_item
    li      $t0, 260
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    j       interrupt_dispatch    # see if other interrupts are waiting
left_start_work:
    li      $t0, 270
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    add		$t0, $t7, 4
    sw      $t0, DROPOFF
    sw      $t0, FINISH_APPLIANCE_INSTANT
    sw      $0, TIMER
    j       interrupt_dispatch    # see if other interrupts are waiting
bonk_submit:
    li      $s6, 1
    jal submit
    j interrupt_dispatch

request_puzzle_interrupt:
	sw 		$0, REQUEST_PUZZLE_ACK
	#Fill in your code here
    # lw $t0, GET_MONEY
    # bge $t0, 100, interrupt_dispatch
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
    add		$t0, $t7, 4
    sw      $t0, PICKUP
    addi    $t7, $t7, -1
    beq     $t7, -5, timer_return
    add		$t0, $t7, 4
    sw      $t0, DROPOFF
    sw      $t0, FINISH_APPLIANCE_INSTANT
    sw      $0, TIMER
    j	    interrupt_dispatch

timer_return:
    lw      $t0, BOT_X
    blt     $t0, 150, timer_left
    bnez    $s7, timer_right_long
    ##short return
    li      $t0, 162
    j       timer_right_return
timer_right_long:
    ##long return
    li      $t0, 174
timer_right_return:
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch    # see if other interrupts are waiting
timer_left:
    bnez    $s7, timer_left_long
    ##short return
    li      $t0, 18
    j       timer_left_return
timer_left_long:
    ##long return
    li      $t0, 6
timer_left_return:
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch    # see if other interrupts are waiting

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
    la $t0, shared
    sw $t0, GET_SHARED
    add $t1, $t0, 4
    lw $t0, 0($t0)              # lo bits
    lw $t1, 0($t1)              # hi bits
    srl $t2, $t1, 13
    and $t2, $t2, 0x1f          # $t2: raw meat count
    srl $t3, $t0, 30
    and $t4, $t1, 0x7
    sll $t4, $t4, 2
    add $t3, $t4, $t3           # $t3: unwashed tomatoes count
    srl $t4, $t0, 20            
    and $t4, $t4, 0x1f          # $t4: uncut onion count
    srl $t5, $t0, 10
    and $t5, $t5, 0x1f          # $t5: unwashed uncut lettuce count
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
    beqz $t2, generate_meat
    li $t1, 2
    sll $t1, $t1, 16
    sw $t1, PICKUP
    sw $t1, PICKUP
generate_meat:
    li $t1, 2
    # sw $t1, GET_INGREDIENT_INSTANT
    sw $t1, GET_INGREDIENT_INSTANT
    # sw $t1, GET_INGREDIENT_INSTANT
    # sw $t1, GET_INGREDIENT_INSTANT
    j return_fetch

app_sink:
    beqz $t3, generate_tomato
    li $t1, 3
    sll $t1, $t1, 16              # pick unwashed tomato
    sw $t1, PICKUP
    sw $t1, PICKUP
    j not_generate_tomato
generate_tomato:
    li $t1, 3
    sw $t1, GET_INGREDIENT_INSTANT
    # sw $t1, GET_INGREDIENT_INSTANT
not_generate_tomato:
    beqz $t5, generate_lettuce
    li $t1, 5
    sll $t1, $t1, 16              # pick unwashed unchopped lettuce
    sw $t1, PICKUP
    sw $t1, PICKUP
    j return_fetch
generate_lettuce:
    li $t1, 5
    sw $t1, GET_INGREDIENT_INSTANT
    # sw $t1, GET_INGREDIENT_INSTANT
    j return_fetch
    
app_chop:
    beqz $t4, generate_onion
    li $t1, 4
    sll $t1, $t1, 16              # pick unchopped onion
    sw $t1, PICKUP
    sw $t1, PICKUP
    j not_generate_onion
generate_onion:
    li $t1, 4
    # sw $t1, GET_INGREDIENT_INSTANT
    sw $t1, GET_INGREDIENT_INSTANT
not_generate_onion:
    li $t1, 5
    sll $t1, $t1, 16              # pick unchopped lettuce
    add $t1, $t1, 1
    sw $t1, PICKUP
    sw $t1, PICKUP
return_fetch:
    jr $ra

submit:
    sub $sp $sp 8
    sw $s0 0($sp)
    sw $s1 4($sp)
    la $s0 order
    sw $s0 GET_TURNIN_ORDER
    lw $t0 BOT_X
    ble  $t0 150 left_submit
    
right_submit:
    li $a2 180
    sw $a2 ANGLE
    j real_submit
left_submit:
    li $a2 0
    sw $a2 ANGLE
real_submit:
    li $t0 1
    sw $t0 ANGLE_CONTROL
    #set angle
    
    lw $s1 4($s0)
    ###$a2 the angel to pickup
    #s1 is the 20 offset int#
    ####bread######

    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 4
    srl $a3 $a3 27
    # sw $a3 0xffff0080($0)   
    sll $a0 $s1 4
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    # sw $a3 0xffff0080($0)
    # sw $a0 PRINT_INT_ADDR
    li $a1 0
    jal pick_up_loads
    bgtz $a3 magic_bread
magic_done:
    ####cheese######
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 9
    srl $a3 $a3 27
    sll $a0 $s1 9
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 65536
    jal pick_up_loads
    ####raw meat######
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 14
    srl $a3 $a3 27
    sll $a0 $s1 14
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 131072
    jal pick_up_loads
    ####meat######
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 19
    srl $a3 $a3 27
    sll $a0 $s1 19
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 131073
    jal pick_up_loads
    ####burnt meat######
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 24
    srl $a3 $a3 27
    sll $a0 $s1 24
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 131074
    jal pick_up_loads
    ####unwashed tomatoes######
    # la $a3 shared
    # sw $a3 GET_SHARED
    # lw $a3 4($a3)
    # sll $a3 $a3 29
    # srl $a3 $a3 27
    
    sll $a0 $s1 29
    srl $a0 $a0 27
    
    # sub $a3 $a0 $a3
    # bgtz $a3 interrupt_dispatch

    sll $a0 $a0 2
    lw $s1 0($s0)
    srl $t0 $s1 29
    add $a0 $a0 $t0
    # la $a3 shared
    # sw $a3 GET_SHARED
    # lw $a3 0($a3)
    # # sll $a3 $a3 29
    # srl $a3 $a3 29
    # sub $a3 $a0 $a3
    # bgtz $a3 interrupt_dispatch

    # sw $a0 PRINT_INT_ADDR
    li $a1 196608
    jal pick_up_loads
    ####washed tomatoes######
    sll $a0 $s1 2
    srl $a0 $a0 27
    # sw $a0 PRINT_INT_ADDR
    li $a1 196609
    jal pick_up_loads
    ####uncut onions######
    sll $a0 $s1 7
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 7
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 262144
    jal pick_up_loads
    ####onions######
    sll $a0 $s1 12
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 12
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 262145
    jal pick_up_loads
    ####Unwashed Unchopped Lettuce######
    sll $a0 $s1 17
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 17
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 327680
    jal pick_up_loads
    ####Unchopped Lettuce######
    sll $a0 $s1 22
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 22
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 327681
    jal pick_up_loads
    ####Lettuce######
    sll $a0 $s1 27
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 27
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 interrupt_dispatch
    # sw $a0 PRINT_INT_ADDR
    li $a1 327682
    jal pick_up_loads
    jal submit_order
    j submit


pick_up_loads:
        li $t1 0    #$t3 i
        li $t2 0
        li $t3 0
    pick_up_loops:
        bge $t1 $a0 end_pick_up 
        bge $t2 4 drop_loads
    once:    
        sw  $a1 PICKUP
        add $t1 $t1 1
        add $t2 $t2 1
        j pick_up_loops
        end_pick_up:
        li $t3 1
        j drop_loads
    drop_loads:
        li $t0 90
        sw $t0 ANGLE
        li $t0 1
        sw $t0 ANGLE_CONTROL
        li $t0 0
        sw $t0 DROPOFF
        li $t0 1
        sw $t0 DROPOFF
        li $t0 2
        sw $t0 DROPOFF
        li $t0 3
        sw $t0 DROPOFF
        li $t2 0
        sw $a2 ANGLE
        li $t0 1
        sw $t0 ANGLE_CONTROL
        beq $t3 0 back_to_load 
        jr $ra
    back_to_load:
        j once

submit_order:
    # j submit_order 
    li $t0 90
    sw $t0 ANGLE
    li $t0 1
    sw $t0 ANGLE_CONTROL
    sw $t0 SUBMIT_ORDER
    
    la $t0 score
    lw $t0 0($t0)
    sub $t0 $t0 $s3
    bgez $t0 submit_continue
    # sw $t0 0xffff0080($0)
submit_continue:  
    move $s3 $t0
    jr $ra

magic_bread:
    lw $t0 GET_MONEY
    blt $t0 20 interrupt_dispatch
    li $t0 0
    li $t1 0
    magic_loop:
        bge $t0 $a3 magic_done
        sw $t1 GET_INGREDIENT_INSTANT
        add $t0 $t0 1
        j magic_loop 