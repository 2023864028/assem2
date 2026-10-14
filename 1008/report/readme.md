**5.8.1 Short Answer**

**1. Which instruction pushes all of the 32-bit general-purpose registers on the stack?**


(어떤 명령어가 모든 32비트 범용 레지스터를 스택에 푸시합니까?)

* **정답: PUSHAD**
* **해설:** 모든 32비트 범용 레지스터를 스택에 일괄적으로 푸시(push)하는 명령어입니다.

**2. Which instruction pushes the 32-bit EFLAGS register on the stack?**


(어떤 명령어가 32비트 EFLAGS 레지스터를 스택에 푸시합니까?)

* **정답: PUSHFD**
* **해설:** 32비트 상태 플래그인 EFLAGS 레지스터의 값을 스택에 푸시하는 명령어입니다.

**3. Which instruction pops the stack into the EFLAGS register?**


(어떤 명령어가 스택을 팝하여 EFLAGS 레지스터에 넣습니까?)

* **정답: POPFD**
* **해설:** 스택 최상단의 값을 팝(pop)하여 EFLAGS 레지스터에 복원하는 명령어입니다.

**4. Challenge: Another assembler (called NASM) permits the PUSH instruction to list multiple specific registers. Why might this approach be better than the PUSHAD instruction in MASM? Here is a NASM example: `PUSH EAX EBX ECX**`


(도전 문제: NASM이라는 다른 어셈블러는 PUSH 명령어에 여러 특정 레지스터를 나열할 수 있도록 허용합니다. 이 방식이 MASM의 PUSHAD 명령어보다 더 나은 이유는 무엇일까요? NASM 예시는 다음과 같습니다: `PUSH EAX EBX ECX`)

* **정답 및 해설: 선택적 레지스터 저장에 따른 메모리 및 실행 시간 절약**
MASM의 `PUSHAD` 명령어는 사용하지 않는 레지스터까지 포함해 8개의 모든 범용 레지스터를 무조건 스택에 저장하므로 불필요한 스택 메모리와 실행 시간이 소모됩니다. 반면 NASM처럼 필요한 레지스터만 지정해서 푸시할 수 있다면, 꼭 보존해야 할 데이터만 스택에 저장하므로 성능상 훨씬 효율적입니다.

**5. Challenge: Suppose there were no PUSH instruction. Write a sequence of two other instructions that would accomplish the same as push eax.**


(도전 문제: PUSH 명령어가 없다고 가정해 봅시다. `push eax`와 동일한 작업을 수행하는 두 개의 다른 명령어 시퀀스를 작성해 보세요.)

* **정답:**
**`SUB ESP, 4`**
**`MOV [ESP], EAX`**
* **해설:** `PUSH` 명령어는 먼저 스택 포인터(ESP)를 데이터 크기만큼 감소시킨 후 그 위치에 데이터를 저장하는 과정을 거칩니다. 32비트(4바이트) 크기인 `EAX`를 푸시하는 것은 `ESP`에서 4를 빼서 공간을 확보한 뒤, 그 주소가 가리키는 스택 메모리에 `EAX` 값을 복사하는 것과 동일하게 동작합니다.

**6. (True/False): The RET instruction pops the top of the stack into the instruction pointer.**


(참/거짓: RET 명령어는 스택의 맨 위 값을 명령어 포인터로 팝합니다.)

* **정답: True (참)**
* **해설:** `RET` 명령어는 서브루틴(프로시저)을 종료하고 돌아갈 때, 스택 최상단에 저장되어 있던 반환 주소를 꺼내서 명령어 포인터(EIP)에 저장합니다.

**7. (True/False): Nested procedure calls are not permitted by the Microsoft assembler unless the NESTED operator is used in the procedure definition.**


(참/거짓: Microsoft 어셈블러에서는 프로시저 정의에 NESTED 연산자를 사용하지 않으면 중첩된 프로시저 호출이 허용되지 않습니다.)

