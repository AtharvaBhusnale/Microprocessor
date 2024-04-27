section .data
	msg1 db 10,13,"Enter 5 64-bit numbers:",0ah
	msg1_len equ $-msg1
	msg2 db 10,13,"The entered 5 64-bit numbers are:",0ah
	msg2_len equ $-msg2

section .bss
	array resd 200
	counter resb 1

section .text
	global _start
	_start:
		;code to display mesaage 1
		mov rax,1
		mov rdi,1
		mov rsi,msg1
		mov rdx,msg1_len
		syscall
    
		;code to accept no.
		mov byte[counter],05
		mov rbx,00
		loop1:
			mov rax,0 ; 0 for read
			mov rdi,0 ; 0 for keyboard
			mov rsi, array ;move pointer to start of array
			add rsi,rbx
			mov rdx,17
			syscall
			add rbx,17 ;to move counter
			dec byte[counter]
			JNZ loop1

		;code to display message 2
		mov Rax,1
		mov Rdi,1
		mov Rsi,msg2
		mov Rdx,msg2_len
		syscall

		;code to display the accepted no.
		mov byte[counter],05
		mov rbx,00
		loop2:
			mov rax,1 ;1 for write
			mov rdi, 1 ;1 for monitor
			mov rsi, array
			add rsi,rbx
			mov rdx,17 ;16 bit +1 for enter
			syscall
			add rbx,17
			dec byte[counter]
			JNZ loop2
		;exit system call
		mov rax ,60
		mov rdi,0
		syscall

;OUTPUT
;student@ioe-hwlab:~$ nasm -f elf64 MPexp1.asm
;student@ioe-hwlab:~$ ld -o prog MPexp1.o
;student@ioe-hwlab:~$ ./prog

;Enter 5 64-bit numbers:
;1
;1
;2
;3
;4

;The entered 5 64-bit numbers are:
;1
;1
;2
;3
;4
