ExitProcess proto
WriteString proto
ReadInt64 proto
WriteInt64 proto
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

; taking value for operations

takingValue BYTE "Enter two values for operations", 0
valueA BYTE "Value a: ", 0
valueB BYTE "Value b: ", 0
resultMessage BYTE "Result: ", 0
DivisionZero Byte "Division par 0", 0
a SDWORD ?
b SDWORD ?
result SDWORD ?

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
    call Crlf
    call Crlf


    ; taking value to make operations
    mov rdx, OFFSET takingValue
    call WriteString
    call Crlf

    mov rdx, OFFSET valueA
    call WriteString
    call ReadInt64
    mov a, eax

    mov rdx, OFFSET valueB
    call WriteString
    call ReadInt64
    mov b, eax

    mov rdx, OFFSET resultMessage
    call WriteString

    ; let's do the operations here
    mov eax, a
    add eax, b

    call WriteInt64

    jmp endProgram

subtraction:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET subMessage
    add rdx, 3
    call WriteString
    call Crlf
    call Crlf


    ; taking value to make operations
    mov rdx, OFFSET takingValue
    call WriteString
    call Crlf

    mov rdx, OFFSET valueA
    call WriteString
    call ReadInt64
    mov a, eax

    mov rdx, OFFSET valueB
    call WriteString
    call ReadInt64
    mov b, eax

    
    mov rdx, OFFSET resultMessage
    call WriteString

    ; let's do the operations here
    mov eax, a
    sub eax, b

    call WriteInt64

    jmp endProgram

multiplication:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET mulMessage
    add rdx, 3
    call WriteString
    call Crlf
    call Crlf


    ; taking value to make operations
    mov rdx, OFFSET takingValue
    call WriteString
    call Crlf


    mov rdx, OFFSET valueA
    call WriteString
    call ReadInt64
    mov a, eax

    mov rdx, OFFSET valueB
    call WriteString
    call ReadInt64
    mov b, eax

    mov rdx, OFFSET resultMessage
    call WriteString

    ; let's do the operations here
    mov eax, a
    cdq
    mov ebx, b       ; Place b in ebx
    imul ebx  

    call WriteInt64

    jmp endProgram

division:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET divMessage
    add rdx, 3
    call WriteString
    call Crlf
    call Crlf


    ; taking value to make operations
    mov rdx, OFFSET takingValue
    call WriteString
    call Crlf

    mov rdx, OFFSET valueA
    call WriteString
    call ReadInt64
    mov a, eax

    mov rdx, OFFSET valueB
    call WriteString
    call ReadInt64
    mov b, eax

    ; Check for division by zero
    cmp b, 0
    call Crlf
    je divisionByZero

    
    mov rdx, OFFSET resultMessage
    call WriteString

    ; let's do the operations here
    mov eax, a
    cdq
    mov ebx, b       ; Place b in ebx
    idiv ebx         ; Divide edx:eax by ebx; quotient in eax
    
    call WriteInt64

    jmp endProgram

modulo:
    mov rdx, OFFSET choiceMessage
    call WriteString
    mov rdx, OFFSET modMessage
    add rdx, 3
    call WriteString
    call Crlf
    call Crlf

    ; taking value to make operations
    mov rdx, OFFSET takingValue
    call WriteString
    call Crlf


    mov rdx, OFFSET valueA
    call WriteString
    call ReadInt64
    mov a, eax

    mov rdx, OFFSET valueB
    call WriteString
    call ReadInt64
    mov b, eax

    ; Check for modulo by zero
    cmp b, 0
    je divisionByZero

    ; let's do the operations here
    mov eax, a
    cdq
    mov ebx, b       ; Place b in ebx
    idiv ebx         ; Divide edx:eax by ebx; quotient in eax, remainder in edx
    mov result, edx  ; take the rest of the division

    mov rdx, OFFSET resultMessage
    call WriteString
    mov eax, result
    
    call WriteInt64

    jmp endProgram


divisionByZero:
    mov rdx, OFFSET DivisionZero
    call WriteString
    call Crlf
    call Crlf

    jmp main

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
