*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 SET TALK OFF
 SET DATE german
 SET DELETED ON
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 NOCLOSE NOMINIMIZE NONE COLOR SCHEME 1
 DEFINE WINDOW beg FROM 5, 19 TO 10, 60 NOCLOSE TITLE ' Данў по реїстрацў∙ ОП ' NOMINIMIZE COLOR SCHEME 10
 DEFINE WINDOW op FROM 0, 2 TO 24, 75 NOCLOSE TITLE ' ВВод даних про обмўннў пункти ' NOMINIMIZE DOUBLE COLOR SCHEME 10
 DEFINE WINDOW op0 FROM 0, 2 TO 14, 75 NOCLOSE TITLE ' ВВод даних про обмўннў пункти ' NOMINIMIZE DOUBLE COLOR SCHEME 10
 CLOSE ALL
 ON ERROR do e_rr WITH ERROR()
 p_ath_3 = p_ath3+'p1'
 SELECT 0
 use &p_ath_3 alias P EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 INDEX ON ident TO dbfs\p_ind COMPACT
 INDEX ON DTOC(dat_reestr, 1)+SUBSTR(nn_reestr, 6, 3) TO dbfs\p_in COMPACT
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS s
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 p_ath_3 = p_ath3+'S_OHR'
 SELECT 0
 use &p_ath_3 alias X SHARED
 INDEX ON kod TO dbfs\x_ind COMPACT
 p_ath_3 = p_ath3+'R'
 SELECT 0
 use &p_ath_3 alias RE SHARED
 INDEX ON kod TO dbfs\r_ind COMPACT
 vih = ' Выход '
 prizn = 0
 SCATTER BLANK MEMVAR
 PUBLIC kz
 PUBLIC sh, vix, nn, v_ident, v_mfo, v_t_ug, v_agen, v_ind_po, v_exit
 PUBLIC v_bb_g, v_bb_zb, v_bb_zb_v
 PUBLIC v_adr_a, v_edrpou, v_adr, v_tel, v_n1_r, v_n2_r, n2, v_n3_r, v_reestr
 PUBLIC v_fio_k, v_fio_nr, v_fio_dat
 PUBLIC v_beg, v_end, v_rest1, v_rest2, v_rest1_2, v_rest2_2, v_rest1_3, v_rest2_3, v_fest_d, v_fest, v_fest_y
 PUBLIC v_syste, v_kas, v_mfo_z, v_zb, v_mfo_v, v_oh1, v_oh2, v_oh3
 PUBLIC naz_b, vix1
 STORE 0 TO m.r1, m.r2, m.r3
 PUBLIC m_r1[ 1], m_r2[ 1], m_r3[ 1]
 SELECT s
 COUNT TO m.r1
 DIMENSION m_r1[ m.r1]
 i = 0
 GOTO TOP
 SCAN
    i = i+1
    m_r1[ i] = STR(mfo, 6)+' '+bb_g+' '+knb
 ENDSCAN
 USE
 SELECT x
 COUNT TO m.r2
 DIMENSION m_r2[ m.r2]
 i = 0
 GOTO TOP
 SCAN
    i = i+1
    m_r2[ i] = nam+' '+kod
 ENDSCAN
 USE
 SELECT re
 COUNT TO m.r3
 DIMENSION m_r3[ m.r3]
 i = 0
 GOTO TOP
 SCAN
    i = i+1
    m_r3[ i] = reg+' '+kod
 ENDSCAN
 USE
 SELECT p
 GOTO BOTTOM
 IF YEAR(DATE())<>YEAR(dat_reestr)
    kz = '000'
 ELSE
    kz = SUBSTR(ident, 1, 3)
 ENDIF
 kz = STRTRAN(STR(VAL(kz)+1, 3), ' ', '0')
 SET INDEX TO dbfs\p_ind
 GOTO TOP
 DO init
 ACTIVATE WINDOW glob
 DO WHILE .T.
    ACTIVATE WINDOW beg
    v_n1_r = '36'
    v_reestr = DATE()
    @ 1, 2 SAY 'Реїстрацўйний номер'
    @ 2, 2 SAY '060'
    @ 2, 5 GET v_n1_r DEFAULT '36' PICTURE '99'
    @ 2, 7 SAY '-'
    @ 2, 8 GET v_n2_r PICTURE '999'
    @ 1, 23 SAY 'Дата реїстрацў∙'
    @ 2, 23 GET v_reestr DEFAULT DATE() SIZE 1, 10
    READ
    DEACTIVATE WINDOW beg
    DO f_rab
    IF nn=0
       DO v_scr0
    ELSE
       WAIT WINDOW NOWAIT 'Помилка при Введеннў даних ! Звернўться до Розробника ПЗ ! '
       = INKEY(2)
       WAIT CLEAR
       QUIT
    ENDIF
    v_n3_r = nn+1
    n3 = IIF(SUBSTR(STR(v_n3_r, 2), 1, 1)=' ', '0'+STR(v_n3_r, 1), STR(v_n3_r, 2))
    v_ident = v_n2_r+n3+SUBSTR(DTOC(v_reestr), 9, 2)
    DO v_scr2
    text1 = '   ВВЕСТИ ЗАПИС  ?? '
    text3 = ' ЗАКЎНЧИТИ РОБОТУ ??'
    v_bd = 'R'
    vix = .F.
    sh = 4
    DO variant WITH text1, vix, 5
    IF vix
       prizn = 1
       SELECT p
       APPEND BLANK
       DO z_scr_g
       IF YEAR(DATE())<>YEAR(dat_reestr)
          kz = '000'
       ELSE
          kz = SUBSTR(ident, 1, 3)
       ENDIF
       kz = STRTRAN(STR(VAL(kz)+1, 3), ' ', '0')
       DO init
       SELECT r
       USE
       ERASE dbfs\rab.dbf
       SELECT p
    ELSE
       DO init
       SELECT r
       USE
       ERASE dbfs\rab.dbf
       SELECT p
    ENDIF
    DO variant WITH text3, vix, 1
    IF vix
       DEACTIVATE WINDOW op
       DEACTIVATE WINDOW glob
       EXIT
    ELSE
       CLEAR
       DEACTIVATE WINDOW op
    ENDIF
 ENDDO
 RELEASE kz
 RELEASE sh, vix, nn, v_ident, v_mfo, v_t_ug, v_agen, v_ind_po, v_exit
 RELEASE v_bb_g, v_bb_zb, v_bb_zb_v
 RELEASE v_adr_a, v_edrpou, v_adr, v_tel, v_n1_r, v_n2_r, v_n3_r, v_reestr
 RELEASE v_fio_k, v_fio_nr, v_fio_dat
 RELEASE v_beg, v_end, v_rest1, v_rest2, v_rest1_2, v_rest2_2, v_rest1_3, v_rest2_3, v_fest_d, v_fest, v_fest_y
 RELEASE v_syste, v_kas, v_mfo_z, v_zb, v_mfo_v, v_oh1, v_oh2, v_oh3
 RELEASE WINDOW op
 RELEASE WINDOW beg
 CLOSE ALL
 IF prizn=1
    DO arh_bd WITH v_bd
 ENDIF
 ERASE DBFS\S_IND.IDX
 ERASE DBFS\P_IND.IDX
 ERASE DBFS\X_IND.IDX
 ERASE DBFS\R_IND.IDX
 ERASE DBFS\RAB.DBF
 RETURN
