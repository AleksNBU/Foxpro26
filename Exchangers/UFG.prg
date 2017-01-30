*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET TALK OFF
 SET DATE german
 SET DELETED ON
 SET EXACT ON
 SET COLOR TO W+/B
 SET COLOR OF SCHEME 17 TO W+/BG, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 18 TO W+/BG, GR+/B, GR+/W, GR+/W, N+/W, GR+/R, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 20 TO N/BG, N/BG, N/BG, N/BG, W+/BG, W+/B, W+/BG, N/BG, N/BG
 PUBLIC r_adres, r_nam, r_dat, text1, cen, vix, sim_in, sim_out, krit, _ind, r_n_r
 STORE 'абвгдеёжзийклмнопрстуфхцчшщьыэюяў∙ї' TO sim_in
 STORE 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЭЮЯЎ°Ї' TO sim_out
 krit = ' '
 vix = .F.
 ex = 0
 DEFINE WINDOW glob FROM 0, 0 TO 15, 79 FLOAT NONE COLOR SCHEME 8
 ACTIVATE WINDOW glob
 DEFINE WINDOW proc FROM 16, 00 TO 25, 79 NONE
 DEFINE WINDOW proc1 FROM 17, 00 TO 25, 79 NONE COLOR SCHEME 7
 SELECT 0
 USE IN 1 p_ath3+'ufg\UFG.DBF' ALIAS ufg
 INDEX ON num_ufg TO p_ath6+'UFG_NUM.IDX' COMPACT
 INDEX ON num_reestr TO p_ath6+'UFG_REES.IDX' COMPACT
 SELECT 0
 USE IN 2 p_ath3+'UFG\UFG_NUM.DBF' ALIAS nums
 INDEX ON num_ufg TO p_ath6+'NUM_UFG.IDX' COMPACT
 SELECT 0
 USE IN 3 p_ath3+'UFG\UFG_OPER.DBF' ALIAS operac
 INDEX ON num_oper TO p_ath6+'NUM_OPER.IDX' COMPACT
 SELECT 0
 USE IN 4 p_ath3+'ufg\UFG_DEL.DBF' ALIAS ufg_del
 INDEX ON num_ufg TO p_ath6+'UFG_D.IDX' COMPACT
 SELECT 1
 GOTO TOP
 @ 00, 00 SAY REPLICATE('-', 78)
 @ 01, 18 SAY 'ОБЛЎК ПУНКТЎВ УКРА°НСЬКО° ФЎНАНСОВО° ГРУПИ'
 @ 02, 00 SAY REPLICATE('-', 78)
 DEFINE POPUP debb FROM 3, 1 TO 15, 59 PROMPT FIELDS ' '+PADR(LTRIM(nazva), 22)+'▌'+PADR(LTRIM(adres), 22)+'▌'+PADR(num_reestr, 8) TITLE '     Назва           ▌       Адреса         ▌Реїст.№' MARK '' FOOTER ' <-,,,-> - перемiщення, Enter - Редагування ' SCROLL
 pop = 1
 @ 03, 01 GET pop POPUP debb VALID cor_z() WHEN oper() COLOR SCHEME 8
 @ 03, 62 GET tek DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Новий пункт' VALID new_z() COLOR SCHEME 17
 @ 05, 62 GET tek DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Редагування' VALID cor_z() COLOR SCHEME 17
 @ 07, 62 GET tek DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Видалити пункт' VALID del_z() COLOR SCHEME 17
 @ 09, 62 GET tek DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Пошук по номеру' VALID poisk_f() COLOR SCHEME 17
 @ 11, 62 GET spr DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Вилученў пункти' VALID ufg_del() COLOR SCHEME 17
 @ 13, 62 GET spr DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Перелўк операцўй' VALID sprav() COLOR SCHEME 17
 @ 15, 62 GET tek DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Вихўд  ' VALID val_vih() COLOR SCHEME 17
 READ CYCLE
 DEACTIVATE WINDOW proc1
 RELEASE WINDOW proc1
 DEACTIVATE WINDOW proc
 RELEASE WINDOW proc
 DEACTIVATE WINDOW glob
 RELEASE WINDOW glob
 SELECT 1
 PACK
 SELECT 2
 PACK
 SELECT 3
 PACK
 SELECT 4
 PACK
 CLOSE ALL
 DELETE FILE p_ath6+'UFG_D.IDX'
 DELETE FILE p_ath6+'num_oper.IDX'
 DELETE FILE p_ath6+'num_UFG.IDX'
 DELETE FILE p_ath6+'UFG_num.IDX'
 DELETE FILE p_ath6+'UFG_REES.IDX'
 DELETE FILE p_ath6+'num_o_u.IDX'
 DELETE FILE p_ath6+'tmp.dbf'
 DELETE FILE p_ath6+'TEMP1.DBF'
 DELETE FILE p_ath6+'TEMP2.DBF'
 RETURN
