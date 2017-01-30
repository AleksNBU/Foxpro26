*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE poshuk
 PARAMETER rec
 IF  .NOT. WEXIST('poisk')
    DEFINE WINDOW poisk FROM INT((SROWS()-5)/2), INT((SCOLS()-40)/2) TO INT((SROWS()-5)/2)+4, INT((SCOLS()-40)/2)+39 NOFLOAT NOCLOSE SHADOW TITLE ' NN КОДу ' DOUBLE COLOR SCHEME 10
 ENDIF
 IF  .NOT. WEXIST('otkaz')
    DEFINE WINDOW otkaz FROM 1, 18 TO 6, 55 NOFLOAT SHADOW DOUBLE COLOR SCHEME 7
 ENDIF
 STORE '1001' TO krt
 IF WVISIBLE('poisk')
    ACTIVATE WINDOW SAME poisk
 ELSE
    ACTIVATE WINDOW NOSHOW poisk
 ENDIF
 @ 0, 28 TO 2, 34
 @ 1, 3 SAY 'Наберўть NN Коду '
 @ 1, 30 GET krt DEFAULT ' ' SIZE 1, 4 RANGE '1001' PICTURE '9999'
 IF  .NOT. WVISIBLE('poisk')
    ACTIVATE WINDOW poisk
 ENDIF
 READ
 STORE krt TO kluch
 SEEK kluch
 IF FOUND()
    rec = RECNO()
 ELSE
    GOTO TOP
    rec = RECNO()
    IF WVISIBLE('otkaz')
       ACTIVATE WINDOW SAME otkaz
    ELSE
       ACTIVATE WINDOW NOSHOW otkaz
    ENDIF
    @ 0, 1 SAY '  ЎНФОРМАЦЎ° З ТАКИМ NN Коду  '
    @ 1, 1 SAY '     В БАЗЎ ДАНИХ НЕМАЇ !     '
    @ 2, 1 SAY '------------------------------'
    @ 3, 1 SAY ' НАТИСННЎТЬ БУДЬ-ЯКУ KЛАВЎШУ !'
    IF  .NOT. WVISIBLE('otkaz')
       ACTIVATE WINDOW otkaz
    ENDIF
    READ CYCLE
 ENDIF
 RELEASE WINDOW otkaz
 RELEASE WINDOW poisk
 RETURN
*
*** 
*** ReFox - all is not lost 
***
