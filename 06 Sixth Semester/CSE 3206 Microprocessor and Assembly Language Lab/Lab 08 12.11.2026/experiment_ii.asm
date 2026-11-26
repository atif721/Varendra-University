.model small
.stack 100h

.data
    prompt_msg  db 'Enter a digit (0-9): $'
    even_msg    db 0dh, 0ah, 'The number is even.$'
    odd_msg     db 0dh, 0ah, 'The number is odd.$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display input prompt
    lea dx, prompt_msg
    mov ah, 09h
    int 21h

    ; Read a single digit
    mov ah, 01h
    int 21h
    sub al, '0' 
    ; Convert ASCII character to numeric value

    ; Check even/odd using right shift
    shr al, 1      ; Shift LSB into (CF)
    jc  odd_case   ; If CF = 1, number is odd

    lea dx, even_msg  ; If CF = 0, number is even
    jmp print_result

odd_case:
    lea dx, odd_msg

print_result:
    mov ah, 09h
    int 21h

    ; Terminate program
exit_prog:
    mov ah, 4ch
    int 21h
main endp
end main