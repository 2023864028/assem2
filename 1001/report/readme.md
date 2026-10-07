

**1. 지정된 줄 (a)와 (b)가 실행된 후 EDX 레지스터의 값**
`movsx` (Move with Sign-Extend) 명령어는 원본 피연산자의 부호 비트(최상위 비트, MSB)를 확장하여 대상 레지스터의 빈 공간을 채웁니다.

* **(a) 실행 후:** `one`은 16비트(WORD) 변수이며 값은 `8002h`입니다. 이 값을 이진수로 변환하면 최상위 비트가 1이므로(즉, `8`은 `1000(2)`), 음수로 취급됩니다. 32비트 레지스터인 `edx`로 복사될 때 빈 상위 16비트는 모두 1로 채워집니다.


* **결과:** `FFFF8002h`


* **(b) 실행 후:** `two`는 16비트 변수이며 값은 `4321h`입니다. 최상위 비트가 0이므로(즉, `4`는 `0100(2)`), 양수로 취급됩니다. `edx`로 복사될 때 빈 상위 16비트는 모두 0으로 채워집니다.


* **결과:** `00004321h`



**2. 실행 후 EAX 레지스터의 값**

* `mov eax, 1002FFFFh` : `eax` 전체가 `1002FFFFh`로 설정되며, 하위 16비트를 의미하는 `ax` 레지스터의 값은 `FFFFh`가 됩니다.


* `inc ax` : `ax`의 값만 1 증가시킵니다. `FFFFh + 1`은 캐리가 발생하며 하위 16비트는 `0000h`가 됩니다. `ax` 등 부분 레지스터에 대한 연산은 상위 16비트 부분에 영향을 미치지 않습니다.


* **결과:** `10020000h`

**3. 실행 후 EAX 레지스터의 값**

* `mov eax, 30020000h` : `eax`가 설정되며, `ax` 레지스터의 값은 `0000h`가 됩니다.


* `dec ax` : `ax`의 값을 1 감소시킵니다. `0000h - 1`은 언더플로우가 발생하여 `FFFFh`가 됩니다. 마찬가지로 상위 16비트에는 영향을 주지 않습니다.


* **결과:** `3002FFFFh`

**4. 실행 후 EAX 레지스터의 값**

* `mov eax, 1002FFFFh` : `ax` 레지스터의 값은 `FFFFh`입니다.


* `neg ax` : `ax` 값의 2의 보수를 구하여 부호를 반전시킵니다. `FFFFh`(-1)의 2의 보수는 `0001h`입니다. 상위 16비트에는 영향을 주지 않습니다.


* **결과:** `10020001h`

**5. 실행 후 Parity flag(패리티 플래그)의 값**

* `mov al, 1`에 이어 `add al, 3`을 실행하면 `al`의 값은 4가 됩니다.


* 숫자 4를 8비트 이진수로 표현하면 `0000 0100`입니다.
* 패리티 플래그는 연산 결과의 하위 8비트에서 '1'로 설정된 비트의 개수가 짝수면 1, 홀수면 0으로 설정됩니다. 비트 '1'이 단 한 개(홀수)이므로 플래그는 0이 됩니다.
* **결과:** `0` (또는 Clear)

**6. 실행 후 EAX 레지스터 및 Sign flag(사인 플래그)의 값**

* `mov eax, 5` 후 `sub eax, 6`을 실행하면 실제 계산 결과는 수학적으로 `-1`이 됩니다.


* 32비트 2의 보수 시스템에서 `-1`은 16진수로 `FFFFFFFFh`입니다.
* 사인 플래그는 연산 결과의 최상위 비트(MSB) 값을 그대로 따릅니다. `FFFFFFFFh`의 최상위 비트는 1이므로 사인 플래그가 설정(Set)됩니다.
* **결과:** `EAX` = `FFFFFFFFh`, `Sign flag` = `1`

**7. Overflow flag(오버플로우 플래그)가 최종 값의 유효성을 판단하는 데 도움이 되는지 여부 및 이유**

