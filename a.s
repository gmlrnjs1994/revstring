
;KITRI BOB 6th
;Consulting Track
;Cho Hui Gwon

global _start

section .data
	addr 	dw 2
		db 05h, 39h
		db 0dh, 7ch, 4bh, 14h
	addrlen db 16	
section .text

_start:
		;push rbp
		;mov rbp, rsp
		;sub rsp, 0x420	;	buffer[1024]
	
	mov rax, 0x29
	mov rdi, 2	; AF_INET
	mov rsi, 1	; socket stream
	mov rdx, 0	
	syscall		; socket open
	
		;mov r8, rax	; r8 -> client_socket
		;mov [rbp-0x4], rax
		;mov rax, 2
		;mov [rbp-0x20], rax
	
		;mov rdi, rax
	mov rdi, rax	; fd	
	mov rsi, addr	; 0x7fffffffe0c0
	mov rdx, 0x10
	mov rax, 42
	syscall		; connet open

		;mov [rbp-0x8], rax
		;lea rcx, [rbp-0x420]	; rcx <- buffer[1024]
		;mov rax, [rbp-0x4]	; rax <- client_socke

	sub rsp, 0x40	; 64 byte area is maked
	mov rdx, 0x3f	; 0x400
	mov rsi, rsp	; rcx
		;mov rsi, rsp
	mov rdi, 0x3
	mov r8, addr
	mov r9, addrlen
	mov r10, 0
	mov rax, 45
	syscall		; read open

	mov r8, 0	
	mov r9, rax	; r8 <- rax <- len
	mov rax, 1
	mov rdi, 1
		;mov rsi, rcx
		;mov rdx, 0x400
	syscall
parse:		; parse data
	cmp r8, r9
	jae complete
	
	xor rax, rax	; reset rax register	
	mov al, [rsi + r8]

	shl rax, 8
	add r8, 1
	
	mov al, [rsi + r8]
	shl rax, 8
	add r8, 1
	
	mov al, [rsi + r8]
	shl rax, 8
	add r8, 1

	mov al, [rsi + r8]
	shl rax, 8
	add r8, 1

	mov al, [rsi + r8]
	shl rax, 8
	add r8, 1

	mov al, [rsi + r8]
	shl rax, 8
	add r8, 1

	mov al, [rsi + r8]
	shl rax, 8
	add r8, 1

	mov al, [rsi + r8]
		;shl rax, 8
	add r8, 1
	
	push rax
	loop parse
complete:

		;cmp r8, r9
		;jl parse
	
	mov r14, r8
	sub r14, r9
	mov r15, r14
	;mov r15, r9

	;	mov rdi, 1
	;	;mov rsi, rsp
	;	add r14, rsp
	;	mov rsi, r14
	;	mov rdx, r9
	;	mov rax, 1
	;	syscall		; print reverse data

	mov rax, 44
	mov rsi, rsp
	add rsi, r14
	mov rdx, r9
	mov r8, addr
	mov r9, 16
	mov rdi, 3

	syscall		; send reverse data

	mov r8, addr
	mov r9, addrlen
	mov r10, 0
	mov rax, 45
	mov rdi, 3
	sub rsp, 0x40
	mov rsi, rsp
	mov rdx, 0x3f
	syscall		; receive result

	mov rax, 1
	mov rdi, 1
	syscall		; print result
	
	
endpoint:
	mov rax, 1
	mov rbx, 0
	int 0x80

	
	
