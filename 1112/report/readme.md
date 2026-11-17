

1. **Which Direction flag setting causes index registers to move backward through memory when executing string primitives?**
* **정답:** 방향 플래그(Direction flag)가 1 (Set)일 때입니다. (`STD` 명령어를 사용하여 설정할 수 있으며, 이 경우 인덱스 레지스터가 감소하여 역방향으로 이동합니다.)


2. **When a repeat prefix is used with STOSW, what value is added to or subtracted from the index register?**
* **정답:** **2**가 더해지거나 빼집니다. (STOSW는 Word, 즉 2바이트 단위로 데이터를 저장하므로 인덱스 레지스터가 2씩 변합니다.)


3. **In what way is the CMPS instruction ambiguous?**
* **정답:** `CMPS` 자체만으로는 비교할 메모리 피연산자의 **데이터 크기(바이트, 워드, 더블워드 등)를 알 수 없기 때문**입니다. 따라서 모호함을 없애기 위해 `CMPSB`, `CMPSW`, `CMPSD` 등 접미사를 붙이거나 명시적인 피연산자를 사용해야 합니다.


4. **When the Direction flag is clear and SCASB has found a matching character, where does EDI point?**
* **정답:** EDI는 **일치하는 문자 바로 다음 바이트의 주소**를 가리킵니다. (`SCASB`는 문자를 비교한 직후 자동으로 EDI를 1 증가시키기 때문입니다.)


5. **When scanning an array for the first occurrence of a particular character, which repeat prefix would be best?**
* **정답:** **`REPNE` (또는 `REPNZ`)** 접두사입니다. (찾고자 하는 문자와 같지 않은(Not Equal) 동안 스캔을 계속 반복해야 하기 때문입니다.)


6. **What Direction flag setting is used in the Str_trim procedure from Section 9.3?**
* **정답:** 방향 플래그를 1 (Set)로 설정합니다. (문자열의 끝부분(오른쪽)에서부터 역방향으로 공백을 확인하여 잘라내야 하므로 `STD` 명령어를 사용합니다.)


7. **Why does the Str_trim procedure from Section 9.3 use the JNE instruction?**
* **정답:** 잘라내고자 하는 문자(예: 공백)가 아닌 **유효한 일반 문자를 만났을 때 스캔을 멈추고 루프를 빠져나오기 위해서**입니다.


8. **What happens in the Str_ucase procedure from Section 9.3 if the target string contains a digit?**
* **정답:** 아무런 변화 없이 **그대로 무시하고 넘어갑니다.** (`Str_ucase`는 문자가 소문자 'a'~'z' 범위 안에 있을 때만 대문자로 변환하기 때문입니다.)


9. **If the Str_length procedure from Section 9.3 used SCASB, which repeat prefix would be most appropriate?**
* **정답:** **`REPNE` (또는 `REPNZ`)** 접두사입니다. (문자열의 끝을 알리는 Null 문자(`0`)를 찾을 때까지 계속 진행해야 합니다.)


10. **If the Str_length procedure from Section 9.3 used SCASB, how would it calculate and return the string length?**
* **정답:** 널 종료 문자(`0`)를 찾아 루프가 끝난 후, **변경된 `EDI` 주소에서 시작 문자열의 주소를 뺀 값에서 1을 빼서** 길이를 계산합니다. (또는 루프 시작 전 `ECX`를 -1로 두고 끝난 후의 카운트 변화량을 이용해 계산할 수도 있습니다.)


11. **What is the maximum number of comparisons needed by the binary search algorithm when an array contains 1,024 elements?**
* **정답:** **11회**입니다. (이진 검색의 최대 비교 횟수 공식은 $\log_2(N) + 1$이므로, $\log_2(1024) + 1 = 10 + 1 = 11$입니다.)


12. **In the FillArray procedure from the Binary Search example in Section 9.5, why must the Direction flag be cleared by the CLD instruction?**
* **정답:** 배열의 요소를 낮은 메모리 주소부터 높은 주소로 **순방향으로 채워나가며 인덱스를 1씩 증가시켜야 하기 때문**입니다.


