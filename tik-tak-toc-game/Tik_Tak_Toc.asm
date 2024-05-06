include Irvine32.inc
    
.data
board BYTE " 1      |2      |3      ",10,13,
           "        |       |       ",10,13,
           "        |       |       ",10,13,
           " -------+-------+-------",10,13, 
           " 4      |5      |6      ",10,13,
           "        |       |       ",10,13,
           "        |       |       ",10,13,
           " -------+-------+-------",10,13,
           " 7      |8      |9      ",10,13, 
           "        |       |       ",10,13,
           "        |       |       ",10,13,0

	
	Intro byte 9,9,9,9,"X86 Assembly ",10,13,9,32,32,"Name:",
   10,13,9,9,"Abdul Haseeb  | Whatsapp # +92-324-5261091",10,13,0
	
	
	user_input dword  ?
	MsgForInput  BYTE "'s Turn Choose a square: ",0
	Player1 byte 10 dup (?),0  ;nms
	player2 byte 10 dup (?),0  ;nms
	PlayerFlag byte ?
	GameStatus dword  -1,-2,-3,-4,-5,-6,-7,-8,-9		 ;0=x ;1=O
	NameInputMsg0 byte 10,13,"1st Player Enter Name(Only 10 Character is Allowed):",0,10,13
	NameInputMsg1 byte 10,13,"2nd Player Enter Name(Only 10 Character is Allowed):",0,10,13
	EChoice       byte "Enter Position:",0 
	InvalidState  byte "Please Enter Valid Position(between 1 and 9) : ",0
	TossWin       byte "'s won the Toss !!!",0,10,13,10,13
	warning		  byte "This location is already marked !! Choose Remaning one !!!",
					    "Choose Position Again :",0
   PlayerSign byte ?
   RetCondition byte true 
   check dword 0
  	Remaingbox byte "Empty Boxes :",0
	win byte "'s won!!!!",0
   	winflg byte false
	drawflg byte false
	DrawMsg byte "Draw game",0
.code
;________________________________special use____________________________________________________
    PrintIntro proc
	mov edx,offset Intro
	call writeString 
	ret
	PrintIntro endp
;________________________________________________________________________________________________
	 UserName  proc
	  lea edx,NameInputMsg0
	  call writeString 
	  lea edx,player1
	  mov ecx,lengthof player1
	  call readString

	  lea edx,NameInputMsg1
	  call writeString 
	  lea edx,player2
	  mov ecx,lengthof player2
	  call readString
	  ret 
	 UserName  Endp

;________________________________________________________________________________________________
  Toss  proc
  call randomize 
  mov eax,2
  call RandomRange
  cmp eax,0

  je xturn
  mov PlayerFlag,False	  ;nxt xs trun
	lea edx,player2
	mov eax,white+(blue*16)
        call setTextColor
	call writestring
	lea  edx,TossWin
	    
		mov eax,white+(blue*16)
        call setTextColor
		call WriteString
	call crlf
	call crlf
	mov eax,white+(green*16)
	call setTextColor
	lea edx,player2
	call writestring
	lea edx,MsgForInput
	call WriteString
	jmp nxt
  xturn:
	mov PlayerFlag,True	  ;nxt Os trun
	lea edx,player1
	mov eax,white+(blue*16)
    call setTextColor
	call writestring
	lea  edx,TossWin
	    
		mov eax,white+(blue*16)
        call setTextColor
	call WriteString
	  call crlf
	mov eax,white+(green*16)
	call setTextColor
	lea edx,player1
	call writestring
	lea edx,MsgForInput
	call WriteString
	 nxt:
	 mov eax,white+(black*16)
	 call setTextColor
     ret
   Toss Endp
;________________________________________________________________________________________________
   UserInput proc
   rollback::
   againIn:
   cmp check,0
   jg trunMsg
   jmp SkipTrun
   trunMsg:
   
   cmp PlayerFlag,true 
   je player1Msg
   lea edx,player2
   	call writestring
  
   jmp SkipPlayer1
   player1msg:
   lea edx,player1

   
   call writeString
   SkipPlayer1:
   lea edx,MsgForInput
   call writeString
	Skiptrun:
    call readint
	cmp eax,0
	JG above 
	lea edx,InvalidState
	call crlf
	mov eax,white+(red*16)
    call setTextColor
	call writeString
	jmp againIN


	above:
	       cmp eax,10
		   jb below 
		   lea edx,InvalidState
	       call crlf
		   mov eax,white+(red*16)
           call setTextColor
	       call writeString
	       jmp againIN
	below:
	mov  user_input,eax
	mov eax,white+(black*16)
	call setTextColor
	cmp RetCondition,true
	jne RollNxt
	
    ret
   UserInput Endp
;________________________________________________________________________________________________
SetGameStatus proc
RollNxt::
  mov RetCondition,true
 ;we have value and flag
 mov edi,user_input
 sub edi,1
 mov eax,edi
 mov ebx,4
 mul ebx
 mov edi,eax
  
 mov  esi,30
 cmp PlayerFlag,True 
 je CrossLogic
 
 test GameStatus[edi],80000000h         
        jnz negativeO
		lea edx,warning
		mov eax,white+(red*16)
        call setTextColor
		call crlf
		call writeString
		mov RetCondition,false
		jmp rollback

		negativeO:
		mov PlayerFlag,True
		mov GameStatus[edi],1;  1 mean O
	    call BoxSetMark 
		 
		jmp skipX
 



 CrossLogic:
        
		test GameStatus[edi],80000000h         
        jnz negative
		lea edx,warning
		mov eax,white+(red*16)
        call setTextColor
		call crlf
		call writeString
		mov RetCondition,false
		 jmp rollback

		negative:
		mov PlayerFlag,false
		mov GameStatus[edi],0;  0 mean x 
	 
		call BoxSetMark 
		
	 skipX:
	    call clrscr
	    lea  edx,board
		call crlf 
	
		
		call writeString
		
