section .data
        nline 		db	10,10
	nline_len	equ	$-nline
	space		db	" "
	ano		 db      10,"	Block Transfer overlapped with String instruction.",
		ano_len		equ	$-ano
	bmsg		db	10,"Before Transfer::"
	bmsg_len	equ	$-bmsg
	amsg		db	10,"After Transfer::"
	amsg_len	equ	$-amsg
		smsg		db	10,"	Source Block		:"
	smsg_len	equ	$-smsg
	dmsg		db	10,"	Destination Block	:"
	dmsg_len	equ	$-dmsg
	sblock		db	01h,02h,33h,45h,50h
	dblock		times	5	db	0
	section .bss
	char_ans resB	2	;char_ans is of 2 byte because we have 2 byte nos
	
;-----------------------------------------------------------------------------

%macro	Print	2
	 MOV	RAX,1
	 MOV	RDI,1
         MOV	RSI,%1
         MOV	RDX,%2
    syscall
%endmacro

%macro	Read	2
	 MOV	RAX,0
	 MOV	RDI,0
         MOV	RSI,%1
         MOV	RDX,%2
    syscall
%endmacro


%macro Exit 0
	Print	nline,nline_len
	MOV	RAX,60
        MOV	RDI,0
    syscall
%endmacro

section .text
	global _start
_start:
       	Print	ano,ano_len
	Print	bmsg,bmsg_len	;Block values before transfer
	Print 	smsg,smsg_len
	mov	rsi,sblock	;As rsi is used to point source as well as destination block
	call	disp_block	;assign source and destination block separately before call
	Print	dmsg,dmsg_len
	mov	rsi,dblock
	call	disp_block
		call	BT_NO		;call for actual block transfer

	Print	amsg,amsg_len	;Block values after transfer 

	Print 	smsg,smsg_len
	mov	rsi,sblock
	call	disp_block
	Print	dmsg,dmsg_len
	mov	rsi,dblock
	call	disp_block
Exit
BT_NO:
	ws:
    mov rsi,sblock
    mov rdi,dblock
    mov rcx,05
                                                          
     cld                                
     rep movsb
RET
;-----------------------------------------------------------------
disp_block:
	mov	rbp,5		;counter as 5 values

next_num:
	mov	al,[rsi]	;moves 1 value to rsi
	push	rsi		;push rsi on stack as it get modified in Disp_8

	call	Disp_8(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 

	Print	space,1
	
	pop	rsi		;again pop rsi that pushed on stack
	inc	rsi
	
	dec	rbp
	jnz	next_num
RET
;---------------------------------------------------------------
Disp_8:(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 

	MOV	RSI,char_ans+1
	MOV	RCX,2           ;counter
	MOV	RBX,16		;Hex no
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 

next_digit:
	XOR	RDX,RDX
	DIV	RBX

	CMP	DL,9	
	JBE	add30
	ADD	DL,07H

add30	:
	ADD	DL,30H(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 

	MOV	[RSI],DL
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ nasm -f elf64 MPexp9.asm
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ld -o prog MPexp9.o
(base) student@ioe-hwlab:~/Desktop/A_15_Piyush_Chandwani$ ./prog

	Block Transfer overlapped with String instruction.
Before Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:00 00 00 00 00 
After Transfer::
	Source Block		:01 02 33 45 50 
	Destination Block	:01 02 33 45 50 

	DEC	RSI
	DEC	RCX
	JNZ	next_digit

	Print	char_ans,2
ret

;output

;(base) student@ioe-hwlab:~$ nasm -f elf64 MPexp9.asm
;(base) student@ioe-hwlab:~$ ld -o prog MPexp9.o
;(base) student@ioe-hwlab:~$ ./prog

;	Block Transfer overlapped with String instruction.
;Before Transfer::
;	Source Block		:01 02 33 45 50 
;	Destination Block	:00 00 00 00 00 
;After Transfer::
;	Source Block		:01 02 33 45 50 
;	Destination Block	:01 02 33 45 50 
