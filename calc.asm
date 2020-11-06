extern imprime_eax
section .text 
global main 
main: 
	mov ebx, [esp+8] 	; argv 
	mov ecx, [esp+4] 	; argc 
	dec ecx     		; descartar nome do programa 
	add ebx, 4           	; saltar o nome do programa
	mov eax, 0 		; eax has the sum of the numbers read
	cmp ecx, 0
 	je sair
prox_Argumento:
	push    ecx		;ecx vai ser cada numero lido
	push	eax 		;eax vai ser onde vou montar o numero
	mov 	eax, 0		;inicialo a zero
        mov     edx, [ebx] 	;meter em edx o enderenço de memoria onde o argumento começa	
prox_Numero:
	mov 	ecx, [edx]	;buscar o proximo numero do argumento
	and     ecx, 0xFF	;ir buscar os 16 bits menos signifcativos e os outros bits ficam a zero
	cmp 	ecx, 0x00	;comparar se eh o fim da string ( 0 )
	je 	fim_Argumento
	and 	ecx, 0xF	;ir buscar os 8 bits menos significativos, porque estao na mesma ordem na ascii table
        push    ebx
        mov     ebx, eax 	;ebx=eax
        shl     eax, 2   	;shift left by 2 places
        add     eax, ebx 	;eax=eax+ebx
        shl     eax, 1
        pop     ebx
	add     eax, ecx   	;somar a eax ( resultado ) o que está em ecx
	inc 	edx
	jmp 	prox_Numero
fim_Argumento:
	mov 	ecx, eax 	;guardar o numero lido
	pop     eax
	add 	eax, ecx 	;somar o numero lido
	pop 	ecx
	dec 	ecx		;decrementar ecx    
next:
     	add     ebx, 4    	;adicionar ao ebx para ver o proximo argumento
	cmp     ecx, 0 		;comparar ecx com 0 a ver se ainda tem argumentos
	je      sair
	jmp     prox_Argumento
sair: 
   call imprime_eax 
   ret 