* 결론적으로 해당 코드에서 오버플로우 플래그는 프로그래머의 의도된 연산 범위를 판별하는 데 **전혀 도움이 되지 않습니다**.
* **이유:** `al` 레지스터를 부호 있는 1바이트(Signed byte)로 취급할 때, 표현 가능한 유효한 값의 범위는 `-128 ~ +127`입니다. 피연산자로 주어진 `130`이라는 값은 애초에 이 범위를 벗어난 값입니다.


* 컴퓨터 하드웨어(CPU)는 `add al, 130` 명령어를 만났을 때, `130`이라는 값을 이진수 비트 패턴 `1000 0010` (82h)으로 취급합니다. 부호 있는 바이트 관점에서 이 비트 패턴은 실제로는 `-126`을 의미합니다.


* 따라서 CPU는 내부적으로 `-1 (FFh)`과 `-126 (82h)`을 더하게 되며, 그 결과는 비트 단위로 `1000 0001 (81h)`, 즉 십진수로 `-127`이 됩니다.
* `-127`이라는 결과값은 부호 있는 1바이트의 정상적인 표현 범위(-128 ~ 127) 내에 완벽하게 포함됩니다. 따라서 CPU 연산 장치(ALU)는 이 덧셈에서 부호 있는 연산의 오버플로우가 발생하지 않았다고 판단하여 오버플로우 플래그를 `0`으로 설정합니다. 프로그래머의 논리적 의도(129라는 범위를 초과하는 결과)와 달리, 피연산자 자체가 잘못된 값으로 하드웨어에 해석되면서 결과적으로 플래그가 오류를 잡아내지 못하게 된 것입니다.



* **8. 다음 명령어가 실행된 후 RAX에 포함될 값:**
`mov rax, 44445555h` 명령어는 32비트 크기의 상수(`44445555h`)를 64비트 레지스터인 `rax`에 복사합니다. x86-64 아키텍처에서 32비트 상수를 64비트 레지스터로 `mov` 할 때 상위 32비트는 0으로 채워집니다.
**결과:** `0000000044445555h`


* **9. 다음 명령어들이 실행된 후 RAX에 포함될 값:**
`.data` 영역에 정의된 `dwordVal`은 32비트(DWORD) 변수로 `84326732h` 값을 가집니다.
`.code` 영역에서 `mov rax, 0FFFFFFFF00000000h`로 `rax`의 상위 32비트를 1로 채웁니다.
이후 `mov rax, dwordVal`이 실행되면, 32비트 메모리 값(`84326732h`)이 64비트 레지스터로 이동하면서 x86-64의 특성상 목적지 레지스터의 상위 32비트는 0으로 초기화(Zero-extend)됩니다.
**결과:** `0000000084326732h`


* **10. 다음 명령어들이 실행된 후 EAX에 포함될 값:**
`dVal`은 `12345678h` 값을 가진 32비트(DWORD) 변수입니다. 리틀 엔디안(Little Endian) 방식에 의해 메모리에는 `78 56 34 12` 순서로 저장됩니다.
`mov ax, 3`으로 `ax` 레지스터는 `0003h`가 됩니다.
`mov WORD PTR dVal+2, ax` 명령어는 `dVal`의 기준 주소에서 2바이트 떨어진 위치(즉, 상위 16비트인 `1234h`가 있는 자리)를 `ax` 값(`0003h`)으로 덮어씁니다. 메모리는 `78 56 03 00`으로 변경됩니다.
`mov eax, dVal`은 변경된 32비트 값을 다시 읽어옵니다.
**결과:** `00035678h`


* **11. 다음 명령어들이 실행된 후 EAX에 포함될 값:**
`mov dVal, 12345678h`로 메모리는 `78 56 34 12`가 됩니다.
`mov ax, WORD PTR dVal+2` 명령어는 상위 16비트를 읽어오므로 `ax`는 `1234h`가 됩니다.
`add ax, 3`을 통해 `ax`는 `1237h`가 됩니다.
`mov WORD PTR dVal, ax` 명령어는 `dVal`의 시작 위치(하위 16비트)를 `ax` 값으로 덮어씁니다. 메모리의 하위 2바이트가 `5678h`에서 `1237h`로 변경되어, 전체 32비트 메모리는 `37 12 34 12`가 됩니다.
`mov eax, dVal`로 전체 값을 읽어옵니다.
**결과:** `12341237h`


