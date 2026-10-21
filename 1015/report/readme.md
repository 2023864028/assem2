**1.** `mov bx, 0FFFFh` 명령어로 BX가 `FFFFh`로 초기화됩니다. 어떤 값이든 모든 비트가 1인 `FFFFh`와 AND 연산을 하면 자기 자신이 됩니다.

* **답: `006Bh` (또는 `6Bh`)**

**2.** `91BAh` (1001 0001 1011 1010)와 `0092h` (0000 0000 1001 0010)를 비트 단위 AND 연산합니다.

* **답: `0092h` (또는 `92h`)**

**3.** `0649Bh` (0110 0100 1001 1011)와 `003Ah` (0000 0000 0011 1010)를 비트 단위 OR 연산합니다.

* **답: `64BBh**`

**4.** `029D6h` (0010 1001 1101 0110)와 `8181h` (1000 0001 1000 0001)를 비트 단위 XOR 연산합니다. (서로 다를 때 1)

* **답: `A857h**`

**5.** `AFAF649Bh`와 `3A219604h`를 비트 단위 OR 연산합니다.

* **답: `BFAFF69Fh**`

**6.** `AFAF649Bh`를 `FFFFFFFFh`(모든 비트가 1)와 비트 단위 XOR 연산하면 하위 32비트가 완전히 반전(NOT)됩니다. 상위 32비트는 0으로 유지됩니다.

* **답: `0000000050509B64h` (또는 `50509B64h`)**

**7. (이진수 결과)**

* **a.** `01101111b` AND `00101101b` = **`00101101b`**
* **b.** `6Dh`(`01101101b`) AND `4Ah`(`01001010b`) = **`01001000b`**
* **c.** `00001111b` OR `61h`(`01100001b`) = **`01101111b`**
* **d.** `94h`(`10010100b`) XOR `37h`(`00110111b`) = **`10100011b`**

**8. (16진수 결과)**

* **a.** `7Ah` (0111 1010)를 NOT 연산 (1000 0101) = **`85h`**
* **b.** `3Dh` (0011 1101) AND `74h` (0111 0100) = **`34h`**
* **c.** `9Bh` (1001 1011) OR `35h` (0011 0101) = **`BFh`**
* **d.** `72h` (0111 0010) XOR `0DCh` (1101 1100) = **`AEh`**

**9. (Carry, Zero, Sign 플래그 결과)**

* **a.** `test` 명령어는 AND 연산을 수행하지만 값은 저장하지 않고 플래그만 변경합니다. `00001111b` AND `00000010b` = `00000010b` (0이 아니고, 최상위 비트 0). `test`는 항상 CF를 0으로 만듭니다.
* **CF=0, ZF=0, SF=0**


* **b.** `cmp` 명령어는 뺄셈을 수행합니다. 6 - 5 = 1. (양수, 0 아님, 빌림 없음).
* **CF=0, ZF=0, SF=0**


* **c.** 5 - 7 = -2. (음수이므로 SF=1, 결과가 0이 아니므로 ZF=0, 작은 수에서 큰 수를 뺐으므로 빌림 발생 CF=1).
* **CF=1, ZF=0, SF=1**



**10.** ECX 레지스터의 값이 0일 때 분기를 실행하는 조건부 점프 명령어는 **`JECXZ` (Jump if ECX is Zero)** 입니다.

**11.** `JA` (Jump if Above)와 `JNBE` 명령어는 부호 없는(unsigned) 크기 비교 시 대상이 더 클 때 점프합니다. 즉, Carry Flag(CF)가 0이고 Zero Flag(ZF)가 0일 때 점프가 실행됩니다.

* **답: CF = 0 이고 ZF = 0 일 때 점프한다.**

**12.** `eax`에 저장된 `7FFFh` (32,767)와 `8000h` (32,768)를 비교합니다. `jl` (Jump if Less)은 부호 있는(signed) 비교를 수행하므로 32,767 < 32,768 조건이 참(True)이 됩니다. 따라서 `L1` 레이블로 점프가 수행되며 `mov edx, 0` 명령어는 건너뜁니다.

* **답: `1**`