*
PROCEDURE oper
 ACTIVATE WINDOW proc
 SELECT 2
 COPY TO p_ath6+'TEMP1.DBF' FIELDS b.num_oper FOR a.num_ufg=b.num_ufg
 SELECT 0
 USE IN 5 p_ath6+'TEMP1.DBF'
 SELECT 3
 JOIN WITH 5 TO p_ath6+'TEMP2.DBF' FOR e.num_oper=c.num_oper FIELDS c.name_oper
 SELECT 5
 USE
 USE IN 5 p_ath6+'TEMP2.DBF'
 x = 1
 y = 1
 SELECT 1
 CLEAR
 @ 0, 25 SAY 'Дата реїстр.: '+DTOC(dat_reestr)
 SELECT 5
 ACTIVATE WINDOW proc1
 CLEAR
 DO WHILE  .NOT. EOF()
    @ x, y SAY e.name_oper SIZE 1, 78
    x = x+1
    SKIP
 ENDDO
 USE
 SELECT 1
 RETURN
*
PROCEDURE num
 SELECT 1
 IF RECCOUNT()>0
    GOTO BOTTOM
    _inda = a.num_ufg
 ELSE
    _inda = 0
 ENDIF
 SELECT 2
 IF RECCOUNT()>0
    GOTO BOTTOM
    _indb = b.num_ufg
 ELSE
    _indb = 0
 ENDIF
 IF _inda>=_indb
    _ind = _inda+1
 ELSE
    _ind = _indb+1
 ENDIF
 SELECT 1
 RETURN
*
PROCEDURE new_z
 DO num
 CREATE DBF p_ath6+'TMP' (num_ufg N (3), num_oper N (3), name_oper C (130))
 USE
 SELECT 0
 USE p_ath6+'TMP' ALIAS tmp
 INDEX ON num_ufg TO p_ath6+'NUM_O_U.IDX' COMPACT
 r_n_r = SPACE(8)
 r_nam = SPACE(40)
 r_adres = SPACE(50)
 r_dat = DATE()
 text1 = 'НОВИЙ ПУНКТ УФГ'
 DO rab_z
 GOTO BOTTOM
 SHOW GETS
 _CUROBJ = 1
 RETURN
