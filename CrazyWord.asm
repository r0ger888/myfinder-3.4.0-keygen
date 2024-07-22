AboutProc		PROTO :HWND,:UINT,:WPARAM,:LPARAM
RndTime 		PROTO
Randumb 		PROTO :DWORD
TopXYRipped 	PROTO :DWORD,:DWORD
TextSetup 		PROTO
TextLenCalc 	PROTO
StartAddress 	PROTO
WordzAnim 		PROTO


.data

AboutText    	db "  .:: PERYFERiAH kLAN PrEsEnT ::.",13,13
				db "[      MyFinder 3.4.0 Keygen      ]",13,13
				db "[ Author     : MaryNello......... ]",13
                db "[ Date       : 22.o7.2o24........ ]",13
				db "[ Protection : Custom............ ]",13,13
				db "[ GreetZ 2 :",13,13
				db "[ Al0hA ......................[PRF]",13
				db "[ B@TRyNU ....................[PRF]",13
				db "[ WeeGee .....................[PRF]",13
				db "[ r0ger ......................[PRF]",13
				db "[ sabYn ......................[PRF]",13
				db "[ GRUiA ......................[PRF]",13
				db "[ zzLaTaNN ...................[PRF]",13
				db "[ oViSpider ..................[PRF]",13
				db "[ bDM10 ......................[PRF]",13
				db "[ yMRAN ......................[PRF]",13
				db "[ ShTEFY .....................[PRF]",13
				db "[ DAViD ......................[PRF]",13
				db "[ PuMMy ......................[PRF]",13
				db "[ QueenAntonia ...............[PRF]",13
				db "[ and other [ P R F ] members.....]",13,13
				db "[ and also :",13
				db "[ Cachito ...................[TSRh]",13
				db "[ Talers ....................[TSRh]",13
				db "[ Xyl2k ..........................]",13
				db "[ kao ............................]",13
				db "[ Razorblade1979 ............[URET]",13
				db "[ Arttomov ..................[URET]",13
				db "[ Jasi2169 ..................[URET]",13
				db "[ Sunsay ..............[FEELiNNERS]",13
				db "[ WhX .....................[DiSiRE]",13
				db "[ Dilik ..........................]",13
				db "[ Intel Core 2 Extreme ...........]",13
				db "[ Log0 ...........................]",13
				db "[ Bang1338 .................[BGSPA]",13
				db "[ Vad1m ..........................]",13
				db "[  ...  and mainly other ppl . ^) ]",13,13
				db "[ 10x go 2 :",13,13
				db "[ r0ger ..............[keygen temp]",13
				db "[ smirk ....................[music]",13
				db "[ Asterix&Quantum ..........[uFMOD]",13
				db "[ x0man ...............[about temp]",13,13
				db "[ our distro :",13
				db "[ distro.cracksurl.com/team-prf.. ]",13,13
				db "[ discord   : r0ger888........... ]",13
				db "[ telegram  : t.me/r0ger888...... ]",13
				db "[ github    : r0ger888........... ]",0
				
				
aWnd    		dd 0                    
Globalstop		BOOL	FALSE							
RndValue    	dd 0                   
Abttextlen    	dd 0                 
hMem            dd 0                 
JumpHeight    	dd 14h                
TextLeft    	dd 1Fh             
StartPosition   dd 104h               
aWidth			dd 340
aHeight			dd 260
hJump    		dd 0                                                      
hJumpDwn    	dd 0                   
hdc             dd 0                
hdcDest         dd 0              
ahFont    		dd 0                                                    
hBitmap			dd 0      
ThreadId        dd 0      
WordzThread    	dd 0          
AboutBoxTitle   db "Greetz & stuff.",0     
AboutFont     LOGFONT <14,0,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'courier new'>   
TextLength     db 3Ah      
	
; aboutbox temp inspired from Open_Video_Converter_3.0.3.Patch.bagie.tPORt

.code

RndTime      proc ;near               ; CODE XREF: sub_401A25+27p
;SystemTime      = SYSTEMTIME ptr -10h
local SystemTime:SYSTEMTIME
                lea     eax, SystemTime
                push    eax            
                call    GetSystemTime
                movzx   eax, SystemTime.wHour
                imul    eax, 3Ch
                add     ax, SystemTime.wMinute
                imul    eax, 3Ch
                xor     edx, edx
                mov     dx, SystemTime.wSecond
                add     eax, edx
                imul    eax, 3E8h
                mov     dx, SystemTime.wMilliseconds
                add     eax, edx
                mov     RndValue, eax
				ret
