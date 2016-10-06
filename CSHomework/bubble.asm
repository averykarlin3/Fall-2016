;; Bubble Sort
;; R0 = Starting Address, R1 = Ending Address
	.CODE		;Begin code segment
	.ADDR  0x0000	;Start filling in instructions at address 0x00
	ADD R2 R0 #0    ;Initialize as counter
MAIN			;Main function generating numbers for the region
	SUB R3 R1 R2
	STR R3 R2 #0 
	ADD R2 R2 #1
	CMP R2 R1	;Check if done
	BRn MAIN
BSORT			;Bubble sort function
	ADD R3 R0 #0	;Initialization
NEXTLOOP
	LDR R4 R3 #0	;Load
	LDR R5 R3 #1
	CMP R5 R4	;Check order of first two items
	BRn SWITCH
POSTSWITCH
	ADD R3 R3 #1	;Move to next
	CMP R3 R2 	;Check if done with cycle
	BRz NEXT
	CMP R2 R0 	;Check if done
	BRn BSORT
	BRnzp END
SWITCH			;Switch items
	STR R5 R3 #0
	STR R4 R3 #1
	BRnzp POSTSWITCH
NEXT			;Next cycle
	ADD R2 R2 #-1
	BRnzp NEXTLOOP
END
