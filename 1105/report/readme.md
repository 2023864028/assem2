

### 8.10.1 Short Answer



1. **Which statements belong in a procedure's epilogue when the procedure has stack parameters and local variables?**
* **정답:** `mov esp, ebp` 와 `pop ebp` 명령어 (또는 `leave` 명령어), 그리고 이어서 `ret` (또는 `ret n`) 명령어가 옵니다.


2. **When a C function returns a 32-bit integer, where is the return value stored?**
* **정답:** `EAX` 레지스터에 저장됩니다.


3. **How does a program using the STDCALL calling convention clean up the stack after a procedure call?**
* **정답:** 호출된 프로시저(Called procedure) 내부에서 `ret n` 명령어(예: `ret 12`)를 사용하여 반환과 동시에 스택을 정리합니다.


4. **How is the LEA instruction more powerful than the OFFSET operator?**
* **정답:** `OFFSET` 연산자는 어셈블리 타임에 주소가 결정되는 전역 변수 등에만 사용할 수 있지만, `LEA` 명령어는 런타임에 결정되는 간접 피연산자(예: 런타임 스택에 있는 로컬 변수의 주소 `[ebp-4]`)의 오프셋 주소를 가져올 수 있습니다.


5. **In the C++ example shown in Section 8.2.3, how much stack space is used by a variable of type int?**
* **정답:** 4 바이트 (32-bit 환경 기준).


6. **What advantages might the C calling convention have over the STDCALL calling convention?**
* **정답:** 호출자(Caller)가 스택을 정리하므로, C 표준 함수의 `printf`처럼 가변 길이 인수(Variable-length argument) 리스트를 전달하는 것이 가능합니다.


7. **(True/False): When using the PROC directive, all parameters must be listed on the same line.**
* **정답:** False (줄 끝에 쉼표를 사용하여 여러 줄에 걸쳐 파라미터를 나열할 수 있습니다).


8. **(True/False): If you pass a variable containing the offset of an array of bytes to a procedure that expects a pointer to an array of words, the assembler will flag this as an error.**
* **정답:** False (둘 다 32비트 포인터/주소값이므로, 단순 변수 전달 시 어셈블러가 포인터가 가리키는 내부 데이터 타입까지 엄격하게 검사하여 오류로 처리하지는 않습니다).


9. **(True/False): If you pass an immediate value to a procedure that expects a reference parameter, you can generate a general-protection fault.**
* **정답:** True (참조 파라미터는 메모리 주소를 기대하는데, 즉시값을 주소로 취급하여 메모리에 접근하려 하면 잘못된 메모리 참조로 인해 보호 예외(GP Fault)가 발생합니다).



---

### 8.10.2 Algorithm Workbench



1. **Draw a picture of the procedure's stack frame immediately after EBP has been pushed on the runtime stack.**
```text
[ 스택 프레임 구조 (스택은 아래로 자람) ]
+-------------------+
|        10h        | <-- [EBP + 16] (push 10h)
+-------------------+
|        20h        | <-- [EBP + 12] (push 20h)
+-------------------+
|        30h        | <-- [EBP + 8]  (push 30h)
+-------------------+
| 반환 주소 (Ret)   | <-- [EBP + 4]  (call AddThree)
+-------------------+
| 저장된 이전 EBP   | <-- [EBP]      (ESP가 여기를 가리킴)
+-------------------+

```


2. **Create a procedure named AddThree...**
```assembly
AddThree PROC, val1:DWORD, val2:DWORD, val3:DWORD
    mov eax, val1
    add eax, val2
    add eax, val3
    ret
AddThree ENDP

```


3. **Declare a local variable named pArray that is a pointer to an array of doublewords.**
```assembly
LOCAL pArray:PTR DWORD

```


4. **Declare a local variable named buffer that is an array of 20 bytes.**
```assembly
LOCAL buffer[20]:BYTE

```



---

### 8.11 Programming Exercises



5. **Declare a local variable named pwArray that points to a 16-bit unsigned integer.**
```assembly
LOCAL pwArray:PTR WORD

```


6. **Declare a local variable named myByte that holds an 8-bit signed integer.**
```assembly
LOCAL myByte:SBYTE

```


