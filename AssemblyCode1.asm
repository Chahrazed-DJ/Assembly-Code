data segment 
    chh db 23 dup(?)              
    chaine1 db 'Tapez votre chaine :$'   
    chaine2 db 10,13,'la chaine avant la conversion :$'  
    chaine3 db 10,13,'la chaine apres la conversion:$'
data ends 
code segment
start:
     mov ax,data
     mov ds,ax    
     
     ;afficher le msg de chaine1
     mov dx,offset chaine1
     mov ah,09h
     int 21h
     
     mov chh[0],21 ;taille maximale plus 1 de la touche entree 
     mov ah,0Ah       
     mov dx,offset chh
     int 21h    
     
     ;afficher le msg de chaine2
     mov dx,offset chaine2
     mov ah,09h
     int 21h  
     ;affichage de la chaine avant la conversion     
     mov si,1
     mov bx,0
     mov bl,chh[si]
     add bx,2
     mov chh[bx],'$'  
     mov dx ,offset chh
     add dx,2
     mov ah,09h
     int 21h
     
      
     mov si,2  
     ;LE nombre d'iteration egale le nombre reel de caracteres lu
     mov cl,chh[1]
     f:  
     call verifier
     ;verifier si le caractere retourne par la fonction est miniscule 
     cmp al,00  
     je r        
     ;convertir la lettre miniscule en majuscule 
     sub al,20h
     mov chh[si],al
     r:
     inc si
     loop f  
     
     ;changer le cret par $
     mov si,1
     mov bx,0
     mov bl,chh[si]
     add bx,2
     mov chh[bx],'$'                          
     
     ;afficher le msg de chaine3
     mov dx,offset chaine3
     mov ah,09h
     int 21h
     ;afficher la chaine obtenue apres la coversion  
     mov dx ,offset chh
     add dx,2
     mov ah,09h
     int 21h
     
     mov ah,4Ch
     int 21h
     
     ;pour la fonction j'ai fais un passage par registre 
     verifier proc 
        
     mov al,chh[si]
     cmp al,61h   
     jb fin
     cmp al,7Ah
     ja fin
     mov al,chh[si]
     jmp e   
     fin:   
     ;dans le cas ou le caractere n'est pas une lettre miniscule   
     mov al,00
     e:   
     ret   
     
     verifier endp    
code ends    
end start 