* **정답: False (거짓)**
* **해설:** 어셈블리 언어에서 프로시저의 중첩 호출(Nested procedure calls)은 기본적으로 스택을 통해 자연스럽게 지원되며 허용됩니다. `NESTED`라는 특별한 연산자는 필요하지 않습니다.

**8. (True/False): In protected mode, each procedure call uses a minimum of 4 bytes of stack space.**


(참/거짓: 보호 모드에서 각 프로시저 호출은 최소 4바이트의 스택 공간을 사용합니다.)

* **정답: True (참)**
* **해설:** 32비트 보호 모드(Protected mode)에서 프로시저를 호출(`CALL`)하면, 호출이 끝나고 되돌아올 32비트(4바이트) 크기의 반환 주소(EIP)를 반드시 스택에 푸시해야 하므로 최소 4바이트의 스택 공간을 차지하게 됩니다.

**9. (True/False): The ESI and EDI registers cannot be used when passing 32-bit parameters to procedures.**


(참/거짓: 32비트 매개변수를 프로시저에 전달할 때 ESI 및 EDI 레지스터를 사용할 수 없습니다.)

* **정답: False (거짓)**
* **해설:** `ESI`와 `EDI`를 포함한 모든 32비트 범용 레지스터는 프로시저에 매개변수를 전달하는 용도로 자유롭게 사용할 수 있습니다.


**10. (True/False): The ArraySum procedure (Section 5.2.5) receives a pointer to any array of doublewords.**

* **정답: True (참)**
* **해설:** 교재의 `ArraySum` 프로시저는 일반적으로 `ESI` 레지스터를 통해 doubleword(32비트) 배열의 시작 주소(포인터)를 전달받아 배열 요소들의 합을 구합니다.



**11. (True/False): The USES operator lets you name all registers that are modified within a procedure.**

* **정답: True (참)**
* **해설:** `USES` 연산자는 프로시저 내에서 값이 변경될 가능성이 있는 레지스터들을 나열하여, 프로시저 시작과 끝에 해당 레지스터들의 값을 자동으로 백업하고 복원하도록 지정합니다.



**12. (True/False): The USES operator only generates PUSH instructions, so you must code POP instructions yourself.**

* **정답: False (거짓)**
* **해설:** `USES` 연산자는 프로시저 시작 부분에 `PUSH` 명령어들을 자동 생성할 뿐만 아니라, `RET` 명령어 바로 직전에 대응하는 `POP` 명령어들도 자동으로 생성해 줍니다.



**13. (True/False): The register list in the USES directive must use commas to separate the register names.**

* **정답: False (거짓)**
* **해설:** MASM에서 `USES` 지시어 뒤에 오는 레지스터 목록은 쉼표(,)가 아니라 공백(Space)이나 탭(Tab)으로 구분해야 합니다. (예: `USES eax ebx ecx`)



**14. Which statement(s) in the ArraySum procedure would have to be modified so it could accumulate an array of 16-bit words?**

* **정답 및 해설:** 32비트(doubleword)에서 16비트(word) 배열로 변경하려면 두 가지 주요 부분을 수정해야 합니다.
1. 배열 요소를 더하는 레지스터 크기 변경: `ADD EAX, [ESI]`를 16비트 연산인 `ADD AX, [ESI]`로 변경해야 합니다.


2. 포인터 증가량 변경: doubleword는 4바이트이므로 포인터를 4씩 증가시켰지만 (`ADD ESI, 4`), word는 2바이트이므로 다음 요소로 이동하려면 `ADD ESI, 2`로 변경해야 합니다.





**15. What will be the final value in EAX after these instructions execute?**

* **정답: 5**
* **해설:** 스택은 후입선출(LIFO) 구조입니다. `push 5`와 `push 6`을 실행하면 스택 맨 위에는 6이 있습니다. 첫 번째 `pop eax`를 실행하면 6이 EAX에 들어가고, 두 번째 `pop eax`를 실행하면 스택에 남아있던 5가 EAX에 들어가므로 최종 값은 5가 됩니다.