**13.** `cmp eax, 8000h` 명령어 후 `jb L1` (Jump if Below)이 실행됩니다. `jb`는 부호 없는(unsigned) 비교에서 왼쪽 피연산자가 더 작을 때 점프합니다. `7FFFh` (32,767)는 부호 없는 값으로 `8000h` (32,768)보다 작으므로 조건이 참이 되어 `L1`으로 점프합니다. `mov edx, 0`은 건너뛰게 됩니다.

* **답: `1**`

**14.** `cmp eax, 0FFFF8000h` 명령어 후 `jl L2` (Jump if Less)가 실행됩니다. `jl`은 부호 있는(signed) 비교에서 왼쪽 피연산자가 더 작을 때 점프합니다. EAX의 `7FFFh`는 양수 32,767이고, `0FFFF8000h`는 음수 -32,768입니다. 32,767 < -32,768 조건은 거짓이므로 점프하지 않고 `mov edx, 0`이 실행됩니다.

* **답: `0**`

**15.** `jg` (Jump if Greater)는 부호 있는 비교에서 왼쪽이 더 클 때 점프합니다. -30은 -50보다 크므로 점프가 실행됩니다.

* **답: True**

**16.** `ja` (Jump if Above)는 부호 없는 비교에서 왼쪽이 더 클 때 점프합니다. `eax`에 `-42`가 들어가면 16진수 `FFFFFFD6h`로 저장되며, 이는 부호 없는 값으로 볼 때 매우 큰 양수입니다. 따라서 `26`(`0000001Ah`)보다 크므로 점프가 실행됩니다.

* **답: True**

**17.** 모든 비트가 1인 `0FFFFFFFFFFFFFFFFh`와 `80h`를 비트 단위 AND 연산하면 `80h` 부분만 남습니다.

* **답: `0000000000000080h` (또는 `80h`)**

**18.** 위와 동일한 원리로 `808080h` 부분만 남습니다.

* **답: `0000000000808080h` (또는 `808080h`)**

**19.** 위와 동일하게 비트 연산이 적용됩니다. *(참고: x86-64 어셈블러에 따라 최상위 비트가 1인 32비트 immediate 값(`80808080h`)이 64비트로 부호 확장(sign-extension)되어 실제 기계어 동작 시 `FFFFFFFF80808080h`가 될 수도 있으나, 일반적인 비트 마스킹 논리에서는 주어진 값 자체가 답이 됩니다.)*

* **답: `0000000080808080h` (또는 `80808080h`)**

---

### 6.10.2 Algorithm Workbench

**1. AL 레지스터의 ASCII 숫자를 이진 값으로 변환 (단일 명령어)**
ASCII 숫자('0'~'9', 즉 30h~39h)의 상위 4비트를 0으로 지우면 00h~09h가 됩니다. 이미 이진 값이어도 0Fh와 AND 연산하면 값이 유지됩니다.

```assembly
and al, 0Fh

```

**2. 32비트 메모리 피연산자의 패리티 계산 (B0 XOR B1 XOR B2 XOR B3)**

```assembly
mov eax, [mem32]      ; 32비트 메모리 값을 EAX로 로드
mov edx, eax          ; EAX 값을 EDX에 복사
shr edx, 16           ; EDX를 오른쪽으로 16비트 시프트 (B3, B2를 하위로 이동)
xor eax, edx          ; AX = (B0 XOR B2), (B1 XOR B3)
mov dl, ah            ; AH(B1 XOR B3)를 DL로 복사
xor al, dl            ; AL = (B0 XOR B2) XOR (B1 XOR B3)

```

*(실행 후 AL 레지스터에 최종 패리티 결과가 저장됩니다.)*

**3. SetX에는 속하지만 SetY에는 속하지 않는 멤버를 EAX에 생성 (SetX AND NOT SetY)**

```assembly
mov eax, SetX         ; SetX 값을 EAX로 로드
mov ebx, SetY         ; SetY 값을 EBX로 로드
not ebx               ; SetY의 비트를 반전 (NOT SetY)
and eax, ebx          ; EAX = SetX AND (NOT SetY)

```

**4. DX의 부호 없는 정수가 CX의 부호 없는 정수보다 작거나 같을 때 L1으로 점프**

