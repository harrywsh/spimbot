bitboard_jump:

la      $s4, bitboard_jump

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

        # beq     $t5, 32, i_outer_end

        move    $t8, $a0    #warning: reserve $t8!!!
        mul     $t6, $t4, $t5  #warning: reserve $t6!!! 
        add     $t6, $t6, $a0   # base address -8 for bitboard
        
i_outer_loop:
        beq     $a2, $t4, i_outer_end
        mul     $t0, $a2, $t4
        add     $t8, $t0, $a0
        li      $a3, 0

        lb      $s3, 8($t6)
        sll     $s3, $t0, 2
        add     $s3, $s4, $t0
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else11
        jal     floodfill
        move    $a1, $v0
puzzle_line_else11:
        lb      $t1, 0($s3)
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else12
        jal     floodfill
        move    $a1, $v0
puzzle_line_else12:
        lb      $t1, 1($s3)
        #beqz    $t1, puzzle_block2 ###
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else13
        jal     floodfill
        move    $a1, $v0
puzzle_line_else13:
        lb      $t1, 2($s3)
        beqz    $t1, puzzle_block2
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else14
        jal     floodfill
        move    $a1, $v0
puzzle_line_else14:
        lb      $t1, 3($s3)
        beqz    $t1, puzzle_block2
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_block2
        jal     floodfill
        move    $a1, $v0

puzzle_block2:
        add     $a3, $a3, 1
        add     $t8, $t8, 1
        lb      $s3, 9($t6)
        sll     $s3, $t0, 2
        add     $s3, $s4, $t0
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else21
        jal     floodfill
        move    $a1, $v0
puzzle_line_else21:
        lb      $t1, 0($s3)
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else22
        jal     floodfill
        move    $a1, $v0
puzzle_line_else22:
        lb      $t1, 1($s3)
        #beqz    $t1, puzzle_block3 ###
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else23
        jal     floodfill
        move    $a1, $v0
puzzle_line_else23:
        lb      $t1, 2($s3)
        beqz    $t1, puzzle_block3
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else24
        jal     floodfill
        move    $a1, $v0
puzzle_line_else24:
        lb      $t1, 3($s3)
        beqz    $t1, puzzle_block3
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_block3
        jal     floodfill
        move    $a1, $v0

puzzle_block3:
        add     $a3, $a3, 1
        add     $t8, $t8, 1
        lb      $s3, 10($t6)
        sll     $s3, $t0, 2
        add     $s3, $s4, $t0
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else31
        jal     floodfill
        move    $a1, $v0
puzzle_line_else31:
        lb      $t1, 0($s3)
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else32
        jal     floodfill
        move    $a1, $v0
puzzle_line_else32:
        lb      $t1, 1($s3)
        #beqz    $t1, puzzle_block4 ###
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else33
        jal     floodfill
        move    $a1, $v0
puzzle_line_else33:
        lb      $t1, 2($s3)
        beqz    $t1, puzzle_block4
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else34
        jal     floodfill
        move    $a1, $v0
puzzle_line_else34:
        lb      $t1, 3($s3)
        beqz    $t1, puzzle_block4
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_block4
        jal     floodfill
        move    $a1, $v0

puzzle_block4:
        add     $a3, $a3, 1
        add     $t8, $t8, 1
        lb      $s3, 11($t6)
        sll     $s3, $t0, 2
        add     $s3, $s4, $t0
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else41
        jal     floodfill
        move    $a1, $v0
puzzle_line_else41:
        lb      $t1, 0($s3)
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else42
        jal     floodfill
        move    $a1, $v0
puzzle_line_else42:
        lb      $t1, 1($s3)
        #beqz    $t1, puzzle_block5 ###
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else43
        jal     floodfill
        move    $a1, $v0
puzzle_line_else43:
        lb      $t1, 2($s3)
        beqz    $t1, puzzle_block5
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else44
        jal     floodfill
        move    $a1, $v0
puzzle_line_else44:
        lb      $t1, 3($s3)
        beqz    $t1, puzzle_block5
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_block5
        jal     floodfill
        move    $a1, $v0

puzzle_block5:
        beq     $t5, 32, puzzle_line_end_short
        add     $a3, $a3, 1
        add     $t8, $t8, 1
        lb      $s3, 12($t6)
        sll     $s3, $t0, 2
        add     $s3, $s4, $t0
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else51
        jal     floodfill
        move    $a1, $v0
puzzle_line_else51:
        lb      $t1, 0($s3)
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else52
        jal     floodfill
        move    $a1, $v0
puzzle_line_else52:
        lb      $t1, 1($s3)
        beqz    $t1, puzzle_line_end ###
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else53
        jal     floodfill
        move    $a1, $v0
puzzle_line_else53:
        lb      $t1, 2($s3)
        beqz    $t1, puzzle_line_end
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_else54
        jal     floodfill
        move    $a1, $v0
puzzle_line_else54:
        lb      $t1, 3($s3)
        beqz    $t1, puzzle_line_end
        add     $a3, $a3, $t1
        add     $t8, $t8, $t1
        lb      $t0, 8($t8)
        bne     $t0, $t9, puzzle_line_end
        jal     floodfill
        move    $a1, $v0
puzzle_line_end_short:
        add     $t6, 4
        j       i_inner_end
puzzle_line_end:
        add     $t6, 5
i_inner_end:
        add     $a2, $a2, 1
        j       i_outer_loop
i_outer_end:
    ########
    sw  $a0, SUBMIT_SOLUTION
    bnez     $s6, submit
	j	interrupt_dispatch