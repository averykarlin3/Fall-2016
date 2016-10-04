;; Fibonacci
;; R3 = location, R2 = counter, R0 = F_(n-1), R1 = F_n

	.DATA ;Begin data segment
	.ADDR 0x4000 ;Start adding data at x4000
	;;.BLKW #20 ;Allocate 20 spots for numbers
	;;.ADDR 0x4000 ;Move back to start of data
	.FILL #0 ;Add F_0
	.FILL #1 ;Add F_1
	.CODE		; Begin code segment
	.ADDR 0x0000	; Start filling in instructions at address 0x00
WHILE
	CMPI R2 #0 ;
	BRnz END ; Break if 0 or less counter
	ADD R4 R0 R1 ;Adds registers into temp R4
	ADD R0 R1 #0 ;Move R1 to R0
	ADD R1 R4 #0 ;Move R4
	ADD R3 R3 #1 ;R3 = R3 + 1
	STR R1 R3 #0 ;Add R1 to memory
	ADD R2 R2 #-1 ;R2 = R2 - 1
	BRnzp WHILE
END
