#include <bits/stdc++.h>
using namespace std;
#define jumps 3
#define blocks 4
int main(){
	printf( "#############################resolving process starts############################\n"
			"li      $a1, 'A'                   #marker\n"
			"lw      $t4, 0($a0)                #row\n"
        	"lw      $t5, 4($a0)                #col\n\n"
        	"mul     $t8, $t4, $t5              #size\n"
        	"add     $t8, $t8, $a0              #base address - 8 for bitboard\n\n"
        	"li      $a2, 0                     #a2 = i\n"
	);
	printf(	"i_outer_loop:\n"
        	"beq     $a2, $t4, i_outer_end\n"
        	"mul     $t0, $a2, $t5\n"
        	"add     $t6, $t0, $a0              #puzzle address - 8 for each row\n\n"
        	"li      $a3, 0                     #a3 = j\n"
        	"li      $s2, 8						#start of each block\n"
	);
	for (int i = 0; i < blocks;i++){
		printf(	"######block %d starts\n", i);
		printf(	"puzzle_block%d:\n", i);
		if (i != 0)
			printf(	"add     $s2, $s2, 8\n");
		
		printf(	"######prepare jumptable\n"
				"lbu     $t0, %d($t8)\n"
				"sll     $t0, $t0, 2\n"
				"add     $s3, $s4, $t0              #s4 : jumpboard base address\n"
				"######\n\n"
		,8+i);
		printf(	"lb      $t0, 8($t6)\n");
		printf(	"bne     $t0, $t9, puzzle_jump%d_0\n", i);	
		printf(	"move    $t2, $t6\n");
		printf( "jal     floodfill_real\n"
				"add     $a1, $a1, 1\n");
		for (int j = 0; j < jumps;j++){
			printf(	"######jump %d %d starts\n", i, j);
			
			printf(	"puzzle_jump%d_%d:\n", i, j);
			
			printf(	"lb      $t1, %d($s3)\n", j);
			printf(	"add     $a3, $a3, $t1\n"
        			"add     $t6, $t6, $t1\n");
					
			if (i != blocks - 1)
				printf(	"beq     $a3, $s2, puzzle_block%d\n", i+1);
			else
				printf(	"beq     $a3, $s2, puzzle_line_end\n");	
				
			printf("lb      $t0, 8($t6)\n");
			if (j != jumps - 1)
				printf(	"bne     $t0, $t9, puzzle_jump%d_%d\n", i, j+1);
			else if (i != blocks - 1)
				printf(	"bne     $t0, $t9, puzzle_block%d\n", i+1);
			else 
				printf(	"bne     $t0, $t9, puzzle_line_end\n");
			
			printf(	"move    $t2, $t6\n");
			printf( "jal     floodfill_real\n"
					"add     $a1, $a1, 1\n");
			
			printf(	"######\n");
		}
		printf(	"######\n\n");
	}
	printf(	"puzzle_line_end:\n"
		"add     $t8, $t8, %d\n"
		"add     $a2, $a2, 1\n"
		"j       i_outer_loop\n\n"
		"i_outer_end:\n", blocks);
	
	printf( "#############################resolving process ends############################\n");
	return 0;
}
