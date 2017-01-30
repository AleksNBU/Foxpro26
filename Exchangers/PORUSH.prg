*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET DELETED ON
 DEFINE WINDOW w_br FROM 03, 00 TO 20, 79 COLOR SCHEME 08
 DEFINE WINDOW okno1 FROM 21, 00 TO 24, 79 FLOAT FOOTER ' Вихўд - CTRL+W ' COLOR SCHEME 05
 DEFINE WINDOW info FROM 19, 00 TO 24, 79 FLOAT TITLE ' Для виходу натиснўть будь-яку клавўшу ! ' COLOR SCHEME 05
 PUBLIC sim_in, sim_out, krit
 STORE 'абвгдеёжзийклмнопрстуфхцчшщьыэюяў∙ї' TO sim_in
 STORE 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЭЮЯЎ°Ї' TO sim_out
 krit = ' '
 PUBLIC r_ident, r_kas, r_san, r_dat, s
 PUBLIC m_m( 25), sch
 s1 = '!(K01=0.and.K02=0.and.K03=0.and.K04=0.and.K05=0.and.K06=0.and.K07=0 .and.K08=0.and.K09=0.and.K10=0.and.K11=0.and.K12=0.and.K13=0.and.K14=0 .and.K15=0.and.K16=0.and.K17=0.and.K18=0.and.K19=0'
 s2 = '.and.K20=0.and.K21=0.and.K22=0.and.K23=0.and.K24=0.and.K25=0)'
 s = s1+s2
 sch = 25
 m_m = 0
 m_s = 0
 r_ident = SPACE(07)
 r_kas = SPACE(20)
 r_sank = SPACE(30)
 r_dat = DATE()
 v_bd = 'N'
 prizn = 0
 er_rr = ' '
 ON ERROR do e_rr WITH ERROR()
 p_ath_p = p_ath3+'p1'
 SELECT 0
 use &p_ath_p 
 IF er_rr='*'
    QUIT
 ENDIF
 USE
 p_ath_3 = p_ath3+'p1_del'
 SELECT 0
 use &p_ath_3 EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 COPY TO dbfs\RAB0 FIELDS ident, nazva_agen
 USE
 SELECT 0
 USE SHARED dbfs\rab0
 COPY TO dbfs\str STRUCTURE EXTENDED
 USE
 SELECT 0
 USE SHARED dbfs\str
 p_ath_3 = p_ath3+'shab'
 append from &p_ath_3 
 CREATE dbfs\Rab1 FROM dbfs\Str
 APPEND FROM dbfs\rab0
 REPLACE del WITH '*' ALL
 Append from &p_ath_p 
 USE
 SELECT 0
 USE SHARED dbfs\Rab1 ALIAS kb
 INDEX ON ident TO dbfs\rab1_ind COMPACT
 GOTO TOP
 p_ath_s = p_ath3+'s_nar'
 SELECT 0
 use &p_ath_S alias SPD EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 CREATE DBF Dbfs\TMP1 (p C (01), k_nar C (02), sod_nar C (72))
 USE
 SELECT 0
 USE EXCLUSIVE Dbfs\TMP1 ALIAS tmp1
 p_ath_3 = p_ath3+'NAR'
 SELECT 0
 use &p_ath_3 alias PD EXCLUSIVE 
 INDEX ON ident+DTOC(dat_p, 1) TO dbfs\Nard_IND
 DO c_bd
 PACK
 USE
 CLOSE ALL
 IF prizn=1
    DO arh_bd WITH v_bd
 ENDIF
 RELEASE WINDOW okno1
 RELEASE WINDOW w_br
 RELEASE WINDOW info
 ERASE dbfs\tmp1.dbf
 ERASE dbfs\rab1_IND.IDX
 ERASE dbfs\Nard_IND.idx
 ERASE dbfs\str.dbf
 ERASE dbfs\rab0.dbf
 ERASE dbfs\rab1.dbf
 SET ESCAPE ON
 ON KEY LABEL F1
 ON KEY LABEL F5
 ON KEY LABEL F6
 ON KEY LABEL F7
 ON KEY LABEL F8
 ON KEY LABEL F9
 RETURN