```assembly
cmp dx, cx
jbe L1                ; Jump if Below or Equal (부호 없는 비교)

```

**5. AX의 부호 있는 정수가 CX의 부호 있는 정수보다 클 때 L2로 점프**

```assembly
cmp ax, cx
jg L2                 ; Jump if Greater (부호 있는 비교)

```

### 1. Filling an Array (배열을 난수로 채우기)

$N$개의 더블워드(32비트) 배열을 $j$부터 $k$까지의 난수로 채우는 프로시저입니다. `RandomRange` 함수를 사용하여 난수를 생성합니다.

```assembly
;---------------------------------------------------------
; FillArray
; 주어진 범위(j~k) 내의 난수로 배열을 채웁니다.
; 입력: 
;   ESI = 배열의 포인터
;   ECX = 배열의 크기 (N)
;   EAX = 범위의 최솟값 (j)
;   EBX = 범위의 최댓값 (k)
; 반환: 없음
;---------------------------------------------------------
FillArray PROC USES eax ebx ecx edx esi
    ; RandomRange는 0부터 (n-1)까지의 난수를 생성하므로
    ; (k - j + 1)을 계산하여 범위를 설정합니다.
    sub ebx, eax    ; EBX = k - j
    inc ebx         ; EBX = k - j + 1
    mov edx, eax    ; EDX에 최솟값 j를 임시 저장

L1:
    mov eax, ebx    ; RandomRange의 입력값으로 (k-j+1) 설정
    call RandomRange; EAX에 0부터 (k-j) 사이의 난수 반환
    add eax, edx    ; 난수에 최솟값 j를 더해 최종 범위(j~k) 달성
    
    mov [esi], eax  ; 배열에 난수 저장
    add esi, 4      ; 다음 배열 요소로 이동 (더블워드 = 4바이트)
    loop L1         ; ECX가 0이 될 때까지 반복

    ret
FillArray ENDP

```

### 2. Summing Array Elements in a Range (범위 내의 배열 요소 합계 구하기)

배열 내의 값들 중 $j$와 $k$ 사이(포함)에 있는 값들만 찾아 합계를 구합니다. 결과는 EAX 레지스터에 반환되어야 하므로 EAX는 보존(USES) 목록에서 제외합니다.

```assembly
;---------------------------------------------------------
; SumRange
; 배열 요소 중 j와 k 범위 내에 있는 값들의 합을 구합니다.
; 입력:
;   ESI = 부호 있는 더블워드 배열의 포인터
;   ECX = 배열의 크기
;   EBX = 범위의 최솟값 (j)
;   EDX = 범위의 최댓값 (k)
; 반환:
;   EAX = 조건에 맞는 요소들의 합
;---------------------------------------------------------
SumRange PROC USES ebx ecx edx esi edi
    mov eax, 0      ; 합계를 저장할 EAX를 0으로 초기화

L1:
    mov edi, [esi]  ; 현재 배열 요소를 EDI로 가져옴
    
    ; 범위 검사 (edi < j 또는 edi > k 인 경우 건너뜀)
    cmp edi, ebx
    jl Skip         ; 현재 값이 j(EBX)보다 작으면 Skip
    cmp edi, edx
    jg Skip         ; 현재 값이 k(EDX)보다 크면 Skip
    
    add eax, edi    ; 조건을 만족하면 EAX에 더함

Skip:
    add esi, 4      ; 다음 요소로 이동
    loop L1

    ret
SumRange ENDP

```

### 3. Test Score Evaluation (시험 점수 평가)

0에서 100 사이의 점수를 입력받아 미국의 일반적인 성적 등급(A, B, C, D, F)에 해당하는 알파벳을 반환합니다.

