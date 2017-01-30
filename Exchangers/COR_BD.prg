*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET TALK OFF
 SET DATE german
 CLOSE ALL
 CLOSE DATABASES
 SET COLOR TO W/B
 SET SAFETY OFF
 SET COLOR TO W+/B
 SET COLOR OF SCHEME 17 TO W+/BG, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 18 TO W+/BG, GR+/B, GR+/W, GR+/W, N+/W, GR+/R, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 20 TO N/BG, N/BG, N/BG, N/BG, W+/BG, W+/B, W+/BG, N/BG, N/BG
 PUBLIC sim_in, sim_out, krit
 STORE 'абвгдеёжзийклмнопрстуфхцчшщьыэюяў∙ї' TO sim_in
 STORE 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЭЮЯЎ°Ї' TO sim_out
 krit = ' '
 prizn = 0
 v_bd = 'R'
 ON ERROR do e_rr WITH ERROR()
 p_ath_3 = p_ath3+'r'
 SELECT 0
 use &p_ath_3 alias reg SHARED
 p_ath_3 = p_ath3+'s_ohr'
 SELECT 0
 use &p_ath_3 alias ohr SHARED
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS s
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 p_ath_3 = p_ath3+'p1'
 SELECT 0
 use &p_ath_3 alias We EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 rr = ''
 COUNT TO nn
 IF nn=0
    WAIT WINDOW TIMEOUT 2 'Даних у БАЗЎ нема ! '
    RETURN
 ENDIF
 GOTO TOP
 INDEX ON STR(mfo, 6)+bb_g+DTOC(dat_reestr) TO dbfs\ind COMPACT
 SET RELATION TO STR(mfo, 6)+bb_g INTO s
 DEFINE WINDOW s_tr FROM 0, 0 TO 2, 79 COLOR SCHEME 17
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 FLOAT FOOTER ' Вихўд - CTRL+W ' DOUBLE COLOR SCHEME 8
 ACTIVATE WINDOW glob
 @ 20, 2 SAY 'Для пошуку потрўбного Коду ОП натиснўть клавишу < F7 >'
 @ 21, 2 SAY 'Для пошуку Прўзвища Касира ОП натиснўть клавишу < F8 >'
 @ 22, 2 SAY 'Для виправлення кодўв РАЙОНА чи ОХОРОНИ натиснўть клавишу < F9 >'
 DO c_bd
 RELEASE WINDOW glob
 SET FILTER TO
 CLOSE ALL
 IF prizn=1
    DO arh_bd WITH v_bd
 ENDIF
 ERASE DBFS\IND.IDX
 ERASE DBFS\S_IND.IDX
 RELEASE WINDOW s_tr
 RETURN
*
PROCEDURE c_bd
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 do poisk_f
 ON KEY LABEL F9 do ZAM
 ACTIVATE WINDOW s_tr
 DEFINE WINDOW w_br FROM 3, 0 TO 20, 79 COLOR SCHEME 17
 BROWSE FIELDS ident :H = 'Код ОП' :R, nn_reestr :H = 'Реїстр.N' :R :W = kont1(), dat_reestr :H = 'Дата реїстр' :R :W = kont1(), mfo :H = 'МФО Банк' :V = who(), bb_g :H = 'Баланс' :V = who(), nazva_agen :H = 'Назва агенту' :V = who(), edrpou :H = 'Код ЇДРПОУ' :V = who(), adres_ag :H = 'Адреса агенту' :V = who(), typ_ugod :H = 'Tип угоди' :V = who(), ind_po :H = 'ДПЎ' :W = s_reg('IND_PO'), adres_po :H = 'Адреса OП' :V = who(), fio_k :H = 'Прўзвище касира' :V = who(), fio_nr :H = 'Реїстр.N' :V = who(), fio_dat :H = 'Дата Реїстр.' :V = who(), tel_po :H = 'Район' :W = s_reg('TEL_PO'), beg_end :H = 'Pоботa' :V = who(), rest_time :H = 'Перерва 1' :V = who(), rest_time2 :H = 'Перерва 2' :V = who(), rest_time3 :H = 'Перерва 3' :V = who(), festival_d :H = 'Роб.днў' :V = who(), festival_y :H = 'Cвята' :V = who(), po_system :H = 'ЕKKA' :V = who(), kassa :H = 'Кат.охор' :V = who(), mfo_zb :H = 'МФО.Зб' :V = who(), bb_zb :H = 'Баланс' :V = who(), mfo_zb_v :H = 'МФО в.дня' :V = who(), bb_zb_v :H = 'Баланс' :V = who(), vid_zber :H = 'Вид охор' :V = who(), kod1 :H = 'Код 1 пўдр' :W = s_ment('KOD1'), kod2 :H = 'Код 2 пўдр' :W = s_ment('KOD2'), kod3 :H = 'Код 3 пўдр' :W = s_ment('KOD3'), nn_del :H = 'N видал.' :R :W = kont1(), dat_del :H = 'Дата видал.' :R :W = kont1() WINDOW w_br TITLE ' Корегування Бази Даних ' PARTITION 9 WHEN pokaz()
 ON KEY LABEL F7
 ON KEY LABEL F8
 ON KEY LABEL F9
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
 DEFINE WINDOW poshuk FROM 11, 27 TO 13, 64 FLOAT TITLE 'Введўть Код обмўнного пункту' COLOR SCHEME 1
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
    WAIT WINDOW TIMEOUT 2 ' Кодa обмўнного пункту < '+k_op+' > немаї '
    GOTO TOP
 ENDIF
 RETURN
