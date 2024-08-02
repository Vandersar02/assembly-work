start:
    mov ax, 0000h   ; Initialize AX with 0000h
    mov bx, 0000h   ; Initialize BX with 0000h
    mov cx, 0000h   ; Initialize CX with 0000h
    mov al, 25h     ; Set AL to 25h
    mov cl, 00h     ; Set CL to 00h
    mov bl, 01h     ; Set BL to 01h

root:
    cmp al, 00h     ; Compare AL with 00h
    jz zero         ; Jump to zero if AL is zero
    sub al, bl      ; Subtract BL from AL
    aas             ; ASCII adjust after subtraction
    add bl, 02h     ; Add 2 to BL
    inc cl          ; Increment CL
    jmp root        ; Jump to root (loop)

zero:
    add cl, 30h     ; Add 30h to the value in CL (convert to ASCII)
    mov dl, cl      ; Move the value in CL to DL
    mov ah, 2       ; Set AH to 2 (DOS function to display character)
    int 21h         ; Call interrupt 21h (DOS interrupt)