13. **In the BinarySearch procedure from Section 9.5, why could the statement at label L2 be removed without affecting the outcome?**
* **정답:** 어셈블리 분기(조건문)에서 찾고자 하는 값과 '같다(`JE`)', '작다(`JL`)'의 두 가지 조건을 이미 확인하고 나면 남은 조건은 '크다'밖에 없으므로, **불필요한 비교나 분기(`Jump`) 명령어를 제거해도 코드가 자연스럽게(Fall-through) 남은 로직을 실행**하기 때문입니다.


14. **In the BinarySearch procedure from Section 9.5, how might the statement at label L4 be eliminated?**
* **정답:** 루프(Loop) 블록의 구조를 재배열하여, 특정 조건 완료 후 강제로 점프(`JMP`)하는 대신 **자연스럽게 다음 실행 흐름으로 이어지도록 조건 분기 논리를 최적화**함으로써 제거할 수 있습니다.



1. **32비트 모드에서 베이스-인덱스(base-index) 피연산자의 예:**
`[ebx + esi]` (예: `mov eax, [ebx + esi]`)
2. **32비트 모드에서 베이스-인덱스-변위(base-index-displacement) 피연산자의 예:**
`array[ebx + esi]` 또는 `[ebx + esi + 4]` (예: `mov eax, array[ebx + esi]`)
3. **3행 4열의 32비트 더블워드(doubleword) 2차원 배열에서 ESI와 EDI를 사용해 2번째 행, 3번째 열의 요소를 지정하는 표현식:**
* 행과 열의 인덱스는 0부터 시작하므로 2번째 행은 인덱스 1, 3번째 열은 인덱스 2입니다.
* 한 행의 크기 = 4(열) × 4(더블워드 바이트 수) = 16바이트입니다.
* `ESI`에 행 오프셋(1 × 16 = 16)이 저장되어 있다고 가정할 때, 표현식은 `[ESI + EDI*4]` 입니다. (또는 배열 이름을 포함해 `array[ESI + EDI*4]`)


4. **`CMPSW`를 사용하여 `sourcew`와 `targetw`라는 두 개의 16비트 배열을 비교하는 명령어:**
```assembly
mov esi, OFFSET sourcew
mov edi, OFFSET targetw
mov ecx, LENGTHOF sourcew
cld
repe cmpsw

```


5. **`SCASW`를 사용하여 `wordArray`에서 16비트 값 `0100h`를 검색하고, 일치하는 멤버의 오프셋을 `EAX`에 복사하는 명령어:**
```assembly
mov edi, OFFSET wordArray
mov ecx, LENGTHOF wordArray
mov ax, 0100h
cld
repne scasw
jne notFound
sub edi, 2      ; 일치하는 위치로 되돌리기 위해 2바이트 감소 (SCASW가 EDI를 2 증가시켰으므로)
mov eax, edi
notFound:

```


6. **`Str_compare` 프로시저를 사용하여 두 문자열 중 더 큰 것을 결정하고 콘솔 창에 출력하는 명령어 시퀀스:**
```assembly
INVOKE Str_compare, ADDR string1, ADDR string2
ja str1_is_larger
; string2가 더 크거나 같은 경우
mov edx, OFFSET string2
jmp print
str1_is_larger:
mov edx, OFFSET string1
print:
call WriteString

```


7. **`Str_trim` 프로시저를 호출하여 문자열 끝에 있는 모든 "@" 문자를 제거하는 방법:**
```assembly
INVOKE Str_trim, ADDR myString, '@'

```


8. **Irvine32 라이브러리의 `Str_ucase`를 수정하여 모든 문자를 소문자로 변경하는 방법:**
대문자 'A'와 'Z' 사이인지 확인한 뒤, 범위 내에 있다면 5번째 비트를 세팅(32를 더하거나 20h와 OR 연산)하여 소문자로 바꿉니다.
```assembly
cmp al, 'A'
jb next
cmp al, 'Z'
ja next
or al, 20h      ; 대문자를 소문자로 변환 (add al, 32와 동일)
next:

```