7. **Declare a local variable named myArray that is an array of 20 doublewords.**
```assembly
LOCAL myArray[20]:DWORD

```


8. **Create a procedure named SetColor...**
* (참고: Irvine32의 `SetTextColor`는 EAX 레지스터에 색상값을 받으며 형식은 `(배경색 * 16) + 전경색` 입니다.)


```assembly
SetColor PROC, forecolor:DWORD, backcolor:DWORD
    mov eax, backcolor
    shl eax, 4          ; 배경색을 상위 4비트로 시프트 (x 16)
    or  eax, forecolor  ; 전경색과 결합
    call SetTextColor
    ret
SetColor ENDP

```


9. **Create a procedure named WriteColorChar...**
```assembly
WriteColorChar PROC, char:BYTE, forecolor:DWORD, backcolor:DWORD
    mov eax, backcolor
    shl eax, 4
    or  eax, forecolor
    call SetTextColor   ; 색상 설정

    mov al, char
    call WriteChar      ; 단일 문자 출력
    ret
WriteColorChar ENDP

```


10. **Write a procedure named DumpMemory...**
* (참고: `DumpMem`은 ESI=주소, ECX=요소 개수, EBX=요소의 크기를 인자로 사용합니다.)


```assembly
DumpMemory PROC USES esi ecx ebx, address:DWORD, units:DWORD, unitType:DWORD
    mov esi, address
    mov ecx, units
    mov ebx, unitType
    call DumpMem
    ret
DumpMemory ENDP

```


11. **Declare a procedure named MultArray...**
```assembly
; PROTO 선언
MultArray PROTO, ptr1:PTR DWORD, ptr2:PTR DWORD, count:DWORD

; PROC 선언
MultArray PROC, ptr1:PTR DWORD, ptr2:PTR DWORD, count:DWORD
    ; (함수 내부 구현 코드가 들어갈 자리)
    ret
MultArray ENDP

```


### 1. FindLargest Procedure

부호 있는 32비트(SDWORD) 배열에서 최댓값을 찾아 `EAX`에 반환하는 프로시저입니다. `USES` 지시어를 통해 `EAX`를 제외한 수정된 레지스터들을 보존합니다.

```assembly
; PROTO 선언
FindLargest PROTO, ptrArray:PTR SDWORD, arraySize:DWORD

; PROC 구현
FindLargest PROC USES esi ecx edx,
    ptrArray:PTR SDWORD, arraySize:DWORD
    
    mov esi, ptrArray       ; ESI에 배열 포인터 저장
    mov ecx, arraySize      ; ECX에 배열 길이 저장
    mov eax, [esi]          ; 첫 번째 요소를 임시 최댓값으로 설정
    add esi, 4              ; 다음 요소로 포인터 이동
    dec ecx                 ; 남은 비교 횟수 감소
    jz L_End                ; 배열 길이가 1이었다면 바로 종료

L_Loop:
    mov edx, [esi]
    cmp edx, eax            ; 현재 요소(EDX)와 최댓값(EAX) 비교
    jle L_Next              ; 현재 요소가 작거나 같으면 건너뜀
    mov eax, edx            ; 더 크면 최댓값 갱신
L_Next:
    add esi, 4              ; 다음 요소로 이동
    loop L_Loop             ; ECX가 0이 될 때까지 반복
L_End:
    ret
FindLargest ENDP

```

---

### 4. FindThrees Procedure

배열 내에서 숫자 '3'이 연속으로 3번 등장하면 `EAX`에 1을, 그렇지 않으면 0을 반환합니다.

```assembly
; PROTO 선언
FindThrees PROTO, ptrArray:PTR DWORD, arrSize:DWORD

; PROC 구현
FindThrees PROC USES esi ecx,
    ptrArray:PTR DWORD, arrSize:DWORD
    
    mov esi, ptrArray
    mov ecx, arrSize
    sub ecx, 2              ; 3개가 연속되는지 보려면 최소 (크기-2)번 검사해야 함
    jl L_False              ; 배열 크기가 3 미만이면 무조건 0

L_Loop:
    mov eax, [esi]
    cmp eax, 3
    jne L_Next              ; 첫 번째가 3이 아니면 다음 위치로
    
    mov eax, [esi+4]
    cmp eax, 3
    jne L_Next              ; 두 번째가 3이 아니면 다음 위치로
    
    mov eax, [esi+8]
    cmp eax, 3
    je L_True               ; 세 번째까지 3이면 성공

L_Next:
    add esi, 4
    loop L_Loop             ; 못 찾으면 포인터를 한 칸(4바이트) 옮겨 다시 검사

L_False:
    mov eax, 0
    jmp L_End
L_True:
    mov eax, 1
L_End:
    ret
FindThrees ENDP

```

