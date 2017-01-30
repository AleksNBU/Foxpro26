*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 SET TALK OFF
 SET CENTURY ON
 SET DATE german
 CLOSE ALL
 DEFINE WINDOW beg FROM 5, 20 TO 10, 50 NOCLOSE TITLE ' Перевўрка повноти ' NOMINIMIZE COLOR SCHEME 10
 PUBLIC p_reestr, r_ident
 ACTIVATE WINDOW beg
 p_reestr = DATE()
 @ 1, 02 SAY ' Ведўть дату звўтностў '
 @ 2, 10 GET p_reestr SIZE 1, 10
 READ
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS kb
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\kb_ind COMPACT
 p_ath_3 = p_ath3+'p1'
 SELECT 0
 use &p_ath_3 SHARED
 COPY TO dbfs\rab0
 USE
 SELECT 0
 USE EXCLUSIVE dbfs\rab0.dbf ALIAS baz
 INDEX ON ident TO dbfs\rab0_ind
 p_ath_3 = p_ath3+'kurs'
 SELECT 0
 use &p_ath_3  SHARED
 COPY TO dbfs\rab1 ALL FOR dat=p_reestr
 USE
 SELECT 0
 USE EXCLUSIVE dbfs\rab1.dbf ALIAS ku
 INDEX ON ident TO dbfs\rab1_ind UNIQUE
 COUNT TO rab
 IF rab=0
    WAIT WINDOW TIMEOUT 2 'Даних на задану дату у файлў KURS.DBF нема !'
    DEACTIVATE WINDOW beg
    CLOSE ALL
    RELEASE p_reestr
    RELEASE WINDOW beg
    ERASE dbfs\rab1_ind.idx
    ERASE dbfs\kb_ind.idx
    ERASE dbfs\mfo_ind.idx
    ERASE dbfs\rab1.dbf
    ERASE dbfs\rab0.dbf
    RETURN
 ENDIF
 GOTO TOP
 SELECT baz
 GOTO TOP
 DO WHILE  .NOT. EOF()
    SELECT ku
    SEEK baz.ident
    IF FOUND()
       SELECT baz
       DELETE
       SELECT ku
       GOTO TOP
    ENDIF
    SELECT baz
    SKIP
 ENDDO
 PACK
 GOTO TOP
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\mfo_ind
 SET RELATION TO STR(mfo, 6)+bb_g INTO kb
 COUNT TO rab
 IF rab<>0
    a1 = SUBSTR(DTOC(p_reestr), 1, 2)+SUBSTR(DTOC(p_reestr), 4, 2)+SUBSTR(DTOC(p_reestr), 9, 2)
    fal1 = 'txt\'+a1+'.FUL'
    REPORT FORMAT FULL_OP.FRX TO FILE (fal1) NOCONSOLE
    WAIT WINDOW TIMEOUT 2 'Ўнформацўя про повноту введ.даних у файлў '+fal1
 ELSE
    WAIT WINDOW TIMEOUT 2 ' Повна ўнформацўя по введеним даним про курс Валют '
 ENDIF
 DEACTIVATE WINDOW beg
 CLOSE ALL
 RELEASE p_reestr
 RELEASE WINDOW beg
 ERASE dbfs\rab1_ind.idx
 ERASE dbfs\kb_ind.idx
 ERASE dbfs\mfo_ind.idx
 ERASE dbfs\rab1.dbf
 ERASE dbfs\rab0.dbf
 RETURN
*
FUNCTION n_bank
 PARAMETER prb_b
 DO CASE
    CASE prb_b='2'
       RETURN 'фўлўя УКРЕКСЎМБАНКу               '
    CASE prb_b='3'
       RETURN 'Харкўвське головне регўональне управлўння Промўнвестбанку'
    CASE prb_b='4'
       RETURN 'Харкўвська обласна дирекцўя Агропромбанку'
    CASE prb_b='5'
       RETURN 'Харкўвська обласна дирекцўя УкрСоцбанку'
    CASE prb_b='6'
       RETURN 'вўддўлення Ощадбанку              '
    CASE prb_b>'6'
       RETURN 'Комерцўйнў банки'
 ENDCASE
*
*** 
*** ReFox - all is not lost 
***