**16. Which statement is true about what will happen when the example code runs?**

* **정답: d. The program will halt with a runtime error on Line 11**
* **해설:** 4번 줄의 `call Ex2Sub`가 실행되면 돌아올 반환 주소(Return Address)가 스택에 푸시됩니다. 하지만 서브루틴 내부의 10번 줄(`pop eax`)에서 이 반환 주소를 `EAX`로 팝(pop)해버립니다. 이로 인해 11번 줄의 `ret` 명령어가 실행될 때, 스택의 다음 값인 `20`을 반환 주소로 착각하고 이동하려 시도하게 되므로 11번 줄에서 런타임 에러(메모리 참조 오류)가 발생합니다.



**17. Which statement is true about what will happen when the example code runs?**

* *(참고: 이미지가 12번 줄에서 잘려 객관식 보기가 보이지 않으므로 코드의 실행 결과를 설명해 드립니다.)*
* **해설:** `Ex3Sub` 프로시저가 호출되기 전, `main`에서 `EAX`는 30이었습니다. 10번 줄의 `pusha` 명령어는 호출 시점의 모든 범용 레지스터 상태(EAX=30 포함)를 스택에 일괄 저장합니다. 11번 줄에서 `mov eax,80`으로 값이 80으로 바뀌지만, 12번 줄의 `popa` 명령어가 스택에 저장해둔 이전 레지스터 값들을 모두 복원합니다. 따라서 **12번 줄 실행 직후 EAX는 다시 30으로 되돌아갑니다.**

* **정답: c. EAX will equal 30 on line 6**

* **해설:** `Ex3Sub` 내부에서 `pusha` 명령어가 호출될 당시의 모든 범용 레지스터 값(EAX의 30 포함)을 스택에 저장합니다. 그 후 11번 줄에서 `mov eax,80`으로 EAX 값이 80으로 변경되지만, 12번 줄의 `popa` 명령어가 스택에 저장해둔 레지스터 상태를 모두 원래대로 복원하므로 EAX는 다시 30이 됩니다. 따라서 무사히 6번 줄로 반환(`ret`)되었을 때 EAX 값은 30입니다.



**18. Which statement is true about what will happen when the example code runs?**

* **정답: a. EAX will equal 30 on line 7**

* **해설:** 이 코드는 `CALL` 명령어를 수동으로 흉내 내는 트릭을 사용하고 있습니다.


1. 3번 줄(`push offset Here`)에서 `Here` 라벨의 주소를 스택에 직접 푸시합니다.


2. 4번 줄(`jmp Ex4Sub`)에서 서브루틴으로 점프합니다. (`CALL`과 달리 복귀 주소를 스택에 넣지 않습니다.)


3. `Ex4Sub` 내부의 11번 줄(`ret`)이 실행되면, 스택의 맨 위 값을 꺼내서 명령어 포인터(EIP)로 사용합니다. 이때 스택 맨 위에는 아까 넣은 `Here`의 주소가 있으므로 `Here` 라벨(5번 줄)로 돌아가게 됩니다.


4. 6번 줄(`mov eax,30`)이 정상적으로 실행되므로, 7번 줄에 도달했을 때 EAX는 30이 됩니다.





**19. Which statement is true about what will happen when the example code runs?**

* **정답: a. EDX will equal 40 on line 6**

* **해설:** 서브루틴에 매개변수를 전달하고 스택을 조작하는 과정을 살펴보면 다음과 같습니다.
1. 4번 줄(`push eax`)에서 값 40이 스택에 푸시됩니다.


2. 5번 줄(`call Ex5Sub`)에서 함수 호출로 인해 '돌아갈 반환 주소(6번 줄 주소)'가 스택에 추가로 푸시됩니다. (현재 스택 상태: 최상단 [반환 주소], 그 아래 [40])


3. 10번 줄(`pop eax`)에서 스택 최상단의 '반환 주소'를 꺼내 EAX에 임시 보관합니다. (현재 스택 상태: 최상단 [40])


