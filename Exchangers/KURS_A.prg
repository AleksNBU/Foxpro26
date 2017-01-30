*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 SET MESSAGE TO 23 CENTER
 SET TALK OFF
 SET CENTURY ON
 SET DATE german
 SET PRINTER ON
 SET CONSOLE ON
 CLOSE ALL
 er_rr = ' '
 ON ERROR do e_rr WITH ERROR()
 DEFINE WINDOW beg FROM 12, 19 TO 17, 60 NOCLOSE TITLE 'Дати по аналўзу Курсўв' NOMINIMIZE COLOR SCHEME 10
 DEFINE POPUP vv_dat FROM 9, 13 TO 14, 36 MESSAGE ' Для вўдбўру декўльких - Кл. Shift+Enter. Виконати - Кл. Space ' TITLE ' Перўод ' SHADOW MARK '+' MARGIN MULTI FOOTER ' Кўнець-Space ' COLOR SCHEME 20
 DEFINE BAR 1 OF vv_dat PROMPT ' В розрўзў дат     '
 DEFINE BAR 2 OF vv_dat PROMPT ' За весь перўод    '
 DEFINE BAR 3 OF vv_dat PROMPT 'За перўод по банкам'
 DEFINE BAR 4 OF vv_dat PROMPT 'За перўод по БАНКУ '
 ON SELECTION POPUP vv_dat do WORK_DAT 
 DEFINE POPUP vv_ FROM 09, 16 TO 016, 36 MESSAGE ' Для вўдбўру декўльких - Кл. Shift+Enter. Виконати - Кл. Space ' TITLE ' Валюта ' SHADOW MARK '+' MARGIN MULTI FOOTER 'Кўнець-Space' COLOR SCHEME 20
 DEFINE BAR 1 OF vv_ PROMPT '   Долари   '
 DEFINE BAR 2 OF vv_ PROMPT '   Ївро    '
 DEFINE BAR 3 OF vv_ PROMPT '   Рублў    '
 DEFINE BAR 4 OF vv_ PROMPT 'Канад.Долари'
 DEFINE BAR 5 OF vv_ PROMPT 'Англўй.Фунти'
 DEFINE BAR 6 OF vv_ PROMPT 'Ўнша валюта '
 ON SELECTION POPUP vv_ do WORK 
 ACTIVATE WINDOW beg
 PUBLIC r_nazva
 r_nazva = SPACE(36)
 PUBLIC r_dat, vls3, n_dat, k_dat, fal
 PUBLIC su, su1, m_m( 6), m_d( 4), p_reestr, k_reestr
 m_m = 0
 m_d = 0
 fal = 0
 vls = 'Власний пункт обмўну'+SPACE(40)
 p_reestr = DATE()
 k_reestr = DATE()
 @ 1, 02 SAY 'Поч.дата аналўзу'
 @ 2, 03 GET p_reestr SIZE 1, 10
 @ 1, 21 SAY 'Кўнц.дата аналўзу'
 @ 2, 22 GET k_reestr SIZE 1, 10
 READ
 DEACTIVATE WINDOW beg
 a1 = SUBSTR(DTOC(p_reestr), 1, 2)+SUBSTR(DTOC(p_reestr), 4, 2)
 a2 = SUBSTR(DTOC(k_reestr), 1, 2)+SUBSTR(DTOC(k_reestr), 4, 2)
 nam_f_d = 'txt\'+a1+a2+'.DAY'
 nam_f_p = 'txt\'+a1+a2+'.PER'
 nam_f_v = 'txt\'+a1+a2+'.VSI'
 nam_f_b = 'txt\'+a1+a2+'.BNK'
 p_ath_3 = p_ath3+'kurs'
 SELECT 0
 use &p_ath_3 alias bd SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 COPY TO dbfs\rab ALL FOR (p_reestr<=dat .AND. dat<=k_reestr) .AND. kod_v<>'000'
 USE
 SELECT 0
 USE EXCLUSIVE dbfs\rab.dbf ALIAS baz
 INDEX ON DTOS(dat) TO dbfs\d_ind UNIQUE
 COUNT TO nn
 GOTO TOP
 IF nn=0
    WAIT WINDOW TIMEOUT 2 'Данў з '+DTOC(p_reestr)+' по '+DTOC(k_reestr)+' в KURS.Dbf вўдсутнў!'
    DO konec
    RETURN
 ELSE
    COPY TO dbfs\F_Dat FIELDS dat
    SELECT 0
    USE EXCLUSIVE dbfs\F_Dat.dbf ALIAS day
    INDEX ON DTOS(dat) TO Dbfs\Day_ind
    n_dat = day.dat
    GOTO BOTTOM
    k_dat = day.dat
    GOTO TOP
 ENDIF
 p_ath_3 = p_ath3+'p1'
 SELECT 0
 use &p_ath_3 alias op SHARED
 INDEX ON ident TO dbfs\op_ind
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS kb
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\kb_ind COMPACT
 p_ath_3 = p_ath3+'kl_val'
 SELECT 0
 use &p_ath_3 alias KV SHARED
 INDEX ON kod_v TO dbfs\kv_ind
 SELECT baz
 INDEX ON DTOS(dat)+kod_v TO dbfs\b_ind
 ACTIVATE POPUP vv_dat
 ACTIVATE POPUP vv_
 su = 0
 FOR k = 1 TO 6
    su = su+m_m(k)
 ENDFOR
 DO fil_val
 IF fal=1
    DO konec
    RETURN
 ENDIF
 su1 = 0
 FOR k = 1 TO 4
    su1 = su1+m_d(k)
 ENDFOR
 IF m_d(3)=3 .AND. m_d(4)=4 .AND. (m_d(1)<>0 .OR. m_d(2)<>0)
    WAIT WINDOW TIMEOUT 2 'Запрос по розрўзам пўдготовлений невўрно !'
    DO konec
    RETURN
 ENDIF
 HIDE MENU SAVE nachn
 HIDE POPUP SAVE f
 SET CONSOLE OFF
 DO CASE
    CASE su1=1
       set print to &nam_f_d
       WAIT WINDOW NOWAIT ' Чекайте: йдуть розрахунки! '
       = INKEY(1)
       DO evry_day
       WAIT WINDOW TIMEOUT 3 'Данў по аналўзу курсўв у файлў з розширенням DAY'
    CASE su1=2
       set print to &nam_f_p
       r_dat = 'з '+DTOC(n_dat)+' по '+DTOC(k_dat)
       WAIT WINDOW NOWAIT ' Чекайте: йдуть розрахунки! '
       = INKEY(1)
       DO itog
       WAIT WINDOW TIMEOUT 3 'Данў по аналўзу курсўв у файлў з розширенням PER'
    CASE su1=3 .AND. m_d(3)=0
       set print to &nam_f_v
       WAIT WINDOW NOWAIT ' Чекайте: йдуть розрахунки! '
       = INKEY(1)
       DO evry_day
       r_dat = 'з '+DTOC(n_dat)+' по '+DTOC(k_dat)
       DO itog
       WAIT WINDOW TIMEOUT 3 'Данў по аналўзу курсўв у файлў з розширенням BCE'
    CASE su1=3 .AND. m_d(1)=0
       set print to &nam_f_b
       r_dat = 'з '+DTOC(n_dat)+' по '+DTOC(k_dat)
       WAIT WINDOW NOWAIT ' Чекайте: йдуть розрахунки! '
       = INKEY(1)
       DO itog_b
       WAIT WINDOW TIMEOUT 3 'Данў по аналўзу курсўв у файлў з розширенням BNK'
    CASE su1=4 .AND. m_d(1)=0 .AND. m_d(2)=0 .AND. m_d(3)=0
       DO f_bank
       COPY TO dbfs\rab_b ALL FOR STR(mfo, 6)=SUBSTR(r_nazva, 1, 6) .AND. bb_g=SUBSTR(r_nazva, 8, 4)
       SELECT 0
       USE EXCLUSIVE dbfs\rab_b.dbf ALIAS baz_b
       INDEX ON DTOS(dat)+kod_v TO dbfs\bb_ind
       nam_f_n = 'txt\'+a1+a2+'.'+SUBSTR(r_nazva, 4, 3)
       set print to &nam_f_n
       r_dat = 'з '+DTOC(n_dat)+' по '+DTOC(k_dat)
       WAIT WINDOW NOWAIT ' Чекайте: йдуть розрахунки! '
       = INKEY(1)
       DO itog_kb
       WAIT WINDOW TIMEOUT 3 'Данў по банку про курси у файлў з розширенням '+SUBSTR(r_nazva, 4, 3)
       SELECT baz
 ENDCASE
 SET PRINTER TO
 SET DEVICE TO SCREEN
 SET PRINTER OFF
 SHOW MENU nachn
 SHOW POPUP f
 DO konec
 RETURN