```assembly
;---------------------------------------------------------
; CalcGrade
; 0~100 사이의 점수를 학점(A~F) 문자로 변환합니다.
; 입력: 
;   EAX = 시험 점수 (0 ~ 100)
; 반환:
;   AL = 학점 문자 ('A', 'B', 'C', 'D', 'F')
;---------------------------------------------------------
CalcGrade PROC
    ; AL로 결과를 반환하므로 EAX 전체 값 변경을 주의해야 합니다.
    ; CMP 명령어를 통해 점수 구간을 확인합니다.
    cmp eax, 90
    jae GradeA      ; 90 이상이면 A
    cmp eax, 80
    jae GradeB      ; 80 이상이면 B
    cmp eax, 70
    jae GradeC      ; 70 이상이면 C
    cmp eax, 60
    jae GradeD      ; 60 이상이면 D
    
    ; 60 미만인 경우 F
    mov al, 'F'
    jmp Done

GradeA: 
    mov al, 'A'
    jmp Done
GradeB: 
    mov al, 'B'
    jmp Done
GradeC: 
    mov al, 'C'
    jmp Done
GradeD: 
    mov al, 'D'

Done:
    ret
CalcGrade ENDP

```assembly
INCLUDE Irvine32.inc

.data
    msgScore BYTE "Score: ", 0
    msgGrade BYTE ", Grade: ", 0

.code
main PROC
    call Randomize      ; 난수 시드 초기화
    mov ecx, 10         ; 10번 반복

TestLoop:
    ; 50 ~ 100 사이의 난수 생성 (범위 51, 시작 50)
    mov eax, 51
    call RandomRange
    add eax, 50
    
    ; 점수 출력
    push eax            ; 점수 백업
    mov edx, OFFSET msgScore
    call WriteString
    call WriteDec
    pop eax             ; 점수 복구
    
    ; CalcGrade 호출 및 결과 출력
    call CalcGrade      ; AL에 등급(A~F) 반환
    mov edx, OFFSET msgGrade
    call WriteString
    call WriteChar      ; AL의 문자 출력
    call Crlf
    
    loop TestLoop
    exit
main ENDP

;---------------------------------------------------------
; CalcGrade
; 0~100 사이의 점수를 입력받아 등급(A~F)을 AL에 반환
; 입력: EAX = 점수
; 반환: AL = 등급 문자
;---------------------------------------------------------
CalcGrade PROC USES ebx ecx edx esi edi
    cmp eax, 90
    jae GradeA
    cmp eax, 80
    jae GradeB
    cmp eax, 70
    jae GradeC
    cmp eax, 60
    jae GradeD
    mov al, 'F'
    jmp Done

GradeA: mov al, 'A'
        jmp Done
GradeB: mov al, 'B'
        jmp Done
GradeC: mov al, 'C'
        jmp Done
GradeD: mov al, 'D'

Done:
    ret
CalcGrade ENDP
END main

```

---

### 4. College Registration

`.IF`/`.ELSEIF` 지시어 대신 하위 수준의 `CMP`와 조건부 점프 명령어를 사용하여 논리를 구현하고, 학점(credits) 범위를 검사(1~30)하는 프로그램입니다. (Section 6.7.3의 구체적인 등록 조건 예시로 평균 학점(GPA)이 특정 기준 이상이거나 신청 학점이 특정 기준 이하일 때 등록 가능하다고 가정하여 구조화했습니다.)

```assembly
INCLUDE Irvine32.inc

.data
    promptGPA BYTE "Enter grade average (e.g., 1 to 400): ", 0
    promptCredits BYTE "Enter credits (1 to 30): ", 0
    msgInvalid BYTE "Error: Credits must be between 1 and 30.", 0
    msgSuccess BYTE "The student can register.", 0
    msgFail BYTE "The student cannot register.", 0
    
    gradeAvg DWORD ?
    credits DWORD ?

.code
main PROC
    ; 학점(credits) 입력 및 범위 검사
    mov edx, OFFSET promptCredits
    call WriteString
    call ReadDec
    mov credits, eax

    ; 1 미만 또는 30 초과 검사
    cmp eax, 1
    jb InvalidCredits
    cmp eax, 30
    ja InvalidCredits

    ; 평균 학점(GPA) 입력
    mov edx, OFFSET promptGPA
    call WriteString
    call ReadDec
    mov gradeAvg, eax

    ; 등록 논리 평가 (예: 평점 250 이상이면 무조건 통과, 아니면 학점 12 이하만 통과)
    cmp gradeAvg, 250
    jae CanRegister     ; GPA >= 250 이면 등록 가능
    
    cmp credits, 12
    jbe CanRegister     ; GPA가 낮아도 credits <= 12 이면 등록 가능
    jmp CannotRegister  ; 둘 다 만족하지 않으면 등록 불가

