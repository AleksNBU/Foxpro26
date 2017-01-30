*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 CLOSE DATABASES
 er_rr = ' '
 ON ERROR do e_rr WITH ERROR()
 SET MEMOWIDTH TO 150
 SET DECIMALS TO 4
 SET ECHO OFF
 SET TALK OFF
 SET SAFETY OFF
 SET CENTURY ON
 SET CONSOLE OFF
 SET EXCLUSIVE OFF
 DEFINE WINDOW bar_d FROM 10, 15 TO 12, 45 FLOAT SHADOW COLOR SCHEME 1
 ACTIVATE WINDOW bar_d
 ddd = DATE()
 @ 0, 0 SAY ' Заказана Дата '
 @ 0, 17 GET ddd SIZE 1, 10 PICTURE '@D'
 READ
 DEACTIVATE WINDOW bar_d
 pens = 0.01 
 m_c = ddd
 IF FILE('dbfs\work1.dbf')
    ERASE dbfs\work1.dbf
 ENDIF
 CREATE DBF dbfs\work1 (p1 M)
 USE
 IF FILE('dbfs\temp.dbf')
    ERASE dbfs\temp.dbf
 ENDIF
 CREATE DBF dbfs\temp (dat D (10), ident C (7), mfo N (6), bb_g C (4), kod_v C (3), nomin N (5), kurs N (9, 4), prizn C (1), prav C (1), pri_n N (1), t_kurs N (9, 4))
 USE
 IF FILE('dbfs\rab3.dbf')
    ERASE dbfs\rab3.dbf
 ENDIF
 CREATE DBF dbfs\rab3 (dat D (10), ident C (7), mfo N (6), bb_g C (4), kod_v C (3), kurs N (9, 4), kurs_l N (9, 4), kurs_h N (9, 4), nomin N (5), t_kurs N (9, 4), r_l N (9, 4), r_h N (9, 4), razn N (9, 4))
 USE
 IF  .NOT. EMPTY(SYS(2000, p_ath5+'vk*.*'))
    SELECT 0
    USE SHARED DBFS\KB_TVBV ALIAS kbn
    INDEX ON STR(mfo, 6)+bb_g TO dbfs\i_mfo
    p_ath_1 = p_ath1+'kl_v030'
    SELECT 0
    use &p_ath_1  
    COPY TO dbfs\rab_cv
    USE SHARED dbfs\rab_cv ALIAS cv
    INDEX ON DTOC(d_val, 1)+r030 TO dbfs\i1_cv
    SET FILTER TO d_val=ddd
    COUNT TO rab
    IF rab=0
       SET FILTER TO
       GOTO TOP
       INDEX ON DTOC(d_val, 1) TO dbfs\i_cv UNIQUE
       GOTO BOTTOM
       IF d_val>ddd
          SKIP -1
       ENDIF
       dat_t = d_val
       INDEX ON DTOC(d_val, 1)+r030 TO dbfs\i1_cv
       SET FILTER TO d_val=dat_t
       WAIT WINDOW TIMEOUT 2 'Даних за '+DTOC(ddd)+' у Довўднўку валют kl_r030 нема. Беремо за '+DTOC(dat_t)
    ENDIF
    GOTO TOP
    INDEX ON r030 TO dbfs\i2_cv
    SELECT 0
    USE EXCLUSIVE dbfs\rab3 ALIAS rb3
    SELECT 0
    USE EXCLUSIVE dbfs\work1 ALIAS wk
    p_ath_3 = p_ath3+'p1'
    SELECT 0
    use &p_ath_3 alias bd SHARED
    IF er_rr='*'
       QUIT
    ENDIF
    INDEX ON ident+STR(mfo, 6)+bb_g TO dbfs\i_bd
    SELECT 0
    USE EXCLUSIVE dbfs\temp ALIAS tmp
    p_ath_3 = p_ath3+'kurs'
    SELECT 0
    use &p_ath_3 alias krs EXCLUSIVE   
    IF er_rr='*'
       QUIT
    ENDIF
    DIMENSION d_ir[ 1]
    k_at = ADIR(d_ir, p_ath5+'vk*.*')
    SET PRINTER ON
    DIMENSION st_ru[ 7, 4]
    WAIT WINDOW NOWAIT 'Трошки зачекайте'
    FOR n = 1 TO k_at
       eror = ' '
       dlin_name = LEN(d_ir(n,1))-4
       nam_file = p_ath7+SUBSTR(d_ir(n,1), 1, dlin_name)+'.t'+RIGHT(d_ir(n,1), 2)
       set print to &nam_file
       nam = p_ath6+d_ir(n,1)
       nam2 = p_ath5+d_ir(n,1)
       nam_brak = p_ath8+d_ir(n,1)
       SET CONSOLE OFF
       ? '------------------------------------------------------------------------'
       ? 'Протокол прийому даних файлу VK    Управлўння HБУ в Харкўвськўй областў '
       ? '------------------------------------------------------------------------'
       SELECT tmp
       ZAP
       SELECT rb3
       ZAP
       SELECT wk
       ZAP
       APPEND BLANK
       APPEND MEMO p1 FROM (p_ath5+d_ir(n,1))
       sl_str = MLINE(p1, 2)
       kol_str2 = MEMLINES(p1)
       k_str = VAL(SUBSTR(sl_str, 55, 9))
       dat_otch = SUBSTR(sl_str, 4, 2)+'.'+SUBSTR(sl_str, 6, 2)+'.'+SUBSTR(sl_str, 08, 4)
       dat_per = SUBSTR(sl_str, 31, 2)+'.'+SUBSTR(sl_str, 33, 2)+'.'+SUBSTR(sl_str, 35, 4)
       vr_per = SUBSTR(sl_str, 40, 2)+':'+SUBSTR(sl_str, 42, 2)
       k_bank = SUBSTR(sl_str, 45, 6)
       SELECT kbn
       SEEK k_bank
       ? 'Файл -> '+d_ir(n,1)+'           '+knb
       ? ' '
       ? ' '
       ? 'Дата передачi -> '+dat_per+'  '+vr_per+'    Дата прийому -> '+DTOC(DATE())+'  '+SUBSTR(TIME(), 1, 9)
       ? 'Дата звiтностi-> '+dat_otch
       IF  .NOT. FOUND()
          ? k_bank+' -> МФО '+k_bank
          eror = '*'
       ELSE
          pr_bank = prb
          im_f = SUBSTR(ncks, 1, 4)
          IF SUBSTR(d_ir(n,1), 3, 4)<>im_f
             ? 'Ўм"я файлу '+d_ir(n,1)+' не вўдповўдаї МФО '+k_bank
             eror = '*'
          ENDIF
       ENDIF
       IF d_ir(n,1)<>UPPER(SUBSTR(sl_str, 65, 12))
          ? 'Помилкове ўм"я файлу в заголовному рядку '+d_ir(n,1)+' # '+UPPER(SUBSTR(sl_str, 65, 12))
          eror = '*'
       ENDIF
       IF SUBSTR(sl_str, 1, 2)<>'03'
          ? 'Помилковий номер схеми в заголовному рядку -> '+SUBSTR(sl_str, 1, 2)+'  чекаїмо  03'
          eror = '*'
       ENDIF
       IF m_c<>CTOD(dat_otch)
          ? 'Переданий звўтний перўод (DDMMYYY1) -> '+dat_otch+'  чекаїмо '+DTOC(m_c)
          eror = '*'
       ENDIF
       IF SUBSTR(sl_str, 52, 2)<>'12'
          ? 'Помилкова одиниця вимўрювання -> '+SUBSTR(sl_str, 52, 2)+'  чекаїмо  12'
          eror = '*'
       ENDIF
       SELECT tmp
       kol_str = 0
       FOR ac = 3 TO kol_str2
          sl_str = MLINE(wk.p1, ac)
          IF  .NOT. EMPTY(sl_str) .AND. sl_str<>CHR(26)
             kol_str = kol_str+1
             IF SUBSTR(sl_str, 1, 1)='#'
                nv1 = AT('=', sl_str, 1)
                nv2 = AT('=', sl_str, 2)
                r_ident = SUBSTR(sl_str, nv1+1, 7)
                k_bb_g = ALLTRIM(SUBSTR(sl_str, nv2+1, 4))
                IF nv2=0
                   ? 'Нема кода поля В020 для Пункту обмўну з кодом '+r_ident
                   eror = '*'
                ENDIF
             ELSE
                nv = AT('=', sl_str, 1)
                pokaz = ALLTRIM(SUBSTR(sl_str, 1, nv-1))
                s_um = ALLTRIM(SUBSTR(sl_str, nv+1))
                su2 = LEN(s_um)
                kon = .F.
                FOR ak = 1 TO su2
                   IF SUBSTR(s_um, ak, 1)<>' ' .AND. SUBSTR(s_um, ak, 1)<>'0' .AND. SUBSTR(s_um, ak, 1)<>'1' .AND. SUBSTR(s_um, ak, 1)<>'2' .AND. SUBSTR(s_um, ak, 1)<>'3' .AND. SUBSTR(s_um, ak, 1)<>'4' .AND. SUBSTR(s_um, ak, 1)<>'5' .AND. SUBSTR(s_um, ak, 1)<>'6' .AND. SUBSTR(s_um, ak, 1)<>'7' .AND. SUBSTR(s_um, ak, 1)<>'8' .AND. SUBSTR(s_um, ak, 1)<>'9' .AND. SUBSTR(s_um, ak, 1)<>'.' .AND. SUBSTR(s_um, ak, 1)<>CHR(26)
                      kon = .T.
                   ENDIF
                ENDFOR
                IF kon=.T.
                   ? 'Для даних по валюте '+SUBSTR(pokaz, 2, 3)+' в курсе валюты ї не цифровў символи '
                   eror = '*'
                ENDIF
                IF eror<>'*'
                   APPEND BLANK
                   REPLACE ident WITH r_ident, mfo WITH VAL(k_bank), bb_g WITH k_bb_g, prizn WITH SUBSTR(pokaz, 1, 1), kod_v WITH SUBSTR(pokaz, 2, 3), kurs WITH VAL(s_um), dat WITH m_c
                ENDIF
             ENDIF
          ENDIF
       ENDFOR
       IF k_str<>kol_str
          ? 'Кўлькўсть записўв не вўдповўдаї значенню в заголовному рядку -> '+ALLTRIM(STR(k_str))+' # '+ALLTRIM(STR(kol_str))
          eror = '*'
       ENDIF
       IF eror=' '
          INDEX ON ident+STR(mfo, 6)+bb_g TO dbfs\i_rab1 UNIQUE
          SET RELATION TO ident+STR(mfo, 6)+bb_g INTO bd
          REPLACE prav WITH '*' ALL FOR ident<>bd.ident
          COUNT FOR prav='*' TO rab
          IF rab<>0
             SET FILTER TO prav='*'
             GOTO TOP
             DO WHILE  .NOT. EOF()
                ? 'Код Обмўнного пункту '+ident+' не вўдповўдаї Вашему МФО '+STR(mfo, 6)
                ? 'разом з ознакою баланс/безбаланс.вўддўлення банку '+bb_g
                SKIP
             ENDDO
             eror = '*'
          ENDIF
          SET FILTER TO
          SET INDEX TO
          REPLACE prav WITH ' ' ALL
          SET RELATION OFF INTO bd
          INDEX ON kod_v TO dbfs\i_rab2
          SET RELATION TO kod_v INTO cv
          REPLACE t_kurs WITH cv.z_kurs ALL FOR prizn='1'
          REPLACE t_kurs WITH cv.z_kurs ALL FOR prizn='2'
          REPLACE nomin WITH cv.nomin ALL FOR prizn='1'
          REPLACE nomin WITH cv.nomin ALL FOR prizn='2'
          COPY TO Rab1 FOR EMPTY(t_kurs)
          SELECT 0
          USE SHARED Rab1 ALIAS rb1
          COUNT TO rab
          IF rab<>0
             GOTO TOP
             DO WHILE  .NOT. EOF()
                SELECT cv
                SEEK rb1.kod_v
                IF  .NOT. FOUND() .AND. (rb1.kod_v<>'000')
                   ? 'Для Обмўнного пункту '+rb1.ident+' код валюти '+rb1.kod_v+' в довўднику не знайден'
                   eror = '*'
                ENDIF
                GOTO TOP
                SELECT rb1
                IF prizn<>'1' .AND. prizn<>'2'
                   ? 'Для Обм.пункту '+ident+' для кода валюти '+kod_v+' помилковий признак кордону валюти '+prizn+'. Чекаїмо 1 чи 2'
                   eror = '*'
                ENDIF
                SKIP
             ENDDO
          ENDIF
          USE
          ERASE rab1.dbf
          SELECT tmp
          SET RELATION OFF INTO cv
          IF eror=' '
             REPLACE pri_n WITH VAL(prizn) ALL
             INDEX ON ident+kod_v TO dbfs\i_r1 FOR prizn='1' .OR. prizn='2'
             TOTAL ON ident+kod_v TO Rab2 FOR prizn='1' .OR. prizn='2' FIELDS pri_n
             SELECT 0
             USE SHARED Rab2 ALIAS rb2
             COUNT TO rab
             IF rab<>0
                GOTO TOP
                DO WHILE  .NOT. EOF()
                   IF pri_n<>3
                      ? 'Для Обм.пункту '+ident+' для кода валюти '+kod_v+' некоректно задани валютнў кордони '
                      eror = '*'
                   ENDIF
                   SKIP
                ENDDO
             ENDIF
             USE
             ERASE rab2.dbf
          ENDIF
       ENDIF
       IF eror=' '
          SELECT tmp
          COPY TO Rab1 FOR prizn='1'
          INDEX ON ident+STR(mfo, 6)+bb_g+kod_v TO dbfs\i_r2 FOR prizn='2'
          SELECT 0
          USE SHARED Rab1 ALIAS rb1
          SELECT rb3
          APPEND FROM Rab1 FIELDS dat, ident, mfo, bb_g, kod_v, nomin, kurs, t_kurs
          GOTO TOP
          REPLACE kurs_l WITH kurs ALL
          SELECT rb1
          USE
          ERASE rab1.dbf
          SELECT rb3
          SET RELATION TO ident+STR(mfo, 6)+bb_g+kod_v INTO tmp
          REPLACE kurs_h WITH tmp.kurs ALL FOR tmp.prizn='2'
          GOTO TOP
          SET RELATION OFF INTO tmp
          REPLACE r_l WITH 1 ALL FOR kod_v<>'000' .AND. kurs_l=0
          REPLACE r_h WITH 1 ALL FOR kod_v<>'000' .AND. kurs_h=0
          COPY TO Rab1 FOR  .NOT. EMPTY(r_l) .OR.  .NOT. EMPTY(r_h)
          SELECT 0
          USE SHARED Rab1 ALIAS rb1
          COUNT TO rab
          IF rab<>0
             GOTO TOP
             DO WHILE  .NOT. EOF()
                IF r_l<>0
                   ? 'Для ОП '+ident+' для валюти '+kod_v+' Купўвля='+STR(kurs_l, 6, 4)+' ?. Поточн.курс='+STR(t_kurs, 6, 4)
                ENDIF
                IF r_h<>0
                   ? 'Для ОП '+ident+' для валюти '+kod_v+' Продаж='+STR(kurs_h, 6, 4)+' ?. Поточн.курс='+STR(t_kurs, 6, 4)
                ENDIF
                SKIP
             ENDDO
             eror = '*'
          ENDIF
          USE
          ERASE rab1.dbf
          IF eror=' '
             SELECT rb3
             REPLACE r_l WITH kurs_l ALL FOR kurs_l<>0 .AND. ABS((kurs_l/t_kurs)-1)>0.5 
             REPLACE r_h WITH kurs_h ALL FOR kurs_h<>0 .AND. ABS((kurs_h/t_kurs)-1)>0.5 
             COPY TO Rab1 FOR  .NOT. EMPTY(r_l) .OR.  .NOT. EMPTY(r_h)
             SELECT 0
             USE SHARED Rab1 ALIAS rb1
             COUNT TO rab
             IF rab<>0
                GOTO TOP
                DO WHILE  .NOT. EOF()
                   IF r_l<>0
                      ? 'Для ОП '+ident+' для валюти '+kod_v+' Купўвля='+STR(kurs_l, 6, 4)+' ?. Поточн.курс='+STR(t_kurs, 6, 4)
                   ENDIF
                   IF r_h<>0
                      ? 'Для ОП '+ident+' для валюти '+kod_v+' Продаж='+STR(kurs_h, 6, 4)+' ?. Поточн.курс='+STR(t_kurs, 6, 4)
                   ENDIF
                   SKIP
                ENDDO
                eror = '+'
             ENDIF
             USE
             ERASE rab1.dbf
          ENDIF
          IF eror=' ' .OR. eror='+'
             SELECT rb3
             GOTO TOP
             ra_dat = rb3.dat
             ra_mfo = rb3.mfo
             SELECT krs
             INDEX ON DTOC(dat)+STR(mfo, 6) TO dbfs\i_krs
             SEEK DTOC(ra_dat)+STR(ra_mfo, 6)
             IF FOUND()
                DELETE ALL FOR (krs.dat=ra_dat) .AND. (krs.mfo=ra_mfo)
                PACK
             ENDIF
             APPEND FROM DBFS\Rab3 FIELDS dat, ident, mfo, bb_g, kod_v, nomin, kurs_l, kurs_h, t_kurs, r_l, r_h, razn
             REPLACE dat_z WITH DATE() ALL FOR ddd=krs.dat
             REPLACE time_z WITH TIME() ALL FOR ddd=krs.dat
             REPLACE a_fio WITH _fio ALL FOR ddd=krs.dat
          ENDIF
       ENDIF
       DO CASE
          CASE eror='*'
             ? ''
             ? 'Файл не прийнято !'
             ? '-----------------------------------------------------------------------'
             ? '.F.'
             copy file &nam2 to (nam_brak)
             erase &nam2
          CASE eror=' '
             IF FILE(nam2)
                ? ''
                ? 'Файл прийнято без помилок'
                ? '-----------------------------------------------------------------------'
                ? '.T.'
                copy file &nam2 to &nam
                erase &nam2
             ENDIF
          CASE eror='+'
             IF FILE(nam2)
                ? ''
                ? 'Файл прийнято з зауваженнями'
                ? '-----------------------------------------------------------------------'
                ? '.T.'
                copy file &nam2 to &nam
                erase &nam2
             ENDIF
       ENDCASE
    ENDFOR
    SET PRINTER TO
    SET DEVICE TO SCREEN
    SET PRINTER OFF
    CLOSE DATABASES
    ON ERROR
    SET CONSOLE ON
    ERASE dbfs\rab1.dbf
    ERASE dbfs\rab2.dbf
    ERASE dbfs\rab3.dbf
    ERASE dbfs\i_mfo.idx
    ERASE dbfs\i1_cv.idx
    ERASE dbfs\i_cv.idx
    ERASE dbfs\i2_cv.idx
    ERASE dbfs\i_bd.idx
    ERASE dbfs\i_rab1.idx
    ERASE dbfs\i_rab2.idx
    ERASE dbfs\i_r1.idx
    ERASE dbfs\i_r2.idx
    ERASE dbfs\i_krs
    ERASE dbfs\rab_cv.dbf
    WAIT CLEAR
 ELSE
    WAIT WINDOW NOWAIT 'У каталозў '+p_ath5+' немаї даних для обробки'
 ENDIF
 RETURN
*
*** 
*** ReFox - all is not lost 
***
