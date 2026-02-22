section .data
	strmsg db "Vending Machine System V0.03",10
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
    	     db "#   08       Nescafe Can                 3.50     14     #",10
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

	; Item dispensed messages
	msg01 db "Dispensing: Mtn Dew          | Price: RM 2.30",10
	len01 equ $- msg01

	msg02 db "Dispensing: Coke             | Price: RM 2.30",10
	len02 equ $- msg02

	msg03 db "Dispensing: Red-Bull(eur)    | Price: RM 8.25",10
	len03 equ $- msg03

	msg04 db "Dispensing: 100 Plus         | Price: RM 2.50",10
	len04 equ $- msg04

	msg05 db "Dispensing: Milo Can         | Price: RM 3.00",10
	len05 equ $- msg05

	msg06 db "Dispensing: Spritzer Water   | Price: RM 1.80",10
	len06 equ $- msg06

	msg07 db "Dispensing: Lipton Ice Tea   | Price: RM 2.80",10
	len07 equ $- msg07

	msg08 db "Dispensing: Nescafe Can      | Price: RM 3.50",10
	len08 equ $- msg08

	msg09 db "Dispensing: Twisties         | Price: RM 2.00",10
	len09 equ $- msg09

	msg10 db "Dispensing: Oreo             | Price: RM 2.50",10
	len10 equ $- msg10

	msg11 db "Dispensing: KitKat           | Price: RM 2.80",10
	len11 equ $- msg11

	msg12 db "Dispensing: Snickers         | Price: RM 3.00",10
	len12 equ $- msg12

	msg13 db "Dispensing: Pringles (small) | Price: RM 4.00",10
	len13 equ $- msg13

	msg14 db "Dispensing: Lay's Classic    | Price: RM 2.50",10
	len14 equ $- msg14

	msg15 db "Dispensing: Kinder Bueno     | Price: RM 3.20",10
	len15 equ $- msg15

	msg16 db "Dispensing: Monster Energy   | Price: RM 7.50",10
	len16 equ $- msg16

	msg17 db "Dispensing: Sting            | Price: RM 3.80",10
	len17 equ $- msg17

	msginvalid db "Invalid selection. Please enter 01-17.",10
	leninvalid equ $- msginvalid

	msgthanks db "Thank you! Enjoy your item!",10
	lengthanks equ $- msgthanks

section .bss
	choice resb 4

section .text
	global _start

_start:
	; Display version string
	mov eax, 4
	mov ebx, 1
	mov ecx, strmsg
	mov edx, lengmsg
	int 0x80

	; Display menu
	mov eax, 4
	mov ebx, 1
	mov ecx, menu
	mov edx, lengmenu
	int 0x80

	; Read user input (up to 4 bytes: "01\n\0")
	mov eax, 3
	mov ebx, 0
	mov ecx, choice
	mov edx, 4
	int 0x80

	; ASCII to integer 
	movzx eax, byte [choice]
	movzx ebx, byte [choice+1]

	cmp ebx, 10			; is second char a newline?
	je  single_digit		; yes → single digit was entered

	; Two digit input: combine tens and units
	sub eax, 48			; first char → digit
	imul eax, 10			; ×10
	sub ebx, 48			; second char → digit
	add eax, ebx			; eax = full number
	jmp compare

single_digit:
	sub eax, 48			; eax = single digit value

	; Comparisons 
compare:
	cmp eax, 1
	je  item_01
	cmp eax, 2
	je  item_02
	cmp eax, 3
	je  item_03
	cmp eax, 4
	je  item_04
	cmp eax, 5
	je  item_05
	cmp eax, 6
	je  item_06
	cmp eax, 7
	je  item_07
	cmp eax, 8
	je  item_08
	cmp eax, 9
	je  item_09
	cmp eax, 10
	je  item_10
	cmp eax, 11
	je  item_11
	cmp eax, 12
	je  item_12
	cmp eax, 13
	je  item_13
	cmp eax, 14
	je  item_14
	cmp eax, 15
	je  item_15
	cmp eax, 16
	je  item_16
	cmp eax, 17
	je  item_17

	; Invalid input
	mov eax, 4
	mov ebx, 1
	mov ecx, msginvalid
	mov edx, leninvalid
	int 0x80
	jmp exit

	; Item handlers
item_01:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg01
	mov edx, len01
	int 0x80
	jmp thanks

item_02:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg02
	mov edx, len02
	int 0x80
	jmp thanks

item_03:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg03
	mov edx, len03
	int 0x80
	jmp thanks

item_04:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg04
	mov edx, len04
	int 0x80
	jmp thanks

item_05:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg05
	mov edx, len05
	int 0x80
	jmp thanks

item_06:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg06
	mov edx, len06
	int 0x80
	jmp thanks

item_07:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg07
	mov edx, len07
	int 0x80
	jmp thanks

item_08:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg08
	mov edx, len08
	int 0x80
	jmp thanks

item_09:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg09
	mov edx, len09
	int 0x80
	jmp thanks

item_10:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg10
	mov edx, len10
	int 0x80
	jmp thanks

item_11:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg11
	mov edx, len11
	int 0x80
	jmp thanks

item_12:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg12
	mov edx, len12
	int 0x80
	jmp thanks

item_13:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg13
	mov edx, len13
	int 0x80
	jmp thanks

item_14:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg14
	mov edx, len14
	int 0x80
	jmp thanks

item_15:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg15
	mov edx, len15
	int 0x80
	jmp thanks

item_16:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg16
	mov edx, len16
	int 0x80
	jmp thanks

item_17:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg17
	mov edx, len17
	int 0x80
	jmp thanks

thanks:
	mov eax, 4
	mov ebx, 1
	mov ecx, msgthanks
	mov edx, lengthanks
	int 0x80

exit:
	mov eax, 1
	xor ebx, ebx		; exit code 0
	int 0x80