*
PROCEDURE rab_z
 DEFINE WINDOW okno1 FROM 3, 01 TO 22, 78 TITLE text1 FOOTER ' ESC - Вихўд ' DOUBLE
 ACTIVATE WINDOW okno1
 DEFINE POPUP vid_zayav1 FROM 09, 00 TO 15, 75 PROMPT FIELDS LEFT(tmp.name_oper, 73) MARK '' MARGIN FOOTER '  , - перемiщення  ' SCROLL
 ex = 0
 la = 0
 popa1 = 1
 DO WHILE .T.
    rr = 1
    @ 01, 01 SAY 'Дата реїстрацў∙ : '
    @ 01, 19 GET r_dat SIZE 1, 10 VALID r_dat<=DATE() ERROR 'Дата реїстрацў∙ повинна бути менше або дорўвнювати поточнўй!'
    @ 01, 33 SAY 'Реїстрацўйний номер : '
    @ 01, 55 GET r_n_r SIZE 1, 8 PICTURE '###.####'
    @ 03, 01 SAY 'Назва пункту  : '
    @ 03, 17 GET r_nam SIZE 1, 40 VALID r_nam<>' ' ERROR ' Не заповнено поле Назва. Повторўть операцўю ! '
    @ 05, 01 SAY 'Адреса пункту : '
    @ 05, 17 GET r_adres SIZE 1, 50 VALID r_adres<>' ' ERROR ' Не заповнено поле Адреса. Повторўть операцўю ! '
    cen = 1
    @ 06, 25 TO 08, 48
    @ 07, 27 SAY '<<Перелўк операцўй>>'
    @ 07, 27 GET cen SIZE 1, 20 PICTURE '@*I' VALID per_oper() COLOR SCHEME 7,9
    @ 09, 00 GET popa1 POPUP vid_zayav1 WHEN xxx() COLOR SCHEME 4
    @ 17, 15 GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN Додати ПУНКТ' VALID val_vih()
    @ 17, 50 GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN Вихўд' VALID ex_vih()
    READ CYCLE MODAL
    la = LASTKEY()
    IF ex=1 .OR. la=27
       RELEASE WINDOW okno1
       SET FILTER TO
       SELECT tmp
       USE
       DELETE FILE p_ath6+'tmp.dbf'
       SELECT 1
       RETURN
    ENDIF
    IF rr=1
       EXIT
    ENDIF
 ENDDO
 IF text1=='НОВИЙ ПУНКТ УФГ'
    SELECT 1
    APPEND BLANK
    DO zapis
 ELSE
    SELECT 1
    m.num_ufg = _ind
    m.nazva = r_nam
    m.adres = r_adres
    m.dat_reestr = r_dat
    m.num_reestr = r_n_r
    GATHER MEMVAR
    SELECT 2
    DELETE FOR num_ufg=_ind
    APPEND FROM p_ath6+'TMP'
 ENDIF
 RELEASE WINDOW okno1
 SET FILTER TO
 SELECT tmp
 USE
 DELETE FILE p_ath6+'tmp.dbf'
 SELECT 1
 RETURN
*
PROCEDURE zapis
 REPLACE num_ufg WITH _ind
 REPLACE nazva WITH r_nam
 REPLACE adres WITH r_adres
 REPLACE dat_reestr WITH r_dat
 REPLACE num_reestr WITH r_n_r
 SELECT 2
 APPEND FROM p_ath6+'TMP'
 RETURN
*
PROCEDURE val_vih
 CLEAR READ
 RETURN
*
PROCEDURE ex_vih
 CLEAR READ
 ex = 1
 RETURN
*
PROCEDURE cor_z
 SCATTER MEMVAR
 _ind = m.num_ufg
 r_nam = m.nazva
 r_adres = m.adres
 r_dat = m.dat_reestr
 r_n_r = m.num_reestr
 SELECT 2
 GOTO TOP
 COPY TO p_ath6+'TMP1' FIELDS b.num_ufg, b.num_oper FOR m.num_ufg=b.num_ufg
 SELECT 0
 USE p_ath6+'TMP1' ALIAS tmp1
 SELECT tmp1
 JOIN WITH 3 TO p_ath6+'TMP' FOR num_oper=c.num_oper FIELDS num_ufg, c.num_oper, c.name_oper
 USE
 DELETE FILE p_ath6+'TMP1.DBF'
 SELECT 0
 USE p_ath6+'TMP' ALIAS tmp
 text1 = ' РЕДАГУВАННЯ ПУНКТУ УФГ '
 DO rab_z
 SELECT 1
 _CUROBJ = 1
 RETURN