* **12. 양의 정수와 음의 정수를 더할 때 Overflow 플래그가 설정될 수 있는지 여부:**
양수와 음수를 더하는 연산의 결과는 항상 두 피연산자 사이의 값으로 도출되므로 표현 가능한 범위를 초과하는 오버플로우가 물리적으로 발생할 수 없습니다.
**결과:** `No`


* **13. 음의 정수끼리 더하여 양의 결과가 나올 때 Overflow 플래그가 설정되는지 여부:**
두 음수의 합은 음수여야 합니다. 부호 있는 연산에서 결과가 양수로 나왔다는 것은 표현 가능한 최소 음수 범위를 초과하여 부호 비트가 반전되는 언더플로우/오버플로우가 발생했음을 의미하므로 플래그가 설정됩니다.
**결과:** `Yes`


* **14. NEG 명령어가 Overflow 플래그를 설정할 수 있는지 여부:**
표현 가능한 가장 작은 음수(예: 8비트에서 -128)에 `NEG`(2의 보수화)를 취하면, 양수로 변환된 결과(+128)가 부호 있는 정수의 최대 허용 범위(+127)를 초과하게 되므로 오버플로우 플래그가 설정됩니다.
**결과:** `Yes`


* **15. Sign 플래그와 Zero 플래그가 동시에 설정될 수 있는지 여부:**
Zero 플래그는 연산 결과가 정확히 '0'일 때만 설정됩니다. 숫자 '0'의 2진수 표현은 최상위 비트(부호 비트)가 0이므로, 최상위 비트가 1일 때 설정되는 Sign 플래그와는 논리적으로 동시에 활성화될 수 없습니다.
**결과:** `No`


* **16. 다음 각 명령어의 유효성 (Valid/Invalid) 판별:**
* **a. `mov ax, var1**`: `Invalid`. `ax`는 16비트 레지스터이고, `var1`은 8비트(SBYTE) 변수이므로 피연산자의 크기가 일치하지 않습니다.


* **b. `mov ax, var2**`: `Valid`. `ax`와 `var2` 모두 16비트(WORD) 크기로 일치합니다.


* **c. `mov eax, var3**`: `Invalid`. `eax`는 32비트 레지스터이고, `var3`은 16비트(SWORD) 변수이므로 크기가 다릅니다.


* **d. `mov var2, var3**`: `Invalid`. x86 어셈블리에서는 메모리에서 메모리로 직접 데이터를 이동시키는 명령이 허용되지 않습니다.


* **e. `movzx ax, var2**`: `Invalid`. `movzx`(제로 확장 이동) 명령어는 원본 피연산자의 크기가 목적지 피연산자의 크기보다 작아야 합니다. 두 피연산자 모두 16비트이므로 유효하지 않습니다.


* **f. `movzx var2, al**`: `Invalid`. `movzx` 명령어의 목적지 피연산자는 반드시 레지스터여야 하며, 메모리 변수(`var2`)를 목적지로 지정할 수 없습니다.


* **g. `mov ds, ax**`: `Valid` (유효함). 범용 레지스터(`ax`)의 값을 세그먼트 레지스터(`ds`)로 복사하는 것은 허용됩니다.


* **h. `mov ds, 1000h**`: `Invalid` (유효하지 않음). 상수(즉시값)를 세그먼트 레지스터에 직접 이동시킬 수 없습니다.



**17. 명령어 실행 후 목적지 피연산자의 16진수 값**
(사전 정보: `var1 SBYTE -4, -2, 3, 1`)

* **a. `mov al, var1**`: `FCh`. 1바이트 변수 `var1`의 첫 번째 값인 -4가 `al`에 저장됩니다. -4의 8비트 16진수 표현은 FCh입니다.


* **b. `mov ah, [var1+3]**`: `01h`. `var1` 주소에서 3바이트 떨어진 4번째 요소인 1이 `ah`에 저장됩니다.



**18. 명령어 실행 후 목적지 피연산자의 16진수 값**
(사전 정보: `var2 WORD 1000h, 2000h, 3000h, 4000h`, `var3 SWORD -16, -42`)