*
PROCEDURE f_rab
 v_ident = v_n2_r+SUBSTR(DTOC(v_reestr), 9, 2)
 COPY TO dbfs\rab ALL FOR SUBSTR(ident, 1, 5)=v_n2_r .AND. SUBSTR(ident, 6, 2)=SUBSTR(DTOC(v_reestr), 9, 2)
 SELECT 0
 USE EXCLUSIVE dbfs\rab.dbf ALIAS r
 INDEX ON ident TO dbfs\r_ind COMPACT
 COUNT TO nn
 RETURN
*
PROCEDURE init
 v_ident = ''
 v_n1_r = '36'
 v_n2_r = kz
 v_mfo = m_r1(1)
 v_bb_g = m_r1(1)
 v_t_ug = 1
 v_agen = SPACE(60)
 v_fio_k = SPACE(60)
 v_fio_nr = '   '
 v_fio_dat = DATE()
 v_ind_po = m_r3(1)
 v_tel = m_r3(m.r3)
 v_edrpou = SPACE(12)
 v_adr_a = SPACE(60)
 v_adr = SPACE(60)
 v_beg = '0900'
 v_end = '1800'
 v_rest1 = '1300'
 v_rest2 = '1400'
 v_rest1_2 = '0000'
 v_rest2_2 = '0000'
 v_rest1_3 = '0000'
 v_rest2_3 = '0000'
 v_fest_d = '1111100'
 v_fest = 'F'
 v_fest_y = .F.
 v_syste = 1
 v_kas = 0
 v_mfo_z = m_r1(m.r1)
 v_bb_zb = m_r1(m.r1)
 v_mfo_v = m_r1(m.r1)
 v_bb_zb_v = m_r1(m.r1)
 v_zb = 1
 v_oh1 = m_r2(1)
 v_oh2 = m_r2(1)
 v_oh3 = m_r2(1)
 RETURN
