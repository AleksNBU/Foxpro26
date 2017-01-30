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
 DEFINE WINDOW beg FROM 5, 16 TO 10, 62 NOCLOSE NOMINIMIZE COLOR SCHEME 10
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
 PUBLIC p_edrpou, m_m( 25)
 n_bnk = SPACE(35)
 sm_p = 0
 sm_v = 0
 sch = 25
 ACTIVATE WINDOW glob
 ACTIVATE WINDOW beg
 n_bank = SPACE(35)
 p_reestr = DATE()
 k_reestr = DATE()
 p_edrpou = SPACE(12)
 @ 00, 03 SAY 'Поч.дата перевўрки'
 @ 01, 06 GET p_reestr SIZE 1, 10
 @ 00, 25 SAY 'Кўн.дата перевўрки'
 @ 01, 25 GET k_reestr SIZE 1, 10
 READ
 @ 2, 10 SAY 'Код ЇДРПОУ (до 12 цифр)'
 @ 3, 15 GET p_edrpou PICTURE '999999999999'
 READ
 IF p_edrpou=SPACE(12)
    DEACTIVATE WINDOW beg
    DEACTIVATE WINDOW glob
    WAIT WINDOW TIMEOUT 2 'Не введкно Код ЇДРПОУ. Розрахунки припинено ! '
    RETURN
 ENDIF
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
 COPY TO Dbfs\EDR_F ALL FOR (edrpou=p_edrpou)
 USE
 SELECT 0
 USE SHARED Dbfs\EDR_F ALIAS tmp_f
 COUNT TO k_bo
 IF k_bo=0
    DEACTIVATE WINDOW beg
    DEACTIVATE WINDOW glob
    WAIT WINDOW TIMEOUT 2 'Даних по Коду ЇДРПОУ='+p_edrpou+' за даний перўод у БД ОП Нема ! '
    USE
    RETURN
 ENDIF
 a1 = SUBSTR(p_edrpou, 1, 8)
 fal1 = 'txt\'+a1+'.POR'
 GOTO TOP
 COUNT FOR por='*' TO sm_p
 GOTO TOP
 COUNT TO sm_v
 GOTO TOP
 SET FILTER TO por='*'
 REPORT FORMAT POR_KOD.FRX TO FILE (fal1) NOCONSOLE
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
 ERASE dbfs\TMP_F.dbf
 ERASE dbfs\rab_1.dbf
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
*** 
*** ReFox - all is not lost 
***