*
PROCEDURE c_bd
 ON KEY LABEL F1 DO V_INFO 
 ON KEY LABEL F5 do ADD_K  
 ON KEY LABEL F6 do DEL_K  
 ON KEY LABEL F7 do POISK_OP 
 ON KEY LABEL F8 do POISK_F 
 ON KEY LABEL F9 do POISK_N 
 ON KEY LABEL F2 CLEAR READ
 ON KEY LABEL F3 CLEAR READ
 ON KEY LABEL F4 CLEAR READ
 ON KEY LABEL F9 CLEAR READ
 ACTIVATE WINDOW okno1
 @ 00, 08 SAY 'Вихўд з режиму регўстрацў∙ перевўрки ОП  -> Кл.< ESC > ' COLOR W+/R 
 @ 01, 08 SAY 'Додаткова ўнформацўя роботи в режимў - Kлавиша < F1 > '
 DO WHILE .T.
    ex = 0
    BROWSE FIELDS ident :H = 'Код ОП' :R, dat_p :H = 'Дата перевўр' :R, fio :H = ' Касир' :R, san :H = '        Санкцў∙' :R, por :H = 'Пор' WINDOW w_br TITLE ' База Даних перевўрки пунктов обмўну валюти '
    IF ex=0
       EXIT
    ENDIF
 ENDDO
 DEACTIVATE WINDOW info
 ON KEY LABEL F1
 ON KEY LABEL F5
 ON KEY LABEL F6
 ON KEY LABEL F7
 ON KEY LABEL F2
 ON KEY LABEL F3
 ON KEY LABEL F4
 ON KEY LABEL F8
 ON KEY LABEL F9
 SET FILTER TO
 RETURN
*
PROCEDURE v_info
 ON KEY LABEL F1 CLEAR READ
 ON KEY LABEL F5 CLEAR READ
 ON KEY LABEL F6 CLEAR READ
 ON KEY LABEL F7 CLEAR READ
 ON KEY LABEL F8 CLEAR READ
 ACTIVATE WINDOW info
 @ 00, 02 SAY 'Добавити у Базу Даних ўнформацўю про перевўрку ОП  - Kлавиша < F5 > '
 @ 01, 02 SAY 'Видалити з Бази Даних ўнформацўю про перевўрку ОП -  Kлавиша < F6 >'
 @ 02, 02 SAY 'Пошук Запису у БД по Коду Обмўнного Пункта-ПОРУШНИКА-Клавишу < F7 >'
 @ 03, 02 SAY 'Пошук Прўзвища Касира Обмўнного Пункта-ПОРУШНИКА ! - Kлавиша < F8 >'
 READ
 DEACTIVATE WINDOW info
 ON KEY LABEL F1 DO V_INFO 
 ON KEY LABEL F5 do ADD_K    
 ON KEY LABEL F6 do DEL_K    
 ON KEY LABEL F7 do POISK_OP 
 ON KEY LABEL F8 do POISK_F  
 ON KEY LABEL F9 do POISK_N  
 RETURN
*
PROCEDURE add_k
 PACK
 COUNT TO sp
 DO f_kod
 DO f_t_nar
 GOTO TOP
 vix = .F.
 DO variant WITH 'Додати  запис ?', vix, 5
 IF vix
    prizn = 1
    APPEND BLANK
    REPLACE ident WITH r_ident
    REPLACE fio WITH r_kas
    REPLACE san WITH r_sank
    REPLACE dat_p WITH r_dat
    REPLACE dat WITH DATE()
    REPLACE time WITH TIME()
    REPLACE a_fio WITH _fio
    FOR i = 5 TO sch+4
       r = FIELD(i)
       REPLA &R WITH M_M(i-4)
    ENDFOR
    IF &S 
       REPLACE por WITH '*'
    ENDIF
 ENDIF
 r_kas = SPACE(20)
 r_sank = SPACE(30)
 m_m = 0
 ex = 1
 RETURN
*
PROCEDURE del_k
 vix = .F.
 DO variant WITH 'Видалити запис ?', vix, 5
 IF vix
    WAIT WINDOW NOWAIT ' Ўнформацўя про про перевўрку ОП Видалена з Бази Даних ! '
    = INKEY(1)
    WAIT CLEAR
    DELETE
    prizn = 1
 ENDIF
 ex = 1
 RETURN
*
PROCEDURE poisk_op
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
PROCEDURE poisk_f
 DEFINE WINDOW poshuk_f FROM 12, 15 TO 14, 64 FLOAT TITLE ' Введўть текст для пошука Прўзвища Касира ' COLOR SCHEME 1
 ACTIVATE WINDOW poshuk_f
 slovo = SPACE(20)
 @ 0, 13 GET slovo VALID  .NOT. EMPTY(slovo) ERROR ' Текст для пошука не введено! Виправити ! '
 READ
 IF LASTKEY()=13
    krit = ALLTRIM(slovo)
 ENDIF
 RELEASE WINDOW poshuk_f
 pr_p = 'POR="*".and.'
 pr_fio = 'chrtran(krit,sim_in,sim_out)$chrtran(FIO,sim_in,sim_out)'
 bbb = pr_p+pr_fio+'=.T.'
 set fiLter to &bbb
 COUNT TO sct
 IF sct=0
    WAIT WINDOW TIMEOUT 1 ' Такого Касира <'+ALLTRIM(slovo)+'> серед Порушникўв немаї ! '
    SET FILTER TO
    GOTO TOP
 ENDIF
 RETURN
