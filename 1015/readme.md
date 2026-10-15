## 10월 15일 수업 내용

data
val1 DWORD 5
result DWORD ?
.code
mov eax,6
.IF eax > val1
mov result,1
.ENDIF
mov eax,6
cmp eax,val1
jbe @C0001 ; jump on unsigned comparison
mov result,1
@C0001:
