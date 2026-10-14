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