RndTime      endp


Randumb      proc arg_0000:DWORD;near               ; CODE XREF: StartAddress+A3p
;arg_0000           = dword ptr  8
                mov     eax, arg_0000
                imul    edx, RndValue, 8088405h
                inc     edx
                mov     RndValue, edx
                mul     edx
                mov     eax, edx
				ret
Randumb      endp

TextLenCalc      proc near 
                push    offset AboutText
                call    lstrlen
                mov     Abttextlen, eax
                imul    eax, 15h
                push    eax      
                push    40h  
                call    GlobalAlloc
                mov     hMem, eax
				ret
TextLenCalc      endp


TextSetup      proc
LOCAL var_88:DWORD
LOCAL var_44:DWORD
                push    TextLeft
                pop var_44
                push    StartPosition
                pop var_88
                mov     edx, hMem
                mov     ecx, offset AboutText
                xor     eax, eax
loc_401827: 
                push    eax
                mov     al, [ecx]
                mov     [edx], al
                push var_44
                pop     dword ptr [edx+1]
                push var_88
                pop     dword ptr [edx+5]
                push    dword ptr [edx+1]
                pop     dword ptr [edx+9]
                push    dword ptr [edx+5]
                pop     dword ptr [edx+0Dh]
                add var_44,8
                add     edx, 15h
                cmp     al, 0Dh
                jnz     short loc_40185C
                push    TextLeft
                pop var_44
                add var_88,0Fh
loc_40185C: 
                pop     eax
                inc     eax
                inc     ecx
                cmp     Abttextlen, eax
                ja      short loc_401827
				ret
TextSetup      endp

StartAddress    proc
LOCAL hdcSrc:HDC 
LOCAL hBackground:DWORD
LOCAL var_4:DWORD
                
                invoke CreateCompatibleDC,0
                mov hdcSrc,eax 
                invoke FindResource,hInstance,250,eax                 
			    invoke BitmapFromResource,eax,250
                mov hBackground,eax
	            invoke SelectObject,hdcSrc,hBackground
	            
	        	     
loc_401897:    
                mov var_4,0
           		invoke StretchBlt,hdcDest,0,0,aWidth,aHeight,hdcSrc,0,0,aWidth,aHeight,0CC0020h
                mov     edx, hMem

loc_4018CD:  
                mov     eax, [edx+5]
                cmp     [edx+0Dh], eax
                jnz     short loc_401939
                mov     eax, [edx+1]
                mov     ecx, eax
                add     ecx, 7
                cmp     hJump, eax
                jb      short loc_40193F
                cmp     hJump, ecx
                ja      short loc_40193F
                mov     eax, [edx+5]
                mov     ecx, eax
                add     ecx, 0Fh
                cmp     hJumpDwn, eax
                jb      short loc_401937
                cmp     hJumpDwn, ecx
                ja      short loc_401937
                push    edx
                push    JumpHeight
                call    Randumb
                pop     edx
                mov     ecx, eax
                push    edx
                push    2
                call    Randumb
                pop     edx
                cmp     al, 1
                jnz     short loc_40192D
                mov     dword ptr [edx+11h], 1
                imul    ecx, -1
                jmp     short loc_401934
; ---------------------------------------------------------------------------
loc_40192D:                   
                mov     dword ptr [edx+11h], 0FFFFFFFFh
loc_401934:           
                add     [edx+5], ecx
loc_401937:  
                jmp     short loc_40193F
; ---------------------------------------------------------------------------
loc_401939: 
                mov     eax, [edx+11h]
                add     [edx+5], eax
loc_40193F:    
                push    edx
                cmp     byte ptr [edx], 0Dh
                jz      short loc_40195B
                push    1    
                lea     eax, [edx]
                push    eax  
                push    dword ptr [edx+5]
                push    dword ptr [edx+1] 
                push    hdcDest        
                call    TextOut

loc_40195B:  
                pop     edx
                movzx   ecx, TextLength
                imul    ecx, 0Fh
                imul    ecx, -1
                cmp     ecx, [edx+5]
                jnz     short loc_401975
                pusha
                call    TextSetup
                popa

