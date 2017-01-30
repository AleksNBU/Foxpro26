*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 SET TALK OFF
 SET COLOR OF SCHEME 17 TO W+/B, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET CENTURY ON
 SET DELETED OFF
 SET DATE german
 CLOSE ALL
 er_rr = ' '
 ON ERROR do e_rr WITH ERROR()
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 NOCLOSE NOMINIMIZE NONE COLOR SCHEME 17
 DEFINE WINDOW beg FROM 5, 18 TO 10, 60 NOCLOSE TITLE ' Дати перевўрки Обм.пунктўв ' NOMINIMIZE COLOR SCHEME 10
 IF FILE('dbfs\temp.dbf')
    ERASE dbfs\temp.dbf
 ENDIF
 SELECT 0
 CREATE DBF dbfs\temp (ident C (7), dat_p D (10), san C (30), por C (01), del C (01), nn_del C (08), typ_ugod N (01), mfo N (06), bb_g C (04), nazva_agen C (60), edrpou C (12), adres_po C (60), prb C (01), knb C (27), adress C (50), per_por C (21), k01 N (01), k02 N (01), k03 N (01), k04 N (01), k05 N (01), k06 N (01), k07 N (01), k08 N (01), k09 N (01), k10 N (01), k11 N (01), k12 N (01), k13 N (01), k14 N (01), k15 N (01), k16 N (01), k17 N (01), k18 N (01), k19 N (01), k20 N (01), k21 N (01), k22 N (01), k23 N (01), k24 N (01), k25 N (01))
 USE
 SELECT 0
 USE SHARED dbfs\temp ALIAS tmp
 PUBLIC n_bnk, sm_p, sm_v, p_reestr, k_reestr
 PUBLIC r_mfo, r_bb_g, r_nazva, sh, vix, sch, r_iden
 PUBLIC m_m( 25)
 n_bnk = SPACE(35)
 sm_p = 0
 sm_v = 0
 sch = 25
 ACTIVATE WINDOW glob
 ACTIVATE WINDOW beg
 n_bank = SPACE(35)
 p_reestr = DATE()
 k_reestr = DATE()
 @ 1, 02 SAY 'Поч.дата перевўрки'
 @ 2, 03 GET p_reestr SIZE 1, 10
 @ 1, 21 SAY 'Кўн.дата перевўрки'
 @ 2, 22 GET k_reestr SIZE 1, 10
 READ
 p_ath_3 = p_ath3+'NAR'
 SELECT 0
 use &p_ath_3 SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 COPY TO dbfs\rab1 ALL FOR (p_reestr<=dat_p .AND. dat_p<=k_reestr)
 USE
 SELECT 0
 USE SHARED dbfs\rab1.dbf
 COUNT TO k_bo
 IF k_bo=0
    DEACTIVATE WINDOW beg
    DEACTIVATE WINDOW glob
    WAIT WINDOW TIMEOUT 2 'Даниих по перевўркам з '+DTOC(p_reestr)+' по '+DTOC(k_reestr)+' у БД нема !'
    USE
    RETURN
 ENDIF
 USE
 p_ath_3 = p_ath3+'S_NAR'
 SELECT 0
 use &p_ath_3 SHARED
 i = 0
 SCAN
    i = i+1
    m_m( i) = k_nar+' '+sod_nar
 ENDSCAN
 USE
 p_ath_3 = p_ath3+'P1'
 SELECT 0
 use &p_ath_3 SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 COPY TO dbfs\Rabp
 USE
 p_ath_d = p_ath3+'P1_DEL'
 SELECT 0
 use &p_ath_3 SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 USE
 SELECT 0
 USE SHARED dbfs\Rabp ALIAS rabp
 APPEND FROM (p_ath_d)
 INDEX ON ident TO dbfs\rabp_IND
 SELECT tmp
 APPEND FROM Dbfs\Rab1
 GOTO TOP
 SET RELATION TO ident INTO rabp
 REPLACE typ_ugod WITH rabp.typ_ugod, mfo WITH rabp.mfo, bb_g WITH rabp.bb_g, nazva_agen WITH rabp.nazva_agen, edrpou WITH rabp.edrpou, adres_po WITH rabp.adres_po, nn_del WITH rabp.nn_del ALL
 SET RELATION TO
 REPLACE del WITH '*' ALL FOR nn_del<>' '
 SELECT rabp
 USE
 SELECT 0
 SELECT 0
 USE SHARED dbfs\KB_TVBV.dbf ALIAS rab0
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\rab0_ind COMPACT
 SELECT tmp
 GOTO TOP
 SET RELATION TO STR(mfo, 6)+bb_g INTO rab0
 REPLACE prb WITH rab0.prb, knb WITH rab0.knb, adress WITH rab0.adress ALL
 SET RELATION TO
 SELECT rab0
 USE
 SELECT tmp
 GOTO TOP
 SCAN FOR por='*'
    z = ''
    FOR i = 17 TO sch+16
       fie = FIELD(i)
       im_p = IIF(fie='K25', 'K99', fie)
       Z=IIF(&FIE=1,Z+' '+Substr(IM_P,2,2),Z)
    ENDFOR
    REPLACE per_por WITH z
 ENDSCAN
 GOTO TOP
 DO variant WITH '   По Пунктам ?  ', vix, 8
 IF vix
    a1 = SUBSTR(DTOC(p_reestr), 1, 2)+SUBSTR(DTOC(p_reestr), 4, 2)+'PR_P'
    COPY TO Dbfs\Temp_F FIELDS ident, nazva_agen, del, por
    SELECT 0
    USE dbfs\Temp_f
    INDEX ON ident TO dbfs\tmf_ind UNIQUE
    DO f_punkt
    SELECT tmp
    INDEX ON prb+STR(mfo, 6)+STR(typ_ugod)+DTOS(dat_p) TO dbfs\tmp_ind FOR ident=r_iden
    fal1 = 'txt\'+a1+'.'+SUBSTR(ident, 1, 3)
 ELSE
    DO variant WITH '  ПО ВСЎМ БАНКАМ ?  ', vix, 5
    a1 = SUBSTR(DTOC(p_reestr), 1, 2)+SUBSTR(DTOC(p_reestr), 4, 2)+'PR_B'
    IF vix
       INDEX ON prb+STR(mfo, 6)+DTOC(dat_reestr, 1)+STR(typ_ugod) TO dbfs\tmp_ind
       fal1 = 'txt\'+a1+'.VSE'
    ELSE
       COPY TO Dbfs\Temp_F FIELDS mfo, bb_g, knb, por
       SELECT 0
       USE dbfs\Temp_f
       INDEX ON STR(mfo, 6) TO dbfs\tmf_ind UNIQUE
       DO f_bank
       SELECT tmp
       IF EMPTY(r_mfo)
          INDEX ON prb+STR(mfo, 6)+DTOC(dat_reestr, 1)+STR(typ_ugod) TO dbfs\tmp_ind
          fal1 = 'txt\'+a1+'.VSE'
       ELSE
          INDEX ON prb+STR(mfo, 6)+bb_g+DTOC(dat_reestr, 1)+STR(typ_ugod) TO dbfs\tmp_ind FOR mfo=r_mfo
          fal1 = 'txt\'+a1+'.'+SUBSTR(STR(mfo, 6), 4, 3)
       ENDIF
    ENDIF
 ENDIF
 GOTO TOP
 COUNT FOR por='*' TO sm_p
 GOTO TOP
 COUNT TO sm_v
 GOTO TOP
 SET FILTER TO por='*'
 REPORT FORMAT PER_POR.FRX TO FILE (fal1) NOCONSOLE
 WAIT WINDOW TIMEOUT 2 'Данў по перевўркам ОП в файлў '+fal1
 DEACTIVATE WINDOW beg
 DEACTIVATE WINDOW glob
 SET FILTER TO
 CLOSE ALL
 RELEASE n_bnk, sm_v, sm_p, p_reestr, k_reestr
 RELEASE WINDOW glob
 RELEASE WINDOW beg
 ERASE dbfs\rabp_ind.idx
 ERASE dbfs\rabd_ind.idx
 ERASE dbfs\tmp_ind.idx
 ERASE dbfs\tmf_ind.idx
 ERASE dbfs\rab0_ind.idx
 ERASE dbfs\rab0.dbf
 ERASE dbfs\rab_p.dbf
 ERASE dbfs\rab_d.dbf
 ERASE dbfs\rab1.dbf
 ERASE dbfs\temp_f.dbf
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
PROCEDURE f_bank
 DEFINE POPUP debb1 FROM 00, 20 TO 23, 59 PROMPT FIELDS ' '+STR(mfo, 6)+' '+bb_g+' '+PADR(knb, 27) TITLE ' МФО           Назва банку         ' MARK '' SCROLL COLOR SCHEME 8
 ON SELECTION POPUP debb1 DO VIBOR_POD WITH PROMPT()
 ACTIVATE POPUP debb1
 RETURN
*
PROCEDURE vibor_pod
 PARAMETER pole
 r_mfo = mfo
 DEACTIVATE POPUP debb1
 RETURN
*
PROCEDURE f_punkt
 DEFINE POPUP debb1 FROM 00, 10 TO 23, 69 PROMPT FIELDS ident+' '+PADR(nazva_agen, 47)+' '+del TITLE 'Код   Назва Пункту'+SPACE(31)+' Вид.' MARK '' SCROLL COLOR SCHEME 5
 ON SELECTION POPUP debb1 DO VIBOR_IDN WITH PROMPT()
 ACTIVATE POPUP debb1
 RETURN
*
PROCEDURE vibor_idn
 PARAMETER pole
 r_iden = ident
 DEACTIVATE POPUP debb1
 RETURN
*
FUNCTION variant
 PARAMETER text, vix, sh
 str = 17
 stl = 20
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
*** 
*** ReFox - all is not lost 
***