9. **`Str_trim` 프로시저의 64비트 버전 생성:**
32비트 레지스터 대신 64비트 레지스터(예: `RCX`, `RDI` 등)를 사용하도록 코드를 마이그레이션합니다. (보통 Windows x64 호출 규약에 따라 `RCX`에 문자열 포인터가 전달됨을 활용합니다.)
10. **64비트 모드에서 베이스-인덱스 피연산자의 예:**
`[rbx + rsi]` (예: `mov rax, [rbx + rsi]`)
11. **`EBX`에 2차원 32비트 정수 배열(`myArray`)의 행 인덱스, `EDI`에 열 인덱스가 있을 때 해당 요소를 `EAX`로 이동하는 단일 문장:**
(단, x86에서는 주소 스케일링 한계로 인해 `EBX`에 행 크기(RowSize)가 이미 곱해진 **행 오프셋**이 담겨있다고 전제해야 합니다.)
```assembly
mov eax, myArray[ebx + edi*4]

```


12. **`RBX`에 2차원 64비트 정수 배열(`myArray`)의 행 인덱스, `RDI`에 열 인덱스가 있을 때 해당 요소를 `RAX`로 이동하는 단일 문장:**
(마찬가지로 `RBX`에 이미 행 오프셋이 계산되어 있다고 전제합니다.)
```assembly
mov rax, myArray[rbx + rdi*8]
```[cite: 8]

```


### 1. Improved `Str_copy` Procedure (`Str_copyN`)

복사할 최대 문자 수(`maxChars`)를 파라미터로 추가로 받아, 해당 길이만큼 혹은 널 종료 문자(`0`)를 만날 때까지만 문자열을 복사합니다.

```assembly
Str_copyN PROC USES eax ecx esi edi,
    source:PTR BYTE,
    target:PTR BYTE,
    maxChars:DWORD

    mov esi, source
    mov edi, target
    mov ecx, maxChars
    cmp ecx, 0
    je  done            ; 복사할 길이가 0이면 바로 종료

copy_loop:
    mov al, [esi]
    mov [edi], al
    cmp al, 0           ; 널 종료 문자를 만나면 복사 종료
    je  done
    inc esi
    inc edi
    loop copy_loop      ; ecx가 0이 될 때까지 반복

done:
    ret
Str_copyN ENDP

```

---

### 2. `Str_concat` Procedure

`target` 문자열의 끝(널 문자가 있는 위치)을 찾아낸 뒤, 그 위치부터 `source` 문자열을 덧붙여 병합(Concatenate)합니다.

```assembly
Str_concat PROC USES eax esi edi,
    target:PTR BYTE,
    source:PTR BYTE

    mov edi, target
find_null:
    cmp BYTE PTR [edi], 0
    je  copy_source     ; target의 끝(널 문자)을 찾으면 복사 시작
    inc edi
    jmp find_null

copy_source:
    mov esi, source
copy_loop:
    mov al, [esi]
    mov [edi], al       ; source의 문자를 target 끝부분에 덮어씀
    cmp al, 0
    je  done            ; source의 널 문자까지 복사했으면 종료
    inc esi
    inc edi
    jmp copy_loop

done:
    ret
Str_concat ENDP

```

---

### 3. `Str_remove` Procedure

문자열에서 제거를 시작할 위치 포인터(`pStart`)와 제거할 글자 수(`nChars`)를 받아, 뒤에 남은 문자열을 앞으로 당겨 덮어씀으로써 문자를 삭제합니다.

```assembly
Str_remove PROC USES eax esi edi,
    pStart:PTR BYTE,
    nChars:DWORD

    mov edi, pStart           ; 덮어쓰기 시작할 대상 주소
    mov esi, pStart
    add esi, nChars           ; 삭제할 구간을 건너뛴 뒤쪽 문자열 주소

copy_loop:
    mov al, [esi]
    mov [edi], al             ; 문자를 앞으로 당겨서 덮어씀
    cmp al, 0
    je  done                  ; 널 문자까지 당겨오면 종료
    inc esi
    inc edi
    jmp copy_loop

done:
    ret
Str_remove ENDP