*
PROCEDURE v_scr0
 ACTIVATE WINDOW op
 CLEAR
 @ 0, 60 SAY '1-й Екран'
 @ 0, 1 SAY 'Назва агента (до 60 символўв)'
 @ 1, 1 GET v_agen SIZE 1, 60
 @ 2, 1 SAY 'Код ЇДРПОУ (до 12 символўв)'
 @ 3, 1 GET v_edrpou PICTURE '999999999999'
 @ 4, 1 SAY 'Юридична адреса агента (до 60 символўв)'
 @ 5, 1 GET v_adr_a SIZE 1, 60
 @ 1, 43 SAY 'Характеристика ОП'
 @ 1, 61 GET v_t_ug DEFAULT 1 RANGE 0,2 PICTURE '9'
 @ 2, 43 SAY '1-Власний ОП банку'
 @ 3, 43 SAY '2-ОП на агент.угодў з банком'
 @ 4, 43 SAY '0-ОП з функц.приписно∙ каси'
 @ 5, 43 SAY 'Держ.'
 @ 6, 43 SAY 'Подат'
 @ 7, 43 SAY 'Ўнсп.'
 @ 5, 49 GET v_ind_po SIZE 3, 22 FROM m_r3 PICTURE '@^' COLOR SCHEME 10,2
 @ 6, 1 SAY 'Адреса Обмўнного пункта (до 60 символўв)'
 @ 7, 1 GET v_adr SIZE 1, 40
 @ 8, 1 SAY 'Прўзвища касирўв(до 30 символ)'
 @ 9, 1 GET v_fio_k SIZE 1, 30
 @ 8, 32 SAY 'N реїстр.'
 @ 9, 34 GET v_fio_nr PICTURE '999'
 @ 10, 25 SAY 'Дата реїстрацў∙'
 @ 11, 27 GET v_fio_dat DEFAULT DATE() SIZE 1, 10
 @ 09, 43 SAY 'Район'
 @ 10, 43 SAY 'обмўн'
 @ 11, 43 SAY 'Пункт'
 @ 09, 49 GET v_tel SIZE 3, 22 FROM m_r3 PICTURE '@^' COLOR SCHEME 10,2
 @ 12, 1 SAY 'МФО Банку'
 @ 11, 11 GET v_mfo SIZE 3, 8 FROM m_r1 PICTURE '@^' COLOR SCHEME 10,2
 @ 12, 21 SAY 'Початок роботи'
 @ 12, 37 GET v_beg DEFAULT '0900' PICTURE '9999'
 @ 12, 44 SAY 'Кўнець роботи'
 @ 12, 61 GET v_end DEFAULT '1800' PICTURE '9999'
 @ 13, 21 SAY 'Початок 1-о∙ перерви'
 @ 13, 42 GET v_rest1 DEFAULT '1300' PICTURE '9999'
 @ 13, 47 SAY 'Кўнець 1-о∙ перерви'
 @ 13, 67 GET v_rest2 DEFAULT '1400' PICTURE '9999'
 @ 14, 21 SAY 'Початок 2-о∙ перерви'
 @ 14, 42 GET v_rest1_2 DEFAULT '1300' PICTURE '9999'
 @ 14, 47 SAY 'Кўнець 2-о∙ перерви'
 @ 14, 67 GET v_rest2_2 DEFAULT '1400' PICTURE '9999'
 @ 15, 21 SAY 'Початок 3-о∙ перерви'
 @ 15, 42 GET v_rest1_3 DEFAULT '1300' PICTURE '9999'
 @ 15, 47 SAY 'Кўнець 3-о∙ перерви'
 @ 15, 67 GET v_rest2_3 DEFAULT '1400' PICTURE '9999'
 @ 16, 44 SAY 'Без перерви - 0000 0000'
 @ 16, 1 SAY 'Робочў  днў'
 @ 16, 13 GET v_fest_d DEFAULT '1111100' PICTURE '9999999'
 @ 17, 1 SAY 'з понедўлку'
 @ 17, 13 SAY 'ХХХХХХХ'
 @ 17, 22 SAY 'Х=1 - робочий  день'
 @ 17, 42 SAY 'Х=0 - вихўдний день'
 @ 19, 1 SAY 'Праця у святковў днў '
 @ 19, 22 GET v_fest PICTURE '@M F,T'
 @ 19, 26 SAY '.T.- працюї'
 @ 19, 39 SAY '.F.- не працюї'
 @ 20, 22 SAY 'кл.Пробўл-вибўр, кл.Enter-ввод  '
 @ 22, 5 SAY ' ДЛЯ ПЕРЕСУВАННЯ ПО ГРАФАХ КОРИСТУЙТЕСЯ КЛ." TAB"'
 @ 21, 57 GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN   Вихўд' VALID val_vih()
 READ CYCLE
 RETURN