CanRegister:
    mov edx, OFFSET msgSuccess
    jmp DisplayResult

CannotRegister:
    mov edx, OFFSET msgFail
    jmp DisplayResult

InvalidCredits:
    mov edx, OFFSET msgInvalid

DisplayResult:
    call WriteString
    call Crlf
    exit
main ENDP
END main

```

---

### 5. Boolean Calculator (1)

`Table-Driven Selection` 기법(Section 6.5.4)을 사용하여 사용자의 메뉴 선택에 따라 적절한 프로시저를 호출하는 부울 계산기 골격 프로그램입니다.

```assembly
INCLUDE Irvine32.inc

.data
    msgMenu BYTE "1. x AND y", 0dh, 0ah
            BYTE "2. x OR y", 0dh, 0ah
            BYTE "3. NOT x", 0dh, 0ah
            BYTE "4. x XOR y", 0dh, 0ah
            BYTE "5. Exit program", 0dh, 0ah
            BYTE "Enter choice (1-5): ", 0
            
    msgAND BYTE "AND operation selected.", 0
    msgOR  BYTE "OR operation selected.", 0
    msgNOT BYTE "NOT operation selected.", 0
    msgXOR BYTE "XOR operation selected.", 0
    
    ; 테이블 기반 선택 구조 (문자 '1'~'5' 매핑)
    CaseTable BYTE '1'                  ; 입력 값
              DWORD AND_op              ; 호출할 프로시저 주소
    EntrySize = ($ - CaseTable)
              BYTE '2'
              DWORD OR_op
              BYTE '3'
              DWORD NOT_op
              BYTE '4'
              DWORD XOR_op
              BYTE '5'
              DWORD Exit_op
    NumberOfEntries = ($ - CaseTable) / EntrySize

.code
main PROC
MenuLoop:
    ; 메뉴 출력 및 입력 대기
    mov edx, OFFSET msgMenu
    call WriteString
    call ReadChar       ; AL에 입력 문자 저장
    call Crlf

    ; 테이블 검색
    mov ebx, OFFSET CaseTable
    mov ecx, NumberOfEntries

L1:
    cmp al, [ebx]       ; 입력값과 테이블의 값 비교
    jne L2              ; 일치하지 않으면 다음 항목으로
    call DWORD PTR [ebx + 1]  ; 일치하면 해당 프로시저 호출
    call Crlf
    jmp MenuLoop        ; 작업 후 메뉴로 복귀

L2:
    add ebx, EntrySize  ; 다음 테이블 항목(5바이트 앞)으로 이동
    loop L1

    jmp MenuLoop        ; 잘못된 입력 시 다시 메뉴로

main ENDP

; --- 연산 더미 프로시저 ---
AND_op PROC
    mov edx, OFFSET msgAND
    call WriteString
    ret
AND_op ENDP

OR_op PROC
    mov edx, OFFSET msgOR
    call WriteString
    ret
OR_op ENDP

NOT_op PROC
    mov edx, OFFSET msgNOT
    call WriteString
    ret
NOT_op ENDP

XOR_op PROC
    mov edx, OFFSET msgXOR
    call WriteString
    ret
XOR_op ENDP

Exit_op PROC
    exit
Exit_op ENDP

END main



### 6. Boolean Calculator (2)

이전 5번 문제의 뼈대에 추가하여 16진수를 입력받고 비트 연산(`AND`, `OR`, `NOT`, `XOR`)을 수행한 뒤 결과를 16진수로 출력하는 프로시저들을 구현합니다.

