;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;   OS - TRAP VECTOR TABLE   ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.OS
.CODE
.ADDR x8000
  ; TRAP vector table
  JMP TRAP_GETC           ; x00
  JMP TRAP_PUTC           ; x01
  JMP TRAP_PUTS           ; x02
  JMP TRAP_VIDEO_COLOR    ; x03
  JMP TRAP_DRAW_PIXEL     ; x04
  JMP TRAP_DRAW_LINE      ; x05
  JMP TRAP_DRAW_SPRITE    ; x06
  JMP TRAP_TIMER          ; x07
  JMP TRAP_GETC_TIMER     ; x08

  OS_KBSR_ADDR .UCONST xFE00  ; alias for keyboard status reg
  OS_KBDR_ADDR .UCONST xFE02  ; alias for keyboard data reg

  OS_ADSR_ADDR .UCONST xFE04  ; alias for display status register
  OS_ADDR_ADDR .UCONST xFE06  ; alias for display data register

  OS_TSR_ADDR .UCONST xFE08 ; alias for timer status register
  OS_TIR_ADDR .UCONST xFE0A ; alias for timer interval register

  OS_VIDEO_NUM_COLS .UCONST #128
  OS_VIDEO_NUM_ROWS .UCONST #124  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; OS DATA MEMORY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xA000
OS_GLOBALS_MEM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; OS VIDEO MEMORY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xC000 
OS_VIDEO_MEM .BLKW x3E00 ;128x124 words


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;   OS & TRAP IMPLEMENTATION   ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE
.ADDR x8200
.FALIGN
  ;; by default, return to usercode: PC=x0000
  CONST R7, #0   ; R7 = 0
  RTI            ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - none
;;; Outputs          - R0 = ASCII character from ASCII keyboard

.CODE
TRAP_GETC
    LC R0, OS_KBSR_ADDR  ; R0 = address of keyboard status reg
    LDR R0, R0, #0       ; R0 = value of keyboard status reg
    BRzp TRAP_GETC       ; if R0[15]=1, data is waiting!
                             ; else, loop and check again...

    ; reaching here, means data is waiting in keyboard data reg

    LC R0, OS_KBDR_ADDR  ; R0 = address of keyboard data reg
    LDR R0, R0, #0       ; R0 = value of keyboard data reg
    RTI                  ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTC   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a single character out to ASCII display
;;; Inputs           - R0 = ASCII character to write to ASCII display
;;; Outputs          - none

.CODE
TRAP_PUTC
  LC R1, OS_ADSR_ADDR 	; R1 = address of display status reg
  LDR R1, R1, #0    	; R1 = value of display status reg
  BRzp TRAP_PUTC    	; if R1[15]=1, display is ready to write!
		    	    ; else, loop and check again...

  ; reaching here, means console is ready to display next char

  LC R1, OS_ADDR_ADDR 	; R1 = address of display data reg
  STR R0, R1, #0    	; R1 = value of keyboard data reg (R0)
  RTI			; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_PUTS   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Put a string of characters out to ASCII display
;;; Inputs           - R0 = Address for first character
;;; Outputs          - none

.CODE
TRAP_PUTS
	TEMP .UCONST x2000 ;Store register
	LC R3 TEMP
	STR R0 R3 #0
	LDR R1 R0 #0 ;Get character
	CMPI R1 #0 ;Check if null character
	BRz END
	LC R3 OS_ADSR_ADDR ;Load constants
	LC R5 OS_ADDR_ADDR
	CONST R4 x0
	HICONST R4 x80
LOOP	LDR R2 R3 #0 ;Check if ready to print
	CMP R2 R4
	BRz ENDLOOP
ENDLOOP
	STR R1 R5 #0 ;Print character
	ADD R0 R0 #1 ;Move to next character
	BRnzp TRAP_PUTS
END
	LC R3 TEMP
	LDR R0 R3 #0	;Restore register
	RTI

;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_VIDEO_COLOR   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Set all pixels of VIDEO display to a certain color
;;; Inputs           - R0 = color to set all pixels to
;;; Outputs          - none

.CODE
TRAP_VIDEO_COLOR
	CONST R1 x00
	HICONST R1 xC0 ;Get initial pixel
	LC R3 OS_VIDEO_NUM_COLS ;Load constants
	LC R4 OS_VIDEO_NUM_ROWS
	MUL R2 R3 R4 ;Get first post-final pixel
	ADD R2 R1 R2
VLOOP	STR R0 R1 #0 ;Add value to pixel
	ADD R1 R1 #1 ;Move to next pixel
	CMP R1 R2 ;Check if done
	BRz ENDV
	BRnzp VLOOP