```

---

### 4. `Str_find` Procedure

`target` 문자열 안에서 `source` 문자열과 처음으로 일치하는 위치를 찾습니다. 일치하면 해당 위치를 `EAX`에 담고 Zero Flag를 1로 세팅(Set)하며, 찾지 못하면 Zero Flag를 0으로 해제(Clear)합니다. (반환값이 `EAX`이므로 `USES` 목록에서 `EAX`를 제외합니다.)

```assembly
Str_find PROC USES ebx edx esi edi,
    pSource:PTR BYTE,
    pTarget:PTR BYTE

    mov edi, pTarget
search_loop:
    mov esi, pSource
    mov edx, edi            ; 현재 target의 검색 시작 위치를 EDX에 임시 저장

compare_loop:
    mov al, [esi]
    cmp al, 0               ; source 문자열 끝 도달 (전부 일치함)
    je  match_found

    mov bl, [edx]
    cmp bl, 0               ; target 문자열 끝 도달 (찾기 실패)
    je  not_found

    cmp al, bl              ; 현재 문자 비교
    jne match_failed

    inc esi
    inc edx
    jmp compare_loop

match_failed:
    cmp BYTE PTR [edi], 0   ; target 전체가 끝났는지 확인
    je  not_found
    inc edi                 ; 일치하지 않으면 target의 다음 문자로 넘어감
    jmp search_loop

match_found:
    mov eax, edi            ; EAX에 일치한 시작 주소 저장
    cmp eax, eax            ; Zero Flag 세팅 (ZF = 1)
    jmp done

not_found:
    mov al, 1
    or al, al               ; Zero Flag 해제 (ZF = 0)

done:
    ret
Str_find ENDP

```


### 5. `Str_nextWord` 프로시저

지정된 구분자(delimiter)를 문자열에서 찾아 널 바이트(0)로 변경하고, 구분자 바로 다음 문자의 주소를 `EAX`에 저장한 뒤 Zero 플래그를 세팅(ZF=1)하는 프로시저입니다. 구분자를 찾지 못하면 Zero 플래그를 해제(ZF=0)합니다.

```assembly
Str_nextWord PROC USES edi,
    pString:PTR BYTE,
    delimiter:BYTE

    mov edi, pString
    mov al, delimiter

search_loop:
    mov cl, [edi]
    cmp cl, 0              ; 문자열의 끝(널 문자)에 도달했는지 확인
    je  not_found          ; 끝이면 찾지 못한 것이므로 not_found로 이동
    
    cmp cl, al             ; 현재 문자가 구분자(delimiter)와 같은지 비교
    je  found              ; 같으면 found로 이동
    
    inc edi                ; 다음 문자로 포인터 이동
    jmp search_loop

found:
    mov BYTE PTR [edi], 0  ; 찾은 구분자를 널 바이트(0)로 변경
    inc edi                ; 구분자 다음 문자를 가리키도록 1 증가
    mov eax, edi           ; 다음 문자의 주소(오프셋)를 EAX에 저장
    cmp al, al             ; Zero Flag 세팅 (ZF = 1)
    jmp done

not_found:
    or al, 1               ; Zero Flag 해제 (ZF = 0)
    ; EAX는 요구사항에 따라 정의되지 않은 상태로 둡니다.

done:
    ret
Str_nextWord ENDP

```

---

### 6. `Get_frequencies` 프로시저 (빈도 테이블 생성)

문자열을 입력받아 각 문자의 ASCII 코드를 인덱스로 삼아 256개의 DWORD 배열(빈도 테이블)에 문자 출현 횟수를 누적하여 기록하는 프로시저입니다.

```assembly
Get_frequencies PROC USES eax esi edi,
    pString:PTR BYTE,
    pTable:PTR DWORD

    mov esi, pString       ; ESI에 문자열의 시작 주소 저장
    mov edi, pTable        ; EDI에 빈도 테이블(배열)의 시작 주소 저장
    xor eax, eax           ; EAX 초기화 (AL 레지스터에 문자를 담을 것이므로 상위 비트를 0으로 만듦)

count_loop:
    mov al, [esi]          ; 문자열에서 한 문자를 AL로 읽어옴
    cmp al, 0              ; 널 문자(문자열 끝)인지 확인
    je  done               ; 문자열이 끝났으면 종료
    
    ; AL에 들어있는 ASCII 코드를 인덱스로 사용하여 해당 DWORD 배열 값 1 증가
    ; 배열의 각 요소는 DWORD(4바이트)이므로 eax * 4를 인덱스로 사용
    inc DWORD PTR [edi + eax*4]
    
    inc esi                ; 문자열의 다음 문자로 포인터 이동
    jmp count_loop