```assembly
INCLUDE Irvine32.inc

.data
    prompt1 BYTE "Enter the first 32-bit hexadecimal integer: ", 0
    prompt2 BYTE "Enter the second 32-bit hexadecimal integer: ", 0
    promptNOT BYTE "Enter a 32-bit hexadecimal integer: ", 0
    msgResult BYTE "The result is: ", 0

.code
; (메인 프로시저와 메뉴 루프는 이전 5번 문제와 동일)

;---------------------------------------------------------
AND_op PROC USES eax ebx edx
    mov edx, OFFSET prompt1
    call WriteString
    call ReadHex        ; 첫 번째 값 EAX에 입력
    mov ebx, eax        ; EBX에 임시 저장

    mov edx, OFFSET prompt2
    call WriteString
    call ReadHex        ; 두 번째 값 EAX에 입력

    and eax, ebx        ; EAX = EAX AND EBX

    mov edx, OFFSET msgResult
    call WriteString
    call WriteHex       ; 결과 출력
    call Crlf
    ret
AND_op ENDP

;---------------------------------------------------------
OR_op PROC USES eax ebx edx
    mov edx, OFFSET prompt1
    call WriteString
    call ReadHex
    mov ebx, eax

    mov edx, OFFSET prompt2
    call WriteString
    call ReadHex

    or eax, ebx         ; EAX = EAX OR EBX

    mov edx, OFFSET msgResult
    call WriteString
    call WriteHex
    call Crlf
    ret
OR_op ENDP

;---------------------------------------------------------
NOT_op PROC USES eax edx
    mov edx, OFFSET promptNOT
    call WriteString
    call ReadHex

    not eax             ; EAX = NOT EAX

    mov edx, OFFSET msgResult
    call WriteString
    call WriteHex
    call Crlf
    ret
NOT_op ENDP

;---------------------------------------------------------
XOR_op PROC USES eax ebx edx
    mov edx, OFFSET prompt1
    call WriteString
    call ReadHex
    mov ebx, eax

    mov edx, OFFSET prompt2
    call WriteString
    call ReadHex

    xor eax, ebx        ; EAX = EAX XOR EBX

    mov edx, OFFSET msgResult
    call WriteString
    call WriteHex
    call Crlf
    ret
XOR_op ENDP

```

---

### 7. Probabilities and Colors

0부터 9까지의 난수를 생성하여 확률(White 30%, Blue 10%, Green 60%)에 따라 20줄의 텍스트 색상을 무작위로 출력하는 프로그램입니다.

```assembly
INCLUDE Irvine32.inc

.data
    msgText BYTE "This line is displayed in a random color.", 0

.code
main PROC
    call Randomize      ; 난수 시드 초기화
    mov ecx, 20         ; 20줄 출력 반복

L1:
    mov eax, 10
    call RandomRange    ; 0 ~ 9 사이의 난수 생성
    
    cmp eax, 2
    jbe IsWhite         ; 0, 1, 2 이면 White (30%)
    
    cmp eax, 3
    je IsBlue           ; 3 이면 Blue (10%)
    
    jmp IsGreen         ; 나머지(4~9)는 Green (60%)

IsWhite:
    mov eax, white + (black * 16) ; Irvine32 색상 상수 (글자색 white, 배경 black)
    jmp PrintLine
    
IsBlue:
    mov eax, blue + (black * 16)
    jmp PrintLine
    
IsGreen:
    mov eax, green + (black * 16)

PrintLine:
    call SetTextColor   ; 결정된 색상 적용
    mov edx, OFFSET msgText
    call WriteString
    call Crlf
    
    loop L1             ; 20번 반복

    ; 원래 색상(회색 글자, 검은 배경)으로 복구
    mov eax, lightGray + (black * 16)
    call SetTextColor
    exit
main ENDP
END main

```

---

### 8. Message Encryption

단일 문자 키가 아닌 다중 문자 암호화 키(예: "ABXmv#7")를 사용하여 메시지를 암호화 및 복호화하는 프로그램입니다. 평문의 인덱스와 별개로 키의 인덱스를 순환시키며 XOR 연산을 수행합니다.

