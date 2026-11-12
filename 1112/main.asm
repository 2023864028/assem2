
INCLUDE Irvine32.inc

.data
    msg1 BYTE "Enter first number: ", 0
    msg2 BYTE "Enter second number: ", 0
    msg3 BYTE "Enter third number: ", 0
    msg4 BYTE "Enter fourth number: ", 0
    msg5 BYTE "Enter fifth number: ", 0
    resultMsg BYTE "Average = ", 0

    num1 DWORD ?
    num2 DWORD ?
    num3 DWORD ?
    num4 DWORD ?
    num5 DWORD ?

.code
main PROC

    ; 첫 번째 숫자 입력
    mov edx, OFFSET msg1
    call WriteString
    call ReadInt
    mov num1, eax

    ; 두 번째 숫자 입력
    mov edx, OFFSET msg2
    call WriteString
    call ReadInt
    mov num2, eax

    ; 세 번째 숫자 입력
    mov edx, OFFSET msg3
    call WriteString
    call ReadInt
    mov num3, eax

    ; 네 번째 숫자 입력
    mov edx, OFFSET msg4
    call WriteString
    call ReadInt
    mov num4, eax

    ; 다섯 번째 숫자 입력
    mov edx, OFFSET msg5
    call WriteString
    call ReadInt
    mov num5, eax

    ; 5개 숫자 합산
    mov eax, num1
    add eax, num2
    add eax, num3
    add eax, num4
    add eax, num5

    ; 평균 계산
    cdq
    mov ebx, 5
    idiv ebx

    ; 결과 출력
    mov edx, OFFSET resultMsg
    call WriteString

    call WriteInt
    call Crlf

    exit

main ENDP
END main