done:
    ret
Get_frequencies ENDP
```[cite: 10]

```


### 7. Sieve of Eratosthenes (에라토스테네스의 체)

초기화되지 않은 데이터 세그먼트(`.data?`)에 65,000바이트 배열을 선언하고, `STOSB`로 0으로 초기화한 뒤 소수가 아닌 위치에 1을 표시하는 알고리즘입니다.

```assembly
.data?
    sieve BYTE 65000 DUP(?)

.code
main PROC
    ; 1. STOSB를 사용하여 배열을 0으로 초기화
    mov edi, OFFSET sieve
    mov ecx, 65000
    mov al, 0
    cld
    rep stosb

    ; 2. 에라토스테네스의 체 알고리즘 구현
    mov esi, 2              ; 시작 숫자 2
OuterLoop:
    cmp esi, 255            ; 65000의 제곱근(약 255)까지만 검사
    ja PrintPrimes
    
    cmp sieve[esi], 1       ; 이미 1(소수 아님)로 표시되었으면 건너뜀
    je NextOuter

    ; 배수들을 1로 마킹
    mov eax, esi
    imul eax, esi           ; i * i 부터 시작
    mov edi, eax
InnerLoop:
    cmp edi, 65000
    jae NextOuter
    mov sieve[edi], 1       ; 소수가 아님을 표시
    add edi, esi            ; 다음 배수로 이동
    jmp InnerLoop

NextOuter:
    inc esi
    jmp OuterLoop

    ; 3. 소수 출력 (값이 0인 인덱스 출력)
PrintPrimes:
    mov esi, 2
PrintLoop:
    cmp esi, 65000
    jae Done
    cmp sieve[esi], 0
    jne SkipPrint
    mov eax, esi
    call WriteDec           ; 소수 출력
    mov al, ' '
    call WriteChar
SkipPrint:
    inc esi
    jmp PrintLoop

Done:
    call Crlf
    exit
main ENDP

```

---

### 8. Bubble Sort (교환 플래그 추가)

안쪽 루프에서 값이 교환되었는지를 추적하는 변수(여기서는 `EDX` 레지스터를 플래그로 사용)를 추가하여, 한 번의 패스 동안 교환이 일어나지 않았다면 정렬이 완료된 것으로 간주하고 조기 종료합니다.

```assembly
BubbleSort PROC USES eax ecx esi, 
    pArray:PTR DWORD, Count:DWORD

    mov ecx, Count
    dec ecx                 ; 외부 루프 카운트 (n-1)

L1:
    push ecx                ; 외부 루프 카운터 저장
    mov esi, pArray         ; 배열 포인터
    mov edx, 0              ; ** Exchange Flag (0 = 교환 없음) **

L2:
    mov eax, [esi]
    cmp [esi+4], eax
    jge L3                  ; 교환이 필요 없으면 점프
    
    ; 값 교환 (Swap)
    xchg eax, [esi+4]
    mov [esi], eax
    mov edx, 1              ; ** 교환 발생: Exchange Flag를 1로 설정 **

L3:
    add esi, 4              ; 다음 원소로 이동
    loop L2                 ; 내부 루프 반복

    pop ecx                 ; 외부 루프 카운터 복구
    
    ; 조기 종료 조건 검사
    cmp edx, 0              ; 교환 플래그가 0인지 확인
    je  SortDone            ; 교환이 한 번도 없었다면 정렬 완료로 간주하고 탈출
    
    loop L1                 ; 외부 루프 반복

SortDone:
    ret
BubbleSort ENDP

```

---

### 9. Binary Search (레지스터 사용)

기존 메모리 변수 대신 레지스터를 사용하여 `first`, `last`, `mid` 값을 추적합니다. (EBX = first, EDX = last, ESI = mid)

