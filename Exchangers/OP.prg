*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET TALK OFF
 SET DATE german
 CLOSE ALL
 CLOSE DATABASES
 SET EXCLUSIVE ON
 SET SAFETY OFF
 SET CENTURY ON
 SET COLOR TO W/B
 CLEAR
 CLEAR ALL
 PUBLIC _fio, nuser, kz, kz1, n_pri, er_rr, v_bd
 @ 04, 21 SAY '    ▓▓▓▓▓    ▓▓▓▓▓▓▓▓▓    ▓       ▓'
 @ 05, 21 SAY '   ▓▓ ▓▓▓    ▓▓▓   ▓▓▓    ▓▓     ▓▓'
 @ 06, 21 SAY '  ▓▓▓ ▓▓▓    ▓▓▓   ▓▓▓    ▓▓▓   ▓▓▓'
 @ 07, 21 SAY ' ▓▓▓  ▓▓▓    ▓▓▓   ▓▓▓    ▓▓▓▓ ▓▓▓▓'
 @ 08, 21 SAY '▓▓▓   ▓▓▓    ▓▓▓▓▓▓▓▓▓    ▓▓▓▓▓▓▓▓▓'
 @ 09, 21 SAY '▓▓▓▓▓▓▓▓▓    ▓▓▓          ▓▓▓   ▓▓▓'
 @ 10, 21 SAY '▓▓▓   ▓▓▓    ▓▓▓          ▓▓▓   ▓▓▓'
 @ 13, 11 SAY 'О Б Р О Б К И  Д А Н И Х  П О  О Б М Ў Н Н И Х   П У Н К Т А Х'
 @ 15, 40 SAY 'м. Харкўв ХОУ HБУ'
 @ 15, 58 SAY 'тел. 707-77-23'
 @ 21, 5 SAY "Наберўть Ваши ЎМ'Я ў ПАРОЛЬ (Перехўд вўд ЎМЕНЎ до ПАРОЛЯ - 'TAB' чў ''"
 @ 22, 5 SAY 'Прў вўдмовў натиснўть "Esc" '
 nuser = _user(FULLPATH(''))
 IF EMPTY(nuser)
    WAIT WINDOW TIMEOUT 1 'Вибачайте. Пароль  невўрний !'
    CLOSE ALL
    QUIT
 ENDIF
 CLEAR
 _fio = _user(FULLPATH(''),2,nuser)
 PUBLIC p_ath1, p_ath2, p_ath3, p_ath4, p_ath5
 PUBLIC p_ath6, p_ath7, p_ath8, p_ath9, p_ath10
 SELECT 0
 USE Anketa
 p_ath1 = RTRIM(value)
 SKIP
 p_ath2 = RTRIM(value)
 SKIP
 p_ath3 = RTRIM(value)
 SKIP
 p_ath4 = RTRIM(value)
 SKIP
 p_ath5 = RTRIM(value)
 SKIP
 p_ath6 = RTRIM(value)
 SKIP
 p_ath7 = RTRIM(value)
 SKIP
 p_ath8 = RTRIM(value)
 SKIP
 p_ath9 = RTRIM(value)
 SKIP
 p_ath10 = RTRIM(value)
 USE
 er_rr = ' '
 ON ERROR do e_rr WITH ERROR()
 imfile_in = p_ath3+'prov.txt'
 COPY FILE (imfile_in) TO dbfs\prov.txt
 IF er_rr='*'
    QUIT
 ENDIF
 ON ERROR
 SET COLOR TO W+/B
 ON KEY LABEL f10 QUIT
 ERASE DBFS\RAB_IND.IDX
 ERASE DBFS\RAB_E.IDX
 ERASE DBFS\IN_TVBV.IDX
 ERASE DBFS\STR.DBF
 ERASE DBFS\KB_TVBV.DBF
 ERASE DBFS\RAB.DBF
 SELECT 0
 p_ath_2 = p_ath2+'rcukru'
 use &p_ath_2 SHARED
 COPY TO dbfs\rab ALL FOR ko=20 .OR. ku=20
 USE
 SELECT 0
 p_ath_2 = p_ath2+'kodbank'
 use &p_ath_2 
 COPY TO dbfs\str STRUCTURE EXTENDED
 USE
 SELECT 0
 USE SHARED dbfs\str
 p_ath_3 = p_ath3+'SH_B020'
 append from &p_ath_3 
 CREATE dbfs\KB_TVBV FROM dbfs\Str
 Append from &p_ath_2 
 REPLACE bb_g WITH '0001' ALL
 USE
 SELECT 0
 USE SHARED dbfs\rab.dbf ALIAS rab
 INDEX ON STR(mfo, 6) TO dbfs\rab_ind COMPACT
 SELECT 0
 USE SHARED dbfs\KB_TVBV ALIAS kb_t
 INDEX ON STR(mfo, 6) TO dbfs\in_tvb COMPACT
 SET RELATION TO STR(mfo, 6) INTO rab
 REPLACE adress WITH rab.adress ALL
 p_ath_p = p_ath2+'spr_tvbv'
 Append from &p_ath_p for B020<>'0001'
 REPLACE bb_g WITH b020 ALL FOR b020<>' '
 REPLACE prb WITH rab.prb ALL
 USE
 SELECT rab
 USE
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 FLOAT TITLE ' АДМЎНЎСТРАТОР ' COLOR SCHEME 8
 SELECT 0
 p_ath_4 = p_ath4+'E000r'
 use &p_ath_4 alias E000r 
 INDEX ON nom TO dbfs\rab_E
 SEEK nuser
 n_pri = e000r.pri
 COUNT TO kz
 vn = 07
 gn = 10
 gn1 = gn+20
 IF nuser='  99' .OR. n_pri<>1
 ELSE
    ACTIVATE WINDOW glob
    DO admin
 ENDIF
 SELECT e000r
 SET FILTER TO pri=1
 COUNT TO kz1
 IF kz1>1
    WAIT WINDOW TIMEOUT 3 'ПОМИЛКА-<АДМЎНЎСТРАТОР> повинен бути тўлькў один ! '
    WAIT WINDOW TIMEOUT 3 'Звернўться до АДМЎНЎСТРАТОРА Комплексу ! '
    USE
    DEACTIVATE WINDOW glob
    RELEASE WINDOW glob
    RETURN
 ENDIF
 SET FILTER TO
 SET FILTER TO pri=2
 COUNT TO kz1
 IF kz1>1
    WAIT WINDOW TIMEOUT 3 'ПОМИЛКА-ВИКОНАВЕЦ по ВВОДУ,КОРИГУВАННЮ повинен бути тўлькў один !'
    WAIT WINDOW TIMEOUT 3 'Звернўться до АДМЎНЎСТРАТОРА Комплексу ! '
    USE
    DEACTIVATE WINDOW glob
    RELEASE WINDOW glob
    RETURN
 ENDIF
 SET FILTER TO
 SET FILTER TO pri=3
 COUNT TO kz1
 IF kz1>1
    WAIT WINDOW TIMEOUT 3 'ПОМИЛКА-ВИКОНАВЕЦ по ОБРОБЦЎ КУРСЎВ ВАЛЮТ повинен бути тўлькў один !'
    WAIT WINDOW TIMEOUT 3 'Звернўться до АДМЎНЎСТРАТОРА Комплексу ! '
    USE
    DEACTIVATE WINDOW glob
    RELEASE WINDOW glob
    RETURN
 ENDIF
 SET FILTER TO
 USE
 DEACTIVATE WINDOW glob
 RELEASE WINDOW glob
 SET COLOR OF SCHEME 19 TO W+/BG, W+/B, W+/BG, N/BG, N/BG, W+/B,,, N+/BG
 @ 0, 0 TO 2, 79 DOUBLE COLOR SCHEME 19
 @ 1, 1 SAY REPLICATE('▒', 78) COLOR SCHEME 19
 SET COLOR OF SCHEME 20 TO N/BG, N/BG, N/BG, N/BG, W+/BG, W+/B, W+/BG, N/BG, N/BG
 SET COLOR OF SCHEME 24 TO W+/RB, W+/B, W+/RB, W+/RB, W+/RB, W+/B, GR+/RB, N/RB, N/RB
 SET COLOR OF SCHEME 17 TO W+/BG, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 18 TO W+/BG, GR+/B, GR+/W, GR+/W, N+/W, GR+/R, W+/B, N+/N, GR+/W, N+/W
 IF n_pri=1 .OR. n_pri=2 .OR. nuser='  99'
    imparol1 = .F.
 ELSE
    imparol1 = .T.
 ENDIF
 IF n_pri=1 .OR. n_pri=3 .OR. nuser='  99'
    imparol2 = .F.
 ELSE
    imparol2 = .T.
 ENDIF
 DEFINE MENU nachn COLOR SCHEME 20
 DEFINE PAD frm OF nachn PROMPT 'Бази даних' AT 1, 5 SKIP FOR imparol1
 DEFINE PAD nast OF nachn PROMPT 'Довiдники' AT 1, 20 SKIP FOR imparol1
 DEFINE PAD spr OF nachn PROMPT 'Вихўдни форми' AT 1, 34
 DEFINE PAD srv OF nachn PROMPT 'Курси валют' AT 1, 52 SKIP FOR imparol2
 DEFINE PAD quit OF nachn PROMPT 'Виxўд' AT 1, 68
 ON SELECTION MENU nachn do LIN_MENU
 ffffff = 'FRM'
 acti menu nachn pad &FFFFFF
 SET COLOR TO W/B
 CLOSE ALL
 CLEAR ALL
 ERASE DBFS\RAB_IND.IDX
 ERASE DBFS\RAB_E.IDX
 ERASE DBFS\IN_TVBV.IDX
 ERASE DBFS\STR.DBF
 ERASE DBFS\Rab.DBF
 QUIT
