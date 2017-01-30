*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 PARAMETER var
 PUBLIC r_dat, text1, text2, text3, text0
 r_dat = DATE()
 r_dat1 = DATE()
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 NOCLOSE NOMINIMIZE NONE COLOR SCHEME 17
 DEFINE WINDOW beg FROM 09, 24 TO 15, 54 NOCLOSE NOMINIMIZE COLOR SCHEME 10
 DEFINE WINDOW beg1 FROM 09, 24 TO 19, 54 NOCLOSE NOMINIMIZE COLOR SCHEME 10
 ACTIVATE WINDOW glob
 @ 03, 16 TO 07, 63
 @ 04, 33 SAY 'Вихўдна форма:'
 DO CASE
    CASE var=1
       @ 06, 24 SAY 'ПЕРЕЛЎК ПУНКТЎВ УФГ НА ЗВЎТНУ ДАТУ'
       ACTIVATE WINDOW beg
       @ 01, 05 SAY 'Введўть звўтну дату:'
       @ 03, 10 GET r_dat SIZE 1, 10
       READ
       text1 = 'ПЕРЕЛЎК'
       text2 = 'пунктўв Укра∙нсько∙ фўнансово∙ групи (УФГ)'
       text3 = 'зареїстрованих на '+DTOC(r_dat)+' р.'
       text0 = ''
       SELECT 0
       USE p_ath3+'UFG\UFG.DBF'
       COPY TO p_ath6+'TMP_P1' FOR dat_reestr<=r_dat
       USE
       file1 = 'TXT\'+DTOS(r_dat)+'.UFG'
    CASE var=2
       @ 06, 26 SAY 'ПЕРЕЛЎК ПУНКТЎВ УФГ ЗА ПЕРЎОД'
       ACTIVATE WINDOW beg1
       @ 01, 05 SAY 'Введўть початкову дату:'
       @ 03, 10 GET r_dat SIZE 1, 10
       @ 05, 05 SAY 'Введўть кўнцеву дату:'
       @ 07, 10 GET r_dat1 SIZE 1, 10
       READ
       text1 = 'ПЕРЕЛЎК'
       text2 = 'пунктўв Укра∙нсько∙ фўнансово∙ групи (УФГ)'
       text3 = 'зареїстрованих з '+DTOC(r_dat)+' по '+DTOC(r_dat1)+' рр.'
       SELECT 0
       USE p_ath3+'UFG\UFG.DBF'
       COPY TO p_ath6+'TMP_P1' FOR dat_reestr<=r_dat1 .AND. dat_reestr>=r_dat
       USE
       file1 = 'TXT\'+DTOS(r_dat1)+'.U_P'
    CASE var=3
       @ 06, 18 SAY 'ПЕРЕЛЎК ВИДАЛЕНИХ ПУНКТЎВ УФГ НА ЗВЎТНУ ДАТУ'
       ACTIVATE WINDOW beg
       @ 01, 05 SAY 'Введўть звўтну дату:'
       @ 03, 10 GET r_dat SIZE 1, 10
       READ
       text1 = 'ПЕРЕЛЎК'
       text0 = 'ВИДАЛЕНИХ'
       text2 = 'пунктўв Укра∙нсько∙ фўнансово∙ групи (УФГ)'
       text3 = 'зареїстрованих на '+DTOC(r_dat)+' р.'
       SELECT 0
       USE p_ath3+'UFG\UFG_DEL.DBF'
       COPY TO p_ath6+'TMP_P1' FOR dat_reestr<=r_dat
       USE
       file1 = 'TXT\'+DTOS(r_dat)+'.U_D'
 ENDCASE
 RELEASE WINDOW beg
 RELEASE WINDOW beg1
 RELEASE WINDOW glob
 SELECT 0
 USE IN 1 p_ath6+'TMP_P1'
 INDEX ON num_reestr TO p_ath6+'NUM_REES.IDX' COMPACT
 SELECT 1
 COUNT TO x
 IF x<>0
    SELECT 0
    USE IN 2 p_ath3+'UFG\UFG_NUM.DBF' ALIAS ufg_num
    INDEX ON num_ufg TO p_ath6+'NUM_UFG.IDX' COMPACT
    SELECT 0
    USE IN 3 p_ath3+'UFG\UFG_OPER.DBF' ALIAS ufg_oper
    INDEX ON num_oper TO p_ath6+'NUM_OPER.IDX' COMPACT
    SELECT 1
    SET RELATION TO num_ufg INTO 2
    SELECT 2
    SET RELATION TO num_oper INTO 3
    SELECT 1
    SET SKIP TO 2, 3
    REPORT FORMAT PRN_1.FRX TO FILE (file1) NOCONSOLE
    WAIT WINDOW TIMEOUT 2 'Даннў по перелўку пунктўв УФГ в файлў '+file1
    CLOSE ALL
    DELETE FILE NUM_OPER.IDX
    DELETE FILE NUM_UFG.IDX
    DELETE FILE NUM_REES.IDX
    DELETE FILE p_ath6+'TMP_P1.DBF'
    SET SKIP TO
 ELSE
    WAIT WINDOW TIMEOUT 2 'На дтау '+DTOC(r_dat)+' ўнформацў∙ немаї '
    CLOSE ALL
    DELETE FILE p_ath6+'TMP_P1.DBF'
 ENDIF
 RETURN
*
*** 
*** ReFox - all is not lost 
***
