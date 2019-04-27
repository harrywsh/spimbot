    la  $a0, puzzle
    sw  $a0, REQUEST_PUZZLE
    #######
        li      $a1, 'A'
        li      $a2, 0

        lw      $t4, 0($a0)
        lw      $t5, 4($a0)
        addi    $t7, $t5, 7 ##
        div     $t7, $t7, 8 ##
        
i_outer_loop:
        beq     $a2, $t4, i_outer_end

        li      $a3, 0
        li      $t6, 0  ##
        mul     $t8, $a2, $t7 ##
i_inner_loop:
        beq     $t6, $t7, i_inner_end
        beq     $a3, $t5, i_inner_end

        add     $t2, $t8, $t6
        add     $t2, $t2, $a0
        lb      $t3, 12($t2)
        
        andi    $t1, $t3, 0x80
        beqz    $t1, else1
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
        j       else2
else1:
        add     $a3, $a3, 1
        andi    $t1, $t3, 0x40
        beqz    $t1, else2
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
        j       else3
else2:
        add     $a3, $a3, 1
        andi    $t1, $t3, 0x20
        beqz    $t1, else3
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
        j       else4
else3:
        add     $a3, $a3, 1
        andi    $t1, $t3, 0x10
        beqz    $t1, else4
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
        j       else5
else4:
        add     $a3, $a3, 1
        beq     $a3, $t5, i_inner_end
        andi    $t1, $t3, 0x8
        beqz    $t1, else5
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
        j       else6
else5:
        add     $a3, $a3, 1
        andi    $t1, $t3, 0x4
        beqz    $t1, else6
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
        j       else7
else6:
        add     $a3, $a3, 1
        andi    $t1, $t3, 0x2
        beqz    $t1, else7
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
        j       else8
else7:
        add     $a3, $a3, 1
        andi    $t1, $t3, 0x1
        beqz    $t1, else8
        # marker = floodfill(puzzle,marker,i,j);
        jal     floodfill
        move    $a1, $v0
        add     $a3, $a3, 1
else8:
        add     $a3, $a3, 1
        add     $t6, $t6, 1
        j       i_inner_loop
i_inner_end:

        add     $a2, $a2, 1
        j       i_outer_loop
i_outer_end:
    ########