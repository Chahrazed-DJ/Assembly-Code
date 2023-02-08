data segment  
   
    a dw  ?          ;declaration de la variable globale 
    p db 10 dup(0) 
    
 ends 

code segment     
    mov ax,data 
    mov ds,ax    
    
    mov a,10
    ;reservation de l'espace et declaration des var locales
    sub sp,4
    mov bp,sp 
    mov [bp+2],5
    mov [bp],0 
    ;les var d'entree  
    mov bx,[bp+2]
    push bx 
    push a   
    sub sp,2     
    mov si,0    
    mov di,0
    ;l'apelle de la proc produit 
    call produit
    ;mettre le resultat dans c
    mov bp,sp 
    mov bx,[bp] 
    mov [bp+4],bx   
    ;nettoyage et liberation de l'espace dans la pile 
    add sp,6
    add sp,4   
    
    ;comparaison de valeur de c avec 64h qui est 100 en decimale
    ;si la valeur est composee de deux chiffres en decimale   
    ; on l'affiche sinon on termine le programme sans l'afficher 
    cmp bx,64h
    JGE l  
    
    ;un sous programme qui affiche la val  de c en decimale 
    mov al,bl
    mov si,9
    mov bl,10
    mov p[9],'$'
fn: dec si 
    xor ah,ah
    div bl
    add ah,48
    mov p[si],ah  
    cmp al,0
    jnz fn
   
    mov dx,si
    mov ah,09h    
    int 21h   
    
l:
    mov ah,4ch
    int 21h  
    
  produit proc    
    ;sauvegarde de contexte  
    cmp si,0
    JNE prog 
    push ax 
    push bx
    push bp    
    inc si 
    ;recuperation des entrees dans les registres   
    prog:
    mov bp,sp
    mov ax,[bp+10+di]
    mov bx,[bp+12+di]         
    
    ;les instructions qui calcule le produit
    cmp ax,0
    JE  fin  
    cmp bx,0
    JE  fin
    JMP etiq2
    fin:mov [bp+8],0 
    JMP resultat
    etiq2:cmp ax,1
    JE fin2  
    JMP etiq3
    fin2:mov [bp+8],bx  
    JMP resultat
    etiq3: cmp bx,1
    JE fin3 
    JMP res
    fin3: mov [bp+8+di],ax 
    ;recuperer le contexte  
    resultat:   
    cmp di,0
    JE result
    add sp,di ;on vide la pile selon le nombre d'apelles fait par la procedure elle meme 
    result:
    pop bp
    pop bx
    pop ax
    JMP endd
    
    res: 
    mov bx,a      
    mov bp,sp
    add [bp+10+di],bx 
    dec [bp+12+di]  
    add di,2
    call produit  
    
    endd:
ret 
produit endp        
ends 