ENDV
RTI       ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_PIXEL   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draw point on video display
;;; Inputs           - R0 = row to draw on (y)
;;;                  - R1 = column to draw on (x)
;;;                  - R2 = color to draw with
;;; Outputs          - none

.CODE
TRAP_DRAW_PIXEL
  LEA R3, OS_VIDEO_MEM       ; R3=start address of video memory
  LC  R4, OS_VIDEO_NUM_COLS  ; R4=number of columns
  
  CMPIU R1, #0    	     ; Checks if x coord from input is > 0
  BRn END_PIXEL
  CMPIU R1, #127    	     ; Checks if x coord from input is < 127
  BRp END_PIXEL
  CMPIU R0, #0    	     ; Checks if y coord from input is > 0
  BRn END_PIXEL
  CMPIU R0, #123    	     ; Checks if y coord from input is < 123
  BRp END_PIXEL
  
  MUL R4, R0, R4      	     ; R4= (row * NUM_COLS)
  ADD R4, R4, R1      	     ; R4= (row * NUM_COLS) + col
  ADD R4, R4, R3      	     ; Add the offset to the start of video memory
  STR R2, R4, #0      	     ; Fill in the pixel with color from user (R2)
  
END_PIXEL
	CONST R3 x0		;Check for subtrap
	HICONST R3 x80
	CMP R3 R4
	BRnz RETURN_TRAP
	RTI       		     ; PC = R7 ; PSR[15]=0
RETURN_TRAP
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_LINE   ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draws line on the video screen
;;; Inputs           - R0 = x coordinate of start point
;;; Inputs           - R1 = y coordinate of start point
;;; Inputs           - R2 = x coordinate of the end point
;;; Inputs           - R3 = y coordinate of the end point
;;; Inputs           - R4 = color of line
;;; Outputs          - none
.CODE
TRAP_DRAW_LINE
	HICONST R6 x40 ;Store initial register values
	STR R0 R6 #0
	STR R1 R6 #1
	STR R2 R6 #2
	STR R3 R6 #3
	STR R4 R6 #4
	STR R7 R6 #5
	SUB R1 R3 R1 ;Check if y1-y0 > x1-x0
	SUB R0 R2 R0
	CMP R1 R0
	BRp SWAP
	CONST R5 #0
	STR R5 R6 #6 ;ST value storage
POSTSWAP1
	LDR R0 R6 #0 ;Check if x0 > x1
	LDR R1 R6 #1
	CMP R0 R1
	BRp SWAP2
POSTSWAP2
	LDR R0 R6 #0 ;Calculate Delta X
	LDR R1 R6 #2
	SUB R0 R1 R0
	STR R0 R6 #10 ;Delta X Storage
	LDR R0 R6 #1 ;Calculate Delta Y
	LDR R1 R6 #3
	CMP R1 R0
	BRn ABS
	SUB R0 R1 R0
	CONST R1 #1
POSTABS
	STR R0 R6 #11 ;Delta Y Storage
	STR R1 R6 #12 ;Y Step Storage
	CONST R5 #0 ;Initialize R5
	STR R5 R6 #15 ;Error Storage
	LDR R1 R6 #0  ;For Loop prep
	LDR R0 R6 #1
LOOPL	
	LDR R3 R6 #2
	CMP R1 R3     ;Check if For loop complete
	BRp POSTLOOP
	LDR R4 R6 #6 ;Load ST
	STR R1 R6 #13 ;Store Current X
	STR R0 R6 #14 ;Store Current Y
	LDR R2 R6 #4 ;Load color
	CMPI R4 #0 ;Check if ST (plot (y, x))
	BRp ST
	LEA R4 TRAP_DRAW_PIXEL
	JSRR R4 ;Draw pixel (x, y)
POSTST
	LDR R5 R6 #15 ;Add Delta Y to Error
	LDR R3 R6 #11
	ADD R5 R5 R3
	STR R5 R6 #15
	ADD R5 R5 R5 ;Check if 2*error >= Delta X
	LDR R4 R6 #10
	CMP R5 R4
	BRnp IF
POSTIF
	ADD R1 R1 #1 ;Move to next x value
	BR LOOPL
POSTLOOP
	LDR R7 R6 #5 ;Restore R7
	BR ENDL
IF
	ADD R0 R0 R4 ;y = y + ystep
	LDR R5 R6 #15
	SUB R5 R5 R4 ;error = error - deltax
	STR R5 R6 #15
	BR POSTIF
ST		;Plot (y, x) if ST
	ADD R5 R0 #0
	ADD R0 R1 #0
	ADD R1 R5 #0
	LEA R4 TRAP_DRAW_PIXEL
	JSRR R4
	BR POSTST
ABS
	SUB R0 R0 R1
	CONST R1 #-1
	BR POSTABS
