function _USER
parameters PathUserDbf,Info,Code
if parameters()<1
 PathUserDbf=fullpath('')
endif 
if parameters()<2
 Info=0
endif 
if parameters()<3
 Code='    '
endif 
push key clear
private ppReturn
ppReturn=''
if file(PathUserDbf+'E000.DBF')
 sele 0
 use PathUserDbf+'E000'
 do fDefa
 if Info=0
  do fInput
 else
  do fRetu 
 endif 
 do fRele
 sele E000
 use
endif
pop key
return ppReturn

function fDefa
public ppGo
public dimension ppWin[5]
public dimension ppInp[2]
public dimension ppIn[30]
public dimension ppOut[10]

function fRele
release ppGo,ppWin,ppInp,ppIn,ppOut

function fWind
define window wwUser from 16,21 to 19,60 in screen ;
 title  ppWin[1] footer ppWin[2];
 color W+/GR,,W+/GR,W+/GR,W+/GR,,,,,
activate window wwUser 
@ 0,1 say padr(ppWin[3],15) 
@ 1,1 say padr(ppWin[4],15) 
@ 0,17 say space(20) color W+/GB
@ 1,17 say space(20) color W+/GB

function fDeac
release windows wwUser

function fSet
ppIn[1]=""
ppIn[2]=""
ppIn[3]=""
ppIn[4]=""
for p2=1 to 10
 ppIn[10+p2]=0
endfor
for p2=1 to 10
 ppOut[p2]=''
endfor

function fLoad
private p1,p2,p3
p1=fChange(-1,3,E000.IN)
ppIn[1]=substr(p1,1,4)
ppIn[2]=substr(p1,5,1)
ppIn[3]=substr(p1,6,20)
ppIn[4]=substr(p1,26,20)
for p2=1 to 10
 p3=substr(p1,46-1+p2,1)
 ppIn[10+p2]=asc(p3)
endfor
p1=fChange(-1,11,E000.OUT)
p3=1
for p2=1 to 10
 ppOut[p2]=substr(p1,p3,ppIN[10+p2])
 p3=p3+ppIn[10+p2]
endfor

function fSave
private p1,p2,p3
p1=ppIn[1]+ppIn[2]+ppIn[3]+ppIn[4]
for p2=1 to 10
 p3=chr(ppIN[10+p2])
 p1=p1+p3
endfor
p1=p1+space(10)
p1=fChange(1,3,p1)
sele E000
if !eof()
 replace next 1 in with p1
endif 

function fRetu
sele E000
if type('Code')='N'
 loca for recno()=Code
endif 
if type('Code')='C'
 private p1
 p1=fchange(1,3,padr(code,65))
 p1=fchange(0,3,p1,1,4)
 loca for like(p1,in)
endif
if !eof()
 do fLoad
 if Info<0
  ppReturn=ppIn[abs(Info)]
 else
  ppReturn=ppOut[Info]
 endif
endif   

function fInput
ppGo=0
ppWin[1]='Вўдрекомендуйтесь'
*ppWin[2]='[┘]Вхўд, з Ctrl - змўна паролю'
ppWin[2]='[┘]-Вхўд'
ppWin[3]='Користувач'
ppWin[4]='Пароль'
ppWin[5]="Невўрнў ўм'я або пароль"
ppInp[1]=''
ppInp[2]=''
do fWind
do while ppGo<1 
 if ppGo<1
  ppInp[1]=padr(upper(fWord(ppInp[1],0,"")),20)
 endif 
 if ppGo<1
  ppInp[2]=padr(upper(fWord(ppInp[2],1,'*')),20)
 endif 
 do fEnter with 1
enddo
do fDeac
do fEnter with 2
ppWin[1]='Змўна паролю'
ppWin[2]='[┘]Ввўд'
ppWin[3]='Новий пароль'
ppWin[4]='Ще раз'
ppWin[5]="Пароль не однаковий"
ppInp[1]=''
ppInp[2]=''
do fWind
do while ppGo<1
 if ppGo<1
  ppInp[1]=padr(upper(fWord(ppInp[1],0,"*")),20)
 endif
 if ppGo<1
  ppInp[2]=padr(upper(fWord(ppInp[2],1,'*')),20)
 endif 
 do fEnter with 3
enddo
do fDeac

function fWord
parameters par1,par2,par3
if parameters()<1
 par1=''
endif
if parameters()<2
 par2=0
endif
if parameters()<3
 par3=''
