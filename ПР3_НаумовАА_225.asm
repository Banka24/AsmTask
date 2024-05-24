; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    y1 db ?
    x db ?
    a db ? 
    perenos db 13, 10,"$"
    vvod_a db 13, 10,"Vvedite A=$"
    vvod_x db 13, 10,"Vvedite X=$"
    vivod_y db "Y=$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    xor ax, ax           
    mov dx, offset vvod_x
    mov ah, 9
    int 21h        ; output string at ds:dx   
    
sled1:
    mov ah, 1
    int 21h
    sub al, 30h
    test bx, bx 
    mov x, al
    xor ax, ax
    xor bx, bx
    mov dx, offset vvod_a
    mov ah, 9
    int 21h  
    mov ah, 1
    int 21h   
    sub al, 30h
    test bx, bx
    mov a, al 
    cmp x, 3 
    jle sled2
    jmp sled3

sled2:
    mov bl, x
    add bl, 4
    mov y1, bl
    jmp sled4

sled3:      
    imul x 
    mov y1, al
    jmp sled4

sled4:
    mov al, x 
    cmp al, a
    jg sled5
    jmp vivod
    
sled5: 
    mov al, a
    cmp al, "-"  
    jz preob
    sub al, 2    
    jmp vivod
    
preob:  
    neg al 
    sub al, 2
    jmp vivod    

vivod:
    add y1, al
    mov dx, offset vivod_y
    mov ah, 9
    int 21h
    mov dl, y1
    mov ah, 2
    int 21h
               
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