* **a. `mov ax, var2**`: `1000h`. `var2`의 첫 번째 16비트 워드 값을 가져옵니다.


* **b. `mov ax, [var2+4]**`: `3000h`. `var2` 시작점부터 4바이트(2워드) 뒤에 있는 세 번째 워드 값을 가져옵니다.


* **c. `mov ax, var3**`: `FFF0h`. `var3`의 첫 번째 값인 -16을 가져옵니다. 16비트에서 -16의 2의 보수 표현은 FFF0h입니다.


* **d. `mov ax, [var3-2]**`: `4000h`. `var3` 메모리 위치에서 2바이트 이전 값을 가져옵니다. 이는 메모리상 바로 앞에 선언된 `var2` 배열의 마지막 요소(4000h)에 해당합니다.



**19. 명령어 실행 후 목적지 피연산자의 16진수 값**
(사전 정보: `var4 DWORD 1, 2, 3, 4, 5`)

* **a. `mov edx, var4**`: `00000001h`. `var4`의 첫 번째 32비트 값(1)을 가져옵니다.


* **b. `movzx edx, var2**`: `00001000h`. `var2`의 첫 번째 워드(1000h)를 가져오며 상위 16비트를 0으로 채워 확장(Zero-extend)합니다.


* **c. `mov edx, [var4+4]**`: `00000002h`. `var4`에서 4바이트 뒤에 있는 두 번째 32비트 값(2)을 가져옵니다.


* **d. `movsx edx, var1**`: `FFFFFFFCh`. `var1`의 첫 번째 바이트(-4, FCh)를 가져오며 부호 비트를 상위 24비트에 복사하여 확장(Sign-extend)합니다.



---

### 4.9.2 Algorithm Workbench 풀이

**1. `three`라는 더블워드 변수의 상위 워드와 하위 워드를 교환하는 MOV 명령어 시퀀스**

```assembly
mov ax, WORD PTR three       ; 하위 워드를 ax에 저장
mov bx, WORD PTR [three+2]   ; 상위 워드를 bx에 저장
mov WORD PTR three, bx       ; 하위 워드 위치에 bx(기존 상위) 값 저장
mov WORD PTR [three+2], ax   ; 상위 워드 위치에 ax(기존 하위) 값 저장

```

**2. XCHG 명령어를 3번까지만 사용하여 4개의 8비트 레지스터(A, B, C, D) 값을 B, C, D, A 순서로 재배열**


(편의상 A=AL, B=BL, C=CL, D=DL로 가정)

```assembly
xchg al, bl  ; 결과: AL=B, BL=A, CL=C, DL=D
xchg bl, cl  ; 결과: AL=B, BL=C, CL=A, DL=D
xchg cl, dl  ; 결과: AL=B, BL=C, CL=D, DL=A

```

**3. AL 레지스터의 메시지 바이트(01110101) 패리티 판별을 위해 패리티 플래그와 산술 명령어를 사용하는 방법**

```assembly
add al, 0    ; 또는 or al, al

```

값의 변경 없이 플래그만 업데이트하기 위해 0을 더합니다. 01110101은 1의 개수가 5개(홀수)이므로 패리티 플래그(PF)는 0(Clear)으로 설정되어 홀수 패리티임을 나타냅니다.

**4. 바이트 피연산자를 사용하여 두 음수를 더해 Overflow 플래그를 설정하는 코드**

```assembly
mov al, -100 ; 9Ch
add al, -50  ; CEh

```

결과가 -150이 되어 1바이트 부호 있는 범위(-128 ~ 127)를 초과하므로 오버플로우 플래그가 설정됩니다.

**5. 덧셈을 사용하여 Zero 플래그와 Carry 플래그를 동시에 설정하는 2개의 명령어**

```assembly
mov al, 0FFh ; 부호 없는 최대값 255
add al, 1    ; 256이 되면서 하위 8비트는 0이 되고 자리올림 발생

```

**6. 뺄셈을 사용하여 Carry 플래그를 설정하는 2개의 명령어**

