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
