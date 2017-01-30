*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE itog_day
 SELECT baz
 INDEX ON kod_v TO ii UNIQUE FOR dat=day.dat
 COPY TO dbfs\F_Val FIELDS kod_v
 INDEX ON kod_v+STR(kurs_l, 9, 4) TO iii FOR dat=day.dat
 SELECT 0
 USE dbfs\F_Val.dbf ALIAS val
 INDEX ON kod_v TO i2
 SELECT val
 GOTO TOP
 DO WHILE  .NOT. EOF()
    SELECT baz
    SEEK val.kod_v
    IF FOUND()
       ims = 'dbfs\RR'+kod_v
       Copy to &ims For Kod_v=val.kod_v
    ENDIF
    SELECT val
    SKIP
 ENDDO
 SELECT val
 SET RELATION TO kod_v INTO kv
 GOTO TOP
 DO WHILE  .NOT. EOF()
    ? '  '+kod_v+' - '+kv.txt
    SKIP
 ENDDO
 USE
 ? ' '
 ? 'Дата: '+r_dat
 ? '==============================================================='
 ? 'КодI      Купўвля      I       Продаж      I   Середнў курси   '
 ? '===I=========I=========I=========I=========I=========I========='
 ? '   I   Min   I   Max   I   Min   I   Max   I Купўвля I Продаж  '
 ? '===I=========I=========I=========I=========I=========I========='
 k = ADIR(m_r, 'dbfs\RR*.dbf')
 FOR i = 1 TO k
    kod_r = SUBSTR('dbfs\'+m_r(i,1), 8, 3)
    USE 'dbfs\'+m_r(i,1)
    COUNT TO rab
    GOTO TOP
    SUM kurs_l, kurs_h TO k_sr, p_sr
    ku_sr = k_sr/rab
    pr_sr = p_sr/rab
    INDEX ON STR(kurs_l, 9, 4) TO dbfs\iii FOR dat=day.dat
    GOTO TOP
    ku_min = kurs_l
    GOTO BOTTOM
    ku_max = kurs_l
    INDEX ON STR(kurs_h, 9, 4) TO dbfs\iii FOR dat=day.dat
    GOTO TOP
    pr_min = kurs_h
    GOTO BOTTOM
    pr_max = kurs_h
    ? kod_r+' '+STR(ku_min, 9, 4)+' '+STR(ku_max, 9, 4)+' '+STR(pr_min, 9, 4)+' '+STR(pr_max, 9, 4)+' '+STR(ku_sr, 9, 4)+' '+STR(pr_sr, 9, 4)
    USE
 ENDFOR
 FOR i = 1 TO 5
    ? ' '
 ENDFOR
 RUN DEL Dbfs\RR*.dbf
 ERASE dbfs\F_Val.dbf
 ERASE ii.idx
 ERASE i2.idx
 RETURN
*
*** 
*** ReFox - all is not lost 
***