*
PROCEDURE v_scr2
 CLEAR
 @ 0, 60 SAY '2-й Екран'
 @ 1, 1 SAY 'Код Обмўнного пункту'
 @ 0, 22, 2, 30 BOX
 @ 1, 23 SAY v_ident
 @ 03, 1 SAY 'Програмно-апаратне обладнання Обмўнного пункту' SIZE 1, 46, 0
 @ 03, 49 GET v_syste DEFAULT 1 RANGE 0,45 PICTURE '99'
 @ 04, 1 SAY "0- ЕККА; вўд 1 до 45 - NN Комп'ют.системи"
 @ 05, 1 SAY 'Вигляд охорони примўщення'
 @ 05, 27 GET v_zb DEFAULT 1 RANGE 1,2 PICTURE '9'
 @ 05, 30 SAY '1 - наявнўсть охоронно∙ сигналўзацў∙'
 @ 06, 30 SAY '2 - ў наявнўсть фўзично∙ охорони'
 @ 08, 01 SAY 'МФО Банку, де зберўгаються цўнностў:'
 @ 07, 38 SAY ' У '
 @ 08, 38 SAY 'роб.'
 @ 09, 38 SAY 'днў '
 @ 07, 42 GET v_mfo_z SIZE 3, 8 FROM m_r1 PICTURE '@^' COLOR SCHEME 10,2
 @ 07, 52 SAY ' У '
 @ 08, 52 SAY 'вих.'
 @ 09, 52 SAY 'днў '
 @ 07, 56 GET v_mfo_v SIZE 3, 8 FROM m_r1 PICTURE '@^' COLOR SCHEME 10,2
 @ 10, 44 SAY 'Код пўдроздўлу, що охороняї'
 @ 11, 44 SAY 'ОП у робочий час'
 @ 10, 1 GET v_oh1 SIZE 3, 42 FROM m_r2 PICTURE '@^' COLOR SCHEME 10,2
 @ 14, 44 SAY 'Код пўдроздўлу, що маї'
 @ 15, 44 SAY 'кнопку тривоги для ОП'
 @ 14, 1 GET v_oh2 SIZE 3, 42 FROM m_r2 PICTURE '@^' COLOR SCHEME 10,2
 @ 18, 44 SAY 'Код пўдроздўлу, що перево-'
 @ 19, 44 SAY 'зить валютнў цўнностў ОП'
 @ 18, 1 GET v_oh3 SIZE 3, 42 FROM m_r2 PICTURE '@^' COLOR SCHEME 10,2
 @ 21, 5 SAY ' ДЛЯ ПЕРЕСУВАННЯ ПО ГРАФАХ КОРИСТУЙТЕСЯ КЛ." TAB"'
 @ 21, 60 GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN   Вихўд' VALID val_vih()
 READ CYCLE
 RETURN