4. 11번 줄(`pop edx`)에서 다음 스택 값인 40을 꺼내 EDX에 넣습니다. 이로써 EDX는 40이 됩니다.


5. 12번 줄(`push eax`)에서 EAX에 보관해두었던 '반환 주소'를 다시 스택에 넣습니다.


6. 13번 줄(`ret`)이 정상적으로 스택의 반환 주소를 꺼내어 6번 줄로 돌아갑니다. 따라서 6번 줄에서 EDX는 40이 됩니다.





**20. What values will be written to the array when the following code executes?**

* **상태:** 이미지가 `.code` 부분에서 잘려 있어서 실행되는 실제 코드를 확인할 수 없습니다. 제공된 데이터 영역(`.data`)의 `array DWORD 4 DUP(0)` 부분만 보면, 초기에는 배열의 네 개 요소 모두 0으로 초기화되어 있다는 것만 알 수 있습니다. 전체 코드가 있어야 정확한 결과 값을 알 수 있습니다.

* **실행 흐름:**
1. `main`에서 `eax=10`, `esi=0`으로 초기화한 뒤 `proc_1`을 호출합니다.
2. `proc_1`은 `proc_2`를, `proc_2`는 `proc_3`을 연달아 호출합니다.
3. 가장 깊은 곳인 `proc_3`에서 `array[0]`에 `eax` 값인 **10**을 저장하고 반환합니다.
4. `proc_2`로 돌아오면 `esi`를 4 증가시키고(esi=4), `eax`를 10 증가시킵니다(eax=20). 그리고 `array[4]`에 **20**을 저장하고 반환합니다.
5. `proc_1`로 돌아오면 다시 `esi`와 `eax`를 각각 4, 10 증가시켜 `array[8]`에 **30**을 저장합니다.
6. 마지막으로 `main`으로 돌아와 `array[12]`에 **40**을 저장합니다.


* **최종 결과:**
`DWORD`(4바이트) 배열의 인덱스 0, 1, 2, 3 위치에 각각 10, 20, 30, 40이 저장됩니다. 즉, 배열에는 **`10, 20, 30, 40`** 순서로 값이 기록됩니다.

---

### 5.8.2 Algorithm Workbench 문제 풀이

**1. PUSH와 POP만을 사용하여 두 레지스터(EAX, EBX)의 값 교환하기**

* **정답 코드:**
```assembly
push eax
push ebx
pop eax
pop ebx

```


* **해설:** 스택의 후입선출(LIFO, Last-In First-Out) 특성을 이용한 트릭입니다. EAX, EBX 순서로 스택에 넣은 뒤, 뺄 때는 반대 순서로 적용되게끔 같은 EAX, EBX 순서로 `pop`을 수행하면 두 레지스터의 값이 서로 뒤바뀌게 됩니다.

**2. RET 명령어 실행 직전, 반환 주소를 3바이트 높게 수정하기**

* **정답 코드:**
```assembly
add dword ptr [esp], 3

```


* **해설:** 서브루틴이 끝나고 돌아가기 직전, 스택의 최상단(`[esp]`)에는 호출한 곳으로 돌아갈 '반환 주소'가 저장되어 있습니다. 이 메모리 공간에 직접 접근하여 값을 3만큼 더해주면 복귀 위치가 3바이트 뒤로 밀리게 됩니다.

**3. 스택에 2개의 32비트(doubleword) 지역 변수 공간을 만들고 1000h, 2000h 할당하기**

* **정답 코드:**
```assembly
sub esp, 8                 ; 8바이트(4바이트 x 2) 공간 확보
mov dword ptr [esp], 1000h     ; 첫 번째 변수에 1000h 저장
mov dword ptr [esp+4], 2000h   ; 두 번째 변수에 2000h 저장

```


* **해설:** 스택은 메모리 주소가 작아지는 방향으로 자라납니다. 따라서 스택 포인터(`esp`)에서 8바이트를 빼주면 지역 변수 2개가 들어갈 빈 공간이 할당됩니다. 이후 `esp`를 기준으로 오프셋(0과 +4)을 사용하여 각각의 값을 집어넣습니다.

