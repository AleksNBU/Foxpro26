*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET TALK OFF
 SET DATE german
 SET DELETED ON
 CLOSE ALL
 CLOSE DATABASES
 ON ERROR do e_rr WITH ERROR()
 SET COLOR TO W/B
 SET SAFETY OFF
 SET COLOR TO W+/B
 DEFINE WINDOW beg FROM 10, 19 TO 15, 60 NOCLOSE TITLE ' Данў по вўдаленню ОП ' NOMINIMIZE COLOR SCHEME 1
 PUBLIC v_n0_r, v_n1_r, v_n2_r, v_reestr, kz
 v_n0_r = '060'
 v_n1_r = '37'
 v_reestr = DATE()
 er_rr = ' '
 prizn = 0
 SET COLOR OF SCHEME 17 TO W+/BG, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 18 TO W+/BG, GR+/B, GR+/W, GR+/W, N+/W, GR+/R, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 20 TO N/BG, N/BG, N/BG, N/BG, W+/BG, W+/B, W+/BG, N/BG, N/BG
 p_ath_3 = p_ath3+'P1_DEL'
 SELECT 0
 use &p_ath_3 alias DEL_F EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 COUNT TO nn
 IF nn=0
    kz = '001'
 ELSE
    INDEX ON DTOC(dat_del, 1)+SUBSTR(nn_del, 6, 3) TO dbfs\f_ind COMPACT
    GOTO BOTTOM
    IF YEAR(DATE())<>YEAR(dat_del)
       kz = '000'
    ELSE
       kz = SUBSTR(nn_del, 6, 3)
    ENDIF
    kz = STRTRAN(STR(VAL(kz)+1, 3), ' ', '0')
 ENDIF
 GOTO TOP
 SELECT 0
 USE SHARED DBFS\\KB_TVBV ALIAS s
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 SELECT 0
 p_ath_3 = p_ath3+'p1'
 use &p_ath_3 alias W EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 INDEX ON STR(mfo, 6)+bb_g+DTOC(dat_reestr) TO dbfs\w_ind COMPACT
 SET RELATION TO STR(mfo, 6)+bb_g INTO s
 DEFINE WINDOW s_tr FROM 0, 0 TO 2, 79 COLOR SCHEME 17
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 FLOAT FOOTER ' Вихўд - CTRL+W ' DOUBLE COLOR SCHEME 8
 ACTIVATE WINDOW glob
 @ 21, 2 SAY 'Для пошуку потрўбного Коду ОП натиснить клавишу < F7 >'
 @ 22, 2 SAY 'Для виключення з реїстрацў∙ запису натиснить клавишу < F8 >'
 DO c_bd
 RELEASE WINDOW glob
 RELEASE WINDOW s_tr
 IF prizn=1
    SELECT w
    SET DELETED OFF
    COPY TO DbfS\RB1 FOR DELETED()
    USE
    SELECT 0
    p_ath_3 = p_ath3+'p1'
    use &p_ath_3 alias W EXCLUSIVE 
    PACK
    SELECT 0
    USE DbfS\RB1
    RECALL ALL
    USE
    SELECT del_f
    APPEND FROM DBFS\RB1
 ENDIF
 CLOSE ALL
 SET DELETED ON
 IF prizn=1
    DO arh_d
 ENDIF
 ERASE DBFS\RB1.DDF
 ERASE DBFS\W_IND.IDX
 ERASE DBFS\F_IND.IDX
 ERASE DBFS\S_IND.IDX
 RELEASE WINDOW s_tr
 RELEASE WINDOW beg
 RETURN
*
PROCEDURE c_bd
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 do DEL_Z
 ACTIVATE WINDOW s_tr
 DEFINE WINDOW w_br FROM 3, 0 TO 21, 79 COLOR SCHEME 17
 BROWSE FIELDS ident :H = 'Код ОП' :R, nn_reestr :H = 'Реїстр.N' :R, dat_reestr :H = 'Дата реїстр' :R, mfo :H = 'МФО Банк' :R, bb_g :H = 'Баланс', nazva_agen :H = 'Назва агенту' :R, adres_ag :H = 'Адреса агенту' :R, adres_po :H = 'Адреса OП' :R WINDOW w_br TITLE ' Виключення з реїстрацў∙ ОП ' PARTITION 9 WHEN pokaz()
 ON KEY LABEL F7
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
PROCEDURE poisk
 DEFINE WINDOW poshuk FROM 10, 27 TO 12, 64 FLOAT TITLE 'Введўть Код обмўнного пункту' COLOR SCHEME 1
 ACTIVATE WINDOW poshuk
 k_op = '       '
 @ 0, 13 GET k_op PICTURE '9999999' COLOR ,W+/G 
 READ
 RELEASE WINDOW poshuk
 IF LASTKEY()=27
    RETURN
 ENDIF
 LOCATE FOR ALLTRIM(ident)=k_op
 IF  .NOT. FOUND()
    WAIT WINDOW TIMEOUT 2 ' Кода обмўнного пункту < '+k_op+' > немаї '
    GOTO TOP
 ENDIF
 RETURN
*
PROCEDURE del_z
 str = 14
 stl = 15
 vibor = ''
 v_n2_r = kz
 ACTIVATE WINDOW beg
 @ 1, 2 SAY 'Реїст.NN видаленння'
 @ 2, 2 SAY v_n0_r
 @ 2, 5 SAY v_n1_r
 @ 2, 7 SAY '-'
 @ 2, 8 GET v_n2_r PICTURE '999'
 @ 1, 23 SAY 'Дата видаленння'
 @ 2, 23 GET v_reestr SIZE 1, 10
 READ
 DEACTIVATE WINDOW beg
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
    kz = STRTRAN(STR(VAL(kz)+1, 3), ' ', '0')
    REPLACE nn_del WITH v_n0_r+v_n1_r+v_n2_r, dat_del WITH v_reestr
    REPLACE dat WITH DATE()
    REPLACE time WITH TIME()
    REPLACE a_fio WITH _fio
    DELETE
    prizn = 1
 ENDIF
 CLEAR READ
 SHOW GETS
 RETURN
*
PROCEDURE arh_d
 nam1 = 'D'+SUBSTR(DTOC(DATE()), 1, 2)+SUBSTR(DTOC(DATE()), 4, 2)+SUBSTR(DTOC(DATE()), 10, 1)+SUBSTR(TIME(), 1, 1)+'.'+SUBSTR(TIME(), 2, 1)+SUBSTR(TIME(), 4, 2)
 name1 = p_ath10+nam1
 name2 = p_ath3+'p1.DBF'
 name3 = p_ath3+'p1_del.DBF'
 ! FOXSWAP ARJ97 A &NAME1 &NAME2 &NAME3 > dbfs\prot_ad.txt
 RETURN
*
*** 
*** ReFox - all is not lost 
***
