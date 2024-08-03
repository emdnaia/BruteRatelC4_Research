
    start:
        
        push rbp
        mov rbp,rsp
        sub rsp, 420h
        xor rax,rax
        xor r8,r8
        
        mov rax,qword ptr gs:[0x60]
        mov r8,qword ptr [rax+0x18]
        jmp compare_mz_header
        
    read_ntdll:
        sub r8,0x1
        
    compare_mz_header:
        cmp word ptr [r8],5A4Dh
        jne read_ntdll
        
    check_e_lfanew_boundary:
        movsxd rax,dword ptr [r8+0x3C]
        lea rdx,qword ptr [rax-0x40]
        cmp rdx,3BFh
        ja read_ntdll
    
    check_pe_signature:
        cmp dword ptr [r8+rax],4550h
        jne read_ntdll
        mov rcx,r8
        nop
          