**4. 인덱스 주소 지정 방식을 써서 32비트 배열의 현재 요소를 바로 앞 위치로 복사하기**

* **정답 코드:** (현재 인덱스가 `esi` 레지스터에 있다고 가정)
```assembly
mov eax, [esi]     ; 현재 위치의 값을 레지스터로 읽어옴
mov [esi-4], eax   ; 이전 위치(4바이트 앞)에 값 저장

```


* **해설:** x86 어셈블리에서는 메모리에서 메모리로 데이터를 직접 복사(`mov [esi-4], [esi]`)할 수 없습니다. 따라서 범용 레지스터(`eax`)를 매개체로 사용하여 값을 임시로 가져온 뒤, `DWORD` 크기인 4바이트만큼 뺀 주소(`[esi-4]`)에 복사해 넣어야 합니다.

**5. 서브루틴의 정상적인 복귀를 방해하지 않으면서 반환 주소 화면에 출력하기**

* **정답 코드:**
```assembly
mov eax, [esp]     ; 스택 최상단의 반환 주소를 EAX로 복사 (Pop하지 않음)
call WriteHex      ; 출력 함수 호출 (환경에 따라 함수명은 다를 수 있음)

```


* **해설:** 스택에 있는 값을 꺼내기 위해 `POP`을 사용하면 스택에서 데이터가 날아가 버려 `RET` 명령어가 길을 잃게 됩니다. 이를 방지하려면 `MOV` 명령어를 사용하여 스택 포인터가 가리키는 위치(`[esp]`)의 값을 단순히 레지스터로 '복사'만 해오면 스택 상태를 온전히 유지할 수 있습니다.

---
5.9 Programming Exercises

### 1. Draw Text Colors



반복문을 사용하여 동일한 문자열을 네 가지 다른 색상으로 출력하는 프로그램입니다.

```assembly
INCLUDE Irvine32.inc

.data
    strMsg BYTE "This is a colored string.", 0

.code
main PROC
    mov ecx, 4          ; 반복 횟수 4번 설정
    mov eax, 1          ; 초기 색상 (Blue=1)

L1:
    call SetTextColor   ; EAX에 저장된 색상 코드로 텍스트 색상 변경
    mov edx, OFFSET strMsg
    call WriteString    ; 문자열 출력
    call Crlf           ; 줄 바꿈

    inc eax             ; 다음 색상 코드로 증가 (1->2->3->4)
    loop L1             ; ECX가 0이 될 때까지 L1 반복

    ; 프로그램 종료 전 색상을 기본값(White=15)으로 복구
    mov eax, white
    call SetTextColor
    
    exit
main ENDP
END main

```

---

### 2. Linking Array Items



주어진 `links` 배열의 인덱스를 따라가며 문자를 올바른 순서대로 읽어 새로운 배열에 복사하는 프로그램입니다. `chars`는 `BYTE`형, `links`는 `DWORD`형으로 선언해야 합니다.

```assembly
INCLUDE Irvine32.inc

.data
    start = 1
    chars BYTE 'H','A','C','E','B','D','F','G'
    links DWORD 0, 4, 5, 6, 2, 3, 7, 0
    
    output BYTE LENGTHOF chars DUP(?) ; 결과를 저장할 배열
    
.code
main PROC
    mov esi, start      ; 현재 읽고 있는 인덱스 (초기값: start = 1)
    mov edi, 0          ; output 배열에 저장할 인덱스
    mov ecx, LENGTHOF chars ; 문자열의 길이(8)만큼 반복

L1:
    ; 1. 현재 인덱스(esi)에 해당하는 문자 가져와서 output 배열에 복사
    mov al, chars[esi]  ; chars는 BYTE 단위이므로 1바이트 오프셋 사용
    mov output[edi], al
    inc edi             ; output 인덱스 증가

    ; 2. 다음 인덱스 찾기
    ; links는 DWORD(4바이트) 배열이므로 인덱스에 4를 곱해서 접근해야 함
    mov esi, links[esi * 4] 
    loop L1

    ; 결과 출력 (확인용)
    mov edx, OFFSET output
    call WriteString
    call Crlf
    
    exit
main ENDP
END main

```

