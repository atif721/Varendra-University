.model small
.stack 100h
.code 
               
main proc
    mov ah,1
    int 21h    ;input first number
    mov bl,al   
    
    mov ah,1
    int 21h    ;input second number
    mov bh,al   
    
    sub bl,bh  ;subtract operation
    add bl,48
    
    mov ah,2
    mov dl,10
    int 21h    ;new line
    mov dl,13
    int 21h   
    
    mov ah,2
    mov dl,bl  ;output
    int 21h  
   
    exit:
    mov ah,4ch
    int 21h    ;return
    main endp
 
 end main