*
PROCEDURE admin
 DEFINE POPUP debb1 FROM vn, gn TO kz+vn+1, gn+23 PROMPT FIELDS '   '+PADR(LTRIM(fio), 20) TITLE 'Вибўр-Enter' MARK '' SCROLL
 pop1 = 1
 @ vn, gn GET pop1 POPUP debb1 VALID form_p() COLOR SCHEME 8
 @ vn+kz+02, gn GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN  Вихўд ўз режиму       ' VALID ex_vih() COLOR SCHEME 10
 READ CYCLE
 RETURN
*
PROCEDURE ex_vih
 CLEAR READ
 RETURN
*
PROCEDURE form_p
 DEFINE POPUP _pri FROM vn+RECNO()+1, gn1 TO vn+RECNO()+1+5, gn1+40 TITLE ' РЕЖИМИ РОБОТИ З КОМПЛЕКСОМ ' SHADOW FOOTER 'Вибўр-Enter' COLOR SCHEME 08
 DEFINE BAR 1 OF _pri PROMPT 'Адмўнўстрування                        '
 DEFINE BAR 2 OF _pri PROMPT 'Ввод, корегування баз даних            '
 DEFINE BAR 3 OF _pri PROMPT 'Обробка Курсўв Валют вўд банкўв        '
 DEFINE BAR 4 OF _pri PROMPT 'Тўлькў Формування Вўхўднўх форм        '
 ON SELECTION POPUP _pri do FORM_V 
 ACTIVATE POPUP _pri
 RETURN