---

### 3. Simple Addition (1)



화면을 지우고, 커서를 화면 중앙 부근으로 이동한 뒤, 두 정수를 입력받아 합을 출력하는 프로그램입니다.

```assembly
INCLUDE Irvine32.inc

.data
    prompt1 BYTE "Enter first integer: ", 0
    prompt2 BYTE "Enter second integer: ", 0
    resultMsg BYTE "The sum is: ", 0

.code
main PROC
    call Clrscr         ; 화면 지우기

    mov dh, 12          ; Y 좌표 (화면 중간쯤인 12번째 줄)
    mov dl, 30          ; X 좌표 (화면 중간쯤인 30번째 칸)
    call Gotoxy         ; 커서 이동

    ; 첫 번째 정수 입력
    mov edx, OFFSET prompt1
    call WriteString
    call ReadInt
    mov ebx, eax        ; 첫 번째 정수를 EBX에 잠시 보관

    ; 두 번째 줄로 이동
    inc dh
    mov dl, 30
    call Gotoxy

    ; 두 번째 정수 입력
    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt

    ; 덧셈 수행
    add eax, ebx        ; EAX = 두 번째 정수 + 첫 번째 정수 (EBX)

    ; 결과 출력
    inc dh
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt       ; EAX에 저장된 합을 출력
    call Crlf

    exit
main ENDP
END main

```

---

### 4. Simple Addition (2)



3번 문제의 코드를 3번 반복하는 루프를 만들고, 매 반복마다 화면을 지우도록 수정한 프로그램입니다.

```assembly
INCLUDE Irvine32.inc

.data
    prompt1 BYTE "Enter first integer: ", 0
    prompt2 BYTE "Enter second integer: ", 0
    resultMsg BYTE "The sum is: ", 0

.code
main PROC
    mov ecx, 3          ; 전체 프로세스를 3번 반복

OuterLoop:
    push ecx            ; 바깥쪽 루프의 카운터를 스택에 백업
    
    call Clrscr         ; 매 반복마다 화면 지우기

    mov dh, 12
    mov dl, 30
    call Gotoxy

    mov edx, OFFSET prompt1
    call WriteString
    call ReadInt
    mov ebx, eax

    inc dh
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt

    add eax, ebx

    inc dh
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt
    call Crlf
    
    call WaitMsg        ; 사용자가 결과를 볼 수 있도록 잠시 멈춤

    pop ecx             ; 바깥쪽 루프 카운터 복구
    loop OuterLoop

    exit
main ENDP
END main

```

---

### 5. BetterRandomRange Procedure



주어진 $M$(`EBX`)과 $N-1$(`EAX` - 1) 사이의 난수를 생성하는 함수를 만들고, 이를 50번 호출하여 테스트하는 프로그램입니다.

```assembly
INCLUDE Irvine32.inc

.code
main PROC
    call Randomize      ; 난수 발생기 시드 초기화

    mov ecx, 50         ; 50번 반복 테스트 설정

L1:
    mov ebx, -300       ; Lower bound (M)
    mov eax, 100        ; Upper bound (N)
    call BetterRandomRange
    
    call WriteInt       ; 생성된 난수 출력
    call Crlf
    
    loop L1

    exit
main ENDP

; --------------------------------------------------------
; BetterRandomRange
; M과 N-1 사이의 난수를 생성합니다.
; 입력: EBX = M (하한값), EAX = N (상한값)
; 반환: EAX = 생성된 난수 (M <= EAX < N)
; --------------------------------------------------------
BetterRandomRange PROC
    push ebx            ; EBX(M) 값 백업

    ; RandomRange 함수는 0 ~ (매개변수 - 1) 사이의 난수를 생성함.
    ; M ~ N-1을 구하려면, (N - M) 범위의 난수를 구한 뒤 M을 더하면 됨.
    sub eax, ebx        ; EAX = N - M
    call RandomRange    ; EAX = 0 ~ (N - M - 1) 사이의 난수 발생

    add eax, ebx        ; 발생된 난수 + M
                        ; 최종 EAX = M ~ N - 1

    pop ebx             ; EBX 복구
    ret
BetterRandomRange ENDP

END main

```