*
PROCEDURE evry_day
 SELECT day
 GOTO TOP
 DO WHILE  .NOT. EOF()
    SELECT baz
    INDEX ON DTOS(dat)+kod_v TO dbfs\b_ind FOR dat=day.dat
    SEEK DTOS(day.dat)
    IF FOUND()
       r_dat = DTOC(dat)
       DO an_day
       DO itog_day
    ENDIF
    SELECT day
    SKIP
 ENDDO
 SELECT baz
 RETURN
*
PROCEDURE konec
 CLOSE ALL
 RELEASE POPUP vv_dat
 RELEASE POPUP vv_
 RELEASE vls, r_dat, n_dat, k_dat
 RELEASE su, su1, m_m, m_d, p_reestr, k_reestr
 RELEASE WINDOW glob
 RELEASE WINDOW beg
 ERASE dbfs\d_ind.idx
 ERASE dbfs\b_ind.idx
 ERASE dbfs\bb_ind.idx
 ERASE dbfs\kb_ind.idx
 ERASE dbfs\kv_ind.idx
 ERASE dbfs\op_ind.idx
 ERASE iii.idx
 ERASE dbfs\rab.dbf
 ERASE dbfs\rab_b.dbf
 RETURN
*
PROCEDURE work_dat
 IF LASTKEY()=32
    FOR i = 1 TO CNTBAR('VV_DAT')
       IF MRKBAR('VV_DAT', i)
          m_d( i) = i
       ENDIF
    ENDFOR
    DEACTIVATE POPUP vv_dat
 ENDIF
 RETURN
