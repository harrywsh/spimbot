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
MAX_TIME                = 9250000
bitboard_jump:
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 3 2 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 4 2 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 3 3 0
.byte 2 3 3 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 4 2 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 3 2 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 5 2 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 4 3 0
.byte 1 4 3 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 5 2 0
.byte 1 3 4 0
.byte 1 3 4 0
.byte 1 3 4 0
.byte 1 3 4 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 5 2 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 4 3 0
.byte 1 4 3 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 5 2 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 1 7 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 3 2 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 4 2 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 3 3 0
.byte 2 3 3 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 4 2 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 2 6 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 3 2 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 3 5 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 4 4 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 5 3 0 0
.byte 5 3 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 6 2 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
.byte 8 0 0 0
puzzle:      .word 0:452
appliance0:  .byte 0
appliance1:  .byte 0
layout:      .byte 0:225
shared:      .word 0:6  
order:       .word 0:6
score:       .word 0:2
request:     .word 0:6
stage:       .word 0
bins:        .byte 0:3
.text
j main

get_appliance:
    la $t0 layout
    la $t3 bins
    sw $t0 GET_LAYOUT
    lw $t1 BOT_X
    bgt $t1 150 get_appliance_right
    lb $t1 32($t0)
    la $t2 appliance1
    sb $t1 0($t2)
    lb $t1 35($t0)
    la $t2 appliance0
    sb $t1 0($t2)
    lb $t1 45($t0)
    sb $t1 0($t3)
    lb $t1 105($t0)
    sb $t1 1($t3)
    lb $t1 165($t0)
    sb $t1 2($t3)
    jr $ra
get_appliance_right:
    lb $t1 39($t0)
    la $t2 appliance0
    sb $t1 0($t2)
    lb $t1 42($t0)
    la $t2 appliance1
    sb $t1 0($t2)
    lb $t1 59($t0)
    sb $t1 0($t3)
    lb $t1 119($t0)
    sb $t1 1($t3)
    lb $t1 179($t0)
    sb $t1 2($t3)
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
    la $t1 request
    li $t0 1764173471
    sw $t0 4($t1)
    li $t0 35636716367
    sw $t0 0($t1)
    sw $t1 SET_REQUEST
   ########initial stage########## 
    la $t1 stage
    sw $0 0($t1)


    lw      $t0, BOT_X
    blt     $t0, 150, run_left
# run_right:
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t0, 101
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    j       start
run_left:
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t0, 79
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
start:
    jal get_appliance
    la      $t0, bins
    lb      $t0, 0($t0)
    li $t7, MAX_ITERATION
    beq $t0, 7, initial_bread
    beq $t0, 11, initial_cheese
    beq $t0, 12, initial_onion
    j initial_normal
initial_bread:
    add $t7, $t7, 2
    j initial_normal
initial_cheese:
    add $t7, $t7, -2
    j initial_normal
initial_onion:
    add $t7, $t7, -1
    j initial_normal
initial_normal:
    # li      $t7, MAX_ITERATION ### reserve t7!!!
    li      $t9, '#' #!!!!!!!warning: don't use t9
    li      $s7, 0 ### reserve s7!!!
    li      $s6, 0 ### reserve s6!!!
    li      $s5, 0 ### RESERVE S5!!!
    la      $s4, bitboard_jump
    la		$t0, puzzle
    sw      $t0, REQUEST_PUZZLE
infinite:
    j infinite

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
    bge     $a0, 280, right_first_bonk
right_bins:
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    ##move west to start
    li      $t0, 180
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch    # see if other interrupts are waiting
right_first_bonk:
    li      $t0, 90
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    li      $t0, 180
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t0, 500
right_first_bonk_loop:
    add		$t0, $t0, -1
    bnez    $t0, right_first_bonk_loop   
    li      $t0, 175
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL  
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
    # sw      $0, GET_BOOST
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
    jal     adjust_fetch
    move    $t7, $v0
    #sw      $0, GET_BOOST
    j       interrupt_dispatch    # see if other interrupts are waiting
