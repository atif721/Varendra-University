.model small
.stack 100h

.data
a db 'This is a string print $' 
         
         ;variable declared above
.code

main proc
    
    mov ax, @data ;initialize data to reg
    mov ds,ax
    
    mov ah,9
    lea dx,a ;print output
    int 21h   
    
    exit:
    mov ah,4ch
    int 21h    ;return 
    main endp         

end main