endif 
push key clear 
public ppp1,ppp2,ppp3,ppp4
ppp1=.t.
ppp2=len(alltrim(par1))
ppp4=ppp2+1
do while ppp1
 @ par2,16+1 say padr(iif(len(par3)>0,replicate(par3,ppp2),par1),20) color W+/GB
 @ par2,16+ppp4 say ''
 ppp3=inkey(0,'S')
 do case
  case ppp3=-9  &&F10
   ppNew=.f.
   ppGo=3
   ppp1=.f.
  case ppp3=27   &&ESC
   ppNew=.f.
   ppGo=3
   ppp1=.f.
  case ppp3=9    &&TAB
   ppp1=.f.
  case ppp3=15   &&CTRL+TAB
   ppp1=.f.
  case ppp3=5    &&UP
   ppp1=.f.
  case ppp3=24   &&DOWN 
   ppp1=.f.
  case ppp3=19   &&LEFT
   ppp4=ppp4-1
   if ppp4<1
    ppp4=1
   endif 
  case ppp3=1    &&HOME
   ppp4=1
  case ppp3=6    &&END 
   ppp4=ppp2+1
  case ppp3=4    &&RIGHT
   ppp4=ppp4+1
   if ppp4>ppp2+1
    ppp4=ppp2+1
   endif 
  case ppp3=127  &&BACKSPACE
   if ppp4>1 and ppp2>0
    par1=substr(par1,1,ppp4-2)+substr(par1,ppp4)
    ppp2=ppp2-1
    ppp4=ppp4-1
   endif
  case ppp3=7    &&DEL
   if ppp2>0
    par1=substr(par1,1,ppp4-1)+substr(par1,ppp4+1)
    ppp2=ppp2-1
   endif
  case ppp3=13   &&ENTER
   ppGo=1
   ppp1=.f.
  case ppp3=10   &&CTRL+ENTER
   ppGo=2
   ppp1=.f.
  otherwise
   if ppp3>=0 and ppp3<=255
    par1=substr(par1,1,ppp4-1)+chr(ppp3)+substr(par1,ppp4)
    ppp4=ppp4+1
    ppp2=ppp2+1
   endif 
 endcase
 if ppp2=20
  ppp1=.f.
 endif 
enddo
rele ppp1,ppp2,ppp3,ppp4
pop key
return par1

function fEnter
parameters par1
if ppGo<3
do case
 case par1=1
  private p1
  p1=padr(space(5)+padr(ppInp[1],20)+padr(ppInp[2],20),65)
  p1=fChange(1,3,p1)
  p1=fChange(0,3,p1,6,45)
  sele E000
  loca for like(p1,in)
  if !eof()
   do fLoad
   ppReturn=ppIn[1]
  else
   do fSet
   ppGo=0 
   wait ppWin[5] wind nowait
  endif 
 case par1=2
  if ppGo=2 and ppIn[2]='2'
   ppGo=0
  endif 
  if ppIn[2]='3' or ppIn[2]='4' 
   ppGo=0
  endif
 case par1=3
  if ppInp[1]==ppInp[2] and ppGo=1
   ppIn[4]=ppInp[2]
   if ppIn[2]='3'
    ppIn[2]='2'
   endif    
   do fSave
  else
   wait ppWin[5] wind nowait
   ppGo=0
  endif 
endcase 
endif
 
function fChange
parameters parType,parLen,parWord,parL1,parL2
public dimension parDad[parLen]
private p1,p2,p3,p4,p5,p6
p1=len(parWord)
if parType<1
 do fChange0
endif
if parType#0
 do fChange2
else
 do fChange3 
endif
if parType>-1
 do fChange1
endif
release parDad  
return parWord

function fChange0
store '' to parDad
p2=int(p1/parLen)
p3=p1%parLen
p5=1
for p4=1 to parLen
 p6=p2
 if p3>0
  p3=p3-1
  p6=p6+1
 endif 
 parDad[p4]=substr(parWord,p5,p6)
 p5=p5+p6
endfor
p2=len(parDad[1])
parWord=''
for p3=1 to p2
 for p4=1 to parLen
  parWord=parWord+substr(parDad[p4],p3,1)
 endfor
endfor

function fChange1
store '' to parDad
for p2=1 to parLen
 p3=p2
 do while p3<=p1
  parDad[p2]=parDad[p2]+substr(parWord,p3,1)
  p3=p3+ParLen
 enddo 
endfor 
parWord=''
for p2=1 to parLen
 parWord=parWord+parDad[p2]
endfor

function fChange2
p3=parWord
parWord=''
for p4=1 to p1
 p2=asc(substr(p3,p4,1))
 p2=p2+parType*(p4+33)  
 do while p2<0
  p2=p2+255
 enddo
 do while p2>255
  p2=p2-255
 enddo 
 parWord=parWord+chr(p2)
endfor

function fChange3
p4=parWord
parWord=''
for p2=1 to p1
 p3=substr(p4,p2,1)
 if p2<parL1 or p2>parL2
  p3='?'
 endif
 parWord=parWord+p3
endfor
