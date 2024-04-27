section .data
	msg1 db 10,13,"Enter a string::"
	len1 equ $-msg1

section .bss
	str1 resb 200   
	result resb 16

section .text

	global _start
	_start:

	;display
		mov rax,1
		mov rdi,1
		mov rsi,msg1
		mov rdx,len1
		syscall

	;storing the string
		mov rax,0
		mov rdi,0
		mov rsi,str1
		mov rdx,200
		syscall

	call display

	;exit system call
		mov rax,60
		mov rdi,60
		syscall

	%macro dispmsg 2
		mov rax,1
		mov rdi,1
		mov rsi,%1
		mov rdx,%2
		syscall
	%endmacro

	display:
		mov rbx,rax            ; store no in rbx
		mov rdi,result         ;point rdi to result variable 
		mov cx,16              ;load count of rotation in cl 

	up1: 
		rol rbx,04               ;rotate no of left by four bits
		mov al,bl	         ; move lower byte in al		
		and al,0fh               ;get only LSB
		cmp al,09h               ;compare with 39h
		jg add_37                ;if greater than 39h skip add 37    
		add al,30h                
		jmp skip                 ;else add 30      

	add_37:
		add al,37h

	skip:

		mov [rdi],al       ;store ascii code in result variable
		inc rdi            ; point to next byte
		dec cx             ; decrement counter
		jnz up1            ; if not zero jump to repeat
		dispmsg result,16        ;call to macro
		ret


;OUTPUT:
;student@ioe-hwlab:~$ nasm -f elf64 MPexp2.asm
;student@ioe-hwlab:~$ ld -o exp MPexp2.o
;student@ioe-hwlab:~$ ./exp

;Enter a string::hello brother
;000000000000000E
