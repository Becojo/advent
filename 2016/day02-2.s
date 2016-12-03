; nasm -f elf64 day02-2.s -o day02-2.o; gcc day02-2.o -o day02-2

SECTION .data
x:              dq 0
y:              dq 2
xp:             dq 0
yp:             dq 0
keyboard:       dq '0', '0', '1', '0', '0', '0', '2', '3', '4', '0', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', '0', '0', '0', 'D', '0', '0'

SECTION .text

        extern getchar
        extern exit
        extern putchar

global main

current_char:
        mov rax, [y]        ; keyboard[y * 2 + x]
        imul rax, 5
        add rax, [x]
        mov rax, [keyboard + rax * 8]
        ret

print_char:
        call current_char
        mov rdi, rax
        call putchar
        ret

main:
        .loop:

        call getchar
        cmp eax, 0xffffffff     ; EOF
        je .end

        cmp eax, 0x0a           ; Next digit
        je .print_key

        mov rdi, [x]
        mov [xp], rdi
        mov rdi, [y]
        mov [yp], rdi

        cmp eax, 'R'
        je .move_right

        cmp eax, 'L'
        je .move_left

        cmp eax, 'U'
        je .move_up

        cmp eax, 'D'
        je .move_down

        .end:
        call print_char

        mov rdi, 10
        call putchar

        mov rdi, 0
        call exit

        .print_key:
        call print_char

        jmp .loop

        .move_right:
        add QWORD [x], 1
        jmp .check_position

        .move_left:
        sub QWORD [x], 1
        jmp .check_position

        .move_down:
        add QWORD [y], 1
        jmp .check_position

        .move_up:
        sub QWORD [y], 1
        jmp .check_position

        .check_position:
        cmp QWORD [y], 0
        jl .reset_position
        cmp QWORD [y], 5
        jae .reset_position

        cmp QWORD [x], 0
        jl .reset_position
        cmp QWORD [x], 5
        jae .reset_position

        call current_char
        cmp rax, '0'
        je .reset_position

        jmp .loop

        .reset_position:
        mov rdi, [xp]
        mov [x], rdi
        mov rdi, [yp]
        mov [y], rdi

        jmp .loop
