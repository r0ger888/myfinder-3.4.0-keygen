.686
.model	flat, stdcall
option	casemap :none

include	resID.inc
include CrazyWord.asm
include textscr_mod.asm
include algo.asm

AllowSingleInstance MACRO lpTitle
        invoke FindWindow,NULL,lpTitle
        cmp eax, 0
        je @F
          push eax
          invoke ShowWindow,eax,SW_RESTORE
          pop eax
          invoke SetForegroundWindow,eax
          mov eax, 0
          ret
        @@:
ENDM

.code
start:
	invoke	GetModuleHandle, NULL
	mov	hInstance, eax
	invoke	InitCommonControls
	invoke LoadBitmap,hInstance,300
	mov hIMG,eax
	invoke CreatePatternBrush,eax
	mov hBrush,eax
	invoke CreateSolidBrush,0
	mov hBackbr,eax
	AllowSingleInstance addr WindowTitle
	invoke	DialogBoxParam, hInstance, IDD_MAIN, 0, offset DlgProc, 0
	invoke	ExitProcess, eax

DlgProc proc hDlg:HWND,uMessg:UINT,wParams:WPARAM,lParam:LPARAM
LOCAL X:DWORD
LOCAL Y:DWORD
LOCAL ps:PAINTSTRUCT
LOCAL hdd:HDC

	.if [uMessg] == WM_INITDIALOG
 
 		push hDlg
 		pop xWnd
 		
		mov eax, 340
		mov nHeight, eax
		mov eax, 260
		mov nWidth, eax                
		invoke GetSystemMetrics,0                
		sub eax, nHeight
		shr eax, 1
		mov [X], eax
		invoke GetSystemMetrics,1               
		sub eax, nWidth
		shr eax, 1
		mov [Y], eax
		invoke SetWindowPos,hDlg,0,X,Y,nHeight,nWidth,40h
            	
		invoke	LoadIcon,hInstance,200
		invoke	SendMessage, xWnd, WM_SETICON, 1, eax
		invoke  SetWindowText,xWnd,addr WindowTitle
		invoke  ScrollerInit,hDlg
		
		invoke CreateFontIndirect,addr TxtFont
		mov hFont,eax
		invoke GetDlgItem,xWnd,IDC_SERIAL
		mov hSerial,eax
		invoke SendMessage,eax,WM_SETFONT,hFont,1
		
		invoke ImageButton,xWnd,20,187,500,502,501,IDB_GEN
		mov hGen,eax
		invoke ImageButton,xWnd,130,187,600,602,601,IDB_ABOUT
		mov hAbout,eax
		invoke ImageButton,xWnd,232,188,700,702,701,IDB_EXIT
		mov hExit,eax
		
		invoke uFMOD_PlaySong,addr xm,xm_length,XM_MEMORY
		
		invoke GetTickCount
		mov Rndvalue,eax
		invoke GenKey,xWnd
		
	.elseif [uMessg] == WM_LBUTTONDOWN

		invoke SendMessage, xWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0

	.elseif [uMessg] == WM_CTLCOLORDLG

		return hBrush

	.elseif [uMessg] == WM_PAINT
                
		invoke BeginPaint,xWnd,addr ps
		mov hdd,eax
		invoke GetClientRect,xWnd,addr r3kt
		invoke FrameRect,hdd,addr r3kt,hBackbr
		invoke EndPaint,xWnd,addr ps
	
	.elseif [uMessg] == WM_CTLCOLORSTATIC
	
		invoke SetBkMode,wParams,TRANSPARENT
		invoke SetTextColor,wParams,White
		invoke GetWindowRect,xWnd,addr WndRect
		invoke GetDlgItem,xWnd,IDC_SERIAL
		invoke GetWindowRect,eax,addr SerialRect
		mov edi,WndRect.left
		mov esi,SerialRect.left
		sub edi,esi
		mov ebx,WndRect.top
		mov edx,SerialRect.top
		sub ebx,edx
		invoke SetBrushOrgEx,wParams,edi,ebx,0
		mov eax,hBrush
		ret

	.elseif [uMessg] == WM_COMMAND
        
		mov eax,wParams
		.if eax == IDB_GEN || eax == IDOK
			invoke GenKey,xWnd
		.elseif eax == IDB_ABOUT
			invoke DialogBoxParam,0,IDD_ABOUT,xWnd,offset AboutProc,0
		.elseif eax == IDB_EXIT || eax == IDCANCEL
			invoke SendMessage,xWnd,WM_CLOSE,0,0
		.endif
             
	.elseif [uMessg] == WM_CLOSE
		invoke uFMOD_PlaySong,0,0,0
		invoke EndDialog,xWnd,0     
	.endif
         xor eax,eax
         ret
DlgProc endp

end start