*
PROCEDURE val_vih
 CLEAR READ
*
PROCEDURE z_scr_g
 REPLACE ident WITH v_ident
 REPLACE mfo WITH VAL(SUBSTR(v_mfo, 1, 6))
 REPLACE bb_g WITH SUBSTR(v_mfo, 8, 4)
 REPLACE typ_ugod WITH v_t_ug
 REPLACE nazva_agen WITH v_agen
 REPLACE edrpou WITH v_edrpou
 REPLACE adres_ag WITH v_adr_a
 REPLACE fio_k WITH v_fio_k
 REPLACE fio_nr WITH v_fio_nr
 REPLACE fio_dat WITH v_fio_dat
 REPLACE ind_po WITH SUBSTR(v_ind_po, 22, 2)
 REPLACE adres_po WITH v_adr
 REPLACE tel_po WITH SUBSTR(v_tel, 22, 2)
 REPLACE dat_reestr WITH v_reestr
 REPLACE beg_end WITH v_beg+v_end
 REPLACE rest_time WITH v_rest1+v_rest2
 REPLACE rest_time2 WITH v_rest1_2+v_rest2_2
 REPLACE rest_time3 WITH v_rest1_3+v_rest2_3
 REPLACE festival_d WITH v_fest_d
 IF v_fest='F'
    v_fest_y = .F.
 ELSE
    v_fest_y = .T.
 ENDIF
 REPLACE festival_y WITH v_fest_y
 REPLACE po_system WITH v_syste
 REPLACE kassa WITH v_kas
 REPLACE mfo_zb WITH VAL(SUBSTR(v_mfo_z, 1, 6))
 REPLACE bb_zb WITH SUBSTR(v_mfo_z, 8, 4)
 REPLACE mfo_zb_v WITH VAL(SUBSTR(v_mfo_v, 1, 6))
 REPLACE bb_zb_v WITH SUBSTR(v_mfo_v, 8, 4)
 REPLACE vid_zber WITH v_zb
 REPLACE kod1 WITH SUBSTR(v_oh1, 42, 4)
 REPLACE kod2 WITH SUBSTR(v_oh2, 42, 4)
 REPLACE kod3 WITH SUBSTR(v_oh3, 42, 4)
 REPLACE dat WITH DATE()
 REPLACE time WITH TIME()
 REPLACE a_fio WITH _fio
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