right_return_work:
    xor     $s7, $s7, 1
    move     $a0, $s7
    jal     fetch_item
    bnez    $s7, right_return_work_long
    li      $t0, 0x00020009
    sw      $t0, SET_TILE
    li      $t0, 342
    j		right_return_work_endif
right_return_work_long:
    li      $t0, 0x0002000c
    sw      $t0, SET_TILE
    li      $t0, 354
    sw      $0, GET_BOOST
    sw      $0, GET_BOOST
right_return_work_endif:
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    # sw      $0, GET_BOOST
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
    li      $t0, 0x00020009
    sw      $t0, SET_TILE
    j       interrupt_dispatch    # see if other interrupts are waiting
right_start_work:
    li      $t0, 270
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    add		$t0, $t7, 4
    sw      $t0, DROPOFF
    lw      $s5, GET_TILE_INFO
    sw      $0, TIMER
    j       interrupt_dispatch    # see if other interrupts are waiting
#### left    
bonk_left:
    lw      $a0, BOT_X      # X coordinate @a0
    beq     $a0, 139, left_counter
    beq     $t7, -1, left_start_work
    blt     $a0, 20, left_first_bonk
left_bins:
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    ##move east to start
    sw      $0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    j       interrupt_dispatch    # see if other interrupts are waiting
left_first_bonk:
    li      $t0, 90
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, PICKUP
    sw      $0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t0, 500
left_first_bonk_loop:
    add		$t0, $t0, -1
    bnez    $t0, left_first_bonk_loop   
    li      $t0, 5
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL  
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
    # sw      $0, GET_BOOST
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
    jal     adjust_fetch
    move    $t7, $v0
    #sw      $0, GET_BOOST
    j       interrupt_dispatch    # see if other interrupts are waiting
left_return_work:
    xor     $s7, $s7, 1
    move    $a0, $s7
    jal     fetch_item
    bnez    $s7, left_return_work_long
    li      $t0, 0x00020005
    sw      $t0, SET_TILE
    li      $t0, 198
    j		left_return_work_endif
left_return_work_long:
    li      $t0, 0x00020002
    sw      $t0, SET_TILE
    li      $t0, 186
    sw      $0, GET_BOOST
    sw      $0, GET_BOOST
left_return_work_endif:
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    li      $t0, 10
    sw      $t0, VELOCITY
    li      $t7, -1
    # sw      $0, GET_BOOST
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
    li      $t0, 0x00020005
    sw      $t0, SET_TILE
    j       interrupt_dispatch    # see if other interrupts are waiting
left_start_work:
    li      $t0, 270
    sw      $t0, ANGLE
    li      $t0, 1
    sw      $t0, ANGLE_CONTROL
    add		$t0, $t7, 4
    sw      $t0, DROPOFF
#    sw      $t0, FINISH_APPLIANCE_INSTANT
    lw      $s5, GET_TILE_INFO
    sw      $0, TIMER
    j       interrupt_dispatch    # see if other interrupts are waiting
bonk_submit:
    li      $s6, 1
    jal     submit
    j interrupt_dispatch

request_puzzle_interrupt:
	sw 		$0, REQUEST_PUZZLE_ACK
	#Fill in your code here
    # lw $t0, GET_MONEY
    # bge $t0, 100, interrupt_dispatch
    la  $a0, puzzle
    sw  $a0, REQUEST_PUZZLE
#############################resolving process starts############################
li      $a1, 'A'                   #marker
lw      $t4, 0($a0)                #row
lw      $t5, 4($a0)                #col

mul     $t8, $t4, $t5              #size
add     $t8, $t8, $a0              #base address - 8 for bitboard

li      $a2, 0                     #a2 = i

bne     $t5, 32, i_outer_loop
i_outer_loop_32:
beq     $a2, $t4, i_outer_end
mul     $t0, $a2, $t5
add     $t6, $t0, $a0              #puzzle address - 8 for each row

