*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
FUNCTION _user
 PARAMETER pathuserdb, info, code
 IF PARAMETERS()<1
    pathuserdb = FULLPATH('')
 ENDIF
 IF PARAMETERS()<2
    info = 0
 ENDIF
 IF PARAMETERS()<3
    code = '    '
 ENDIF
 PUSH KEY CLEAR
 PRIVATE ppreturn
 ppreturn = ''
 IF FILE(pathuserdb+'E000.DBF')
    SELECT 0
    USE pathuserdb+'E000'
    DO fdefa
    IF info=0
       DO finput
    ELSE
       DO fretu
    ENDIF
    DO frele
    SELECT e000
    USE
 ENDIF
 POP KEY
 RETURN ppreturn
*
PROCEDURE fdefa
 PUBLIC ppgo
 PUBLIC dimension, ppwin[ 5]
 PUBLIC dimension, ppinp[ 2]
 PUBLIC dimension, ppin[ 30]
 PUBLIC dimension, ppout[ 10]
*
PROCEDURE frele
 RELEASE ppgo, ppwin, ppinp, ppin, ppout
*
PROCEDURE fwind
 DEFINE WINDOW wwuser FROM 16, 21 TO 19, 60 TITLE ppwin(1) IN screen FOOTER ppwin(2) COLOR W+/GR,,W+/GR,W+/GR,W+/GR,,,,,
 ACTIVATE WINDOW wwuser
 @ 0, 1 SAY PADR(ppwin(3), 15)
 @ 1, 1 SAY PADR(ppwin(4), 15)
 @ 0, 17 SAY SPACE(20) COLOR W+/BG 
 @ 1, 17 SAY SPACE(20) COLOR W+/BG 
*
PROCEDURE fdeac
 RELEASE WINDOW wwuser
*
PROCEDURE fset
 ppin[ 1] = ''
 ppin[ 2] = ''
 ppin[ 3] = ''
 ppin[ 4] = ''
 FOR p2 = 1 TO 10
    ppin[ 10+p2] = 0
 ENDFOR
 FOR p2 = 1 TO 10
    ppout[ p2] = ''
 ENDFOR
*
PROCEDURE fload
 PRIVATE p1, p2, p3
 p1 = fchange(-1,3,e000.in)
 ppin[ 1] = SUBSTR(p1, 1, 4)
 ppin[ 2] = SUBSTR(p1, 5, 1)
 ppin[ 3] = SUBSTR(p1, 6, 20)
 ppin[ 4] = SUBSTR(p1, 26, 20)
 FOR p2 = 1 TO 10
    p3 = SUBSTR(p1, 045+p2, 1)
    ppin[ 10+p2] = ASC(p3)
 ENDFOR
 p1 = fchange(-1,11,e000.out)
 p3 = 1
 FOR p2 = 1 TO 10
    ppout[ p2] = SUBSTR(p1, p3, ppin(10+p2))
    p3 = p3+ppin(10+p2)
 ENDFOR
*
PROCEDURE fsave
 PRIVATE p1, p2, p3
 p1 = ppin(1)+ppin(2)+ppin(3)+ppin(4)
 FOR p2 = 1 TO 10
    p3 = CHR(ppin(10+p2))
    p1 = p1+p3
 ENDFOR
 p1 = p1+SPACE(10)
 p1 = fchange(1,3,p1)
 SELECT e000
 IF  .NOT. EOF()
    REPLACE in WITH p1 NEXT 1
 ENDIF
*
PROCEDURE fretu
 SELECT e000
 IF TYPE('Code')='N'
    LOCATE FOR RECNO()=code
 ENDIF
 IF TYPE('Code')='C'
    PRIVATE p1
    p1 = fchange(1,3,PADR(code, 65))
    p1 = fchange(0,3,p1,1,4)
    LOCATE FOR LIKE(p1, in)
 ENDIF
 IF  .NOT. EOF()
    DO fload
    IF info<0
       ppreturn = ppin(ABS(info))
    ELSE
       ppreturn = ppout(info)
    ENDIF
 ENDIF
