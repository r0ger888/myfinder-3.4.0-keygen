
GenKey		PROTO	:DWORD
Rndproc		PROTO	:DWORD
CustomizePart	PROTO	:DWORD
Clean		PROTO

.data
Phormat 	db "%s-%s-%s-%s-%s",0
Charset 	db "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",0
SrlBuffer 	db 40h dup(0)
buff1 		db 8 dup(0)
buff2 		db 8 dup(0)
buff3 		db 8 dup(0)
buff4 		db 8 dup(0)
buff5 		db 8 dup(0)
Rndvalue dd 0
SrlCounter dd 0

.code
GenKey proc near hDlg:DWORD

		call Clean
		xor eax, eax
		mov SrlCounter, eax
		mov esi, offset buff1
		mov edi, 1

part_1:
		invoke Rndproc,36
		movzx ebx, Charset[eax]
		mov [edi+esi-1], bl
		inc edi
		inc SrlCounter
		cmp SrlCounter, 5
		jl part_1
		invoke CustomizePart,offset buff1
		mov edx, offset buff5
		mov [edx], al
		xor eax, eax
		mov SrlCounter, eax
		mov esi, offset buff2
		mov edi, 1

part_2:
		invoke Rndproc,36
		movzx ebx, Charset[eax]
		mov [edi+esi-1], bl
		inc edi
		inc SrlCounter
		cmp SrlCounter, 5
		jl part_2
		invoke CustomizePart,offset buff2
		mov edx, offset buff5
		mov [edx+1], al
		xor eax, eax
		mov SrlCounter, eax
		mov esi, offset buff3
		mov edi, 1

part_3:
		invoke Rndproc,36
		movzx ebx, Charset[eax]
		mov [edi+esi-1], bl
		inc edi
		inc SrlCounter
		cmp SrlCounter, 5
		jl part_3
		invoke CustomizePart,offset buff3
		mov edx, offset buff5
		mov [edx+2], al
		xor eax, eax
		mov SrlCounter, eax
		mov esi, offset buff4
		mov edi, 1

part_4:
		invoke Rndproc,36
		movzx ebx, Charset[eax]
		mov [edi+esi-1], bl
		inc edi
		inc SrlCounter
		cmp SrlCounter, 5
		jl part_4
		invoke CustomizePart,offset buff4
		mov edx, offset buff5
		mov [edx+3], al
		invoke CustomizePart,offset buff5
		mov edx, offset buff5
		mov [edx+4], al
		mov eax, offset buff1
		mov ebx, offset buff2
		mov ecx, offset buff3
		mov edx, offset buff4
		mov esi, offset buff5
		push esi
		push edx
		push ecx
		push ebx
		push eax
		push offset Phormat
		push offset SrlBuffer
		call wsprintfA
		add esp, 1Ch
		invoke SetDlgItemText,hDlg,IDC_SERIAL,offset SrlBuffer
		ret
GenKey endp

Rndproc proc _amount:DWORD

		push ebx
		mov eax, _amount
		xor ebx, ebx
		imul edx, Rndvalue[ebx], 8088405h
		inc edx
		mov Rndvalue[ebx], edx
		mul edx
		mov eax, edx
		pop ebx
		ret

Rndproc endp

CustomizePart proc near _part:DWORD

		xor esi, esi
		mov edi, [_part]
		invoke lstrlen,edi
		mov edx, edi
		mov ecx, eax
		cmp ecx, 5
		jnz loc_4012AD
		movsx eax, byte ptr [edx+4]
		movsx ecx, byte ptr [edx+2]
		add eax, ecx
		movsx ecx, byte ptr [edx+1]
		add eax, ecx
		movsx ecx, byte ptr [edx]
		movsx edx, byte ptr [edx+3]
		add eax, ecx
		imul eax, edx
		jmp loc_4012C6

loc_4012AD:
		cmp ecx, 4
		jnz loc_4012DC
		movsx ecx, byte ptr [edx]
		movsx esi, byte ptr [edx+2]
		movsx eax, byte ptr [edx+1]
		mov edx, ecx
		add edx, esi
		add eax, edx
		imul eax, ecx

loc_4012C6:
		cmp eax, 1Ah
		jl loc_4012D5

loc_4012CB:
		cdq
		sub eax, edx
		sar eax, 1
		cmp eax, 1Ah
		jge loc_4012CB

loc_4012D5:
		add eax, 41h
		ret

loc_4012DC:
		add esi, 41h
		mov eax, esi
		ret
CustomizePart endp

Clean proc
		invoke RtlZeroMemory,offset buff1,sizeof buff1
		invoke RtlZeroMemory,offset buff2,sizeof buff2
		invoke RtlZeroMemory,offset buff3,sizeof buff3
		invoke RtlZeroMemory,offset buff4,sizeof buff4
		invoke RtlZeroMemory,offset buff5,sizeof buff5
		invoke RtlZeroMemory,offset SrlBuffer,sizeof SrlBuffer
		ret
Clean endp