```assembly
INCLUDE Irvine32.inc

.data
    key BYTE "ABXmv#7"            ; 다중 문자 암호화 키
    keySize = ($ - key)           ; 키의 길이

    buffer BYTE "This is a plain text message to be encrypted.", 0
    bufSize = ($ - buffer) - 1    ; NULL 문자 제외 버퍼 길이

    msgOriginal BYTE "Original Message:  ", 0
    msgEncrypted BYTE "Encrypted Message: ", 0
    msgDecrypted BYTE "Decrypted Message: ", 0

.code
main PROC
    ; 1. 원본 메시지 출력
    mov edx, OFFSET msgOriginal
    call WriteString
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; 2. 암호화 수행 (XOR)
    call TranslateBuffer
    
    mov edx, OFFSET msgEncrypted
    call WriteString
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; 3. 복호화 수행 (동일한 키로 다시 XOR)
    call TranslateBuffer
    
    mov edx, OFFSET msgDecrypted
    call WriteString
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit
main ENDP

;---------------------------------------------------------
; TranslateBuffer
; 다중 문자 키를 사용하여 문자열 버퍼를 XOR 암호화/복호화합니다.
;---------------------------------------------------------
TranslateBuffer PROC USES eax ecx esi edi
    mov ecx, bufSize    ; 반복 횟수 = 문자열 길이
    mov esi, 0          ; 평문 버퍼의 인덱스
    mov edi, 0          ; 키 배열의 인덱스

L1:
    mov al, key[edi]    ; 현재 위치의 키 문자를 가져옴
    xor buffer[esi], al ; 평문 문자와 키 문자를 XOR 연산하여 저장
    
    inc esi             ; 다음 평문 문자로 이동
    inc edi             ; 다음 키 문자로 이동
    
    cmp edi, keySize    ; 키의 끝에 도달했는지 확인
    jb NextChar
    mov edi, 0          ; 끝에 도달했으면 키 인덱스를 0으로 초기화 (순환)

NextChar:
    loop L1

    ret
TranslateBuffer ENDP
END main

```


---

### 9. Validating a PIN

은행의 5자리 PIN 번호가 각 자리별로 지정된 유효 범위(최솟값, 최댓값) 내에 있는지 검사하는 프로시저(`Validate_PIN`)를 구현합니다. 유효하지 않은 자리가 발견되면 즉시 해당 위치(1~5)를 EAX에 반환하고, 모두 유효하면 0을 반환합니다.

```assembly
INCLUDE Irvine32.inc

.data
    ; 각 자리별 허용 범위 (최솟값과 최댓값 배열)
    minRange BYTE 5, 2, 4, 1, 3
    maxRange BYTE 9, 5, 8, 4, 6
    
    ; 테스트용 PIN 배열들 (바이트 배열)
    pin1 BYTE 5, 2, 4, 1, 3   ; Valid (모든 범위 만족)
    pin2 BYTE 4, 2, 4, 1, 3   ; Invalid (1번째 자리가 5보다 작음)
    pin3 BYTE 5, 2, 9, 1, 3   ; Invalid (3번째 자리가 8보다 큼)
    pin4 BYTE 5, 2, 4, 1, 7   ; Invalid (5번째 자리가 6보다 큼)

    msgValid   BYTE "PIN is Valid (Returns 0)", 0
    msgInvalid BYTE "PIN is Invalid at position: ", 0

.code
main PROC
    ; 테스트 1 (Valid)
    mov esi, OFFSET pin1
    call Validate_PIN
    call PrintResult

    ; 테스트 2 (Invalid at 1)
    mov esi, OFFSET pin2
    call Validate_PIN
    call PrintResult

    ; 테스트 3 (Invalid at 3)
    mov esi, OFFSET pin3
    call Validate_PIN
    call PrintResult

    ; 테스트 4 (Invalid at 5)
    mov esi, OFFSET pin4
    call Validate_PIN
    call PrintResult

    exit
main ENDP

;---------------------------------------------------------
; Validate_PIN
; PIN 배열을 검사하여 유효성을 확인합니다.
; 입력: ESI = 5자리 PIN 바이트 배열의 포인터
; 반환: EAX = 0 (유효함), 또는 1~5 (유효하지 않은 자리 위치)
;---------------------------------------------------------
Validate_PIN PROC USES ebx ecx esi edi
    mov edi, 0          ; 배열 인덱스 (0 ~ 4)
    mov ecx, 5          ; 5자리 검사 루프

L1:
    mov al, [esi + edi]     ; 현재 자리의 PIN 숫자 로드
    
    cmp al, minRange[edi]   ; 최솟값 검사
    jb InvalidDigit         ; 작으면 Invalid
    
    cmp al, maxRange[edi]   ; 최댓값 검사
    ja InvalidDigit         ; 크면 Invalid
    
    inc edi                 ; 다음 자리로 이동
    loop L1                 ; 5번 반복

    ; 끝까지 무사히 루프를 통과하면 모두 유효함
    mov eax, 0
    jmp Done

InvalidDigit:
    mov eax, edi            ; 인덱스 (0~4)
    inc eax                 ; 위치 값 (1~5)로 변환하여 EAX에 저장

Done:
    ret
Validate_PIN ENDP

; --- 결과 출력 보조 프로시저 ---
PrintResult PROC
    cmp eax, 0
    jne IsInvalid
    
    mov edx, OFFSET msgValid
    call WriteString
    call Crlf
    jmp Finish
    
IsInvalid:
    mov edx, OFFSET msgInvalid
    call WriteString
    call WriteDec       ; EAX에 저장된 에러 위치(1~5) 출력
    call Crlf
    
Finish:
    ret
PrintResult ENDP

END main

```