### 6. Random Strings



대문자로만 구성된 길이 $L$의 임의의 문자열을 생성하는 프로시저를 작성하는 문제입니다.

* **핵심 로직:** A~Z는 아스키코드로 65~90입니다. 0부터 25 사이의 난수를 생성한 뒤 65('A')를 더하면 임의의 대문자를 얻을 수 있습니다.



```assembly
; 입력: EAX = 문자열 길이(L), EDI = 문자열을 저장할 배열의 포인터
GenerateRandomString PROC USES eax ecx edi
    mov ecx, eax            ; ECX에 루프 카운터(L) 설정
L1:
    mov eax, 26             ; 0 ~ 25 사이의 난수 생성
    call RandomRange
    add eax, 'A'            ; 'A'(65)를 더해 대문자 아스키코드로 변환
    mov [edi], al           ; 배열에 문자 저장
    inc edi                 ; 다음 배열 요소로 포인터 이동
    loop L1
    
    mov BYTE PTR [edi], 0   ; 문자열 끝에 Null 종료 문자 추가
    ret
GenerateRandomString ENDP

```

---

### 7. Random Screen Locations



100밀리초의 지연 시간을 두고 임의의 화면 위치 100곳에 단일 문자를 출력하는 프로그램입니다.

* **핵심 로직:** `GetMaxXY`를 호출하여 화면의 최대 X, Y 좌표를 얻은 뒤, 해당 범위 내에서 난수를 생성해 `Gotoxy`로 커서를 이동시킵니다.



```assembly
main PROC
    call Randomize
    mov ecx, 100            ; 100번 반복
L1:
    call GetMaxXY           ; AL = 최대 열(X), AH = 최대 행(Y) 반환 (버전에 따라 반환 레지스터 확인 필요)
    
    ; X 좌표 난수 생성
    movzx eax, al           ; EAX에 최대 X값 복사
    call RandomRange        ; 0 ~ 최대 X-1 사이의 난수
    mov dl, al              ; DL에 X 좌표 저장

    ; Y 좌표 난수 생성
    movzx eax, ah           ; EAX에 최대 Y값 복사
    call RandomRange
    mov dh, al              ; DH에 Y 좌표 저장

    call Gotoxy             ; 난수로 생성된 (DL, DH) 위치로 커서 이동
    mov al, 'X'             ; 출력할 문자
    call WriteChar
    
    mov eax, 100            ; 100ms
    call Delay              ; 지연
    loop L1
    exit
main ENDP

```

---

### 8. Color Matrix



전경색과 배경색의 모든 가능한 조합($16 \times 16 = 256$)으로 단일 문자를 출력하는 프로그램입니다.

* **핵심 로직:** 배경색은 상위 4비트, 전경색은 하위 4비트입니다. 색상 코드 = `(배경색 * 16) + 전경색` 공식을 활용하여 중첩 루프를 구성합니다.



```assembly
main PROC
    mov ecx, 16             ; 배경색 루프 카운터 (0~15)
    mov ebx, 0              ; 배경색 초기값
OuterLoop:
    push ecx                ; 바깥쪽 루프 카운터 저장
    mov ecx, 16             ; 전경색 루프 카운터 (0~15)
    mov esi, 0              ; 전경색 초기값

InnerLoop:
    mov eax, ebx            ; EAX = 배경색
    shl eax, 4              ; 배경색에 16을 곱함 (상위 4비트로 이동)
    add eax, esi            ; EAX = (배경색 * 16) + 전경색
    call SetTextColor       ; 색상 적용
    
    mov al, 'A'
    call WriteChar          ; 문자 출력

    inc esi                 ; 다음 전경색
    loop InnerLoop

    call Crlf               ; 한 줄 출력 후 줄바꿈
    inc ebx                 ; 다음 배경색
    pop ecx                 ; 바깥쪽 루프 카운터 복원
    loop OuterLoop

    ; 기본 색상으로 복구
    mov eax, 15             ; LightGray on Black
    call SetTextColor
    exit
main ENDP

```

