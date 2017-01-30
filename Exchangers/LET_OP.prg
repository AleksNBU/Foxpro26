*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 SET TALK OFF
 SET CENTURY ON
 SET DATE german
 CLOSE ALL
 DEFINE WINDOW beg FROM 5, 20 TO 10, 50 NOCLOSE TITLE 'Формування повўдомлень' NOMINIMIZE COLOR SCHEME 10
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
 use &p_ath_3 SHARED
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
 COUNT TO rb
 IF rab<>0
    GOTO TOP
    WAIT WINDOW TIMEOUT 2 'У директорў∙ ТХТ\ формуються файли з розширенням .NBU '
    DO WHILE  .NOT. EOF()
       a1 = 'vk'+kb.ncks+SUBSTR(DTOC(p_reestr), 1, 2)
       fal1 = 'txt\'+a1+'.NBU'
       nam = kb.knb
       mfo_r = kb.mfo
       mfo_r = baz.mfo
       SET FILTER TO mfo=mfo_r
       rec = RECNO()
       REPORT FORMAT LET_OP.FRX TO FILE (fal1) NOCONSOLE
       SET FILTER TO
       GOTO rec
       SKIP
    ENDDO
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
*** 
*** ReFox - all is not lost 
***