---

### 10. Parity Checking

데이터 블록(배열) 전체 비트의 패리티(짝수/홀수)를 검사하는 프로시저입니다.
*(교재의 팁에서는 루프 내에서 Parity Flag를 보존하라고 조언하지만, 배열의 모든 바이트를 누적하여 XOR 연산한 뒤 마지막에 한 번만 Parity Flag를 확인하는 것이 훨씬 안전하고 효율적인 방법입니다. 아래 코드는 이 방식을 사용합니다.)*

```assembly
INCLUDE Irvine32.inc

.data
    ; 테스트 배열 1 (짝수 패리티 - 비트 '1'의 총 개수가 짝수)
    ; 01h(1개), 02h(1개), 03h(2개)... 합하면 짝수개가 되도록 구성
    arrayEven BYTE 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 01h
    lenEven = ($ - arrayEven)

    ; 테스트 배열 2 (홀수 패리티 - 비트 '1'의 총 개수가 홀수)
    arrayOdd  BYTE 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 02h
    lenOdd = ($ - arrayOdd)

    msgEven BYTE "Parity is Even (True: 1)", 0
    msgOdd  BYTE "Parity is Odd (False: 0)", 0

.code
main PROC
    ; 테스트 1 (Even)
    mov esi, OFFSET arrayEven
    mov ecx, lenEven
    call CheckParity
    call PrintParity

    ; 테스트 2 (Odd)
    mov esi, OFFSET arrayOdd
    mov ecx, lenOdd
    call CheckParity
    call PrintParity

    exit
main ENDP

;---------------------------------------------------------
; CheckParity
; 바이트 배열 전체의 패리티를 계산합니다.
; 입력: ESI = 배열 포인터, ECX = 배열 크기
; 반환: EAX = 1 (짝수 패리티), 0 (홀수 패리티)
;---------------------------------------------------------
CheckParity PROC USES ecx esi
    mov al, 0           ; 패리티 누적용 레지스터 초기화

L1:
    xor al, [esi]       ; 현재 바이트를 AL과 XOR 누적
    inc esi
    loop L1

    ; 루프 종료 후 AL에는 모든 바이트가 결합된 최종 XOR 결과가 남습니다.
    ; OR 연산을 통해 최종 결과에 대한 Parity Flag(PF)를 세팅합니다.
    or al, al
    jp EvenParity       ; Jump if Parity Even (PF=1 이면 점프)

    ; 홀수 패리티인 경우
    mov eax, 0
    jmp Done

EvenParity:
    ; 짝수 패리티인 경우
    mov eax, 1

Done:
    ret
CheckParity ENDP

; --- 결과 출력 보조 프로시저 ---
PrintParity PROC
    cmp eax, 1
    je IsEven
    
    mov edx, OFFSET msgOdd
    call WriteString
    call Crlf
    jmp Finish
    
IsEven:
    mov edx, OFFSET msgEven
    call WriteString
    call Crlf
    
Finish:
    ret
PrintParity ENDP

END main

```
