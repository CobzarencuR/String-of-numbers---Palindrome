.model small
.stack 100h
.data
	message db 'Enter the character string: $'
	false db 'The string entered is not a palindrome.$'
	true db 'The string entered is a palindrome.$'
	string db ?
.code
	main:
		mov ax, @data
		mov ds, ax
		
		;display message
		mov dx, offset message
		mov ah, 09h
		int 21h
		
		;setting register to 0
		xor ax, ax
		xor bx, bx
		xor cx, cx
		xor dx, dx
		xor si, si
		xor di, di
		xor bp, bp
		
		readCharacter:
		mov ah, 01h
		int 21h
		
		xor ah, ah
		
		cmp al, 91
		jge writeCharacter
		
		cmp al, 65
		jge caseChange
		
		;exit loop when ENTER is pressed
		cmp al, 13
		je intermediateStep
		
		jmp writeCharacter
		
		;from uppercase to lowercase
		caseChange:
		add al, 32
		jmp writeCharacter
		
		;move character to its position in the string
		writeCharacter:
		mov [string+si], al
		inc si
		jmp readCharacter
		
		;last position n-1
		intermediateStep:
		dec si
		jmp comparison
		
		comparison:
		mov al, [string+di] ;move the value of the first character up to n/2
		mov dl, [string+si] ;move the value of the last character up to n/2
		
		;comparison letters
		cmp al, dl
		jne isNotPalindrome
		
		;comparison pozitions
		cmp di, si
		jge isPalindrome
		
		inc di
		dec si
		jmp comparison
		
		isNotPalindrome:
		;display message
		mov dx, offset false 
		mov ah, 09h
		int 21h
		jmp finishReading
		
		isPalindrome:
		;display message
		mov dx, offset true
		mov ah, 09h
		int 21h
		jmp finishReading
		
		finishReading:
		;exit program
		mov ah, 4ch
		int 21h
	end main