*
PROCEDURE del_z
 SCATTER MEMVAR
 DEFINE WINDOW okno7 FROM 1, 18 TO 6, 60 SHADOW TITLE ' ПУНКТ ' COLOR SCHEME 5
 ACTIVATE WINDOW okno7
 @ 0, 0 SAY 'Назва: '+m.nazva
 @ 1, 0 SAY 'Адреса: '+m.adres
 @ 2, 0 SAY 'Дата реїстрацў∙: '+DTOC(m.dat_reestr)
 @ 3, 0 SAY 'Реїстрацўйний номер: '+m.num_reestr
 IF confirm('ВИ ВПЕВНЕНЎ?')
    SELECT 4
    APPEND BLANK
    REPLACE num_ufg WITH m.num_ufg
    REPLACE nazva WITH m.nazva
    REPLACE adres WITH m.adres
    REPLACE dat_reestr WITH m.dat_reestr
    REPLACE num_reestr WITH m.num_reestr
    SELECT 1
    DELETE
 ENDIF
 DEACTIVATE WINDOW okno7
 SHOW GET pop
 _CUROBJ = _CUROBJ
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
 READ CYCLE MODAL
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
PROCEDURE poisk_f
 DEFINE WINDOW poshuk FROM 08, 15 TO 11, 60 FLOAT TITLE ' ПОШУК ' COLOR SCHEME 1
 ACTIVATE WINDOW poshuk
 r_n_r = SPACE(8)
 @ 0, 3 SAY 'Введўть реїстрацўйний номер пункту:'
 @ 1, 13 GET r_n_r SIZE 1, 8 PICTURE '###.####' VALID  .NOT. EMPTY(r_n_r) ERROR ' Текст для пошука не введено! Виправить ! '
 READ
 RELEASE WINDOW poshuk
 SET FILTER TO r_n_r$num_reestr=.T.
 COUNT TO sct
 IF sct=0
    WAIT WINDOW TIMEOUT 1 'Пункта з реїстрацўйним номером '+ALLTRIM(r_n_r)+' немаї ! '
    SET FILTER TO
 ENDIF
 _CUROBJ = _CUROBJ
 SHOW GET pop
 RETURN
*
PROCEDURE sprav
 DEFINE WINDOW okno5 FROM 3, 04 TO 22, 75 TITLE ' Довўдник ' FOOTER ' <-,->,TAB - перемiщення; ESC - Вихўд' DOUBLE
 ACTIVATE WINDOW okno5
 @ 01, 27 SAY 'ПЕРЕЛЎК ОПЕРАЦЎЙ'
 @ 02, 00 SAY REPLICATE('-', 69)
 SELECT 3
 DEFINE POPUP vid_tc FROM 3, 1 TO 14, 68 PROMPT FIELDS LTRIM(c.name_oper) TITLE '   Найменування   ' MARK '' MARGIN FOOTER '  , - перемiщення  ' SCROLL
 popa = 1
 @ 03, 01 GET popa POPUP vid_tc VALID kereg() COLOR SCHEME 4
 @ 16, 03 GET tak DEFAULT 1 SIZE 1, 12, 1 PICTURE '@*HN Додати' VALID dodat() COLOR SCHEME 18
 @ 16, 17 GET tak DEFAULT 1 SIZE 1, 12, 1 PICTURE '@*HN Керегувати' VALID kereg() COLOR SCHEME 18
 @ 16, 31 GET tak DEFAULT 1 SIZE 1, 12, 1 PICTURE '@*HN Видалити' VALID udal() COLOR SCHEME 18
 @ 16, 55 GET tak DEFAULT 1 SIZE 1, 12, 1 PICTURE '@*HN Вихўд' VALID exit() COLOR SCHEME 18
 READ CYCLE MODAL
 DEACTIVATE WINDOW okno5
 RELEASE WINDOW okno5
 PACK
 SELECT ufg
 SHOW GET pop
 _CUROBJ = _CUROBJ
 RETURN