ret
SetGameStatus Endp


;________________________________________________________________________________________________
BoxSetMark  Proc
add check,1
cmp GameStatus[edi],0
jne ChangeSign
mov PlayerSign,'X'
jmp skipChange

ChangeSign:
mov PlayerSign,'O'

skipChange:
cmp user_input,1
je box1
cmp user_input,2
je box2
cmp user_input,3
je box3
cmp user_input,4
je box4
cmp user_input,5
je box5
cmp user_input,6
je box6
cmp user_input,7
je box7
cmp user_input,8
je box8
cmp user_input,9
je box9

box1:
	 mov al,PlayerSign
     mov board[esi],al
	 ret
 box2:
	 mov al,PlayerSign
     mov board[esi+8],al
	 ret
box3:
	 mov al,PlayerSign
     mov board[esi+16],al
	 ret
box4:
	 mov al,PlayerSign
     mov board[esi+104],al
	 ret
box5:
	 mov al,PlayerSign
     mov board[esi+112],al
	 ret
box6:
	 mov al,PlayerSign
     mov board[esi+120],al
	 ret
box7:
	 mov al,PlayerSign
     mov board[esi+208],al
	 ret
box8:
	 mov al,PlayerSign
     mov board[esi+216],al
	 ret
 box9:
	 mov al,PlayerSign
     mov board[esi+224],al
	 ret

BoxSetMark		endp
;________________________________________________________________________________________________

 remain proc 
 call crlf
	
		mov dh,3
		mov dl,95
		call gotoxy
		mov edx,offset Remaingbox
		call writestring
		mov eax,9
		sub eax,check
		call writedec
		mov dh,13
		mov dl,0
		call gotoxy

 ret 
 remain endp
;________________________________________________________________________________________________
CheckWin proc
mov esi,GameStatus
cmp esi,GameStatus+4
je row1


checkRow2:
mov esi,GameStatus+12
cmp esi,GameStatus+16
je row2


CheckRow3:
mov esi,GameStatus+24
cmp esi,GameStatus+28
je row3

CheckCol_1:

mov esi,GameStatus
cmp esi,GameStatus+12
je col1

 CheckCol_2:
 mov esi,GameStatus+4
cmp esi,GameStatus+16
je col2

CheckCol_3:
 mov esi,GameStatus+8
cmp esi,GameStatus+20
je col3

CheckDgnal1:
mov esi,GameStatus+	8
cmp esi,GameStatus+16
je D1
 
CheckDgnal2:
 mov esi,GameStatus
cmp esi,GameStatus+16
je D2
abv1:
mov DrawFlg ,true
jmp SkipNxt1
row1 :
	mov esi,GameStatus+4
	cmp esi,GameStatus+8
	jne checkRow2
	cmp esi,0
	je player1Row1
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win

  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1Row1:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
   mov winflg,true
   jmp 	skipNxt1

 row2 :
	mov esi,GameStatus+16
	cmp esi,GameStatus+20
	jne CheckRow3
	cmp esi,0
	je player1row2
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win
  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1row2:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
  mov winflg,true
  jmp skipNxt1

  row3 :
	mov esi,GameStatus+28
	cmp esi,GameStatus+32
	jne CheckCol_1
	cmp esi,0
	je player1row3
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win
  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1row3:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
   mov winflg,true
   	jmp skipNxt1

    col1 :
	mov esi,GameStatus+12
	cmp esi,GameStatus+24
	jne CheckCol_2
	cmp esi,0
	je player1col1
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win
  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1col1:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
   mov winflg,true
   	jmp skipNxt1


 col2:
   	mov esi,GameStatus+16
	cmp esi,GameStatus+28
	jne CheckCol_3
	cmp esi,0
	je player1col2
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win
  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1col2:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
   mov winflg,true
   	jmp skipNxt1

  col3:
   	mov esi,GameStatus+20
	cmp esi,GameStatus+32
	jne CheckDgnal1
	cmp esi,0
	je player1col3
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win
  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1col3:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
   mov winflg,true
   	jmp skipNxt1


	 D1:
   	mov esi,GameStatus+16
	cmp esi,GameStatus+24
	jne CheckDgnal2
	cmp esi,0
	je player1D1
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win
  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1D1:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
   mov winflg,true
   	jmp skipNxt1


   	 D2:
   	mov esi,GameStatus+16
	cmp esi,GameStatus+32
	jne Abv1
	cmp esi,0
	je player1D2
	call crlf
 lea edx,player2
 call  writeString
  lea edx,win
  call  writeString
  	mov winflg,true
   jmp skipNxt1
player1D2:
 call crlf
 lea edx,player1
 call  writeString
  lea edx,win
  call  writeString
   mov winflg,true
   	jmp skipNxt1


 skipNxt1:
ret
CheckWin endp
;________________________________________________________________________________________________




	 main proc
	call PrintIntro	
	call UserName 

	call Toss
	mov ecx,9
	l1:
	 cmp winflg,true
	 je ext
	call userInput
	call SetGameStatus 
	call remain 
	  mov eax,white+(green*16)
	  call setTextColor
	 call CheckWin
	 mov eax,white+(black*16)
	 call setTextColor
	  loop l1
		cmp drawFlg,true
		jne ext 
		mov eax,white+(yellow*16)
		call settextColor
		mov edx,offset DrawMsg
		call writeString
		ext:
		 exit 
	 main endp
	 


	 end main