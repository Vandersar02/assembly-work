; Devoir 3
; lstcyr 10879

ExitProcess proto
ReadInt64 proto
WriteInt64 proto
WriteString proto
Crlf proto

.data
a SQWORD ?
b SQWORD ?
c SQWORD ?

discriminant SQWORD ?
racineResult SQWORD ?
racine1 SQWORD ?
racine2 SQWORD ?

value_a byte 'Entrez la valeur de A : ', 0
value_b byte 'Entrez la valeur de B : ', 0
value_c byte 'Entrez la valeur de C : ', 0

oneRacineMessage byte "L' equation a une racine double", 0
twoRacineMessage byte "L' equation a deux racines", 0
noRacineMessage byte "Aucune racine distincte", 0
racineValue byte "Solution : ", 0

.code
main proc
    ; Étape 1: Demander à l'utilisateur d'entrer les constantes a, b et c
    ; *****************************************************
     
    mov rdx, offset value_a ;------- Valeur de a -------
    call WriteString
    call ReadInt64  ; Accepter l'entier
    mov a,rax

    ; *****************************************************
     
    mov rdx, offset value_b ;------- Valeur de b -------
    call WriteString
    call ReadInt64   ; Accepter l'entier
    mov b,rax

    ; *****************************************************
     
    mov rdx, offset value_c ;------- Valeur de c -------
    call WriteString
    call ReadInt64  ; Accepter l'entier
    mov c,rax

    call Crlf
    xor eax,eax

    ; Étape 2: Calculer le discriminant
    ; =======================================================================
    ; ------ Calcul du discriminant ------

    mov rax, b
    mov rbx, b
    imul rbx

    mov rbx, a
    imul rbx, c      ; a * c

    imul rbx, 4      ; 4 * a * c

    sub rax, rbx     ; (b * b) - (4 * a * c)

    ; Étape 3: Vérifier le signe du discriminant pour déterminer le nombre de racines réelles
    ; =======================================================================
    cmp rax, 0

    je equal_to

    jg superior_to

    jmp inferior_to


equal_to:
    ; *****************************************************
    ; si discriminant = 0  : une racine double
    ; ------ Message à afficher ------
    mov rdx, offset oneRacineMessage
    call WriteString
    call Crlf

    mov rdx, offset racineValue
    call WriteString

    ; ------ Calcul de la racine 1 ------
    mov rax, b
    neg rax

    xor rdx, rdx   ; Effacer rdx avant la division

    mov rcx, a
    imul rcx, 2

    div rcx       ; Diviser rax par rcx (avec le résultat stocké dans rax)

    call WriteInt64

    jmp end_if


superior_to:
    ; *****************************************************
    ; si discriminant > 0  : deux racines, deux solutions
    ; ------ Message à afficher ------
    mov rdx, offset twoRacineMessage
    call WriteString
    call Crlf

    mov rdx, offset racineValue
    call WriteString

    ; on aurait du calculer la racine carre du discriminant ici mais tout tentatives ont echoues
    ; ou aurait mis la valeur de la racine dans la variable discriminant

    ; ------ Calcul de la racine 1 ------
    mov rax, b
    neg rax
    add rax, discriminant

    xor rdx, rdx   ; Effacer rdx avant la division

    mov rcx, a
    imul rcx, 2

    div rcx       ; Diviser rax par rcx (avec le résultat stocké dans rax)

   
    call WriteInt64
    call Crlf


    mov rdx, offset racineValue
    call WriteString

    ; ------ Calcul de la racine 2 ------
    mov rax, b
    neg rax
    sub rax, discriminant


    xor rdx, rdx   ; Effacer rdx avant la division

    mov rcx, a
    imul rcx, 2

    div rcx       ; Diviser rax par rcx (avec le résultat stocké dans rax)

    call WriteInt64

    jmp end_if


inferior_to:
    ; *****************************************************
    ; si discriminant < 0  :  pas de racines
    ; ------ Message à afficher ------

    mov rdx, offset noRacineMessage
    call WriteString

    jmp end_if


end_if:
    call Crlf
    call ExitProcess

main endp

end
