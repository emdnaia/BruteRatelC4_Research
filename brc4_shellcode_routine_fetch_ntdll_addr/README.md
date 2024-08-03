***BruteRatel C4 (Brc4) shellcode routine to fetch address of ntdll***
```
1. Fetch address of the PEB using gs:[0x60]
2. Get address of PEB_LDR_DATA structure which is an internal variable residing in the ntdll .data section using PEB->0x18 (Ldr)
3. Then it checks for 4d5a (MZ) and loops backwards from the address of PEB_LDR_DATA structure in ntdll .data section towards the start of ntdll
4. When it finds 4d5a (MZ) while searching and looping backwards
	- It fetches the e_lfanew value at offset of 0x3c. The e_lfanew consists of the offset to the PE File Header (IMAGE_NT_HEADER)
	- Then it subtracts 0x40 from the e_lfanew value and compares it with 0x3BFh
		- This is a boundary validation to check if the e_lfanew-0x40 lies at the beginning of the PE File before the section content starts.
	- If the boundary validation is satisfied, it check for the "PE" signature 5045h at the offset of e_lfanew
5. If the PE signature check is satisfied, the r8 register (which had address to PEB_LDR_DATA) at this moment would be the base address of ntdll
6. We just move the base address of ntdll to rcx for further usage.
```

*Wrote a PoC for the Brc4 Shellcode routine:* [**brc4_shellcode_routine_fetch_ntdll_addr.asm**](https://github.com/knight0x07/BruteRatelC4_Research/blob/main/brc4_shellcode_routine_fetch_ntdll_addr/brc4_shellcode_routine_fetch_ntdll_addr.asm)

![img](https://github.com/user-attachments/assets/a6338937-1627-4e71-a3e3-f37dc31d8f59)
