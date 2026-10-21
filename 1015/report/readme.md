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

```
