; Devoir 4: A list of choice for arithmetic operations
; lstcyr 10879
ExitProcess proto
WriteString proto
ReadInt64 proto
Crlf proto

.data
choiceMessage byte "You choose ", 0
menuPrompt BYTE "Enter your choice (1-5 for operations, 0 to quit): ", 0
ChooseOption BYTE "Enter your Choice: ", 0

addMessage BYTE "1. Addition", 0
subMessage BYTE "2. Subtraction", 0
mulMessage BYTE "3. Multiplication", 0
divMessage BYTE "4. Division", 0
modMessage BYTE "5. Modulo", 0
quitMessage BYTE "0. QUIT", 0

.code
main proc
    mov rdx, OFFSET menuPrompt
    call WriteString
    call Crlf

    mov rdx, OFFSET addMessage
    call WriteString
    call Crlf

    mov rdx, OFFSET subMessage
    call WriteString
    call Crlf

    mov rdx, OFFSET mulMessage
    call WriteString
    call Crlf

    mov rdx, OFFSET divMessage
    call WriteString
    call Crlf

    mov rdx, OFFSET modMessage
    call WriteString
    call Crlf

    mov rdx, OFFSET quitMessage
    call WriteString
    call Crlf

    mov rdx, OFFSET ChooseOption
    call WriteString

    ; Read user input
    call ReadInt64
    call Crlf

    ; Compare user choice
    cmp rax, 1
    je addition
    cmp rax, 2
    je subtraction
    cmp rax, 3
    je multiplication
    cmp rax, 4
    je division
    cmp rax, 5
    je modulo
    cmp rax, 0
    je quit

    ; Invalid choice
    jmp invalidChoice

addition:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET addMessage
    add rdx, 3
    call WriteString
    jmp endProgram

subtraction:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET subMessage
    add rdx, 3
    call WriteString
    jmp endProgram

multiplication:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET mulMessage
    add rdx, 3
    call WriteString
    jmp endProgram

division:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET divMessage
    add rdx, 3
    call WriteString
    jmp endProgram

modulo:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET modMessage
    add rdx, 3
    call WriteString
    jmp endProgram

quit:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET quitMessage
    add rdx, 3
    call WriteString
    jmp endProgram

invalidChoice:
    call Crlf
    jmp main

endProgram:
    call Crlf
    call ExitProcess

main endp

end
