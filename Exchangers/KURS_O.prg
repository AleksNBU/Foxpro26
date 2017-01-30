*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET TALK OFF
 SET DATE german
 CLOSE ALL
 CLOSE DATABASES
 SET COLOR TO W/B
 SET SAFETY OFF
 SET CENTURY ON
 SET COLOR TO W+/B
 ON ERROR do e_rr WITH ERROR()
 SET COLOR OF SCHEME 17 TO W+/BG, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS s
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 p_ath_3 = p_ath3+'kurs'
 SELECT 0
 use &p_ath_3 alias W EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 SET FILTER TO r_l<>0 .OR. r_h<>0
 COUNT TO nn
 IF nn=0
    WAIT WINDOW TIMEOUT 3 'Даних по вўдхиленням у БД Kurs нема ! '
    RETURN
 ENDIF
 GOTO TOP
 INDEX ON STR(mfo, 6)+bb_g+ident TO dbfs\w_ind COMPACT
 SET RELATION TO STR(mfo, 6)+bb_g INTO s
 DEFINE WINDOW s_tr FROM 0, 0 TO 2, 79 COLOR SCHEME 17
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 FLOAT FOOTER ' Вихўд - Esc ' DOUBLE COLOR SCHEME 8
 ACTIVATE WINDOW glob
 @ 22, 6 SAY 'Для виключення з бази даних запису натиснўть клавишу < F8 >'
 DO c_bd
 RELEASE WINDOW glob
 RELEASE WINDOW s_tr
 SET FILTER TO
 USE
 p_ath_3 = p_ath3+'kurs'
 SELECT 0
 use &p_ath_3 alias W EXCLUSIVE
 PACK
 CLOSE ALL
 ERASE DBFS\W_IND.IDX
 ERASE DBFS\S_IND.IDX
 RELEASE WINDOW s_tr
 RETURN
*
PROCEDURE c_bd
 ON KEY LABEL F8 do DEL_Z
 ACTIVATE WINDOW s_tr
 DEFINE WINDOW w_br FROM 3, 0 TO 22, 79 COLOR SCHEME 17
 BROWSE FIELDS dat :H = 'Дата' :R, ident :H = 'Код ОП' :R, kod_v :H = 'Валюта' :R, t_kurs :H = 'Поточн.Курс' :R, kurs_l :H = 'Купўвля', kurs_h :H = 'Продаж', r_l :H = 'Вўдх.П', r_h :H = 'Вўдх.К' WINDOW w_br TITLE ' Аналўз ў корегування вўдхилень курсўв валют ' WHEN pokaz()
 ON KEY LABEL F8
 RELEASE WINDOW w_br
 DEACTIVATE WINDOW s_tr
 RETURN
*
PROCEDURE pokaz
 @ 0, 1 SAY 'МФО='
 @ 0, 6 SAY STR(mfo, 6) COLOR W+/B 
 @ 0, 13 SAY 'ДОП.Х-КА='
 @ 0, 23 SAY s.bb_g COLOR W+/B 
 @ 0, 28 SAY 'ЕЛ.АДРЕСА='
 @ 0, 38 SAY s.ncks COLOR W+/B 
 @ 0, 43 SAY 'Банк-'
 @ 0, 48 SAY s.knb COLOR W+/B 
 RETURN
*
PROCEDURE del_z
 str = 14
 stl = 15
 vibor = ''
 DEFINE WINDOW y_n FROM str, stl TO str+4, stl+40 NOFLOAT NOCLOSE SHADOW COLOR SCHEME 1
 ACTIVATE WINDOW y_n
 @ 0, 02 SAY 'Bилучити запис з Кодом ОП      ?'
 @ 0, 28 SAY ident COLOR W+/G 
 @ 2, 10 GET vibor DEFAULT 1 SIZE 1, 7, 5 PICTURE '@*HT  ТАК ; НЎ ' VALID konec()
 READ CYCLE
 RELEASE WINDOW y_n
 RETURN
*
PROCEDURE konec
 IF ALLTRIM(vibor)='ТАК'
    DELETE
 ENDIF
 CLEAR READ
 SHOW GETS
 RETURN
*
*** 
*** ReFox - all is not lost 
***