```assembly
; 입력: 배열 포인터(EAX), 원소 개수(ECX), 찾을 값(EDI)
; 반환: 찾은 인덱스(EAX), 못 찾으면 -1 반환
BinarySearch PROC USES ebx ecx edx esi

    mov ebx, 0              ; EBX = first (0)
    mov edx, ecx
    dec edx                 ; EDX = last (Count - 1)

SearchLoop:
    cmp ebx, edx            ; first > last 이면 검색 실패
    jg NotFound

    ; mid = (first + last) / 2
    mov esi, ebx
    add esi, edx
    shr esi, 1              ; ESI = mid

    ; 배열의 mid 값과 검색할 값(EDI) 비교
    mov ecx, [eax + esi*4]  ; ECX = array[mid]
    cmp ecx, edi
    jl  IsLess              ; array[mid] < searchVal
    jg  IsGreater           ; array[mid] > searchVal

    ; 찾았을 경우
    mov eax, esi            ; EAX에 mid 인덱스 저장
    jmp Done

IsLess:                     ; 오른쪽 절반 탐색
    mov ebx, esi
    inc ebx                 ; first = mid + 1
    jmp SearchLoop

IsGreater:                  ; 왼쪽 절반 탐색
    mov edx, esi
    dec edx                 ; last = mid - 1
    jmp SearchLoop

NotFound:
    mov eax, -1             ; 찾지 못함 (-1 반환)

Done:
    ret
BinarySearch ENDP

```

---

### 10,11. Letter Matrix (50% 확률의 모음/자음 행렬 생성)

4x4 행렬을 생성하며, `RandomRange`를 호출해 각 문자가 50% 확률로 모음(Vowel)이거나 자음(Consonant)이 되도록 랜덤 선택합니다.

```assembly
.data
    vowels     BYTE "AEIOU"
    consonants BYTE "BCDFGHJKLMNPQRSTVWXYZ"

.code
GenerateMatrix PROC USES eax ecx
    mov ecx, 4              ; 4개의 행

RowLoop:
    push ecx                ; 행 카운터 저장
    mov ecx, 4              ; 4개의 열

ColLoop:
    mov eax, 2              ; 0 또는 1을 랜덤 생성 (50% 확률)
    call RandomRange
    cmp eax, 0
    je  PickVowel

PickConsonant:              ; 자음 선택 (21개)
    mov eax, 21
    call RandomRange
    mov al, consonants[eax]
    jmp PrintChar

PickVowel:                  ; 모음 선택 (5개)
    mov eax, 5
    call RandomRange
    mov al, vowels[eax]

PrintChar:
    call WriteChar          ; 문자 출력
    mov al, ' '
    call WriteChar          ; 간격 띄우기
    loop ColLoop            ; 열 루프 반복

    call Crlf               ; 줄바꿈
    pop ecx                 ; 행 카운터 복구
    loop RowLoop            ; 행 루프 반복

    call Crlf               ; 행렬 간 띄어쓰기
    ret
GenerateMatrix ENDP
```[cite: 11]

```

### 12. Calculating the Sum of an Array Row (배열의 특정 행 합계 구하기)

`INVOKE`나 확장된 `PROC` 디렉티브를 사용하지 않고, 수동으로 스택 프레임(`EBP`)을 설정하여 명시적인 스택 매개변수를 통해 배열의 특정 행의 합을 구하는 프로시저입니다.

```assembly
; 매개변수 스택 구조:
; [ebp+20] = 배열의 시작 오프셋 (array offset)
; [ebp+16] = 행의 크기 / 원소 개수 (row size)
; [ebp+12] = 배열 타입 / 원소당 바이트 수 (array type: 1, 2, 4)
; [ebp+8]  = 행 인덱스 (row index)

calc_row_sum PROC
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push esi
    push edi

    ; 1. 행의 시작 오프셋 계산: (row index * row size) * array type
    mov eax, [ebp+8]        ; row index
    imul eax, [ebp+16]      ; eax = row index * row size
    imul eax, [ebp+12]      ; eax = (row index * row size) * array type
    
    mov esi, [ebp+20]       ; 배열 시작 주소
    add esi, eax            ; ESI = 선택된 행의 시작 주소
    
    mov ecx, [ebp+16]       ; 루프 카운터 (row size)
    mov ebx, [ebp+12]       ; 배열 타입 (1, 2, 4)
    xor eax, eax            ; 합계를 저장할 EAX 초기화