---

### 5. DifferentInputs Procedure

입력받은 3개의 파라미터 값이 모두 서로 다르면 `EAX`에 1을, 하나라도 같은 값이 있다면 0을 반환합니다.

```assembly
; PROTO 선언
DifferentInputs PROTO, val1:DWORD, val2:DWORD, val3:DWORD

; PROC 구현
DifferentInputs PROC,
    val1:DWORD, val2:DWORD, val3:DWORD
    
    mov eax, val1
    cmp eax, val2
    je L_Same               ; val1 == val2 이면 종료
    cmp eax, val3
    je L_Same               ; val1 == val3 이면 종료
    
    mov eax, val2
    cmp eax, val3
    je L_Same               ; val2 == val3 이면 종료
    
    mov eax, 1              ; 모두 다르면 1 반환
    jmp L_End
L_Same:
    mov eax, 0              ; 하나라도 같으면 0 반환
L_End:
    ret
DifferentInputs ENDP

```

---

### 7. Greatest Common Divisor (GCD)

유클리드 호제법을 이용해 두 정수의 최대공약수를 구하는 재귀(Recursive) 프로시저입니다. (C언어 논리: `if (y == 0) return x; else return GCD(y, x % y);`)

```assembly
; PROTO 선언
CalcGcd PROTO, val1:DWORD, val2:DWORD

; PROC 구현
CalcGcd PROC USES ebx edx,
    val1:DWORD, val2:DWORD
    
    mov eax, val1           ; EAX = x
    mov ebx, val2           ; EBX = y
    
    cmp ebx, 0
    je L_BaseCase           ; y가 0이면 x(현재 EAX)가 최대공약수
    
    ; 나눗셈을 위해 EDX 초기화 후 EDX:EAX / EBX 수행
    xor edx, edx
    div ebx                 ; 나눗셈 결과: EAX = 몫, EDX = 나머지 (x % y)
    
    ; 재귀 호출: CalcGcd(y, 나머지)
    INVOKE CalcGcd, ebx, edx
    jmp L_End
    
L_BaseCase:
    mov eax, val1
L_End:
    ret
CalcGcd ENDP

```

---

### 8. Counting Matching Elements

두 배열에서 같은 인덱스에 위치한 요소들의 값이 동일한 경우의 수를 카운트하여 `EAX`에 반환합니다.

```assembly
; PROTO 선언
CountMatches PROTO, ptr1:PTR SDWORD, ptr2:PTR SDWORD, arrLen:DWORD

; PROC 구현
CountMatches PROC USES esi edi ecx edx,
    ptr1:PTR SDWORD, ptr2:PTR SDWORD, arrLen:DWORD
    
    mov esi, ptr1
    mov edi, ptr2
    mov ecx, arrLen
    xor eax, eax            ; 매칭 카운트(EAX)를 0으로 초기화
    
    cmp ecx, 0
    jle L_End               ; 배열 크기가 0 이하인 경우 방어코드

L_Loop:
    mov edx, [esi]          ; 첫 번째 배열 요소 읽기
    cmp edx, [edi]          ; 두 번째 배열 요소와 비교
    jne L_Skip              ; 다르면 카운트 증가 생략
    inc eax                 ; 같으면 EAX(카운트) 1 증가
L_Skip:
    add esi, 4              ; SDWORD이므로 포인터를 4바이트씩 이동
    add edi, 4
    loop L_Loop             ; ECX가 0이 될 때까지 반복

L_End:
    ret
CountMatches ENDP

```


### 9. Counting Nearly Matching Elements

두 개의 부호 있는 32비트(SDWORD) 배열을 비교하여, 같은 인덱스의 두 원소 값의 차이가 허용 오차(`diff`) 이하인 경우의 수를 카운트하여 `EAX`에 반환하는 프로시저입니다.