*
PROCEDURE form_v
 REPLACE pri WITH BAR()
 REPLACE dat WITH DATE()
 REPLACE time WITH TIME()
 REPLACE a_fio WITH _fio
 WAIT WINDOW TIMEOUT 3 'Задано режим роботи для ВИКОНАВЦЯ - '+ALLTRIM(fio)
 DEACTIVATE POPUP _pri
 RETURN
*
PROCEDURE lin_menu
 mpad = PAD()
 DO CASE
    CASE mpad='FRM'
       DO bd
    CASE mpad='NAST'
       DO dovidn
    CASE mpad='SPR'
       DO form
    CASE mpad='ANK'
       DO kurs_a
    CASE mpad='SRV'
       DO kurs_v
    OTHERWISE
       IF ffffff='QUIT'
          c = INKEY(0, 'h')
          IF c=13 .OR. c=27
             DEACTIVATE MENU nachn
          ELSE
             ffffff = 'FRM'
             KEYBOARD ('a')
          ENDIF
       ELSE
          DEACTIVATE MENU nachn
       ENDIF
 ENDCASE
 prizpr = 0
 RETURN
*
PROCEDURE bd
 DEFINE POPUP vv FROM 3, 0 TO 017, 36 SHADOW COLOR SCHEME 20
 DEFINE BAR 1 OF vv PROMPT ' Ввод даних в БД зареїстрован. ОП '
 DEFINE BAR 2 OF vv PROMPT ' Довўдка про реїстрацўю ОП на ....'
 DEFINE BAR 3 OF vv PROMPT ' Коригування даних в БД зареїс.ОП '
 DEFINE BAR 4 OF vv PROMPT ' Вилучення даних з реїстрацў∙     '
 DEFINE BAR 5 OF vv PROMPT ' Довўдка про видалення ОП на .....'
 DEFINE BAR 6 OF vv PROMPT ' Перегляд БД вилучених з реїстр.ОП'
 DEFINE BAR 7 OF vv PROMPT ' Коригування БД Порушникўв        '
 DEFINE BAR 8 OF vv PROMPT '\---------------------------------'
 DEFINE BAR 9 OF vv PROMPT ' Розархўвацўя файлўв зареїстров.ОП'
 DEFINE BAR 10 OF vv PROMPT ' Розархўвацўя файлўв видалених ОП '
 DEFINE BAR 11 OF vv PROMPT ' Розархўвацўя файлўв ОП-Порушникўв'
 DEFINE BAR 12 OF vv PROMPT '\---------------------------------'
 DEFINE BAR 13 OF vv PROMPT ' УФГ'
 ON SELECTION POPUP vv do work_bd with bar()
 ACTIVATE POPUP vv
 DEACTIVATE POPUP vv
 RETURN
