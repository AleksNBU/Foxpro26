*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE itog_b
 SELECT baz
 INDEX ON kod_v TO ii UNIQUE
 COPY TO dbfs\F_Val FIELDS kod_v
 INDEX ON kod_v+STR(kurs_l, 9, 4) TO iii
 SELECT 0
 USE dbfs\F_Val.dbf ALIAS val
 INDEX ON kod_v TO i2
 SELECT val
 GOTO TOP
 DO WHILE  .NOT. EOF()
    SELECT baz
    SEEK val.kod_v
    IF FOUND()
       rab = kurs_l
       im = 'dbfs\MIK'+kod_v
       Copy to &im For Kod_v=val.kod_v .and.Kurs_l=Rab
    ENDIF
    SELECT val
    SKIP
 ENDDO
 SELECT baz
 INDEX ON kod_v+STR(kurs_l, 9, 4) TO iii
 SET ORDER TO iii DESCENDING
 SELECT val
 SET ORDER TO i2 DESCENDING
 GOTO TOP
 DO WHILE  .NOT. EOF()
    SELECT baz
    SEEK val.kod_v
    IF FOUND()
       rab = kurs_l
       im = 'dbfs\MAK'+kod_v
       Copy to &im For Kod_v=val.kod_v .and.Kurs_l=Rab
    ENDIF
    SELECT val
    SKIP
 ENDDO
 SELECT baz
 INDEX ON kod_v+STR(kurs_h, 9, 4) TO iii
 SELECT val
 SET ORDER TO i2
 GOTO TOP
 DO WHILE  .NOT. EOF()
    SELECT baz
    SEEK val.kod_v
    IF FOUND()
       rab = kurs_h
       im = 'dbfs\MIP'+kod_v
       Copy to &im For Kod_v=val.kod_v .and.Kurs_h=Rab
    ENDIF
    SELECT val
    SKIP
 ENDDO
 SELECT baz
 INDEX ON kod_v+STR(kurs_h, 9, 4) TO iii
 SET ORDER TO iii DESCENDING
 SELECT val
 SET ORDER TO i2 DESCENDING
 GOTO TOP
 DO WHILE  .NOT. EOF()
    SELECT baz
    SEEK val.kod_v
    IF FOUND()
       rab = kurs_h
       im = 'dbfs\MAP'+kod_v
       Copy to &im For Kod_v=val.kod_v .and.Kurs_H=Rab
    ENDIF
    SELECT val
    SKIP
 ENDDO
 SELECT val
 SET ORDER TO i2 ASCENDING
 SET RELATION TO kod_v INTO kv
 GOTO TOP
 DO WHILE  .NOT. EOF()
    ? '  '+kod_v+' - '+kv.txt
    SKIP
 ENDDO
 USE
 ? ' '
 ? ' Дата: '+r_dat
 ? '======================='+REPLICATE('=', 32)
 ? ' КодIЗначення IKод MФO     I       Назва банку         '
 ? '====I=========I============I'+REPLICATE('=', 27)
 k = ADIR(r_m, 'dbfs\MIK*.dbf')
 FOR i = 1 TO k
    kod_r = SUBSTR('dbfs\'+r_m(i,1), 9, 3)
    ? ' '+kod_r+' Купўвля МIN'
    USE 'dbfs\'+r_m(i,1)
    INDEX ON STR(mfo, 6)+bb_g TO ii UNIQUE
    SET RELATION TO STR(mfo, 6)+bb_g INTO kb
    DO WHILE  .NOT. EOF()
       ? '     '+STR(kurs_l, 9, 4)+'  '+STR(mfo, 6)+' '+bb_g+' '+kb.knb
       SKIP
    ENDDO
    SET RELATION TO
    USE
 ENDFOR
 ? REPLICATE('.', 60)
 ? ' '
 k = ADIR(r_m, 'dbfs\MAK*.dbf')
 FOR i = 1 TO k
    kod_r = SUBSTR('dbfs\'+r_m(k-i+1,1), 9, 3)
    ? ' '+kod_r+' Купўвля МAX'
    USE 'dbfs\'+r_m(k-i+1,1)
    INDEX ON STR(mfo, 6)+bb_g TO ii UNIQUE
    SET RELATION TO STR(mfo, 6)+bb_g INTO kb
    DO WHILE  .NOT. EOF()
       ? '     '+STR(kurs_l, 9, 4)+'  '+STR(mfo, 6)+' '+bb_g+' '+kb.knb
       SKIP
    ENDDO
    SET RELATION TO
    USE
 ENDFOR
 ? REPLICATE('-', 60)
 ? ' '
 k = ADIR(r_m, 'dbfs\MIP*.dbf')
 FOR i = 1 TO k
    kod_r = SUBSTR('dbfs\'+r_m(k-i+1,1), 9, 3)
    ? ' '+kod_r+' Продаж МIN'
    USE 'dbfs\'+r_m(k-i+1,1)
    INDEX ON STR(mfo, 6)+bb_g TO ii UNIQUE
    SET RELATION TO STR(mfo, 6)+bb_g INTO kb
    DO WHILE  .NOT. EOF()
       ? '     '+STR(kurs_h, 9, 4)+'  '+STR(mfo, 6)+' '+bb_g+' '+kb.knb
       SKIP
    ENDDO
    SET RELATION TO
    USE
 ENDFOR
 ? REPLICATE('.', 50)
 ? ' '
 k = ADIR(r_m, 'dbfs\MAP*.dbf')
 FOR i = 1 TO k
    kod_r = SUBSTR('dbfs\'+r_m(k-i+1,1), 9, 3)
    ? ' '+kod_r+' Продаж МAX'
    USE 'dbfs\'+r_m(k-i+1,1)
    INDEX ON STR(mfo, 6)+bb_g TO ii UNIQUE
    SET RELATION TO STR(mfo, 6)+bb_g INTO kb
    DO WHILE  .NOT. EOF()
       ? '     '+STR(kurs_h, 9, 4)+'  '+STR(mfo, 6)+' '+bb_g+' '+kb.knb
       SKIP
    ENDDO
    SET RELATION TO
    USE
 ENDFOR
 ? REPLICATE('=', 60)
 FOR i = 1 TO 5
    ? ' '
 ENDFOR
 RUN DEL Dbfs\MIK*.dbf
 RUN DEL Dbfs\MAK*.dbf
 RUN DEL Dbfs\MIP*.dbf
 RUN DEL Dbfs\MAP*.dbf
 ERASE dbfs\F_VAL.dbf
 ERASE ii.idx
 ERASE i2.idx
 RETURN
*
*** 
*** ReFox - all is not lost 
***