li      $a3, 0                     #a3 = j
li      $s2, 8                                          #start of each block
######block 0 starts
puzzle_32_block0:
######prepare jumptable
lbu     $t0, 8($t8)
# sw      $t0 0xffff0080
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump0_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 0 0 starts
puzzle_32_jump0_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block1
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump0_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 0 1 starts
puzzle_32_jump0_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block1
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump0_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 0 2 starts
puzzle_32_jump0_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block1
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_block1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

######block 1 starts
puzzle_32_block1:
add     $s2, $s2, 8
######prepare jumptable
lbu     $t0, 9($t8)
# sw      $t0 0xffff0080
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump1_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 1 0 starts
puzzle_32_jump1_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block2
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump1_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 1 1 starts
puzzle_32_jump1_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block2
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump1_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 1 2 starts
puzzle_32_jump1_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block2
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_block2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

######block 2 starts
puzzle_32_block2:
add     $s2, $s2, 8
######prepare jumptable
lbu     $t0, 10($t8)
# sw      $t0 0xffff0080
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump2_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 2 0 starts
puzzle_32_jump2_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block3
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump2_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 2 1 starts
puzzle_32_jump2_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block3
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump2_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 2 2 starts
puzzle_32_jump2_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_block3
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_block3
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

######block 3 starts
puzzle_32_block3:
add     $s2, $s2, 8
######prepare jumptable
lbu     $t0, 11($t8)
# sw      $t0 0xffff0080
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump3_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 3 0 starts
puzzle_32_jump3_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_line_end
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump3_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 3 1 starts
puzzle_32_jump3_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_line_end
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_jump3_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 3 2 starts
puzzle_32_jump3_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_32_line_end
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_32_line_end
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

puzzle_32_line_end:
add     $t8, $t8, 5
add     $a2, $a2, 1
j       i_outer_loop_32

i_outer_loop:
beq     $a2, $t4, i_outer_end
mul     $t0, $a2, $t5
add     $t6, $t0, $a0              #puzzle address - 8 for each row

li      $a3, 0                     #a3 = j
li      $s2, 8                                          #start of each block
######block 0 starts
puzzle_block0:
######prepare jumptable
lbu     $t0, 8($t8)
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump0_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 0 0 starts
puzzle_jump0_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block1
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump0_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 0 1 starts
puzzle_jump0_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block1
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump0_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 0 2 starts
puzzle_jump0_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block1
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_block1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

######block 1 starts
puzzle_block1:
add     $s2, $s2, 8
######prepare jumptable
lbu     $t0, 9($t8)
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump1_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 1 0 starts
puzzle_jump1_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block2
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump1_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 1 1 starts
puzzle_jump1_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block2
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump1_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 1 2 starts
puzzle_jump1_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block2
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_block2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

######block 2 starts
puzzle_block2:
add     $s2, $s2, 8
######prepare jumptable
lbu     $t0, 10($t8)
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump2_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 2 0 starts
puzzle_jump2_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block3
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump2_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 2 1 starts
puzzle_jump2_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block3
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump2_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 2 2 starts
puzzle_jump2_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block3
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_block3
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

######block 3 starts
puzzle_block3:
add     $s2, $s2, 8
######prepare jumptable
lbu     $t0, 11($t8)
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump3_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 3 0 starts
puzzle_jump3_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block4
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump3_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 3 1 starts
puzzle_jump3_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block4
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump3_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 3 2 starts
puzzle_jump3_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_block4
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_block4
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

######block 4 starts
puzzle_block4:
add     $s2, $s2, 8
######prepare jumptable
lbu     $t0, 12($t8)
sll     $t0, $t0, 2
add     $s3, $s4, $t0              #s4 : jumpboard base address
######

lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump4_0
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######jump 4 0 starts
puzzle_jump4_0:
lb      $t1, 0($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_line_end
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump4_1
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 4 1 starts
puzzle_jump4_1:
lb      $t1, 1($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_line_end
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_jump4_2
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######jump 4 2 starts
puzzle_jump4_2:
lb      $t1, 2($s3)
add     $a3, $a3, $t1
add     $t6, $t6, $t1
beq     $a3, $s2, puzzle_line_end
lb      $t0, 8($t6)
bne     $t0, $t9, puzzle_line_end
move    $t2, $t6
jal     floodfill_real
add     $a1, $a1, 1
######
######

puzzle_line_end:
add     $t8, $t8, 5
add     $a2, $a2, 1
j       i_outer_loop

i_outer_end:
#############################resolving process ends############################
    sw  $a0, SUBMIT_SOLUTION
    bnez     $s6, submit
	j	interrupt_dispatch

timer_interrupt:
	sw 		$0, TIMER_ACK
	#Fill in your code here
    lw      $t0, GET_TILE_INFO
    sub     $t0, $t0, $s5
    bnez    $t0, timer_pickup
    sw      $0, FINISH_APPLIANCE_INSTANT
timer_pickup:
    add		$t0, $t7, 4
    sw      $t0, PICKUP
    addi    $t7, $t7, -1
    beq     $t7, -4, timer_return
    add		$t0, $t7, 4
    sw      $t0, DROPOFF
#    sw      $t0, FINISH_APPLIANCE_INSTANT
    lw      $s5, GET_TILE_INFO
    sw      $0, TIMER
    j	    interrupt_dispatch

timer_return:
    sw      $0, DROPOFF
    sw      $0, FINISH_APPLIANCE_INSTANT
    sw      $0, PICKUP
    lw      $t0, BOT_X
    blt     $t0, 150, timer_left
    bnez    $s7, timer_right_long
    ##short return
    li      $t0, 162
    # sw      $0, GET_BOOST
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
    lb      $t3, 8($t2)
    bne $t3, $t9, return_short
    bltz $a3, return_short
    beq $a3, $t5, return_short
floodfill_real:
    sb $a1, 8($t2)                  # board[row][col] = marker;

    sub $sp, $sp, 16
    sw $ra, 0($sp)
    sw $a2, 4($sp)
    sw $a3, 8($sp)
    sw $t2, 12($sp)

    addi $a3, $a3, -1
    addi $t2, $t2, -1
    jal floodfill
    addi $a3, $a3, 2
    addi $t2, $t2, 2
    jal floodfill

    addi $a2, $a2, 1
    beq $a2, $t4, floodfill_cont1
    add $t2, $t2, $t5
    jal floodfill
    addi $a3, $a3, -1
    addi $t2, $t2, -1
    jal floodfill
    addi $a3, $a3, -1
    addi $t2, $t2, -1
    jal floodfill

    sub $t2, $t2, $t5
    addi $a2, $a2, -2
    sub $t2, $t2, $t5
    bltz $a2, floodfill_cont2
    jal floodfill
    addi $a3, $a3, 1
    addi $t2, $t2, 1
    jal floodfill
    addi $a3, $a3, 1 
    addi $t2, $t2, 1  
    jal floodfill
floodfill_cont2:
    lw $t2, 12($sp)
    lw $a3, 8($sp)
    lw $a2, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 16
return_short:
    jr	$ra
floodfill_cont1:
    addi $a2, $a2, -2
    sub $t2, $t2, $t5
    bltz $a2, floodfill_cont2
    jal floodfill
    addi $a3, $a3, -1
    addi $t2, $t2, -1
    jal floodfill
    addi $a3, $a3, -1 
    addi $t2, $t2, -1  
    jal floodfill
    j   floodfill_cont2

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
    sw $t1, GET_INGREDIENT_INSTANT
    # sw $t1, GET_INGREDIENT_INSTANT
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
    sw $t1, GET_INGREDIENT_INSTANT
    j return_fetch
    
app_chop:
    beqz $t4, generate_onion
    li $t1, 4
    sll $t1, $t1, 16              # pick unchopped onion
    sw $t1, PICKUP
    sw $t1, PICKUP
    j not_generate_onion
generate_onion:
    li $t1, 5
    sll $t1, $t1, 16              # pick unchopped lettuce
    add $t1, $t1, 1
    sw $t1, PICKUP
    # sw $t1, PICKUP
    la $t0 shared
    sw $t0 GET_SHARED
    lw $t0 0($t0)
    sll $t0 $t0 12
    srl $t0 $t0 27
    bge $t0, 20, not_generate_onion_instant
    li $t1, 4
    sw $t1, GET_INGREDIENT_INSTANT
    # sw $t1, GET_INGREDIENT_INSTANT
    j  not_generate_onion
not_generate_onion_instant:
    sw $t1, PICKUP
not_generate_onion:
    li $t1, 5
    sll $t1, $t1, 16              # pick unchopped lettuce
    add $t1, $t1, 1
    sw $t1, PICKUP
    sw $t1, PICKUP
return_fetch:
    jr $ra

submit:
    
    la $s0 order
    sw $s0 GET_TURNIN_ORDER
    lw $t0 BOT_X
    ble  $t0 150 left_submit
    
right_submit:
    li $a2 180
    sw $a2 ANGLE
    j real_submit
left_submit:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    li $a2 0
    sw $a2 ANGLE
real_submit:
    li $t0 1
    sw $t0 ANGLE_CONTROL
    #set angle
    
    lw $s1 4($s0)
    # sw $s1 0xffff0080
    ###$a2 the angel to pickup
    #s1 is the 20 offset int#
    ####bread######
    la $t3 stage
    lw $t3 0($t3)
    # sw $t3 0xffff0080
    beq $t3 0 Bread
    beq $t3 1 Cheese
    beq $t3 2 Raw_meat
    beq $t3 3 Meat
    beq $t3 4 Burnt_meat
    beq $t3 5 Unwashed_tomatoes
    beq $t3 6 Washed_tomatoes

    lw $s1 0($s0)
    beq $t3 7 Uncut_onions
    beq $t3 8 Oninons
    beq $t3 9 Unwahsed_Unchopped_Lettuce
    beq $t3 10 Unchopped_Lettuce
    beq $t3 11 Lettuce
Bread:
    
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 4
    srl $a3 $a3 27
    # sw $a3 0xffff0080($0)   
    sll $a0 $s1 4
    srl $a0 $a0 27

    sub $a3 $a0 $a3
    
    li $a1 0
    blez $a3 subs
    sub $a0 $a0 $a3
    # sw $a0 0xffff0080
subs:
    jal pick_up_loads


    mul $s2 $a3 20
    # sw $a3 0xffff0080($0)
    # sw $a0 PRINT_INT_ADDR
    bgtz $a3 magic_bread
    # sw  $a3 0xffff0080
   
magic_done:
    
    # bgtz $a3 magic_bread
     

    add $t3 $t3 1
Cheese:
    ####cheese######
    
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 9
    srl $a3 $a3 27
    sll $a0 $s1 9
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 65536
    jal pick_up_loads
    add $t3 $t3 1
Raw_meat:
    ####raw meat######
    
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 14
    srl $a3 $a3 27
    sll $a0 $s1 14
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 131072
    jal pick_up_loads
    add $t3 $t3 1
Meat:
    ####meat######
    
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 19
    srl $a3 $a3 27
    sll $a0 $s1 19
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 131073
    jal pick_up_loads
    add $t3 $t3 1
Burnt_meat:
    ####burnt meat######
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 4($a3)
    sll $a3 $a3 24
    srl $a3 $a3 27
    sll $a0 $s1 24
    srl $a0 $a0 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 131074
    jal pick_up_loads
    add $t3 $t3 1
Unwashed_tomatoes:
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
    # sw $s1 0xffff0080

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
    add $t3 $t3 1
Washed_tomatoes:
    ####washed tomatoes######
    
    sll $a0 $s1 2
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 2
    srl $a3 $a3 27
    blt $a3 $a0 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 196609
    jal pick_up_loads
    add $t3 $t3 1
Uncut_onions:
    
    ####uncut onions######
    sll $a0 $s1 7
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 7
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 262144
    jal pick_up_loads
    add $t3 $t3 1
Oninons:
    
    ####onions######
    sll $a0 $s1 12
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 12
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 262145
    jal pick_up_loads
    add $t3 $t3 1
Unwahsed_Unchopped_Lettuce:
    ####Unwashed Unchopped Lettuce######
    
    sll $a0 $s1 17
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 17
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 327680
    jal pick_up_loads
    add $t3 $t3 1
Unchopped_Lettuce:
    ####Unchopped Lettuce######
    
    sll $a0 $s1 22
    srl $a0 $a0 27
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 22
    srl $a3 $a3 27
    sub $a3 $a0 $a3
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 327681
    jal pick_up_loads
    add $t3 $t3 1
Lettuce:
    ####Lettuce######
    la $s0 order
    sw $s0 GET_TURNIN_ORDER
    lw $s1 0($s0)

    sll $a0 $s1 27
    srl $a0 $a0 27
    # sw $a0 0xffff0080
    # add $t0 $t0 $0
    la $a3 shared
    sw $a3 GET_SHARED
    lw $a3 0($a3)
    sll $a3 $a3 27
    srl $a3 $a3 27

    add $t0 $t0 $0
    # sw $a3 0xffff0080
    sub $a3 $a0 $a3
    # add $t0 $t0 $0
    # sw $a3 0xffff0080
    bgtz $a3 wait_to_die
    # sw $a0 PRINT_INT_ADDR
    li $a1 327682
    jal pick_up_loads
    jal submit_order
    j submit


pick_up_loads:
        li $t1 0    #$t2    i
        li $t2 0
        li $t4 0
    pick_up_loops:
        bge $t1 $a0 end_pick_up 
        bge $t2 3 drop_loads
    once:    
        sw  $a1 PICKUP
        add $t1 $t1 1
        add $t2 $t2 1
        j pick_up_loops
        end_pick_up:
        li $t4 1
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
        beqz $t4 back_to_load 
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
    la $t3 stage
    sw $0 0($t3)
    # la $t0 score
    # sw $t0 0xffff1018($0)
    # lw $t0 0($t0)
    # sw $t0 0xffff0080($0)
    jr $ra
    
magic_bread:
    lw $t0 GET_MONEY
    blt $t0 $s2 interrupt_dispatch
    li $t0 0
    li $t1 0
    magic_loop:
        bge $t0 $a3 magic_done
        sw $t1 GET_INGREDIENT_INSTANT
        add $t0 $t0 1
        j magic_loop 

wait_to_die:
    la $t0 stage
    sw $t3 0($t0)
    j interrupt_dispatch

adjust_fetch:
    lw $t0, BOT_Y
    li $t2, 2
    li $t1, 160
    blt $t0, $t1, bin_1
    j judge_bin
bin_1:
    li $t1, 80
    blt $t0, $t1, bin_0
    # addi $t2, $t2, -1
    j judge_bin
bin_0:
    addi $t2, $t2, -1
judge_bin:
    la $t0, bins
    add $t2, $t0, $t2
    lb $t2, 0($t2)
    li $v0, MAX_ITERATION
    beq $t2, 7, return_bread
    beq $t2, 11, return_cheese
    beq $t2, 12, return_onion
    j return_normal
return_bread:
    add $v0, $v0, 2
    jr $ra
return_cheese:
    add $v0, $v0, -2
    jr $ra
return_onion:
    add $v0, $v0, -1
    jr $ra
return_normal:
    jr $ra