loc_401975:   
                add     edx, 15h
                mov     eax, Abttextlen
                inc var_4
                cmp var_4,eax
                jb      loc_4018CD
                push    0CC0020h  
                push    0             
                push    0             
                push    hdcDest  
                push    aHeight ; height
                push    aWidth ; width  
                push    0          
                push    0           
                push    hdc         
                call    BitBlt
                push    0Ah                    
                call    Sleep
                cmp     Globalstop, 1
                jnz     loc_401897
				ret
StartAddress    endp


WordzAnim      proc 
                mov     ecx, Abttextlen
                mov     edx, hMem
loc_4019D3: 
                mov     eax, [edx+5]
                cmp     [edx+0Dh], eax
                jnz     short loc_401A09
                push    ecx
                push    edx
                push    3
                call    Randumb
                mov     ecx, eax
                push    2
                call    Randumb
                pop     edx
                cmp     al, 1
                jnz     short loc_4019FE
                mov     dword ptr [edx+11h], 1
                imul    ecx, -1
                jmp     short loc_401A05
; ---------------------------------------------------------------------------
loc_4019FE: 
                mov     dword ptr [edx+11h], 0FFFFFFFFh
loc_401A05: 
                add     [edx+5], ecx
                pop     ecx
loc_401A09:    
                dec     dword ptr [edx+0Dh]
                dec     dword ptr [edx+5]
                add     edx, 15h
                loop    loc_4019D3
                invoke Sleep,32h
                cmp     Globalstop, 1
                jnz     short WordzAnim
				ret
WordzAnim      endp


AboutProc proc hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
LOCAL Y:DWORD
LOCAL X:DWORD
LOCAL Aboutrect:RECT
	
                mov eax,uMsg
                cmp     eax, 110h ; <-- WM_INITDIALOG
                jnz     loc_401BAF
                mov     Globalstop, 0
                push hWnd
                pop     aWnd
                call    RndTime
               	invoke GetParent, hWnd
				mov ecx, eax
				invoke GetWindowRect, ecx, addr Aboutrect
				mov edi, Aboutrect.left
				mov esi, Aboutrect.top
				add edi, 0
				add esi, 0
				invoke SetWindowPos,hWnd,HWND_TOP,edi,esi,aWidth,aHeight,SWP_SHOWWINDOW
               invoke SetWindowText,hWnd,offset AboutBoxTitle
               invoke GetDC,aWnd
                mov     hdc, eax
               invoke CreateCompatibleDC,0
                mov     hdcDest, eax
               invoke CreateBitmap,aWidth,aHeight,1,20h,0
                mov     hBitmap, eax
                invoke CreateFontIndirect,addr AboutFont
                mov     ahFont, eax
                invoke SelectObject,hdcDest,hBitmap
                invoke SelectObject,hdcDest,ahFont
                invoke SetBkMode,hdcDest,1
                xor     eax, eax
                mov     ah, 0
                mov     al, 0
                rol     eax, 8
                mov     al, 0
                invoke SetTextColor,hdcDest,0DDDDDDh
                call    TextLenCalc
                call    TextSetup
                invoke CreateThread,0,0,offset StartAddress,0,0,offset ThreadId
                invoke CreateThread,0,0,offset WordzAnim,0,0,offset WordzThread
                jmp     loc_401C83
; ---------------------------------------------------------------------------
loc_401BAF:                  
                cmp uMsg,200h ; <-- WM_MOUSEMOVE
                jnz     short loc_401BD5
                mov eax,lParam;arg_C
                and     eax, 0FFFFh
                mov     hJump, eax
                mov eax,lParam;arg_C
                shr     eax, 10h
                mov     hJumpDwn, eax
                jmp     loc_401C83
; ---------------------------------------------------------------------------
loc_401BD5:                            
                cmp     eax, 201h ; <-- WM_LBUTTONDOWN
                jnz     short loc_401C09
                push    0             
                push    0               
                push    10h           
                push hWnd
                call    SendMessage
                jmp     short loc_401C83
; ---------------------------------------------------------------------------
loc_401C09:                           
                cmp     eax, 10h ; <-- WM_CLOSE
                jnz     short loc_401C83
                mov     Globalstop, 1
                invoke Sleep,64h
                invoke ReleaseDC,aWnd,hdc
                invoke DeleteObject,hdcDest
                invoke DeleteObject,ahFont
                invoke DeleteObject,hBitmap
                invoke TerminateThread,ThreadId,0
                invoke TerminateThread,ThreadId,0
                invoke GlobalFree,hMem
                invoke EndDialog,aWnd,0
loc_401C83:                                                             
                xor     eax, eax
				ret
AboutProc      endp