SWAP			;Swap x0/y0 and x1/y1
	LDR R0 R6 #0
	LDR R1 R6 #1
	STR R1 R6 #0
	STR R0 R6 #1
	LDR R0 R6 #2
	LDR R1 R6 #3
	STR R1 R6 #2
	STR R0 R6 #3
	CONST R5 #1
	STR R5 R6 #6 ;ST Storage
	BR POSTSWAP1
SWAP2			;Swap x0/x1 and y0/y1
	LDR R0 R6 #0
	LDR R1 R6 #2
	STR R1 R6 #0
	STR R0 R6 #2
	LDR R0 R6 #1
	LDR R1 R6 #3
	STR R1 R6 #1
	STR R0 R6 #3
	BR POSTSWAP2
ENDL	
	RTI       		; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;   TRAP_DRAW_SPRITE   ;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Draws a circle on the video screen at a specific loc.
;;; Inputs           - R0 = x coordinate of top left corner of sprite
;;; Inputs           - R1 = y coordinate of top left corner of box
;;; Inputs           - R2 = color of the sprite
;;; Inputs           - R3 = starting address in data memory of sprite pattern
;;; Outputs          - none

.CODE
TRAP_DRAW_SPRITE
	ADD R4 R0 #0 ;Switch x and y coordinates
	ADD R0 R1 #0
	ADD R1 R4 #0
	STORAGE .UCOUNT x4000 ;Store initial registers
	XO .CONST x0
	YO .CONST x1
	COLOR .CONST x2
	OLDLOC .CONST x3
	CHECKER .CONST x4
	LC R6 STORAGE
	STR R0 R6 XO
	STR R1 R6 YO
	STR R2 R6 COLOR
	STR R7 R6 OLDLOC
	CONST R2 x01
YLOOP
	LDR R4 R6 Y0 ;Check if done with loop
	ADD R4 R4 #8
	CMP R4 R0
	BRz ENDY
	LDR R4 R3 #0 ;Load string for line
XLOOP
	LDR R5 R6 X0 ;Check if done with loop
	ADD R5 R5 #8
	CMP R5 R1
	BRz ENDX
	STR R2 R6 CHECKER ;Check if bit is filled
	OR R2 R3 R2
	CMPI R2 #0
	BRz POSTPIXEL
	LDR R2 R6 COLOR	;Color bit
	TRAP x04
POSTPIXEL
	ADD R1 R1 #1 ;Move to next pixel
	LDR R2 R6 CHECKER ;Move to next string bit
	SLL R2 R2 #1
	BR XLOOP
ENDX
	ADD R0 R0 #1 ;Move to next line
	ADD R3 R3 #1
	BR YLOOP
ENDY
	SUB R3 R3 #8
	LDR R0 R6 X0
	LDR R1 R6 Y0
	LDR R2 R6 COLOR
	RTI       ; PC = R7 ; PSR[15]=0


;;;;;;;;;;;;;;;;;;;;;;;;;   TRAP_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: 
;;; Inputs           - R0 = time to wait in milliseconds
;;; Outputs          - none

.CODE
TRAP_TIMER
  LC R1, OS_TIR_ADDR 	; R1 = address of timer interval reg
  STR R0, R1, #0    	; Store R0 in timer interval register

COUNT
  LC R1, OS_TSR_ADDR  	; Save timer status register in R1
  LDR R1, R1, #0    	; Load the contents of TSR in R1
  BRzp COUNT    	; If R1[15]=1, timer has gone off!

  ; reaching this line means we've finished counting R0 
    
  RTI       		; PC = R7 ; PSR[15]=0
  
  
;;;;;;;;;;;;;;;;;;;;;;;   TRAP_GETC_TIMER   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function: Get a single character from keyboard
;;; Inputs           - R0 = time to wait
;;; Outputs          - R0 = ASCII character from keyboard (or NULL)

.CODE
TRAP_GETC_TIMER
	LC R6 OS_TIR_ADDR ;Store wait time in timer
	STR R0 R6 #0
	LC R5 OS_KBSR_ADDR ;Load Constants
	LC R4 OS_KBDR_ADDR
	LC R3 OS_TSR_ADDR
	CONST R2 #0
	HICONST R2 x80
LOOPT
	LDR R0 R3 #0 ;Check if timer done
	CMP R0 R2
	BRzp NULL 
	LDR R0 R5 #0 ;Check if character ready
	CMP R0 R2
	BRzp CHAR
	BR LOOPT
NULL
	CONST R0 #0 ;Insert null character if timeout
	BR ENDT
CHAR
	LDR R0 R4 #0 ;Insert typed character
ENDT
RTI                  ; PC = R7 ; PSR[15]=0
