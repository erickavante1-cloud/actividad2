        AREA    RESET, CODE, READONLY
        ENTRY
        EXPORT  __main

__main
        ; R0 = direcci�n de N
        LDR     R0, =N          
        LDR     R1, [R0]        ; R1 = valor de N
        LDR     R2, =FIB_BASE   ; R2 = direcci�n base en RAM para la secuencia

        ; Primer t�rmino (F0 = 0)
        MOVS    R3, #0          
        STR     R3, [R2], #4    
        CMP     R1, #0          
        BEQ     stop            

        ; Segundo t�rmino (F1 = 1)
        MOVS    R3, #1          
        STR     R3, [R2], #4    
        CMP     R1, #1          
        BEQ     stop            

        ; Iteraci�n para Fn = Fn-1 + Fn-2
        MOVS    R4, #0          ; Fn-2
        MOVS    R5, #1          ; Fn-1
        SUBS    R1, R1, #1      ; ya guardamos dos t�rminos

loop
        ADDS    R6, R4, R5      ; R6 = Fn
        STR     R6, [R2], #4    ; guardar en SRAM
        MOV     R4, R5          ; Fn-2 = Fn-1
        MOV     R5, R6          ; Fn-1 = Fn
        SUBS    R1, R1, #1      ; decrementar contador
        BNE     loop            

stop
        B       stop            ; bucle infinito (detener el programa)

; ===============================
; Datos en RAM
; ===============================
        AREA    DATA, DATA, READWRITE, ALIGN=2

N       DCD     9               ; N�mero de t�rminos (puedes cambiarlo de 0 a 47)
FIB_BASE
        SPACE   200             ; espacio para ~50 n�meros de 32 bits

        END