```assembly
mov al, 1
sub al, 2    ; 더 큰 수를 빼서 언더플로우/빌림(Borrow) 발생

```

**7. 산술식 EAX = -val2 + 7 - val3 + val1 구현** (val1, 2, 3는 32비트 변수)

```assembly
mov eax, val2
neg eax
add eax, 7
sub eax, val3
add eax, val1

```

**8. 인덱스 주소지정과 배율 인수(scale factor)를 사용하여 더블워드 배열 요소의 합을 계산하는 루프**

```assembly
mov eax, 0            ; 합계 저장소 초기화
mov esi, 0            ; 인덱스 레지스터 초기화
mov ecx, LENGTHOF arr ; 배열 크기를 카운터에 설정
L1:
    add eax, arr[esi*4] ; 더블워드(4바이트) 크기만큼 배율 적용
    inc esi
    loop L1

```

**9. 산술식 AX = (val2 + BX) - val4 구현** (val2, 4는 16비트 변수)

```assembly
mov ax, val2
add ax, bx
sub ax, val4

```

**10. 동시에 Carry 플래그와 Overflow 플래그를 모두 설정하는 2개의 명령어**

```assembly
mov al, 80h  ; 부호 있는 바이트 최소값 -128
add al, 80h  ; -128 + -128 연산으로 오버플로우와 캐리 동시 발생

```

**11. INC 및 DEC 실행 후 부호 없는 오버플로우(wrap-around)를 나타내기 위해 Zero 플래그를 사용하는 방법**


INC 명령어는 Carry 플래그에 영향을 주지 않으므로, 레지스터가 표현할 수 있는 최대값(예: FFh)에서 INC 연산을 수행하여 값이 0으로 넘어갈 때 Zero 플래그가 설정(ZF=1)되는 것을 확인하여 부호 없는 오버플로우를 판단할 수 있습니다.

```assembly
mov al, 0FFh
inc al       ; 결과는 0이 되고, Zero 플래그가 1로 설정되어 오버플로우를 감지함

```


**사전 데이터 정의**:

```assembly
.data
myBytes   BYTE 10h,20h,30h,40h
myWords   WORD 3 DUP(?),2000h
myString  BYTE "ABCDE"

```

**12. `myBytes`를 짝수 주소에 정렬(align)하는 디렉티브 삽입**
`myBytes` 선언 바로 위에 `ALIGN 2` 또는 `EVEN` 디렉티브를 추가합니다.

* **답:** `ALIGN 2`

**13. 다음 명령어들이 각각 실행된 후 EAX의 값**

* **a. `mov eax, TYPE myBytes**`: `1`. `myBytes`는 BYTE 타입이므로 1바이트입니다.
* **b. `mov eax, LENGTHOF myBytes**`: `4`. `myBytes`에는 4개의 요소가 있습니다.
* **c. `mov eax, SIZEOF myBytes**`: `4`. TYPE(1) × LENGTHOF(4) = 4바이트입니다.
* **d. `mov eax, TYPE myWords**`: `2`. `myWords`는 WORD 타입이므로 2바이트입니다.
* **e. `mov eax, LENGTHOF myWords**`: `4`. `3 DUP(?)`로 3개, `2000h`로 1개이므로 총 4개입니다.
* **f. `mov eax, SIZEOF myWords**`: `8`. TYPE(2) × LENGTHOF(4) = 8바이트입니다.
* **g. `mov eax, SIZEOF myString**`: `5`. "ABCDE"는 5개의 문자로 이루어져 있으며 널(null) 종료 문자가 명시되지 않았으므로 총 5바이트입니다.

**14. `myBytes`의 첫 2바이트를 DX 레지스터로 이동하여 결과값이 2010h가 되게 하는 단일 명령어**


리틀 엔디안 방식에 따라 첫 2바이트(`10h`, `20h`)를 WORD로 읽으면 `2010h`가 됩니다.

* **답:** `mov dx, WORD PTR myBytes`

**15. `myWords`의 두 번째 바이트를 AL 레지스터로 이동하는 명령어**

* **답:** `mov al, BYTE PTR [myWords+1]`

**16. `myBytes`의 4바이트 모두를 EAX 레지스터로 이동하는 명령어**

