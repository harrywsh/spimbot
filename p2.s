.text

##struct Puzzle {
##    int NUM_ROWS;
##    int NUM_COLS;
##    char** board;
##};
##
##
##char floodfill (Puzzle* puzzle, char marker, int row, int col) {
##    if (row < 0 || col < 0) {
##        return marker;
##    }
##
##    if (row >= puzzle->NUM_ROWS || col >= puzzle->NUM_COLS) {
##        return marker;
##    }
##
##    char ** board = puzzle->board;
##    
##    if (board[row][col] != '#') {
##        return marker;
##    }
##
##    board[row][col] = marker;
##
##    floodfill(puzzle, marker, row + 1, col + 1);
##    floodfill(puzzle, marker, row + 1, col + 0);
##    floodfill(puzzle, marker, row + 1, col - 1);
##
##    floodfill(puzzle, marker, row, col + 1);
##    floodfill(puzzle, marker, row, col - 1);
##
##    floodfill(puzzle, marker, row - 1, col + 1);
##    floodfill(puzzle, marker, row - 1, col + 0);
##    floodfill(puzzle, marker, row - 1, col - 1);
##
##    return marker + 1;
##}

.globl floodfill
floodfill:
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
    lw $t2, 8($a0)                  # char** board = puzzle->board;
    sll $t4, $a2, 2
    add $t2, $t2, $t4
    lw $t2, 0($t2)
    add $t2, $t2, $a3               # $t2 = &board[row][col];
    lbu $t3, 0($t2)                 # $t3 = board[row][col];
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
    

	
	
	
	
##void 
##floyd_warshall (int graph[6][6], int shortest_distance[6][6]) { 
##    for (int i = 0; i < 6; ++i) {
##        for (int j = 0; j < 6; ++j) {
##			if (i == j) {
##				shortest_distance[i][j] = 0;
##			} else {
##				shortest_distance[i][j] = graph[i][j]; 
##			}
##		}
##	}
##    for (int k = 0; k < 6; k++) {
##        for (int i = 0; i < 6; i++) {
##            for (int j = 0; j < 6; j++) {
##				if (shortest_distance[i][k] + shortest_distance[k][j] < shortest_distance[i][j]) {
##					shortest_distance[i][j] = shortest_distance[i][k] + shortest_distance[k][j]; 
##				}
##            } 
##        } 
##    } 
##}

.globl floyd_warshall
floyd_warshall:
    li $t0, 0               # int i = 0;
for_1_out:
    bge $t0, 6, end_1_out
    li $t1, 0               # int j = 0;
for_1_in:
    bge $t1, 6, end_1_in
    mul $t2, $t0, 6
    add $t2, $t2, $t1       # $t2 = 6 * i + j;
    sll $t2, $t2, 2
    add $t3, $t2, $a1       # $t3 = &shortest_distance[i][j];
    bne $t0, $t1, else
    sw $zero, 0($t3)        # shortest_distance[i][j] = 0;
    j increment_j
else:
    add $t4, $t2, $a0
    lw $t4, 0($t4)
    sw $t4, 0($t3)          # shortest_distance[i][j] = graph[i][j];
increment_j:
    addi $t1, $t1, 1        # ++j;
    j for_1_in
end_1_in:
    addi $t0, $t0, 1        # ++i;
    j for_1_out

end_1_out:
    li $t0, 0               # int k = 0;
for_2_out:
    bge $t0, 6, end_2_out
    li $t1, 0               # int i = 0;
for_2_mid:
    bge $t1, 6, end_2_mid
    li $t2, 0               # int j = 0;
for_2_in:
    bge $t2, 6, end_2_in
    mul $t3, $t1, 6
    add $t3, $t3, $t0       # $t3 = 6 * i + k;
    sll $t3, $t3, 2
    add $t3, $t3, $a1
    lw $t3, 0($t3)          # $t3 = shortest_distance[i][k];

    mul $t4, $t0, 6
    add $t4, $t4, $t2       # $t4 = 6 * k + j;
    sll $t4, $t4, 2
    add $t4, $t4, $a1
    lw $t4, 0($t4)          # $t4 = shortest_distance[k][j];

    add $t3, $t3, $t4       # $t3 = shortest_distance[i][k] + shortest_distance[k][j];

    mul $t4, $t1, 6
    add $t4, $t4, $t2       # $t4 = 6 * i + j;
    sll $t4, $t4, 2
    add $t4, $t4, $a1       # $t4 = &shortest_distance[i][j];
    lw $t5, 0($t4)          # $t5 = shortest_distance[i][j];
    bge $t3, $t5, increment_j_in
    sw $t3, 0($t4)
increment_j_in:
    addi $t2, $t2, 1
    j for_2_in
end_2_in:
    addi $t1, $t1, 1
    j for_2_mid
end_2_mid:
    addi $t0, $t0, 1
    j for_2_out
end_2_out:
	jr $ra
