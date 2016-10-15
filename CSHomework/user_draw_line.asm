;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File:    USER_DRAW_LINE.ASM
;;; Purpose: Draw a horizontal line starting at x=COL, y=ROW
;;;	     Uses trap: TRAP_DRAW_PIXEL in os.asm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;  Define constants the user could set prior to running program
ROW .CONST 40	; start at y=40
COL .CONST 40	; start at x=40
LEN .CONST 40	; draw a 40 pixel long horizontal line

;;;  Define some colors
RED   .UCONST x7C00	; 0 11111 00000 00000
GREEN .UCONST x03E0	; 0 00000 11111 00000
BLUE  .UCONST x001F	; 0 00000 00000 11111
WHITE .UCONST x7FFF	; 0 11111 11111 11111
	

.CODE
.ADDR x0000

	;; setup initial arguments for TRAP
	;;
	LC R0, ROW		; set row to draw on
	LC R1, COL		; set first column to draw on
	LC R2, RED		; set color for line
	LC R5, LEN		; initalize loop counter
LOOP	
	TRAP x04		; call TRAP_DRAW_PIXEL
	ADD R1, R1, #1		; increase column by 1
	ADD R5, R5, #-1		; decrement loop counter by 1
	BRp LOOP

END