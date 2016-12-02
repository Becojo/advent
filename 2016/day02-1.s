; nasm -f elf64 day02-1.s -o day02-1.o; gcc day02-1.o -o day02-1

SECTION .data
x:              dq 1
y:              dq 1

SECTION .text
        extern getchar
        extern exit
        extern putchar

global main

print_char:
        mov rdi, [y]        ; keyboard[y * 2 + x]
        imul rdi, 3
        add rdi, [x]
        add rdi, 1
        add rdi, '0'
        call putchar

        ret

main:
        .loop:

        call getchar
        cmp eax, 0xffffffff     ; EOF
        je .end

        cmp eax, 0x0a           ; Next digit
        je .print_key

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
        cmp QWORD [x], 2
        jge .loop
        add QWORD [x], 1
        jmp .loop

        .move_left:
        cmp QWORD [x], 0
        je .loop
        sub QWORD [x], 1
        jmp .loop

        .move_down:
        cmp QWORD [y], 2
        jge .loop
        add QWORD [y], 1
        jmp .loop

        .move_up:
        cmp QWORD [y], 0
        je .loop
        sub QWORD [y], 1
        jmp .loop
