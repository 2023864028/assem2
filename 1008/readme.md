## 10월 8일 수업내용

push esi ; push registers
push ecx
push ebx
mov esi, OFFSET dwordVal ; display some memory
mov ecx, LENGTHOF dwordVal
mov ebx, TYPE dwordVal
call DumpMem
pop ebx ; restore registers
pop ecx
pop esi
mov ecx, 100 ; set outer loop count
L1: ; begin the outer loop
push ecx ; save outer loop count
; --- INNER LOOP START ---
mov ecx, 20 ; set inner loop count
L2: ; begin the inner loop
;
;
loop L2 ; repeat the inner loop
; --- INNER LOOP END ---
pop ecx ; restore outer loop count
loop L1 ; repeat the outer loop
------------------------------------
.data
aName BYTE “I like StarII",0
nameSize = ($ - aName) - 1 ; nameSize = 12
.code
mov ecx,nameSize
mov esi,0
L1: movzx eax,aName[esi] ; get character
push eax ; push on stack
inc esi
Loop L1
mov ecx,nameSize
mov esi,0
L2: pop eax ; get character
mov aName[esi],al ; store in string
inc esi
Loop L2

이 코드는 **문자열을 스택(Stack)에 넣었다가 다시 꺼내서 순서를 뒤집는 코드**입니다.

### 1\. 문자열 준비

```
aName BYTE “I like StarII",0
nameSize = ($ - aName) - 1
```

- `aName`에 `"I like StarII"`라는 문자열을 저장합니다.
- 마지막 `0`은 문자열의 끝을 나타내는 NULL 문자입니다.
- `nameSize`는 NULL 문자를 제외한 문자열 길이입니다.

### 2\. 문자열을 스택에 저장

```
mov ecx, nameSize
mov esi, 0

L1:
    movzx eax, aName[esi]
    push eax
    inc esi
    Loop L1
```

문자열을 **앞에서부터 한 글자씩** 읽어서 스택에 `push`합니다.

예를 들어:

```
I →   push
  → push
l →   push
i →   push
...
```

스택은 **나중에 넣은 값이 먼저 나오는 LIFO(Last In, First Out)** 방식입니다.

### 3\. 스택에서 꺼내 문자열에 저장

```
mov ecx, nameSize
mov esi, 0

L2:
    pop eax
    mov aName[esi], al
    inc esi
    Loop L2
```

스택에서 문자를 `pop`하면 **마지막에 넣었던 문자부터** 나오므로, 원래 문자열의 순서가 거꾸로 됩니다.

예를 들어:

```
원래:    ABCDE
                 ↓ push
스택:    E D C B A
                 ↓ pop
결과:    EDCBA
```

따라서 이 코드의 핵심은:

> **문자열 → 스택에 push → 스택에서 pop → 문자열에 저장 = 문자열 뒤집기**

입니다.

참고로 `movzx eax, aName[esi]`는 **문자 1바이트를 EAX로 가져오면서 나머지 상위 비트를 0으로 채우는 것**, `al`은 EAX의 **하위 8비트(문자 1바이트)**입니다.
