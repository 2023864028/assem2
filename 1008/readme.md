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