*
PROCEDURE poisk_n
 DEFINE WINDOW poshuk_f FROM 12, 15 TO 14, 64 FLOAT TITLE ' Введўть текст для пошука ОП-Порушника за назвою ' COLOR SCHEME 1
 ACTIVATE WINDOW poshuk_f
 slovo = SPACE(20)
 @ 0, 13 GET slovo VALID  .NOT. EMPTY(slovo) ERROR ' Текст для пошука не введено! Виправити ! '
 READ
 IF LASTKEY()=13
    krit = ALLTRIM(slovo)
 ENDIF
 RELEASE WINDOW poshuk_f
 pr_p = 'POR="*".and.'
 pr_fio = 'chrtran(krit,sim_in,sim_out)$chrtran(FIO,sim_in,sim_out)'
 bbb = pr_p+pr_fio+'=.T.'
 set fiLter to &bbb
 COUNT TO sct
 IF sct=0
    WAIT WINDOW TIMEOUT 1 ' Такого Касира <'+ALLTRIM(slovo)+'> серед Порушникўв немаї ! '
    SET FILTER TO
    GOTO TOP
 ENDIF
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
PROCEDURE f_kod
 SELECT kb
 DEFINE WINDOW okno2 FROM 03, 00 TO 21, 79 TITLE ' Зареїстрованў та вилученў обмўн.пункти ' COLOR SCHEME 08
 ACTIVATE WINDOW okno2
 DEFINE POPUP debb1 FROM 00, 00 TO 19, 78 PROMPT FIELDS ident+' '+PADR(nazva_agen, 60)+'     '+del TITLE 'КОД ОП  Назва Агенту'+SPACE(43)+'Вид.з рег. ' MARK '' SCROLL COLOR SCHEME 05
 ON SELECTION POPUP debb1 DO VIBOR_POD WITH PROMPT()
 ACTIVATE POPUP debb1
 DEACTIVATE POPUP debb1
 RELEASE WINDOW okno2
 SELECT pd
 RETURN
*
PROCEDURE vibor_pod
 PARAMETER pole
 r_ident = ident
 DEACTIVATE POPUP debb1
 RETURN
*
PROCEDURE f_t_nar
 SELECT tmp1
 ZAP
 APPEND FROM &p_ath_S 
 DEFINE WINDOW okno3 FROM 02, 00 TO 23, 79 TITLE '   Дата                Прўзвище                     Санкцў∙ (до 30 знакўв)                  ' COLOR SCHEME 08
 ACTIVATE WINDOW okno3
 DEFINE POPUP debb3 FROM 00, 00 TO 16, 78 PROMPT FIELDS p+'  '+sod_nar TITLE ' Тип порушення       ' MARK '+' SCROLL COLOR SCHEME 08
 @ 00, 00 SAY 'Дата:'
 @ 00, 05 GET r_dat DEFAULT DATE() SIZE 1, 10
 @ 00, 17 SAY 'Касир:'
 @ 00, 24 GET r_kas SIZE 1, 20
 @ 00, 46 SAY 'Санкцў∙:'
 @ 00, 54 GET r_sank SIZE 1, 23
 READ
 @ 18, 08 SAY ' <-,,,-> - перемiщення, Enter - Вибўр типу порушення ! '
 pop1 = 1
 @ 01, 00 GET pop1 POPUP debb3 VALID form_v() COLOR SCHEME 8
 @ 19, 30 GET vih DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*HN Вихўд ўз режиму' VALID ex_vih()
 READ CYCLE
 RELEASE WINDOW okno3
 GOTO TOP
 i = 0
 SCAN
    i = i+1
    IF p='+'
       m_m( i) = 1
    ENDIF
 ENDSCAN
 SELECT pd
 RETURN
*
PROCEDURE form_v
 tnz = RECNO()
 IF tnz<>0
    REPLACE p WITH '+' FOR RECNO()=tnz
 ENDIF
 RETURN
*
PROCEDURE ex_vih
 CLEAR READ
 ex = 1
 RETURN
*
*** 
*** ReFox - all is not lost 
***
