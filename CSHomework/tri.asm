;; Triangles
;; A = Input, B = Output
;; R0, R1, R2 = Triangle Edges, R3 = Output

	.CODE		; Begin code segment
	.ADDR  0x0000	; Start adding instructions at address 0x00
MAIN
	LEA R6 ROWNUM
	STR R0 R4 #0 ;Store initial values
	STR R1 R4 #1
	STR R2 R4 #2
	JSRR R6 ;Store row numbers of each value
	STR R1 R4 #3
	LDR R0 R4 #1
	JSRR R6
	STR R1 R4 #4
	LDR R0 R4 #2
	JSRR R6
	STR R1 R4 #5
	LDR R0 R4 #4	;Check if last two rows are equal
	LDR R1 R4 #5
	CMP R0 R1
	BRnp END
	LDR R0 R4 #1 	;Find length of base and store in R0
	LDR R1 R4 #2
	SUB R0 R1 R0
	LDR R1 R4 #0	;Check if left side exists
	LDR R2 R4 #1
	LDR R5 R4 #3
	LDR R6 R4 #4
WHILE	
	CMP R6 R5
	BRz ENDWHILE
	ADD R1 R1 R5
	ADD R5 R5 #1
	BRnzp WHILE
ENDWHILE
	CMP R1 R2
	BRnp END
	LDR R5 R4 #3	;Check if left side is equal
	SUB R7 R6 R5
	CMP R7 R0
	BRnp END
	ADD R3 R3 #1	;Increment R3
	BRnzp END
ROWNUM			;Find row number of each value
	CONST R1 #1
	CONST R2 #1
ROWNUMLOOP
	CMP R2 R0
	BRp PCJUMP
	ADD R1 R1 #1
	ADD R2 R2 R1
	BRnzp ROWNUMLOOP
PCJUMP			;Return to next PC of main
	RET
END