*
PROCEDURE poisk_f
 DEFINE WINDOW poshuk_f FROM 12, 15 TO 14, 64 FLOAT TITLE ' Введўть текст для пошука Фамўлў∙ клўїнта ' COLOR SCHEME 1
 ACTIVATE WINDOW poshuk_f
 slovo = SPACE(20)
 @ 0, 13 GET slovo VALID  .NOT. EMPTY(slovo) ERROR ' Текст для пошука не введено! Виправити ! '
 READ
 IF LASTKEY()=13
    krit = ALLTRIM(slovo)
 ENDIF
 RELEASE WINDOW poshuk_f
 SET FILTER TO CHRTRAN(krit, sim_in, sim_out)$CHRTRAN(fio_k, sim_in, sim_out)=.T.
 COUNT TO sct
 IF sct=0
    WAIT WINDOW TIMEOUT 1 ' Такого Прўзвища <'+ALLTRIM(slovo)+'> немаї ! '
    SET FILTER TO
    GOTO TOP
 ENDIF
 GOTO TOP
 RETURN
*
PROCEDURE s_reg
 PARAMETER par
 rr = par
 DEFINE WINDOW br_reg FROM 09, 30 TO 21, 58 FLOAT TITLE ' Райони ' COLOR SCHEME 10
 SELECT reg
 GOTO TOP
 BROWSE FIELDS kod :H = 'Номер' :W = .F., reg :H = 'Найменування' :W = .F. WINDOW br_reg
 SELECT we
 RELEASE WINDOW br_reg
 rr = ''
 RETURN
*
PROCEDURE s_ment
 PARAMETER par
 rr = par
 DEFINE WINDOW br_reg FROM 09, 20 TO 21, 68 FLOAT TITLE ' Оxорона ' COLOR SCHEME 10
 SELECT ohr
 GOTO TOP
 BROWSE FIELDS kod :H = 'Код' :W = .F., nam :H = '      Найменування' :W = .F. WINDOW br_reg
 SELECT we
 RELEASE WINDOW br_reg
 rr = ''
 RETURN
*
PROCEDURE zam
 SELECT we
 DO CASE
    CASE rr='IND_PO'
       REPLACE we.ind_po WITH reg.kod
    CASE rr='TEL_PO'
       REPLACE we.tel_po WITH reg.kod
    CASE rr='KOD1'
       REPLACE we.kod1 WITH ohr.kod
    CASE rr='KOD2'
       REPLACE we.kod2 WITH ohr.kod
    CASE rr='KOD3'
       REPLACE we.kod3 WITH ohr.kod
 ENDCASE
 REPLACE we.dat WITH DATE()
 REPLACE we.time WITH TIME()
 REPLACE we.a_fio WITH _fio
 prizn = 1
 RETURN
*
PROCEDURE who
 REPLACE we.dat WITH DATE()
 REPLACE we.time WITH TIME()
 REPLACE we.a_fio WITH _fio
 prizn = 1
 RETURN
*
PROCEDURE kont1
 WAIT WINDOW NOWAIT ' Поле не корегуїться '
 RETURN
*
*** 
*** ReFox - all is not lost 
***
