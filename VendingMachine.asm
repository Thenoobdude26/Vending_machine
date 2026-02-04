section .data
	strmsg db "Vending Machine System V0.01",10
	lengmsg equ $- strmsg
	menu db "##########################################################",10
	     db "#                         Welcome                        #",10
	     db "#                                                        #",10
	     db "#                  Please select an item                 #",10
	     db "#                                                        #",10
	     db "#  ItemID    Item                        Price    Stock  #",10
	     db "#  ----------------------------------------------------  #",10
             db "#   01       Mtn Dew                     2.30     10     #",10
             db "#   02       Coke                        2.30     25     #",10
             db "#   03       Red-Bull(eur)               8.25     15     #",10
             db "#   04       100 Plus                    2.50     20     #",10
    	     db "#   05       Milo Can                    3.00     18     #",10
    	     db "#   06       Spritzer Water              1.80     30     #",10
    	     db "#   07       Lipton Ice Tea              2.80     12     #",10
    	     db "#   08       Nescafé Can                 3.50     14     #",10
    	     db "#   09       Twisties                    2.00     22     #",10
    	     db "#   10       Oreo                        2.50     16     #",10
    	     db "#   11       KitKat                      2.80     15     #",10
    	     db "#   12       Snickers                    3.00     10     #",10
    	     db "#   13       Pringles (small)            4.00     08     #",10
    	     db "#   14       Lay's Classic               2.50     20     #",10
    	     db "#   15       Kinder Bueno                3.20     12     #",10
    	     db "#   16       Monster Energy              7.50     12     #",10
    	     db "#   17       Sting                       3.80     18     #",10
	     db "##########################################################",10
	lengmenu equ $- menu

section .bss
	choice resb 4

section .text
	global _start 

_start:
;Display version and proj name
	mov eax,4	;print
	mov ebx,1 	;stdout
	mov ecx,strmsg
	mov edx,lengmsg	;len = msg
	int 0x80	; you remember what this does


;Display Menu	
	mov eax,4
	mov ebx,1
	mov ecx,menu
	mov edx,lengmenu
	int 0x80

;reads and stores user input
	mov eax, 3 ;sysread
	mov ebx, 0 ;stdin
	mov ecx, choice
	mov edx, 4
	int 0x80

;Display input test   
        mov eax,4
        mov ebx,1
        mov ecx,choice
        mov edx,4
        int 0x80


;exit
	mov eax,1
	int 0x80
