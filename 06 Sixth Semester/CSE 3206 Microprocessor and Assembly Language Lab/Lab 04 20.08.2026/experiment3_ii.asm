.model small
.stack 100h 
.code

main proc      
    mov al,3
    mov bl,3
    mul bl      ;multplication 
    
    mov ah,2
    mov dl,al   ;prints output
    add dl,48
    int 21h
    
    exit:
    mov ah,4ch  ;returns             
    int 21h 
    main endp
end main