절댓값을 구하기 위해 두 값을 뺀 후 음수일 경우 `neg` 명령어를 사용하여 양수로 변환하는 로직을 사용합니다.

```assembly
; PROTO 선언
CountNearMatches PROTO,
    ptr1:PTR SDWORD,
    ptr2:PTR SDWORD,
    arrLen:DWORD,
    diff:DWORD

; PROC 구현
CountNearMatches PROC USES esi edi ecx ebx edx,
    ptr1:PTR SDWORD, ptr2:PTR SDWORD, arrLen:DWORD, diff:DWORD
    
    mov esi, ptr1           ; 첫 번째 배열 포인터
    mov edi, ptr2           ; 두 번째 배열 포인터
    mov ecx, arrLen         ; 배열 길이(반복 횟수)
    xor eax, eax            ; 매칭 횟수(EAX) 0으로 초기화
    
    cmp ecx, 0
    jle L_End               ; 배열 길이가 0 이하면 종료

L_Loop:
    mov ebx, [esi]          ; x_i
    mov edx, [edi]          ; y_i
    sub ebx, edx            ; ebx = x_i - y_i
    jns L_CheckDiff         ; 결과가 양수(부호 비트 0)이면 절댓값 변환 건너뜀
    neg ebx                 ; 음수이면 2의 보수를 취해 양수(절댓값)로 변환

L_CheckDiff:
    cmp ebx, diff           ; 절댓값 오차(EBX)와 허용 오차(diff) 비교
    jg L_Skip               ; 오차가 diff보다 크면 카운트 생략
    inc eax                 ; 조건을 만족하면 카운트(EAX) 1 증가

L_Skip:
    add esi, 4              ; SDWORD이므로 다음 원소로 4바이트 이동
    add edi, 4
    loop L_Loop             ; ECX가 0이 될 때까지 반복

L_End:
    ret                     ; EAX에 결과가 담긴 채로 반환
CountNearMatches ENDP

```

---

### 10. Show Procedure Parameters

호출한 프로시저(Caller)의 런타임 스택에 전달된 파라미터들의 메모리 주소와 16진수 값을 출력하는 프로시저입니다.

이 문제를 해결하기 위한 핵심은 **스택 프레임(Stack Frame) 체이닝**입니다. 현재 프로시저(`ShowParams`)의 `EBP`가 가리키는 곳에는 호출자(`MySample`)의 `EBP` 값이 저장되어 있습니다. 이를 통해 호출자의 스택 프레임으로 거슬러 올라가 파라미터(호출자의 `EBP + 8`부터 시작)를 읽어올 수 있습니다.

```assembly
; 문자열 데이터를 위한 데이터 섹션 (호출 프로그램의 .data 영역에 선언되었다고 가정)
.data
msgHeader BYTE "Stack parameters:", 0dh, 0ah
          BYTE "---------------------------", 0
msgAddr   BYTE "Address ", 0
msgEq     BYTE " = ", 0

.code
; PROTO 선언
ShowParams PROTO, paramCount:DWORD

; PROC 구현
ShowParams PROC USES eax ebx ecx edx,
    paramCount:DWORD

    ; 헤더 출력
    mov edx, OFFSET msgHeader
    call WriteString
    call Crlf

    mov ecx, paramCount
    cmp ecx, 0
    jle L_End               ; 출력할 파라미터가 없으면 종료

    ; 호출자의 EBP를 찾아 파라미터 시작 위치(낮은 주소)로 이동
    ; [ebp] 에는 호출자(MySample)의 EBP가 들어있음
    mov ebx, [ebp]
    add ebx, 8              ; 호출자의 첫 번째 파라미터 주소 (EBP + 8)

L_Loop:
    ; "Address " 출력
    mov edx, OFFSET msgAddr
    call WriteString

    ; 파라미터의 주소(EBX) 출력
    mov eax, ebx
    call WriteHex

    ; " = " 출력
    mov edx, OFFSET msgEq
    call WriteString

    ; 파라미터의 실제 값([EBX]) 출력
    mov eax, [ebx]
    call WriteHex
    call Crlf

    ; 다음 파라미터로 이동 (주소가 4바이트씩 증가)
    add ebx, 4
    loop L_Loop

L_End:
    ret
ShowParams ENDP

```
