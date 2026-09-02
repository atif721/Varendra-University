.model small
.stack 100h 
.code

main proc     
    mov al,5
    mov bl,2    
    div bl     ;divison of two value
    
    mov cl,al
    mov ch,ah
 
    mov ah,2
    mov dl,cl   ;qoutient value 
    add dl,48
    int 21h 
    
    mov ah,2
    mov dl,10
    int 21h     ;new line
    mov dl,13
    int 21h
    
    mov ah,2
    mov dl,ch   ;remainder value
    add dl,48
    int 21h
    
    exit:
    mov ah,4ch               
    int 21h     ;return
    main endp
end main