*
FUNCTION dodat
 DEFINE WINDOW okno6 FROM 8, 14 TO 17, 62 SHADOW TITLE ' ВВЕДЎТЬ ' COLOR SCHEME 5
 ACTIVATE WINDOW okno6
 GOTO BOTTOM
 r_num = num_oper
 r_num = r_num+1
 SCATTER BLANK MEMVAR
 @ 1, 2 SAY 'Нова операцўя:'
 @ 2, 2 GET m.name_oper SIZE 3, 43
 @ 6, 08 GET yes_no DEFAULT 0 SIZE 1, 10, 10 FUNCTION '*HT ЗБЕРЕГТИ;\?НЎ'
 SET CURSOR ON
 READ CYCLE MODAL
 IF (yes_no=1) .AND.  .NOT. EMPTY(m.name_oper)
    m.num_oper = r_num
    APPEND BLANK
    GATHER MEMVAR
 ENDIF
 DEACTIVATE WINDOW okno6
 RELEASE WINDOW okno6
 SHOW GET popa
 _CUROBJ = _CUROBJ
 INDEX ON num_oper TO p_ath6+'NUM_OPER.IDX' COMPACT
 RETURN .T.
*
FUNCTION kereg
 DEFINE WINDOW okno6 FROM 8, 14 TO 17, 62 SHADOW TITLE ' РЕДАГУВАННЯ ' COLOR SCHEME 5
 ACTIVATE WINDOW okno6
 SCATTER MEMVAR
 @ 1, 2 SAY 'Зменўть назву операцў∙:'
 @ 2, 2 GET m.name_oper SIZE 3, 43
 @ 6, 08 GET yes_no DEFAULT 0 SIZE 1, 10, 10 FUNCTION '*HT ЗБЕРЕГТИ;\?НЎ'
 SET CURSOR ON
 READ CYCLE MODAL
 IF (yes_no=1) .AND.  .NOT. EMPTY(m.name_oper)
    GATHER MEMVAR
 ENDIF
 DEACTIVATE WINDOW okno6
 SHOW GET popa
 _CUROBJ = _CUROBJ
 INDEX ON num_oper TO p_ath6+'NUM_ind.IDX' COMPACT
 RETURN .T.
*
PROCEDURE udal
 SCATTER MEMVAR
 DEFINE WINDOW okno7 FROM 3, 10 TO 6, 70 SHADOW TITLE ' ОПЕРАЦЎЯ ' COLOR SCHEME 5
 ACTIVATE WINDOW okno7
 @ 0, 0 SAY m.name_oper SIZE 2, 65
 IF confirm('ВИ ВПЕВНЕНЎ?')
    DELETE FOR name_oper=m.name_oper
    SELECT 2
    DELETE FOR b.num_oper=m.num_oper
    PACK
    SELECT 3
 ENDIF
 DEACTIVATE WINDOW okno7
 SHOW GET popa
 _CUROBJ = _CUROBJ
 RETURN
*
FUNCTION confirm
 PARAMETER question
 PRIVATE width, button
 DEFINE WINDOW confirm FROM 0, 0 TO 1, 1 SHADOW DOUBLE COLOR SCHEME 7
 width = MAX(30, LEN(question))
 DO open_win WITH 'confirm', 8, 35-INT(width/2), 14, (43+INT(width/2))+1
 @ 0, 7 SAY 'Ўнформацўя буде знищена!!!'
 @ 2, INT(WCOLS()/2)-INT(LEN(question)/2) SAY question
 @ 4, INT(WCOLS()/2)-15 GET button DEFAULT 0 SIZE 1, 6, 20 FUNCTION '*HT \?НЎ;ТАК'
 READ CYCLE MODAL
 DEACTIVATE WINDOW confirm
 RELEASE WINDOW confirm
 IF button=2
    RETURN .T.
 ELSE
    RETURN .F.
 ENDIF
