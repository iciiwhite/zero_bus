;
; © 2026 Icii Digital. This software is provided 'as is', without warranty of any kind, express or implied. In no event shall Icii Digital be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
;

section .text
global hypervisor_init
global hypervisor_send

hypervisor_init:
    xor eax, eax
    ret

hypervisor_send:
    mov rax, rdi
    mov rcx, rdx
    xor eax, eax
    ret