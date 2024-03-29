bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 3h
    b db 7h
    e dw 22h
    f dw 13h
    g dw 45h
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(e+f+g)/(a+b) - PROBLEM 25 : e,f,g - word, a,b - byte
        ; exit(0)
        
        mov eax, 0
        mov ax, [e]
        add ax,[f]
        add ax, [g] ; AX = e+f+g
        
        mov ecx, 0
        mov cl, [a]
        add cl, [b]; CL = a+b
        
        div cl; AL = quotient, AH = remainder
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