*
PROCEDURE work
 IF LASTKEY()=32
    FOR i = 1 TO CNTBAR('VV_')
       IF MRKBAR('VV_', i)
          m_m( i) = i
       ENDIF
    ENDFOR
    DEACTIVATE POPUP vv_
 ENDIF
 RETURN
*
PROCEDURE fil_val
 DO CASE
    CASE su=1
       SET FILTER TO kod_v='840'
    CASE su=2
       SET FILTER TO kod_v='978'
    CASE su=3 .AND. m_m(1)=0
       SET FILTER TO kod_v='643'
    CASE su=4 .AND. m_m(1)=0 .AND. m_m(2)=0 .AND. m_m(3)=0 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='124'
    CASE su=5 .AND. m_m(1)=0 .AND. m_m(2)=0 .AND. m_m(3)=0 .AND. m_m(4)=0
       SET FILTER TO kod_v='826'
    CASE su=3 .AND. m_m(3)=0
       SET FILTER TO kod_v='840' .OR. kod_v='978'
    CASE su=4 .AND. m_m(4)=0
       SET FILTER TO kod_v='840' .OR. kod_v='643'
    CASE su=5 .AND. m_m(1)=0 .AND. m_m(4)=0 .AND. m_m(5)=0
       SET FILTER TO kod_v='978' .OR. kod_v='643'
    CASE su=5 .AND. m_m(2)=0 .AND. m_m(3)=0 .AND. m_m(5)=0
       SET FILTER TO kod_v='840' .OR. kod_v='124'
    CASE su=6 .AND. m_m(2)=0 .AND. m_m(3)=0 .AND. m_m(4)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='840' .OR. kod_v='826'
    CASE su=6 .AND. m_m(1)=0 .AND. m_m(3)=0 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='978' .OR. kod_v='124'
    CASE su=7 .AND. m_m(1)=0 .AND. m_m(3)=0 .AND. m_m(4)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='978' .OR. kod_v='826'
    CASE su=7 .AND. m_m(1)=0 .AND. m_m(2)=0 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='643' .OR. kod_v='124'
    CASE su=8 .AND. m_m(1)=0 .AND. m_m(2)=0 .AND. m_m(4)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='643' .OR. kod_v='826'
    CASE su=6 .AND. m_m(4)=0 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='840' .OR. kod_v='978' .OR. kod_v='643'
    CASE su=7 .AND. m_m(3)=0 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='840' .OR. kod_v='978' .OR. kod_v='124'
    CASE su=8 .AND. m_m(3)=0 .AND. m_m(4)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='840' .OR. kod_v='978' .OR. kod_v='826'
    CASE su=9 .AND. m_m(1)=0 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='978' .OR. kod_v='643' .OR. kod_v='124'
    CASE su=10 .AND. m_m(1)=0 .AND. m_m(4)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='978' .OR. kod_v='643' .OR. kod_v='826'
    CASE su=11 .AND. m_m(1)=0 .AND. m_m(3)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='643' .OR. kod_v='124' .OR. kod_v='826'
    CASE su=12 .AND. m_m(1)=0 .AND. m_m(2)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='643' .OR. kod_v='124' .OR. kod_v='826'
    CASE su=8 .AND. m_m(2)=0 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='643' .OR. kod_v='124' .OR. kod_v='840'
    CASE su=9 .AND. m_m(2)=0 .AND. m_m(4)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='643' .OR. kod_v='826' .OR. kod_v='840'
    CASE su=10 .AND. m_m(2)=0 .AND. m_m(3)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='124' .OR. kod_v='826' .OR. kod_v='840'
    CASE su=10 .AND. m_m(5)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='840' .OR. kod_v='978' .OR. kod_v='643' .OR. kod_v='124'
    CASE su=13 .AND. m_m(2)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='840' .OR. kod_v='643' .OR. kod_v='124' .OR. kod_v='826'
    CASE su=14 .AND. m_m(1)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='978' .OR. kod_v='643' .OR. kod_v='124' .OR. kod_v='826'
    CASE su=11 .AND. m_m(4)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='643' .OR. kod_v='826' .OR. kod_v='840' .OR. kod_v='978'
    CASE su=12 .AND. m_m(3)=0 .AND. m_m(6)=0
       SET FILTER TO kod_v='124' .OR. kod_v='826' .OR. kod_v='840' .OR. kod_v='978'
    CASE su=15 .AND. m_m(6)=0
       SET FILTER TO kod_v='840' .OR. kod_v='978' .OR. kod_v='643' .OR. kod_v='124' .OR. kod_v='826'
    CASE su=6 .AND. m_m(1)=0 .AND. m_m(2)=0 .AND. m_m(3)=0 .AND. m_m(4)=0 .AND. m_m(5)=0
       SET FILTER TO (kod_v<>'840' .AND. kod_v<>'978' .AND. kod_v<>'' .AND. kod_v<>'124' .AND. kod_v<>'826')
    CASE su=21
       SET FILTER TO
    OTHERWISE
       WAIT WINDOW TIMEOUT 2 'Запрос по валютам пўдготовлений невўрно !'
       fal = 1
 ENDCASE
 RETURN
*
PROCEDURE f_bank
 SELECT kb
 DEFINE POPUP debb1 FROM 04, 03 TO 23, 47 PROMPT FIELDS ' '+STR(mfo, 6)+' '+bb_g+' '+PADR(knb, 27) TITLE ' МФО    Баланс     Назва банку         ' MARK '' SCROLL COLOR SCHEME 8
 ON SELECTION POPUP debb1 DO VIBOR_POD WITH PROMPT()
 ACTIVATE POPUP debb1
 SELECT baz
 RETURN
*
PROCEDURE vibor_pod
 PARAMETER pole
 r_nazva = STR(mfo, 6)+' '+bb_g+' '+knb
 DEACTIVATE POPUP debb1
 RETURN
*
*** 
*** ReFox - all is not lost 
***