*
PROCEDURE open_win
 PARAMETER win_name, y1, x1, y2, x2
 PRIVATE y11, x11, y22, x22
 STORE INT((y1+y2)/2) TO y11, y22
 STORE INT((x1+x2)/2) TO x11, x22
 MOVE WINDOW (win_name) TO y11, x11
 ZOOM WINDOW (win_name) NORM FROM (y11-1), (x11-1) TO (y22+1), (x22+1)
 ACTIVATE WINDOW IN screen (win_name)
 DO WHILE (y11>y1) .OR. (y22<y2) .OR. (x11>x1) .OR. (x22<x2)
    y11 = MAX(y1, (y11-1))
    y22 = MIN(y2, (y22+1))
    x11 = MAX(x1, (x11-1))
    x22 = MIN(x2, (x22+1))
    ZOOM WINDOW (win_name) NORM FROM y11, x11 TO y22, x22
 ENDDO
 RETURN
*
PROCEDURE exit
 CLEAR READ
 SHOW GET pop
 _CUROBJ = 1*_CUROBJ
 RETURN
*
PROCEDURE per_oper
 DEFINE WINDOW oper FROM 2, 1 TO 23, 78 SHADOW TITLE ' Формування списку операцўй пунктўв УФГ ' COLOR N/W 
 ACTIVATE WINDOW oper
 DEFINE POPUP oper_spr FROM 0, 0 TO 07, 75 PROMPT FIELDS operac.name_oper TITLE ' Довўдник ' MARK '' MARGIN FOOTER '  , - перемiщення  ' SCROLL
 SELECT tmp
 DEFINE POPUP oper_new FROM 14, 0 TO 21, 75 PROMPT FIELDS tmp.name_oper TITLE ' Операцў∙ нового пункту ' MARK '' MARGIN FOOTER '  , - перемiщення  ' SCROLL
 ex = 0
 la = 0
 popa1 = 1
 @ 0, 0 GET popa1 POPUP oper_spr VALID perenos() COLOR SCHEME 4
 @ 09, 06 SAY ' Додати '
 @ 09, 06 GET tak DEFAULT 1 SIZE 1, 10, 1 PICTURE '@*I' VALID perenos()
 @ 09, 23 SAY ' Видалити'
 @ 09, 23 GET tak DEFAULT 1 SIZE 1, 10, 1 PICTURE '@*I' VALID obr_per()
 @ 09, 39 GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN Зберегти' VALID zber()
 @ 09, 55 GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN Вихўд' VALID ex_vih()
 @ 11, 0 GET popa1 POPUP oper_new VALID obr_per() COLOR SCHEME 4
 READ CYCLE MODAL
 la = LASTKEY()
 IF ex=1 .OR. la=27
    RELEASE WINDOW oper
    SET FILTER TO
    SHOW GET popa1
 ENDIF
 DEACTIVATE WINDOW oper
 _CUROBJ = 6
 SELECT 1
 RETURN
*
FUNCTION perenos
 LOCATE FOR operac.num_oper=tmp.num_oper
 IF FOUND()=.F.
    DEFINE WINDOW okno7 FROM 7, 15 TO 16, 63 SHADOW TITLE ' Повна назва операцў∙, що додаїться ' COLOR SCHEME 5
    ACTIVATE WINDOW okno7
    SCATTER MEMVAR
    @ 1, 2 GET operac.name_oper SIZE 3, 43 DISABLE
    @ 6, 8 GET yes_no DEFAULT 0 SIZE 1, 10, 10 FUNCTION '*HT ЗБЕРЕГТИ;\?НЎ'
    SET CURSOR ON
    READ CYCLE MODAL
    IF yes_no=2
       RETURN
    ENDIF
    SELECT tmp
    APPEND BLANK
    REPLACE tmp.num_ufg WITH _ind
    REPLACE tmp.num_oper WITH operac.num_oper
    REPLACE tmp.name_oper WITH operac.name_oper
    DEACTIVATE WINDOW okno7
    RELEASE WINDOW okno7
    _CUROBJ = 1
    SHOW GETS
 ELSE
    WAIT WINDOW TIMEOUT 3 'Така операцўя вже ўснуї !'
    _CUROBJ = 1
    SHOW GETS
 ENDIF
 RETURN .T.
