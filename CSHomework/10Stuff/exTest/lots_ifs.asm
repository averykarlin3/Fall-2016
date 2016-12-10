.CODE
.FALIGN
testIfs
	;; prologue
	STR R7, R6, #-2
	STR R5, R6, #-3
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R0, R5, #3
	ADD R6, R6, #-1
	STR R0, R6, #0
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #10
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testslots_ifs_COMP_GOOD_0
	CONST R0, #0
	JMP testslots_ifs_COMP_END_0
testslots_ifs_COMP_GOOD_0
	CONST R0, #1
testslots_ifs_COMP_END_0
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testslots_ifs_IF_0
	BRz testslots_ifs_ELSE_0
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #5
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testslots_ifs_COMP_GOOD_1
	CONST R0, #0
	JMP testslots_ifs_COMP_END_1
testslots_ifs_COMP_GOOD_1
	CONST R0, #1
testslots_ifs_COMP_END_1
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testslots_ifs_IF_1
	BRz testslots_ifs_ELSE_1
	ADD R6, R6, #-1
	CONST R0, #11
	HICONST R0, #0
	STR R0, R6, #0
	JMP testslots_ifs_ENDIF_1
testslots_ifs_ELSE_1
	ADD R6, R6, #-1
	CONST R0, #12
	HICONST R0, #0
	STR R0, R6, #0
testslots_ifs_ENDIF_1
	JMP testslots_ifs_ENDIF_0
testslots_ifs_ELSE_0
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #20
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testslots_ifs_COMP_GOOD_2
	CONST R0, #0
	JMP testslots_ifs_COMP_END_2
testslots_ifs_COMP_GOOD_2
	CONST R0, #1
testslots_ifs_COMP_END_2
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testslots_ifs_IF_2
	BRz testslots_ifs_ELSE_2
	ADD R6, R6, #-1
	CONST R0, #13
	HICONST R0, #0
	STR R0, R6, #0
	JMP testslots_ifs_ENDIF_2
testslots_ifs_ELSE_2
	ADD R6, R6, #-1
	CONST R0, #14
	HICONST R0, #0
	STR R0, R6, #0
testslots_ifs_ENDIF_2
testslots_ifs_ENDIF_0
	;; function epilogue
	LDR R0, R6, #0
	STR R0, R5, #2
	ADD R6, R5, #0
	ADD R6, R6, #2
	LDR R7, R5, #1
	LDR R5, R5, #0
	RET
.FALIGN
main
	;; prologue
	STR R7, R6, #-2
	STR R5, R6, #-3
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	ADD R6, R6, #-1
	CONST R0, #8
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 testIfs
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #4
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 testIfs
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #45
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 testIfs
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	;; function epilogue
	LDR R0, R6, #0
	STR R0, R5, #2
	ADD R6, R5, #0
	ADD R6, R6, #2
	LDR R7, R5, #1
	LDR R5, R5, #0
	RET
