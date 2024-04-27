section .data

	welmsg db 10,'Welcome to count positive and negative numbers in an array',10
	welmsg_len equ $-welmsg

	pmsg db 10,'Count of +ve numbers::'
	pmsg_len equ $-pmsg

	nmsg db 10,'Count of -ve numbers::'
	nmsg_len equ $-nmsg

	nwline db 10

	array dw 8505h,90ffh,87h,88h,8a9fh,0adh,02h,8507h

	arrcnt equ 8

	pcnt db 0
	ncnt db 0

section .bss
	dispbuff resb 2

%macro print 2                  ;defining print function
	mov eax, 4              ; this 4 commands signifies the print sequence
	mov ebx, 1                               
	mov ecx, %1             ; first parameter
	mov edx, %2             ;second parameter
	int 80h                 ;interrupt command      
%endmacro

section .text
	global _start       ;must be declared for linker
	_start:            ;tells linker the entry point ;i.e start of code
	print welmsg,welmsg_len   ;print title
	mov esi,array
	mov ecx,arrcnt       ;store array count in extended counter reg    


up1:                         ;label
	bt word[esi],15
	;bit test the array number (15th byte) pointed by esi. 
	;It sets the carray flag as the bit tested
	jnc pnxt     ;jump if no carry to label pskip
	inc byte[ncnt]   ;if the 15th bit is 1 it signifies it is a ;negative no and so we ;use this command 		to increment ncnt counter.
	jmp pskip       ;unconditional jump to label skip

	pnxt: inc byte[pcnt]    ;label pnxt if there no carry then it is ;positive no 
	;and so pcnt is incremented
	pskip: inc esi         ;increment the source index but this ;instruction only increments it by 8 bit 		but the no’s in array ;are 16 bit word and hence it needs to be incremented twice.

	inc esi
	loop up1       ;loop it ends as soon as the array end “count” or 

	;ecx=0 loop automatically assums ecx has the counter

	print pmsg,pmsg_len      ;prints pmsg
	mov bl,[pcnt]    ;move the positive no count  to lower 8 bit of B reg 
	call disp8num            ;call disp8num subroutine
	print nmsg,nmsg_len         ;prints nmsg 
	mov bl,[ncnt]    ;move the negative no count to lower 8 bits of b reg
	call disp8num        ;call disp8num subroutine


	print nwline,1        ;New line char

	exit:
	mov eax,01
	mov ebx,0
	int 80h

	disp8num:
	mov ecx,2        ;move 2 in ecx ;Number digits to display
	mov edi,dispbuff               ;Temp buffer

		dup1:      ;this command sequence which converts hex to bcd
		rol bl,4  	;Rotate number from bl to get MS digit to LS digit
	mov al,bl         ;Move  bl i.e. rotated number to AL
	and al,0fh          ;Mask upper digit (logical AND the contents ;of lower8 bits of accumulator with 		0fh )

	cmp al,09          ;Compare al with 9

	      jbe dskip  	;If number below or equal to 9 go to add only 30h
	     ;add al,07h ;Else first add 07h to accumulator
		
	dskip:
	      add al,30h        ;Add 30h to accumulator 
		 mov [edi],al           ;Store ASCII code in temp buff (move contents       ;of accumulator to 		the location pointed by edi)
	inc edi 	;Increment destination index i.e. pointer to      ;next location in temp buff
	loop dup1         ;repeat till ecx becomes zero

	print dispbuff,2         ;display the value from temp buff
	ret                      ;return to calling program

;OUTPUT
;(base) student@ioe-hwlab:~$ nasm -f elf64 MPexp5.asm
;(base) student@ioe-hwlab:~$ ld -o prog MPexp5.o
;(base) student@ioe-hwlab:~$ ./prog

;Welcome to count positive and negative numbers in an array

;Count of +ve numbers::04
;Count of -ve numbers::04
