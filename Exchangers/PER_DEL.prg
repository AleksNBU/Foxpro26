*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 SET DELETED ON
 SET TALK OFF
 SET CENTURY ON
 SET COLOR OF SCHEME 17 TO W+/B, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET DATE german
 er_rr = ' '
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 NOCLOSE NOMINIMIZE NONE COLOR SCHEME 17
 DEFINE WINDOW beg FROM 5, 19 TO 10, 60 NOCLOSE TITLE ' Дати по видаленню ОП ' NOMINIMIZE COLOR SCHEME 10
 CLOSE ALL
 ON ERROR do e_rr WITH ERROR()
 p_ath_3 = p_ath3+'p1_DEL'
 SELECT 0
 use &p_ath_3 alias bd SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 SELECT 0
 USE SHARED dbfs\KB_TVBV ALIAS kb
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 PUBLIC vix, nn, pn, p_reestr, k_reestr
 text = ' ЗАКЎНЧИТИ РОБОТУ ??'
 vix = .F.
 SELECT bd
 ACTIVATE WINDOW glob
 ACTIVATE WINDOW beg
 DO WHILE .T.
    p_reestr = DATE()
    k_reestr = DATE()
    @ 1, 02 SAY 'Поч.дата вилучення'
    @ 2, 03 GET p_reestr SIZE 1, 10
    @ 1, 21 SAY 'Кўн.дата вилучення'
    @ 2, 22 GET k_reestr SIZE 1, 10
    READ
    COPY TO dbfs\rab ALL FOR (p_reestr<=dat_del .AND. dat_del<=k_reestr)
    SELECT 0
    USE SHARED dbfs\rab.dbf ALIAS rab
    INDEX ON DTOS(dat_del) TO dbfs\p_ind COMPACT
    RECALL ALL
    COUNT TO nn
    GOTO TOP
    IF nn=0
       WAIT WINDOW TIMEOUT 2 'Виделенў данў з '+DTOC(p_reestr)+' по '+DTOC(k_reestr)+' в  БД вўдсутнў!'
    ELSE
       a1 = SUBSTR(DTOC(p_reestr), 1, 2)+SUBSTR(DTOC(p_reestr), 4, 2)
       a2 = SUBSTR(DTOC(k_reestr), 1, 2)+SUBSTR(DTOC(k_reestr), 4, 2)
       a3 = SUBSTR(DTOC(k_reestr), 9, 2)
       fal1 = 'txt\'+a1+a2+'.'+a3
       SET RELATION TO STR(mfo, 6)+bb_g INTO kb
       REPORT FORMAT PER_DEL.FRX TO FILE (fal1) NOCONSOLE
       WAIT WINDOW TIMEOUT 3 'Данў по перелўку видалених ОП в файлў '+fal1
    ENDIF
    DO variant WITH text, vix, 5
    IF vix
       EXIT
    ELSE
       SET RELATION TO
       CLEAR
       SELECT rab
       USE
       ERASE dbfs\rab.dbf
       SELECT bd
    ENDIF
 ENDDO
 DEACTIVATE WINDOW beg
 DEACTIVATE WINDOW glob
 CLOSE ALL
 RELEASE vix, nn, pn, p_reestr, k_reestr
 RELEASE WINDOW glob
 RELEASE WINDOW beg
 ERASE dbfs\p_ind.idx
 ERASE dbfs\s_ind.idx
 ERASE dbfs\rab.dbf
 RETURN
*
FUNCTION variant
 PARAMETER text, vix, sh
 str = 17
 stl = 22
 vibor = ''
 IF  .NOT. WEXIST('y_n')
    DEFINE WINDOW y_n FROM str, stl TO str+4, stl+28 NOFLOAT NOCLOSE SHADOW COLOR SCHEME sh
 ENDIF
 IF WVISIBLE('y_n')
    ACTIVATE WINDOW SAME y_n
 ELSE
    ACTIVATE WINDOW NOSHOW y_n
 ENDIF
 @ 0, 4 SAY text
 @ 2, 4 GET vibor DEFAULT 1 SIZE 1, 7, 5 PICTURE '@*HT  ТАК ; НЎ ' VALID konec()
 IF  .NOT. WVISIBLE('y_n')
    ACTIVATE WINDOW y_n
 ENDIF
 READ CYCLE
 RELEASE WINDOW y_n
 RETURN vix
*
FUNCTION konec
 IF ALLTRIM(vibor)='ТАК'
    vix = .T.
 ELSE
    vix = .F.
 ENDIF
 CLEAR READ
 SHOW GETS
 RETURN vix
*
*** 
*** ReFox - all is not lost 
***
