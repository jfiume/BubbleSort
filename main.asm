;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
		.data
List:	.byte 100, 25, 75, 80, 35, 2, 127, 60, 18, 40, 15, 66, 90, 66, 10, 115, 59, 50, 28, 41
numListElements:
		.byte 20
                                            
		.text
	clr.b R4		;set R4 to 0x00
	clr.b R5		;set R5 to 0x00
	clr.b R6		;set R5 to 0x00
	clr.b R7		;set R5 to 0x00
	clr.b R8		;set R5 to 0x00
	mov.b #-1, R4	;move 0xFF to R4

sort:
	tst.b R4		;test if R4 is 0
	jz    end		;if R4 is 0 then jump to the end, the list is sorted
	mov.b #0, R7	;move 0x00 to R7, this will serve as index 1
	mov.b #1, R8	;move 0x01 to R8, this will serve as index 2
	mov.b #0, R4	;move 0x00 to R4, this will count the number of swaps though the list

next:
	mov.b @R7(List), R5		;move the element in the list corresponding to the index in R7 to R5
	mov.b @R8(List), R6		;move the element in the list corresponding to the index in R8 to R6
	cmp.b R5, R6			;compare list element i to i+1
	jge   incNums			;if R6 is larger or equal to R5 then we jump to incrementing the indexes, no swaps are made

swapNums:
	mov.b R6, @R7(List)		;swap the elements of the list, i -> i+1
	mov.b R5, @R8(List)		;swap the elements of the list, i+1 -> i
	inc.b R4				;add one to the count of swaps

incNums:
	inc.b R7				;increment index 1
	inc.b R8				;increment index 2
	cmp.b R8, numListElements	;compare index 2 to the total number of elements in the list
	jz    sort				;if it is 0 then we have reached the end of the list and jump back to the beginning
	jmp   next				;if we have not reached the end of the list, then we continue to compare the next two elements

end:
	NOP						;end of program
;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
