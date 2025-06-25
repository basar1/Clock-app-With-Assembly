org 100h
#start=Emulation_Kit.exe# ;emilation kiti otamatik baslat:) 
    
    mov ch, 0       ; Saati 0 olarak baslat
    mov cl, 0       ; Dakikayi 0 olarak baslat
    mov bh, 0       ; Saniyeyi 0 olarak baslat 

  .data
message db 'Saati ayarlamak icin deger girin (saat:dakika:saniye): $'   
  .code
main proc
    mov ax, @data   ; Veri segmentini ayarla
    mov ds, ax      ; DS'i veri segmentiyle yukle

    ; Kullanici ya mesaji  goster :)
    lea dx, message ; Mesajin adresini DX'e yukle
    mov ah, 09h   
    int 21h         ; Mesaji ekrana yazdir
    
    ; Saati al
    mov ah, 01h     ; Klavyeden karakter okuma hizmeti
    int 21h         ; Kullanicidan karakteri al
    sub al, '0'     ; Karakteri rakam degerine donustur (ASCII)
    mov ch, al      ; AL register'ndaki degeri saat (CH) degiskenine ata
    
    ; Dakikayi al
    mov ah, 01h     ; Klavyeden karakter okuma hizmet
    int 21h         ; Kullanicidan karakteri al
    sub al, '0'     ; Karakteri rakam degerine donustur (ASCII)
    mov cl, al      ; AL register'ndaki degeri dakika (CL) degiskenine ata
    
    ; Saniyeyi al
    mov ah, 01h     ; Klavyeden karakter okuma hizmet 
    int 21h         ; Kullancidan karakteri al
    sub al, '0'     ; Karakteri rakam degerine donustur (ASCII)
    mov bh, al      ; AL register'ndaki degeri saniye (DH) degiskenine ata

    
 
mov bl, 10   
update_time:
    ; Saniyeyi artir
    inc bh          ; Saniyeyi bir artir
    cmp bh, 60 
         ; Saniye 60'a ulastiginda
    je increment_minute ; Eger saniye 60 ise dakikayi artir

    jmp display_time ; Zamani goster ve donguye devam et

increment_minute:
    mov bh, 0       ; saniyeyi sifirla
    inc cl          ; Dakikayi bir arttir
    cmp cl, 60      ; Dakika 60'a ulastiginda
    je increment_hour; Eger dakika 60 ise saati artir

    jmp display_time ; Zamani goster ve donguye devam et

increment_hour:
    mov cl, 0       ; Dakikayi sifirla
    inc ch          ; Saati bir artir
    cmp ch, 24      ; Saat 24'e ulastiginda
    je reset_time   ; Eðer saat 24 ise zamani sifirla

    jmp display_time ; Zamani goster ve donguye devam et

reset_time:
    mov ch, 0       ; Saati sifirla
    mov cl, 0       ; Dakikayi sifirla
    mov bh, 0       ; Saniyeyi sifirla

    jmp display_time ; Zamani goster ve donguye devam et  
    
       
    
display_time:


;hour ilk basamak
mov al, ch
div bl            
mov ah, 0     
mov si, ax
mov al, numbers[si]  ;bolum al'de  

mov dx, 2030h
out dx, al

mov ax, 0
;hour ikinci basamak
mov al, ch
div bl
mov al, ah ;kalan ah'ta
mov ah, 0
mov si, ax
mov al, numbers[si]
                    
mov dx, 2031h
out dx, al

mov ax, 0

;- 
mov al, numbers[10] 
mov dx, 2032h
out dx, al   
;minute ilk basamak 
mov al, cl
div bl
mov ah, 0  
mov si, ax
mov al, numbers[si]

mov dx, 2033h
out dx, al

mov ax, 0 
   
   
;minute ikinci basamak 
mov al, cl
div bl
mov al, ah
mov ah, 0
mov si, ax
mov al, numbers[si]

mov dx, 2034h
out dx, al

mov ax, 0   

;-
mov al, numbers[10]
mov dx, 2035h
out dx, al    
;second1 ilk basamk 
mov al, bh
div bl
mov ah, 0 
mov si, ax
mov al, numbers[si]

mov dx, 2036h 
out dx, al

mov ax, 0   
          
;second2  ikinci basamak
mov al, bh
div bl
mov al, ah
mov ah, 0 
mov si, ax
mov al, numbers[si]

mov dx, 2037h
out dx, al   

mov ax, 0         


jmp update_time           


ret   


numbers DB	10111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 11111101b, 00000111b, 01111111b, 01101111b, 01000000b              
                ;0          ;1         ;2       ;3          ;4      ;5           ;6          ;7          ;8         ;9         ;-