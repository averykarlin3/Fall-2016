;;; OS Code
  .OS
  .CODE
  .ADDR x8000

; the TRAP vector table
  JMP TRAP_GETC         ; x00
  JMP TRAP_PUTC         ; x01
  JMP TRAP_PUTS         ; x02
  JMP BAD_TRAP          ; x03
  JMP BAD_TRAP          ; x04
  JMP BAD_TRAP          ; x05
  JMP TRAP_DRAW_SPRITE  ; x06
  JMP TRAP_DRAW_LINE    ; x07
  JMP TRAP_GETC_TIMER   ; x08	
  JMP TRAP_LFSR_SET_SEED; x09
  JMP TRAP_LFSR         ; X0A
  JMP BAD_TRAP          ; x0B
  JMP BAD_TRAP          ; x0C
  JMP BAD_TRAP          ; x0D
  JMP BAD_TRAP          ; x0E
  JMP BAD_TRAP          ; x0F
  JMP BAD_TRAP          ; x10
  JMP BAD_TRAP          ; x11
  JMP BAD_TRAP          ; x12
  JMP BAD_TRAP          ; x13
  JMP BAD_TRAP          ; x14
  JMP BAD_TRAP          ; x15
  JMP BAD_TRAP          ; x16
  JMP BAD_TRAP          ; x17
  JMP BAD_TRAP          ; x18
  JMP BAD_TRAP          ; x19
  JMP BAD_TRAP          ; x1A
  JMP BAD_TRAP          ; x1B
  JMP BAD_TRAP          ; x1C
  JMP BAD_TRAP          ; x1D
  JMP BAD_TRAP          ; x1E
  JMP BAD_TRAP          ; x1F
  JMP BAD_TRAP          ; x20
  JMP BAD_TRAP          ; x21
  JMP BAD_TRAP          ; x22
  JMP BAD_TRAP          ; x23
  JMP BAD_TRAP          ; x24
  JMP BAD_TRAP          ; x25
  JMP TRAP_RESET_VMEM   ; x26
  JMP TRAP_BLT_VMEM     ; x27

;;; OS memory address constants
USER_CODE_ADDR 	.UCONST x0000
OS_CODE_ADDR 	.UCONST x8000

OS_GLOBALS_ADDR .UCONST xA000
OS_STACK_ADDR 	.UCONST xBFFF
OS_VIDEO_ADDR 	.UCONST xC000
				
OS_KBSR_ADDR	.UCONST xFE00   ; keyboard status register
OS_KBDR_ADDR	.UCONST xFE02   ; keyboard data register

OS_ADSR_ADDR	.UCONST xFE04   ; display status register
OS_ADDR_ADDR	.UCONST xFE06   ; display data register

OS_TSR_ADDR	.UCONST xFE08   ; timer register
OS_TIR_ADDR	.UCONST xFE0A   ; timer interval register

OS_VDCR_ADDR .UCONST xFE0C      ; video display control register

OS_VIDEO_NUM_COLS .UCONST #128
OS_VIDEO_NUM_ROWS .UCONST #124

TIM_INIT 	.UCONST #100

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;   OS & TRAP IMPLEMENTATION   ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
.CODE
.ADDR x8200
OS_START
  ;; initialize timer
  LC R0, TIM_INIT
  LC R1, OS_TIR_ADDR
  STR R0, R1, #0

  ;; R7 <- User code address (x0000)
  LC R7, USER_CODE_ADDR 
  RTI ; RTI removes the privilege bit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; OS VIDEO MEMORY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xC000 
OS_VIDEO_MEM .BLKW x3E00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; OS DATA MEMORY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.DATA
.ADDR xA000
;;;  LFSR value used by lfsr code
LFSR .FILL 0x0001

OS_GLOBALS_MEM	.BLKW x1000

.CODE
BAD_TRAP
	JMP OS_START 	; restart machine

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_RESET_VMEM - In double-buffered video mode, resets the video
;;; display, i.e., turns it to black.
;;; Inputs - none
;;; Outputs - none

.CODE	
TRAP_RESET_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #1
  STR R5, R4, #0
  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_BLT_VMEM - In double-buffered video mode, copies the contents
;;; of video memory to the video display.
;;; Inputs - none
;;; Outputs - none

.CODE
TRAP_BLT_VMEM
  LC R4, OS_VDCR_ADDR
  CONST R5, #2
  STR R5, R4, #0
  RTI
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_GETC - Check for a character from the keyboard
;;; Inputs - none
;;; Outputs - R0: the value of the KBSR 
;;;             - the MSB is 1 if a character was read
;;; 	      R1: the value of the character read from the keyboard

.CODE
TRAP_GETC
  LC R4, OS_KBSR_ADDR
  LDR R0, R4, #0		; Read the KBSR into R0
  BRzp GETC_END		; Check if the MSB is zero

  LC R4, OS_KBDR_ADDR
  LDR R1, R4, #0		; Read the character into R1

GETC_END
  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_PUTC - Put a character on the console
;;; Inputs - R0: ASCII character value to be output
;;; Outputs - none

.CODE
TRAP_PUTC
  LC R4, OS_ADSR_ADDR
  LDR R1, R4, #0
  BRzp TRAP_PUTC		; Loop while the MSB is zero

  LC R4, OS_ADDR_ADDR
  STR R0, R4, #0		; Write out the character

  RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_PUTS - for writing null-terminated string to ASCII display
;;; Inputs - R0: address of first character in string
;;; Outputs - none

.CODE
TRAP_PUTS
	RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_GETC_TIMER - for getting single character from keyboard
;;; Inputs - R0: time to wait
;;; Outputs - R0: character from keyboard or 0 otherwise


.CODE
TRAP_GETC_TIMER
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_LFSR - returns a shifted bit pattern
;;; Inputs - none
;;; Outputs - R0: shifted bit pattern

.CODE
TRAP_LFSR
  LEA R3, LFSR
  LDR R0, R3, 0

  SLL R1, R0, 2	  ; move bit 13 to MSB
  XOR R2, R0, R1  ; xor with bit 15

  SLL R1, R0, 3	  ; move bit 12 to MSB
  XOR R2, R1, R2

  SLL R1, R0, 5	  ; move bit 10 to MSB
  XOR R2, R1, R2

  SRL R2, R2, 15  ; Shift right logical move MSB to LSB and zeros elsewhere

  SLL R0, R0, 1	  ; shift left by one bit
  OR  R0, R0, R2  ; add in the LSB - note upper bits of R2 are all 0

  STR R0, R3, 0	  ; update the LFSR in memory

  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_LFSR_SET_SEED - sets the seed value used by TRAP_LFSR
;;; Inputs - R0: initial value
;;; Outputs - none

.CODE
TRAP_LFSR_SET_SEED
  LEA R3, LFSR

  STR R0, R3, #0

  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_DRAW_SPRITE - draws an 8x8 sprite on the screen. 
;;; Inputs - R0: video column (left) 
;;;          R1: video row (upper) 
;;;          R2: color 
;;;          R3: Address of sprite bitmap - an array of 8 words 
;;; Outputs - video memory will be updated to include sprite 

.CODE 
TRAP_DRAW_SPRITE 
  RTI


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; TRAP_DRAW_LINE - draws a line
;;; Inputs -  R0: (x0)
;;;           R1: (y0)
;;;           R2: (x1)
;;;           R3: (y1)
;;;           R4: color
;;; Outputs - video memory will be updated 

.CODE
TRAP_DRAW_LINE
  RTI