---

### 9. Recursive Procedure



재귀 프로시저를 조건문 없이 `LOOP` 명령어만을 사용하여 지정된 횟수만큼 호출하는 문제입니다.

* **핵심 로직:** `LOOP` 명령어는 `ECX` 값을 1 감소시키고 0이 아니면 점프합니다. 이를 재귀 호출과 결합하여 횟수를 제한합니다.



```assembly
.data
    counter DWORD 0         ; 실행 횟수를 확인할 전역 카운터

.code
main PROC
    mov ecx, 5              ; 재귀를 5번 허용
    call RecursiveProc
    exit
main ENDP

RecursiveProc PROC
    inc counter             ; 실행될 때마다 카운터 1 증가
    ; ECX가 0보다 클 때만 다시 자신을 호출하도록 LOOP 사용
    ; LOOP는 보통 라벨로 점프하지만, 여기서 자신을 호출하는 트릭으로 사용할 수 있음
    loop RecursiveProc      ; ECX 감소 후 0이 아니면 재귀 호출
    ret
RecursiveProc ENDP

```

---

### 10. Fibonacci Generator



$N$개의 피보나치 수열 값을 생성하여 더블워드(`DWORD`) 배열에 저장하는 문제입니다. $N=47$까지 테스트합니다.

* **핵심 로직:** 피보나치 수열은 이전 두 값의 합입니다. $N=47$의 결과가 약 29억이므로 32비트 범용 레지스터(`EAX`, `EBX`)에 충분히 담깁니다.



```assembly
; 입력: ESI = 배열 포인터, ECX = 생성할 개수(N)
GenerateFibonacci PROC USES eax ebx ecx esi
    mov eax, 1              ; Fib(1)
    mov ebx, 0              ; Fib(0)
    
L1:
    ; 다음 피보나치 수 계산: New = EAX + EBX
    push eax                ; 현재 EAX 보관
    add eax, ebx            ; EAX = 현재 값 + 이전 값
    mov [esi], eax          ; 계산된 값을 배열에 저장
    
    pop ebx                 ; 이전 EAX 값을 EBX로 이동 (다음 반복을 위해)
    add esi, TYPE DWORD     ; 포인터를 4바이트 다음으로 이동
    loop L1

    ret
GenerateFibonacci ENDP

```

---

### 11. Finding Multiples of K



크기가 $N$인 바이트 배열에서 $K$의 배수에 해당하는 인덱스를 찾아 해당 배열 요소를 1로 설정하는 문제입니다. (에라토스테네스의 체 기본 원리)

* **핵심 로직:** 나눗셈으로 나머지를 확인하는 조건문을 쓰지 않아도, 인덱스 자체를 $K$씩 증가시키며 루프를 돌면 쉽게 배수를 찾을 수 있습니다.



```assembly
; 입력: ESI = 배열 포인터, EBX = K값, ECX = 배열 크기(N)
FindMultiples PROC USES eax ecx edi
    mov edi, ebx            ; 인덱스를 K로 시작
    
L1:
    cmp edi, ecx            ; 인덱스가 N보다 크거나 같은지 확인
    jae Done                ; 범위를 벗어나면 종료
    
    ; 배수에 해당하는 인덱스 위치를 1로 설정
    mov BYTE PTR [esi + edi], 1
    
    add edi, ebx            ; 인덱스에 K를 더해 다음 배수로 이동
    jmp L1                  ; 반복 (Chapter 6 조건문 대신 점프 사용)

Done:
    ret
FindMultiples ENDP

```
