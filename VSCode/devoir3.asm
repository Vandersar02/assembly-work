; Devoir 3: Calcul de l' equation quadratique
; lstcyr 10879

ExitProcess proto
ReadInt64 proto
WriteInt64 proto
WriteString proto
sqrt_proc proto:qword
Crlf proto

.data
a SQWORD ?
b SQWORD ?
c SQWORD ?

discriminant SQWORD ?
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
    ;------- Valeur de a ------- 
    mov rdx, offset value_a
    call WriteString

    ; Accepter l'entier
    call ReadInt64
    mov a, rax

    ; *****************************************************
    ;------- Valeur de b ------- 
    mov rdx, offset value_b
    call WriteString

    ; Accepter l'entier
    call ReadInt64
    mov b, rax

    ; *****************************************************
    ;------- Valeur de c ------- 
    mov rdx, offset value_c
    call WriteString

    ; Accepter l'entier
    call ReadInt64
    mov c, rax

    call Crlf

    ; Étape 2: Calculer le discriminant
    ; =======================================================================
    ; ------ Calcul du discriminant ------
    mov rax, b
    imul rax, rax ; b * b

    mov rbx, a
    imul rbx, c    ; a * c

    imul rbx, 4    ; 4 * a * c

    sub rax, rbx   ; (b * b) - (4 * a * c)

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
    neg rax           ;-b

    xor rdx, rdx   ; Effacer rdx avant la division

    mov rcx, a
    imul rcx, 2     ; 2 * a

    cqo             ; Signe étendu de rax à rdx:rax
    idiv rcx       ; Diviser rax par rcx (avec le résultat stocké dans rax)

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

    ; Calcul de la racine carrée du discriminant

    mov rax, discriminant
    call sqrt_proc
    mov discriminant, rax    ; Stocker le résultat dans discriminant

    ; ------ Calcul de la racine 1 ------
    mov rax, b
    neg rax             ; -b

    add rax, discriminant ; -b + delta

    xor rdx, rdx   ; Effacer rdx avant la division

    mov rcx, a
    imul rcx, 2     ; 2* a

    cqo             ; Signe étendu de rax à rdx:rax
    idiv rcx       ; Diviser rax par rcx (avec le résultat stocké dans rax)
  
    call WriteInt64
    call Crlf

    mov rdx, offset racineValue
    call WriteString

    ; ------ Calcul de la racine 2 ------
    mov rax, b
    neg rax             ; -b

    sub rax, discriminant   ; -b - delta

    xor rdx, rdx   ; Effacer rdx avant la division

    mov rcx, a
    imul rcx, 2     ; 2 * a

    cqo             ; Signe étendu de rax à rdx:rax
    idiv rcx       ; Diviser rax par rcx (avec le résultat stocké dans rax)

    call WriteInt64

    jmp end_if



inferior_to:
    ; *****************************************************
    ; si discriminant < 0  :  pas de racines
    ; ------ Message à afficher ------
    mov rdx, offset noRacineMessage
    call WriteString


end_if:
    call Crlf
    call ExitProcess

main endp


; Calcul de la racine carrée
sqrt_proc proc val:qword
    movq xmm0, val     ; Charger le nombre en virgule flottante dans xmm0
    sqrtss xmm0, xmm0  ; Calculer la racine carrée de xmm0
    cvtss2si rax, xmm0 ; Convertir le résultat en entier signé 64 bits
    ret
sqrt_proc endp

end