*
PROCEDURE obr_per
 SELECT tmp
 vix = .F.
 sh = 4
 DO variant WITH 'Видалити помўч.запис', vix, 5
 IF vix
    DELETE
    PACK
 ENDIF
 _CUROBJ = 6
 SHOW GETS
 RETURN
*
PROCEDURE zber
 DEACTIVATE WINDOW mat_tc
 RELEASE WINDOW mat_tc
 CLEAR READ
 SHOW GET popa1
 _CUROBJ = 13
 SELECT 1
 RETURN
*
PROCEDURE xxx
 SHOW GET popa1
 RETURN
*
PROCEDURE ufg_del
 SELECT 4
 DEFINE POPUP debb_d FROM 3, 1 TO 15, 59 PROMPT FIELDS ' '+PADR(LTRIM(nazva), 22)+'▌'+PADR(LTRIM(adres), 22)+'▌'+PADR(num_reestr, 8) TITLE '     Назва           ▌       Адреса         ▌Реїст.№' MARK '' FOOTER ' <-,,,-> - перемiщення, ESC - Вихўд ' SCROLL
 DEFINE WINDOW glob1 FROM 0, 0 TO 15, 79 FLOAT NONE COLOR SCHEME 8
 ACTIVATE WINDOW glob1
 @ 00, 00 SAY REPLICATE('-', 78)
 @ 01, 18 SAY 'ВИЛУЧЕНЎ ПУНКТИ УКРА°НСЬКО° ФЎНАНСОВО° ГРУПИ'
 @ 02, 00 SAY REPLICATE('-', 78)
 pop_d = 1
 @ 03, 01 GET pop_d POPUP debb_d WHEN oper_d() COLOR SCHEME 8
 @ 07, 62 GET tek DEFAULT 1 SIZE 1, 18, 1 PICTURE '@*HN Остаточне вид-ня' VALID del_z_d() COLOR SCHEME 17
 READ CYCLE
 DEACTIVATE WINDOW glob1
 RELEASE WINDOW glob1
 RETURN
*
PROCEDURE oper_d
 ACTIVATE WINDOW proc
 SELECT 2
 COPY TO p_ath6+'TEMP1.DBF' FIELDS b.num_oper FOR d.num_ufg=b.num_ufg
 SELECT 0
 USE IN 5 p_ath6+'TEMP1.DBF'
 SELECT 3
 JOIN WITH 5 TO p_ath6+'TEMP2.DBF' FOR e.num_oper=c.num_oper FIELDS c.name_oper
 SELECT 5
 USE
 USE IN 5 p_ath6+'TEMP2.DBF'
 x = 1
 y = 1
 CLEAR
 SELECT 4
 @ 0, 25 SAY 'Дата реїстр.: '+DTOC(dat_reestr)
 SELECT 5
 DO WHILE  .NOT. EOF()
    @ x, y SAY e.name_oper SIZE 1, 78
    x = x+1
    SKIP
 ENDDO
 USE
 SELECT 4
 RETURN
*
PROCEDURE del_z_d
 SCATTER MEMVAR
 DEFINE WINDOW okno7 FROM 2, 18 TO 6, 60 SHADOW TITLE ' ПУНКТ ' COLOR SCHEME 5
 ACTIVATE WINDOW okno7
 @ 0, 0 SAY 'Назва: '+m.nazva
 @ 1, 0 SAY 'Адреса: '+m.adres
 @ 2, 0 SAY 'Дата реїстрацў∙: '+DTOC(m.dat_reestr)
 IF confirm('ВИ ВПЕВНЕНЎ?')
    DELETE
    PACK
    SELECT 2
    DELETE FOR num_ufg=m.num_ufg
    PACK
    SELECT 4
 ENDIF
 DEACTIVATE WINDOW okno7
 SHOW GET pop_d
 _CUROBJ = _CUROBJ
 RETURN
*
*** 
*** ReFox - all is not lost 
***
