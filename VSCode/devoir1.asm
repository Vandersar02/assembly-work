; write my name on screen 
; lstcyr 10879

ExitProcess proto
WriteString proto

.data
my_name byte 'John Doe', 0

.code
main proc
	mov	rdx, offset my_name
	call WriteString

	call  ExitProcess

main endp
end