* **답:** `mov eax, DWORD PTR myBytes`

**17. `myWords`를 32비트 레지스터로 직접 이동할 수 있게 하는 LABEL 디렉티브 삽입**


`myWords WORD...` 선언 바로 위에 다음을 추가합니다.

* **답:** `myWordsDword LABEL DWORD`

**18. `myBytes`를 16비트 레지스터로 직접 이동할 수 있게 하는 LABEL 디렉티브 삽입**


`myBytes BYTE...` 선언 바로 위에 다음을 추가합니다.

* **답:** `myBytesWord LABEL WORD`

---

### 4.10 Programming Exercises 풀이

**1. Big Endian에서 Little Endian으로 변환**


`MOV` 명령어를 사용하여 `bigEndian` 배열의 바이트 순서를 뒤집어 `littleEndian`에 저장합니다.

```assembly
.code
    mov al, [bigEndian+3]
    mov BYTE PTR littleEndian, al

    mov al, [bigEndian+2]
    mov BYTE PTR [littleEndian+1], al

    mov al, [bigEndian+1]
    mov BYTE PTR [littleEndian+2], al

    mov al, [bigEndian]
    mov BYTE PTR [littleEndian+3], al

```

**2. 배열 값 쌍 교환하기**


루프와 인덱스 주소지정을 사용하여 짝수 개 요소로 이루어진 배열(예: 32비트 DWORD 배열 `array`)의 인접한 쌍(i와 i+1)을 교환합니다.

```assembly
.code
    mov ecx, LENGTHOF array / 2   ; 배열 요소 수의 절반만큼 루프 실행
    mov esi, 0                    ; 인덱스 초기화

L1:
    mov eax, array[esi]           ; i번째 요소 읽기
    xchg eax, array[esi+4]        ; i+1번째 요소와 교환 (DWORD는 4바이트)
    mov array[esi], eax           ; 교환된 값을 i번째에 저장
    add esi, 8                    ; 다음 쌍으로 이동 (2개 요소 = 8바이트)
    loop L1

```

**3. 배열 값 간의 차이(Gaps) 합산하기**


더블워드(DWORD) 배열에서 연속된 요소 간의 차이를 구하고 그 합을 계산합니다.

```assembly
.code
    mov ecx, (LENGTHOF array) - 1 ; 갭의 개수는 (요소 수 - 1)
    mov esi, 0                    ; 인덱스 초기화
    mov eax, 0                    ; 합계를 저장할 레지스터 초기화

L1:
    mov ebx, array[esi+4]         ; 다음 요소 읽기
    sub ebx, array[esi]           ; 현재 요소를 빼서 차이(Gap) 계산
    add eax, ebx                  ; 차이를 합계(eax)에 더함
    add esi, 4                    ; 다음 요소로 인덱스 이동
    loop L1

```


**4. Word 배열을 DoubleWord 배열로 복사하기**


부호 없는 16비트(Word) 배열의 요소를 부호 없는 32비트(DoubleWord) 배열로 복사할 때는 `MOVZX` (0으로 확장하여 이동) 명령어를 사용해야 합니다.

```assembly
.data
    wordArray WORD 10h, 20h, 30h, 40h
    dwordArray DWORD LENGTHOF wordArray DUP(?)
.code
    mov ecx, LENGTHOF wordArray  ; 루프 카운터 설정
    mov esi, 0                   ; 원본 배열 인덱스
    mov edi, 0                   ; 대상 배열 인덱스
L1:
    movzx eax, wordArray[esi]    ; 16비트 값을 32비트 레지스터로 0 확장 복사
    mov dwordArray[edi], eax     ; 32비트 배열에 저장
    add esi, TYPE wordArray      ; 원본 인덱스 2 증가
    add edi, TYPE dwordArray     ; 대상 인덱스 4 증가
    loop L1

```

**5. 피보나치 수열(Fibonacci Numbers)**


첫 두 항이 1이고, 이후의 항은 앞의 두 항을 더하여 계산되는 피보나치 수열의 첫 7개 값을 계산하는 루프입니다.