*
PROCEDURE finput
 ppgo = 0
 ppwin[ 1] = 'Вўдрекомендуйтесь'
 ppwin[ 2] = '[┘]-Вхўд'
 ppwin[ 3] = 'Користувач'
 ppwin[ 4] = 'Пароль'
 ppwin[ 5] = "Невўрнў ўм'я або пароль"
 ppinp[ 1] = ''
 ppinp[ 2] = ''
 DO fwind
 DO WHILE ppgo<1
    IF ppgo<1
       ppinp[ 1] = PADR(UPPER(fword(ppinp(1),0,'')), 20)
    ENDIF
    IF ppgo<1
       ppinp[ 2] = PADR(UPPER(fword(ppinp(2),1,'*')), 20)
    ENDIF
    DO fenter WITH 1
 ENDDO
 DO fdeac
 DO fenter WITH 2
 ppwin[ 1] = 'Змўна паролю'
 ppwin[ 2] = '[┘]Ввўд'
 ppwin[ 3] = 'Новий пароль'
 ppwin[ 4] = 'Ще раз'
 ppwin[ 5] = 'Пароль не однаковий'
 ppinp[ 1] = ''
 ppinp[ 2] = ''
 DO fwind
 DO WHILE ppgo<1
    IF ppgo<1
       ppinp[ 1] = PADR(UPPER(fword(ppinp(1),0,'*')), 20)
    ENDIF
    IF ppgo<1
       ppinp[ 2] = PADR(UPPER(fword(ppinp(2),1,'*')), 20)
    ENDIF
    DO fenter WITH 3
 ENDDO
 DO fdeac
*
FUNCTION fword
 PARAMETER par1, par2, par3
 IF PARAMETERS()<1
    par1 = ''
 ENDIF
 IF PARAMETERS()<2
    par2 = 0
 ENDIF
 IF PARAMETERS()<3
    par3 = ''
 ENDIF
 PUSH KEY CLEAR
 PUBLIC ppp1, ppp2, ppp3, ppp4
 ppp1 = .T.
 ppp2 = LEN(ALLTRIM(par1))
 ppp4 = ppp2+1
 DO WHILE ppp1
    @ par2, 017 SAY PADR(IIF(LEN(par3)>0, REPLICATE(par3, ppp2), par1), 20) COLOR W+/BG 
    @ par2, 16+ppp4 SAY ''
    ppp3 = INKEY(0, 'S')
    DO CASE
       CASE ppp3=-9
          ppnew = .F.
          ppgo = 3
          ppp1 = .F.
       CASE ppp3=27
          ppnew = .F.
          ppgo = 3
          ppp1 = .F.
       CASE ppp3=9
          ppp1 = .F.
       CASE ppp3=15
          ppp1 = .F.
       CASE ppp3=5
          ppp1 = .F.
       CASE ppp3=24
          ppp1 = .F.
       CASE ppp3=19
          ppp4 = ppp4-1
          IF ppp4<1
             ppp4 = 1
          ENDIF
       CASE ppp3=1
          ppp4 = 1
       CASE ppp3=6
          ppp4 = ppp2+1
       CASE ppp3=4
          ppp4 = ppp4+1
          IF ppp4>ppp2+1
             ppp4 = ppp2+1
          ENDIF
       CASE ppp3=127
          IF ppp4>1 .AND. ppp2>0
             par1 = SUBSTR(par1, 1, ppp4-2)+SUBSTR(par1, ppp4)
             ppp2 = ppp2-1
             ppp4 = ppp4-1
          ENDIF
       CASE ppp3=7
          IF ppp2>0
             par1 = SUBSTR(par1, 1, ppp4-1)+SUBSTR(par1, ppp4+1)
             ppp2 = ppp2-1
          ENDIF
       CASE ppp3=13
          ppgo = 1
          ppp1 = .F.
       CASE ppp3=10
          ppgo = 2
          ppp1 = .F.
       OTHERWISE
          IF ppp3>=0 .AND. ppp3<=255
             par1 = SUBSTR(par1, 1, ppp4-1)+CHR(ppp3)+SUBSTR(par1, ppp4)
             ppp4 = ppp4+1
             ppp2 = ppp2+1
          ENDIF
    ENDCASE
    IF ppp2=20
       ppp1 = .F.
    ENDIF
 ENDDO
 RELEASE ppp1, ppp2, ppp3, ppp4
 POP KEY
 RETURN par1
