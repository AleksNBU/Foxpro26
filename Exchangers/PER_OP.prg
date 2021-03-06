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
 ON ERROR do e_rr WITH ERROR()
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 NOCLOSE NOMINIMIZE NONE COLOR SCHEME 17
 DEFINE WINDOW beg FROM 5, 18 TO 10, 48 NOCLOSE TITLE ' ��� ��५��� ���.�㭪��� ' NOMINIMIZE COLOR SCHEME 10
 IF FILE('dbfs\temp.dbf')
    ERASE dbfs\temp.dbf
 ENDIF
 SELECT 0
 CREATE DBF dbfs\temp (ident C (7), nn_reestr C (8), dat_reestr D (10), dat_del D (10), mfo N (6), bb_g C (4), typ_ugod N (1), nazva_agen C (60), adres_ag C (60), edrpou C (12), adres_po C (60), prb C (1), knb C (27), adress C (50))
 USE
 SELECT 0
 USE SHARED dbfs\temp ALIAS tmp
 PUBLIC n_bnk, sm_0, sm_0_1, sm_2, sm_0_1_2, p_reestr
 PUBLIC r_mfo, r_bb_g, r_nazva, sh, vix
 n_bnk = SPACE(35)
 sm_0 = 0
 sm_0_1 = 0
 sm_2 = 0
 sm_0_1_2 = 0
 er_rr = ' '
 ACTIVATE WINDOW glob
 ACTIVATE WINDOW beg
 n_bank = SPACE(35)
 p_reestr = DATE()
 @ 1, 05 SAY '��� ���⭮��� ��'
 @ 2, 10 GET p_reestr SIZE 1, 10
 READ
 p_ath_3 = p_ath3+'P1_DEL'
 SELECT 0
 use &p_ath_3 SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 COPY TO Dbfs\Rab0 FOR dat_del>=p_reestr
 USE
 p_ath_d = p_ath3+'P1'
 SELECT 0
 use &p_ath_D SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 USE
 SELECT 0
 USE dbfs\Rab0
 APPEND FROM (p_ath_d)
 COPY TO Dbfs\Rab1 FOR dat_reestr<p_reestr
 USE
 SELECT 0
 USE SHARED dbfs\rab1.dbf
 COUNT TO k_bo
 IF k_bo=0
    DEACTIVATE WINDOW beg
    DEACTIVATE WINDOW glob
    WAIT WINDOW TIMEOUT 2 '����� �� ��� '+DTOC(p_reestr)+', '+DTOC(k_reestr)+' ���� ! '
    USE
    RETURN
 ENDIF
 USE
 SELECT 0
 USE SHARED dbfs\KB_TVBV.dbf ALIAS rab
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\rab_ind COMPACT
 SELECT tmp
 APPEND FROM Dbfs\Rab1
 GOTO TOP
 SET RELATION TO STR(mfo, 6)+bb_g INTO rab
 REPLACE prb WITH rab.prb, knb WITH rab.knb, adress WITH rab.adress ALL
 SELECT rab
 USE
 a1 = SUBSTR(DTOC(p_reestr), 1, 2)+SUBSTR(DTOC(p_reestr), 4, 2)+SUBSTR(DTOC(p_reestr), 7, 2)+'OP'
 a2 = SUBSTR(DTOC(p_reestr), 1, 2)+SUBSTR(DTOC(p_reestr), 4, 2)+SUBSTR(DTOC(p_reestr), 7, 2)+'��'
 SELECT tmp
 DO variant WITH '  �� ���� ������ ?  ', vix, 5
 IF vix
    INDEX ON prb+STR(mfo, 6)+bb_g+DTOC(dat_reestr, 1)+STR(typ_ugod) TO dbfs\tmp_ind
    fal1 = 'txt\'+a1+'.VSE'
 ELSE
    COPY TO Dbfs\Temp_F FIELDS mfo, bb_g, knb
    SELECT 0
    USE dbfs\Temp_f
    INDEX ON STR(mfo, 6)+bb_g TO dbfs\tmf_ind UNIQUE
    DO f_bank
    SELECT tmp
    IF EMPTY(r_mfo)
       INDEX ON prb+STR(mfo, 6)+bb_g+DTOC(dat_reestr, 1)+STR(typ_ugod) TO dbfs\tmp_ind
       fal1 = 'txt\'+a1+'.VSE'
    ELSE
       INDEX ON prb+STR(mfo, 6)+bb_g+DTOC(dat_reestr, 1)+STR(typ_ugod) TO dbfs\tmp_ind FOR r_mfo=STR(mfo, 6)+bb_g
       fal1 = 'txt\'+a1+'.'+SUBSTR(STR(mfo, 6), 4, 3)
    ENDIF
 ENDIF
 GOTO TOP
 COUNT FOR typ_ugod=0 TO sm_0
 GOTO TOP
 COUNT FOR typ_ugod=0 .OR. typ_ugod=1 TO sm_0_1
 GOTO TOP
 COUNT FOR typ_ugod=2 TO sm_2
 GOTO TOP
 COUNT TO sm_0_1_2
 GOTO TOP
 REPORT FORMAT PER_OP.FRX TO FILE (fal1) NOCONSOLE
 SET FILTER TO typ_ugod=0
 WAIT WINDOW TIMEOUT 2 '���� �� ��५��� �� � 䠩��� '+fal1
 DEACTIVATE WINDOW beg
 DEACTIVATE WINDOW glob
 CLOSE ALL
 RELEASE n_bnk, sm_0, sm_0_1, sm_2, sm_0_1_2, p_reestr, k_reestr
 RELEASE WINDOW glob
 RELEASE WINDOW beg
 ERASE dbfs\rab_ind.idx
 ERASE dbfs\tmp_ind.idx
 ERASE dbfs\tmf_ind.idx
 SET DELETED ON
 RETURN
*
FUNCTION n_bank
 PARAMETER prb_b
 DO CASE
    CASE prb_b='2'
       RETURN '����� �������������               '
    CASE prb_b='3'
       RETURN '������쪥 ������� ॣ�����쭥 �ࠢ����� �஬�����⡠���'
    CASE prb_b='4'
       RETURN '������쪠 ����᭠ ��४��� ��ய஬�����'
    CASE prb_b='5'
       RETURN '������쪠 ����᭠ ��४��� �����桠���'
    CASE prb_b='6'
       RETURN '���������� �頤�����              '
    CASE prb_b>'6'
       RETURN '���������� �����'
 ENDCASE
*
PROCEDURE f_bank
 DEFINE POPUP debb1 FROM 00, 20 TO 23, 59 PROMPT FIELDS ' '+STR(mfo, 6)+' '+bb_g+' '+PADR(knb, 27) TITLE ' ���   ������      ����� �����         ' MARK '' SCROLL COLOR SCHEME 8
 ON SELECTION POPUP debb1 DO VIBOR_POD WITH PROMPT()
 ACTIVATE POPUP debb1
 RETURN
*
PROCEDURE vibor_pod
 PARAMETER pole
 r_mfo = STR(mfo, 6)+bb_g
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
 @ 2, 4 GET vibor DEFAULT 1 SIZE 1, 7, 5 PICTURE '@*HT  ��� ; �� ' VALID konec()
 IF  .NOT. WVISIBLE('y_n')
    ACTIVATE WINDOW y_n
 ENDIF
 READ CYCLE
 RELEASE WINDOW y_n
 RETURN vix
*
FUNCTION konec
 IF ALLTRIM(vibor)='���'
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