*
PROCEDURE work_bd
 PARAMETER var
 DO CASE
    CASE var=1
       DO vvod
    CASE var=2
       DO vvod_dov
    CASE var=3
       DO cor_bd
    CASE var=4
       DO del_op
    CASE var=5
       DO vvod_del
    CASE var=6
       DO see_del
    CASE var=7
       DO porush
    CASE var=9
       DO r_arh_bd WITH 'R'
    CASE var=10
       DO r_arh_bd WITH 'D'
    CASE var=11
       DO r_arh_bd WITH 'N'
    CASE var=13
       DO ufg
 ENDCASE
 RETURN
*
PROCEDURE form
 DEFINE POPUP f FROM 3, 34 TO 14, 62 SHADOW COLOR SCHEME 20
 DEFINE BAR 1 OF f PROMPT ' Перелўк зареїстр.ОП на....'
 DEFINE BAR 2 OF f PROMPT ' Перелўк ЗАРЕЇСТР.ОП за....'
 DEFINE BAR 3 OF f PROMPT 'Перелўк ОП по ЕДРПОУ за....'
 DEFINE BAR 4 OF f PROMPT ' Перелўк видалених ОП за...'
 DEFINE BAR 5 OF f PROMPT ' Перелўк ОП-порушникўв за..'
 DEFINE BAR 6 OF f PROMPT 'ОП-Порушники по ЕДРПОУ за..'
 DEFINE BAR 7 OF f PROMPT '\--------------------------'
 DEFINE BAR 8 OF f PROMPT ' Аналўз курсўв за перўод   '
 DEFINE BAR 9 OF f PROMPT '\--------------------------'
 DEFINE BAR 10 OF f PROMPT ' УФГ                     '
 ON SELECTION POPUP f do work_F with bar()
 ACTIVATE POPUP f
 DEACTIVATE POPUP f
 RETURN
*
PROCEDURE work_f
 PARAMETER var
 DO CASE
    CASE var=1
       DO per_op
    CASE var=2
       DO per_op_z
    CASE var=3
       DO op_kod_z
    CASE var=4
       DO per_del
    CASE var=5
       DO per_por
    CASE var=6
       DO por_kod
    CASE var=8
       DO kurs_a
    CASE var=10
       DO ufg_menu
 ENDCASE
 RETURN
*
PROCEDURE kurs_v
 DEFINE POPUP k FROM 3, 49 TO 11, 77 SHADOW COLOR SCHEME 20
 DEFINE BAR 1 OF k PROMPT 'Ввод даних по курсам валют'
 DEFINE BAR 2 OF k PROMPT 'Аналўз вўдхилення курсўв  '
 DEFINE BAR 3 OF k PROMPT 'Повнота надання курсўв на.'
 DEFINE BAR 4 OF k PROMPT 'Листи банкам-вўдсутнў данў'
 DEFINE BAR 5 OF k PROMPT '\-------------------------'
 DEFINE BAR 6 OF k PROMPT 'Арх-цўя Ф.курсўв за перўод'
 DEFINE BAR 7 OF k PROMPT 'Вўдновл.Ф.курсўв за перўод'
 ON SELECTION POPUP k do work_K with bar()
 ACTIVATE POPUP k
 DEACTIVATE POPUP k
 RETURN
*
PROCEDURE work_k
 PARAMETER var
 DO CASE
    CASE var=1
       DO kurs_m
    CASE var=2
       DO kurs_o
    CASE var=3
       DO full_op
    CASE var=4
       DO let_op
    CASE var=6
       DO arh_m
    CASE var=7
       DO r_arh_kv
 ENDCASE
 RETURN
*
PROCEDURE ufg_menu
 DEFINE POPUP u FROM 16, 40 TO 20, 72 SHADOW COLOR SCHEME 20
 DEFINE BAR 1 OF u PROMPT ' Перелўк зар-них УФГ на дату'
 DEFINE BAR 2 OF u PROMPT ' Перелўк зар-них УФГ за перўод'
 DEFINE BAR 3 OF u PROMPT ' Перелўк видалених УФГ на дату'
 ON SELECTION POPUP u do PRN_1 with bar()
 ACTIVATE POPUP u
 DEACTIVATE POPUP u
 RETURN
*
PROCEDURE work_u
 PARAMETER var
 DO CASE
    CASE var=1
       DO per_op
    CASE var=2
       DO per_op_z
    CASE var=3
       DO op_kod_z
 ENDCASE
 RETURN
*
*** 
*** ReFox - all is not lost 
***
