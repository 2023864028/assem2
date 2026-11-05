.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
includelib kernel32.lib

.data
    msg db "2023860428", 20h, 0

.code
main PROC
    invoke ExitProcess, 0
main ENDP

END main
