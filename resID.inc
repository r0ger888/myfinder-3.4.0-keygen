include		windows.inc 
include		kernel32.inc 
include		user32.inc 
include     gdi32.inc  
include 	shell32.inc
include		winmm.inc
include		masm32.inc
include		msvcrt.inc
include		comctl32.inc
include		oleaut32.inc
include		ole32.inc
include		advapi32.inc
include		comdlg32.inc
include     /masm32/macros/macros.asm

includelib	kernel32.lib
includelib	user32.lib 
includelib 	gdi32.lib
includelib 	shell32.lib
includelib	winmm.lib
includelib 	masm32.lib
includelib	msvcrt.lib
includelib	comctl32.lib
includelib  oleaut32.lib
includelib  ole32.lib
includelib	advapi32.lib
includelib	comdlg32.lib

include btnt.inc

include ufmod.inc
includelib ufmod.lib

DlgProc			PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	1000
IDD_ABOUT	equ	2000
IDB_EXIT	equ	1001
IDB_GEN		equ	1002
IDB_ABOUT	equ	1003
IDC_SERIAL	equ	1004

.data
include viulumies_lentaa2.inc
WindowTitle	db	"pRF.4eVeR!",0
r3kt			RECT	<>
TxtFont		LOGFONT <16,0,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'courier new'>
TxtFont2		LOGFONT <16,0,0,0,FW_BOLD,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,0,'ms sans serif'>
DELAY_VALUE			equ		6
Transparency		dd		?
TRANSPARENT_VALUE	equ 254

.data?
hInstance	dd	?
xWnd		dd	?
hFont			dd	?
hIMG			dd  ?
hSerial     dd  ?
WndRect			RECT <?>
SerialRect		RECT <?>
hAnim		 	dd ?
hFormwnd		dd ?
hTxtscr			dd ?
xThread 	    dd ?
yThread			dd ?
nWidth			dd ?
nHeight			dd ?
hBrush			dd ?
hBackbr			dd ?
