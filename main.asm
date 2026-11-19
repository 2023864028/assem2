.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'First number: $'
    MSG2 DB 0DH,0AH,'Second number: $'
    MSG3 DB 0DH,0AH,'Addition: $'
    MSG4 DB 0DH,0AH,'Subtraction: $'
    MSG5 DB 0DH,0AH,'Multiplication: $'
    MSG6 DB 0DH,0AH,'Division: $'

    MSG7 DB 0DH,0AH,'AX = $'
    MSG8 DB 0DH,0AH,'BX = $'
    MSG9 DB 0DH,0AH,'CX = $'
    MSG10 DB 0DH,0AH,'DX = $'

    NUM1 DW ?
    NUM2 DW ?
    RESULT DW ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 첫 번째 숫자 입력
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    MOV NUM1, AX

    ; 두 번째 숫자 입력
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    MOV NUM2, AX

    ; 덧셈
    MOV AX, NUM1
    ADD AX, NUM2

    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    ; 뺄셈
    MOV AX, NUM1
    SUB AX, NUM2

    LEA DX, MSG4
    MOV AH, 09H
    INT 21H

    ; 곱셈
    MOV AX, NUM1
    MUL NUM2

    LEA DX, MSG5
    MOV AH, 09H
    INT 21H

    ; 나눗셈
    MOV AX, NUM1
    MOV DX, 0
    DIV NUM2

    LEA DX, MSG6
    MOV AH, 09H
    INT 21H

    ; 레지스터 출력
    MOV AX, NUM1
    MOV BX, NUM2
    MOV CX, 0
    MOV DX, 0

    LEA DX, MSG7
    MOV AH, 09H
    INT 21H

    MOV AX, NUM1

    ; 종료
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