```assembly
.data
    fibArray DWORD 7 DUP(?)      ; 7개 요소 공간 할당
.code
    mov fibArray[0], 1           ; Fib(1) = 1
    mov fibArray[4], 1           ; Fib(2) = 1 (DWORD는 4바이트 간격)
    
    mov ecx, 5                   ; 7개 중 첫 2개는 설정했으므로 5번 반복
    mov esi, 8                   ; 배열의 3번째 요소(인덱스 8)부터 시작
L1:
    mov eax, fibArray[esi-4]     ; Fib(n-1) 값 가져오기
    add eax, fibArray[esi-8]     ; Fib(n-1) + Fib(n-2) 계산
    mov fibArray[esi], eax       ; 결과를 Fib(n)에 저장
    add esi, 4                   ; 다음 요소로 인덱스 이동
    loop L1

```

**6. 배열 뒤집기 (제자리에서)**


다른 배열로 복사하지 않고 제자리(in place)에서 요소를 뒤집으려면 `LENGTHOF`, `SIZEOF`, `TYPE` 연산자를 활용해 양쪽 끝에서부터 중앙으로 이동하며 값을 교환(Swap)해야 합니다.

```assembly
.data
    myArray DWORD 10h, 20h, 30h, 40h, 50h
.code
    mov ecx, LENGTHOF myArray / 2           ; 배열 길이의 절반만큼 반복
    mov esi, 0                              ; 시작 포인터 (앞쪽)
    mov edi, SIZEOF myArray - TYPE myArray  ; 끝 포인터 (마지막 요소의 위치)
L1:
    mov eax, myArray[esi]                   ; 앞쪽 요소 읽기
    xchg eax, myArray[edi]                  ; 끝쪽 요소와 값 교환
    mov myArray[esi], eax                   ; 교환된 값을 앞쪽에 저장
    
    add esi, TYPE myArray                   ; 시작 포인터 1칸 전진
    sub edi, TYPE myArray                   ; 끝 포인터 1칸 후퇴
    loop L1

```

**7. 문자열을 역순으로 복사하기**


`source`의 문자들을 끝에서부터 읽어서 `target` 배열에 복사합니다. 널 종료 문자(0)는 제외하고 문자열만 역순으로 배치합니다.

```assembly
.data
    source BYTE "This is the source string", 0
    target BYTE SIZEOF source DUP('#')
.code
    mov ecx, SIZEOF source - 1  ; 널 문자 제외한 문자열 길이
    mov esi, SIZEOF source - 2  ; source의 마지막 문자 인덱스 (널 문자 바로 앞)
    mov edi, 0                  ; target의 첫 번째 인덱스
L1:
    mov al, source[esi]         ; source의 뒤쪽 문자 읽기
    mov target[edi], al         ; target의 앞쪽에 저장
    dec esi                     ; source 인덱스 감소 (뒤로 이동)
    inc edi                     ; target 인덱스 증가 (앞으로 이동)
    loop L1
    
    mov target[edi], 0          ; 새 target 문자열 끝에 널 종료 문자 추가

```

**8. 배열 요소 시프트 (오른쪽 순환)**


배열의 마지막 요소를 미리 저장한 뒤, 뒤에서부터 앞으로 순회하며 바로 앞의 요소를 현재 위치로 덮어쓰고, 마지막에 저장해둔 요소를 배열의 첫 번째 자리에 넣습니다.

```assembly
.data
    array DWORD 10, 20, 30, 40
.code
    mov ecx, LENGTHOF array - 1          ; 마지막 1개를 제외하고 이동하므로 -1
    mov esi, SIZEOF array - TYPE array   ; 배열의 가장 마지막 요소 인덱스
    mov eax, array[esi]                  ; 맨 끝 요소(예: 40)를 eax에 임시 저장
L1:
    mov edx, array[esi - TYPE array]     ; 현재 위치의 바로 앞 요소를 읽기
    mov array[esi], edx                  ; 현재 위치에 앞 요소를 복사(밀어내기)
    sub esi, TYPE array                  ; 인덱스를 앞으로 1칸 이동
    loop L1
    
    mov array[0], eax                    ; 맨 앞에 임시로 저장해둔 맨 끝 요소를 삽입

```