SumLoop:
    cmp ebx, 1
    je AddByte
    cmp ebx, 2
    je AddWord
    cmp ebx, 4
    je AddDword

AddByte:
    movzx edx, BYTE PTR [esi]
    add eax, edx
    add esi, 1
    jmp NextElement

AddWord:
    movzx edx, WORD PTR [esi]
    add eax, edx
    add esi, 2
    jmp NextElement

AddDword:
    add eax, DWORD PTR [esi]
    add esi, 4

NextElement:
    loop SumLoop            ; 행의 크기만큼 반복

    pop edi
    pop esi
    pop ecx
    pop ebx
    pop ebp
    ret 16                  ; 4개의 매개변수(16바이트) 스택 정리
calc_row_sum ENDP

```

---

### 13. Trimming Leading Characters (앞부분 특정 문자 제거)

문자열의 앞부분에서 지정된 문자(예: '#')가 연속해서 나올 경우 이를 제거하고, 나머지 문자열을 앞으로 당겨서 덮어쓰는 프로시저입니다.

```assembly
Trim_leading PROC USES eax esi edi,
    pString:PTR BYTE,       ; 문자열 포인터
    trimChar:BYTE           ; 제거할 문자

    mov esi, pString
    mov al, trimChar

    ; 1. 제거할 문자가 아닌 첫 번째 유효 문자 찾기
SkipLoop:
    mov dl, [esi]
    cmp dl, 0               ; 문자열이 끝났는지 확인
    je  Done
    cmp dl, al              ; 제거할 문자와 같은지 비교
    jne FoundStart          ; 다르면 여기가 유효 문자열의 시작점
    inc esi
    jmp SkipLoop

    ; 2. 남은 문자열을 원래 위치(pString)로 당겨서 복사
FoundStart:
    mov edi, pString        ; 덮어쓸 시작 위치
CopyLoop:
    mov dl, [esi]
    mov [edi], dl
    cmp dl, 0               ; 널 문자(끝)까지 복사했으면 종료
    je  Done
    inc esi
    inc edi
    jmp CopyLoop

Done:
    ret
Trim_leading ENDP

```

---

### 14. Trimming a Set of Characters (문자열 끝에서 필터 세트 문자 제거)

문자열의 끝에서부터 역방향으로 탐색하며, 문자가 '필터 배열'에 포함되어 있을 경우 널 문자(0)로 바꾸어 제거하는 프로시저입니다. 필터 배열에 없는 문자를 만나는 즉시 잘라내기를 중단합니다.

```assembly
Trim_set PROC USES eax ebx esi edi,
    pString:PTR BYTE,       ; 대상 문자열 포인터
    pFilter:PTR BYTE        ; 필터 문자 집합 배열 포인터

    ; 1. 문자열의 끝(널 문자 앞)으로 포인터 이동
    mov edi, pString
FindEnd:
    cmp BYTE PTR [edi], 0
    je  StepBack
    inc edi
    jmp FindEnd

StepBack:
    dec edi                 ; 마지막 문자 위치로 이동

    ; 2. 끝에서부터 역방향으로 필터 문자와 비교
CheckStringLoop:
    cmp edi, pString        ; 문자열의 처음을 지나쳤는지 확인
    jb  Done
    
    mov al, [edi]           ; 현재 문자
    mov esi, pFilter        ; 필터 배열 포인터 초기화

CheckFilterLoop:
    mov bl, [esi]
    cmp bl, 0               ; 필터 배열의 끝 도달 (해당 문자가 필터에 없음)
    je  Done                ; 삭제를 중단하고 종료
    
    cmp al, bl              ; 현재 문자가 필터 문자와 일치하는지 확인
    je  MatchFound          ; 일치하면 제거(널 문자로 변경) 처리로 이동
    
    inc esi
    jmp CheckFilterLoop

MatchFound:
    mov BYTE PTR [edi], 0   ; 현재 문자를 널 문자로 변경(잘라냄)
    dec edi                 ; 이전 문자로 이동하여 다시 검사
    jmp CheckStringLoop

Done:
    ret
Trim_set ENDP

```
