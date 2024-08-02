; Devoir 2 write int in console from 1 to the user's number
; lstcyr 10879
ExitProcess proto
ReadInt64 proto
WriteInt64 proto
WriteString proto
Crlf proto

.data
num byte 0
result byte 0

message byte 'Enter a positif integer: ', 0

.code
main proc
	; affichez le message
	mov rdx, offset message
	call WriteString

	; Acceptez l' entier
	call ReadInt64
	mov num, al

	sub num, 1
	
boucle:
	sub al, num
	mov result, al

	call WriteInt64
	call Crlf

	mov al, result
	add al, num

	dec num
	cmp al, result

	jne boucle

	call  ExitProcess
main endp
end