*
PROCEDURE fenter
 PARAMETER par1
 IF ppgo<3
    DO CASE
       CASE par1=1
          PRIVATE p1
          p1 = PADR(SPACE(5)+PADR(ppinp(1), 20)+PADR(ppinp(2), 20), 65)
          p1 = fchange(1,3,p1)
          p1 = fchange(0,3,p1,6,45)
          SELECT e000
          LOCATE FOR LIKE(p1, in)
          IF  .NOT. EOF()
             DO fload
             ppreturn = ppin(1)
          ELSE
             DO fset
             ppgo = 0
             WAIT WINDOW NOWAIT ppwin(5)
          ENDIF
       CASE par1=2
          IF ppgo=2 .AND. ppin(2)='2'
             ppgo = 0
          ENDIF
          IF ppin(2)='3' .OR. ppin(2)='4'
             ppgo = 0
          ENDIF
       CASE par1=3
          IF ppinp(1)==ppinp(2) .AND. ppgo=1
             ppin[ 4] = ppinp(2)
             IF ppin(2)='3'
                ppin[ 2] = '2'
             ENDIF
             DO fsave
          ELSE
             WAIT WINDOW NOWAIT ppwin(5)
             ppgo = 0
          ENDIF
    ENDCASE
 ENDIF
*
FUNCTION fchange
 PARAMETER partype, parlen, parword, parl1, parl2
 PUBLIC dimension, pardad[ parlen]
 PRIVATE p1, p2, p3, p4, p5, p6
 p1 = LEN(parword)
 IF partype<1
    DO fchange0
 ENDIF
 IF partype<>0
    DO fchange2
 ELSE
    DO fchange3
 ENDIF
 IF partype>-1
    DO fchange1
 ENDIF
 RELEASE pardad
 RETURN parword
*
PROCEDURE fchange0
 STORE '' TO pardad
 p2 = INT(p1/parlen)
 p3 = MOD(p1, parlen)
 p5 = 1
 FOR p4 = 1 TO parlen
    p6 = p2
    IF p3>0
       p3 = p3-1
       p6 = p6+1
    ENDIF
    pardad[ p4] = SUBSTR(parword, p5, p6)
    p5 = p5+p6
 ENDFOR
 p2 = LEN(pardad(1))
 parword = ''
 FOR p3 = 1 TO p2
    FOR p4 = 1 TO parlen
       parword = parword+SUBSTR(pardad(p4), p3, 1)
    ENDFOR
 ENDFOR
*
PROCEDURE fchange1
 STORE '' TO pardad
 FOR p2 = 1 TO parlen
    p3 = p2
    DO WHILE p3<=p1
       pardad[ p2] = pardad(p2)+SUBSTR(parword, p3, 1)
       p3 = p3+parlen
    ENDDO
 ENDFOR
 parword = ''
 FOR p2 = 1 TO parlen
    parword = parword+pardad(p2)
 ENDFOR
*
PROCEDURE fchange2
 p3 = parword
 parword = ''
 FOR p4 = 1 TO p1
    p2 = ASC(SUBSTR(p3, p4, 1))
    p2 = p2+partype*(p4+33)
    DO WHILE p2<0
       p2 = p2+255
    ENDDO
    DO WHILE p2>255
       p2 = p2-255
    ENDDO
    parword = parword+CHR(p2)
 ENDFOR
*
PROCEDURE fchange3
 p4 = parword
 parword = ''
 FOR p2 = 1 TO p1
    p3 = SUBSTR(p4, p2, 1)
    IF p2<parl1 .OR. p2>parl2
       p3 = '?'
    ENDIF
    parword = parword+p3
 ENDFOR
*
*** 
*** ReFox - all is not lost 
***
