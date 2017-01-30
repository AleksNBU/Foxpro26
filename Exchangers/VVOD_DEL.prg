*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET CENTURY ON
 SET SAFETY OFF
 SET DELETED ON
 SET TALK OFF
 SET COLOR OF SCHEME 17 TO W+/B, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET DATE german
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 NOCLOSE NOMINIMIZE NONE COLOR SCHEME 17
 DEFINE WINDOW beg FROM 5, 19 TO 10, 60 NOCLOSE TITLE ' Данў по видаленню ОП ' NOMINIMIZE COLOR SCHEME 10
 DEFINE WINDOW otkaz FROM 1, 18 TO 6, 55 NOFLOAT SHADOW DOUBLE COLOR SCHEME 7
 CLOSE ALL
 ON ERROR do e_rr WITH ERROR()
 p_ath_3 = p_ath3+'p1_DEL'
 SELECT 0
 use &p_ath_3 alias P SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 INDEX ON nn_del+DTOC(dat_del) TO dbfs\p_ind COMPACT
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS s
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 PUBLIC naz_b, vix, nn, v_n0_r, v_n1_r, v_ident, v_n2_r, v_reestr
 text = ' ЗАКЎНЧИТИ РОБОТУ ??'
 vix = .F.
 naz_b = ''
 SELECT p
 ACTIVATE WINDOW glob
 ACTIVATE WINDOW beg
 DO WHILE .T.
    v_n0_r = '060'
    v_n1_r = '37'
    v_n2_r = '001'
    v_reestr = DATE()
    @ 1, 2 SAY 'Реїстр.NN видалення'
    @ 2, 2 GET v_n0_r PICTURE '999'
    @ 2, 5 GET v_n1_r PICTURE '99'
    @ 2, 7 SAY '-'
    @ 2, 8 GET v_n2_r PICTURE '999'
    @ 1, 23 SAY 'Дата видалення '
    @ 2, 23 GET v_reestr SIZE 1, 10
    READ
    DO f_rab
    IF nn=0
       WAIT WINDOW TIMEOUT 2 ' Такў данў по видаленню ОП в Базў вўдсутнў ! '
    ELSE
       fal1 = 'txt\'+nn_del+'.del'
       GOTO TOP
       REPORT FORMAT VVOD_DEL.FRX TO FILE (fal1) NOCONSOLE
       WAIT WINDOW TIMEOUT 3 ' Данў по видаленню ОП в файлў '+fal1
    ENDIF
    DO variant WITH text, vix, 5
    IF vix
       EXIT
    ELSE
       CLEAR
       SELECT r
       USE
       ERASE dbfs\rab.dbf
       SELECT p
    ENDIF
 ENDDO
 DEACTIVATE WINDOW beg
 DEACTIVATE WINDOW glob
 CLOSE ALL
 RELEASE naz_b, vix, nn, v_n0_r, v_n1_r, v_n2_r, v_reestr
 RELEASE WINDOW glob
 RELEASE WINDOW beg
 RELEASE WINDOW otkaz
 ERASE dbfs\p_ind.idx
 ERASE dbfs\s_ind.idx
 ERASE dbfs\rab.dbf
 RETURN
*
PROCEDURE f_rab
 COPY TO dbfs\rab ALL FOR nn_del=v_n0_r+v_n1_r+v_n2_r .AND. dat_del=v_reestr
 SELECT 0
 USE SHARED dbfs\rab.dbf ALIAS r
 RECALL ALL
 INDEX ON ident TO dbfs\r_ind COMPACT
 COUNT TO nn
 GOTO TOP
 v_mfo = STR(mfo, 6)+bb_g
 SELECT s
 SEEK v_mfo
 IF FOUND()
    naz_b = knb
 ENDIF
 SELECT r
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
