;; Multiplication program
;; C = A*B
;; R0 = A, R1 = B, R2 = C

	.DATA		; This is a code segment
	.ADDR  0x4000	; Start filling in instructions at address 0x00
	.BLKW #15
	.FILL 0x1
	.CODE
	.ADDR 0x0000
	CONST R1, #2
	CONST R0, #3
	CONST R2, #0    ; Initialize C to 0
	

LOOP

	CMPI R1, #0	; Compare B to 0
	Sell2
	BRNZ END 
	STEP3	; if (B <= 0) Branch to the end

	ADD R2, R2, R0	; C = C + A

STEP4
	Add R1, R1, #-1	; B =  B - 1

	BR LOOP	; Go back to the beginning of the loop

END


;.ADDR sets the current memory address being set by the code for storing instructions/data in assembly
;Labels are put unindented before a line to signify that line being written as a label
;.Fill automatically does .ADDR + 1 after
;CODE and DATA determine where can be written at any given time
;.BLKW moves the cursor to after the block, setting all to 0 in between
;Tabs don't matter, but new lines do
;Labels and functions are automatically made all capital if not put so, except BRnzp, the three (or less) are put lower case
;BR = BRnpz
;BLKW starts with the current unincremented location - Makes it so assembler can't set other - Software can, not assembler


;MOD not working
