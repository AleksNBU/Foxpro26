*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET TALK OFF
 SET DATE german
 CLOSE ALL
 CLOSE DATABASES
 SET COLOR TO W/B
 SET SAFETY OFF
 SET COLOR TO W+/B
 SET COLOR OF SCHEME 17 TO W+/BG, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 18 TO W+/BG, GR+/B, GR+/W, GR+/W, N+/W, GR+/R, W+/B, N+/N, GR+/W, N+/W
 SET COLOR OF SCHEME 20 TO N/BG, N/BG, N/BG, N/BG, W+/BG, W+/B, W+/BG, N/BG, N/BG
 PUBLIC sim_in, sim_out, krit
 STORE '������񦧨�������������������������' TO sim_in
 STORE '�����������������������������������' TO sim_out
 krit = ' '
 prizn = 0
 v_bd = 'R'
 ON ERROR do e_rr WITH ERROR()
 p_ath_3 = p_ath3+'r'
 SELECT 0
 use &p_ath_3 alias reg SHARED
 p_ath_3 = p_ath3+'s_ohr'
 SELECT 0
 use &p_ath_3 alias ohr SHARED
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS s
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 p_ath_3 = p_ath3+'p1'
 SELECT 0
 use &p_ath_3 alias We EXCLUSIVE   
 IF er_rr='*'
    QUIT
 ENDIF
 rr = ''
 COUNT TO nn
 IF nn=0
    WAIT WINDOW TIMEOUT 2 '����� � ���� ���� ! '
    RETURN
 ENDIF
 GOTO TOP
 INDEX ON STR(mfo, 6)+bb_g+DTOC(dat_reestr) TO dbfs\ind COMPACT
 SET RELATION TO STR(mfo, 6)+bb_g INTO s
 DEFINE WINDOW s_tr FROM 0, 0 TO 2, 79 COLOR SCHEME 17
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 FLOAT FOOTER ' ����� - CTRL+W ' DOUBLE COLOR SCHEME 8
 ACTIVATE WINDOW glob
 @ 20, 2 SAY '��� ����� ���������� ���� �� ������� ������� < F7 >'
 @ 21, 2 SAY '��� ����� ������� ���� �� ������� ������� < F8 >'
 @ 22, 2 SAY '��� ���ࠢ����� ����� ������ � ������� ������� ������� < F9 >'
 DO c_bd
 RELEASE WINDOW glob
 SET FILTER TO
 CLOSE ALL
 IF prizn=1
    DO arh_bd WITH v_bd
 ENDIF
 ERASE DBFS\IND.IDX
 ERASE DBFS\S_IND.IDX
 RELEASE WINDOW s_tr
 RETURN
*
PROCEDURE c_bd
 ON KEY LABEL F7 do poisk
 ON KEY LABEL F8 do poisk_f
 ON KEY LABEL F9 do ZAM
 ACTIVATE WINDOW s_tr
 DEFINE WINDOW w_br FROM 3, 0 TO 20, 79 COLOR SCHEME 17
 BROWSE FIELDS ident :H = '��� ��' :R, nn_reestr :H = '������.N' :R :W = kont1(), dat_reestr :H = '��� �����' :R :W = kont1(), mfo :H = '��� ����' :V = who(), bb_g :H = '������' :V = who(), nazva_agen :H = '����� ������' :V = who(), edrpou :H = '��� 􄐏��' :V = who(), adres_ag :H = '���� ������' :V = who(), typ_ugod :H = 'T�� 㣮��' :V = who(), ind_po :H = '���' :W = s_reg('IND_PO'), adres_po :H = '���� O�' :V = who(), fio_k :H = '������� ����' :V = who(), fio_nr :H = '������.N' :V = who(), fio_dat :H = '��� ������.' :V = who(), tel_po :H = '�����' :W = s_reg('TEL_PO'), beg_end :H = 'P����a' :V = who(), rest_time :H = '���ࢠ 1' :V = who(), rest_time2 :H = '���ࢠ 2' :V = who(), rest_time3 :H = '���ࢠ 3' :V = who(), festival_d :H = '���.���' :V = who(), festival_y :H = 'C���' :V = who(), po_system :H = '�KKA' :V = who(), kassa :H = '���.���' :V = who(), mfo_zb :H = '���.��' :V = who(), bb_zb :H = '������' :V = who(), mfo_zb_v :H = '��� �.���' :V = who(), bb_zb_v :H = '������' :V = who(), vid_zber :H = '��� ���' :V = who(), kod1 :H = '��� 1 ����' :W = s_ment('KOD1'), kod2 :H = '��� 2 ����' :W = s_ment('KOD2'), kod3 :H = '��� 3 ����' :W = s_ment('KOD3'), nn_del :H = 'N �����.' :R :W = kont1(), dat_del :H = '��� �����.' :R :W = kont1() WINDOW w_br TITLE ' ��ॣ㢠��� ���� ����� ' PARTITION 9 WHEN pokaz()
 ON KEY LABEL F7
 ON KEY LABEL F8
 ON KEY LABEL F9
 RELEASE WINDOW w_br
 DEACTIVATE WINDOW s_tr
 RETURN
*
PROCEDURE pokaz
 @ 0, 1 SAY '���='
 @ 0, 6 SAY STR(mfo, 6) COLOR W+/B 
 @ 0, 13 SAY '���.�-��='
 @ 0, 23 SAY s.bb_g COLOR W+/B 
 @ 0, 28 SAY '��.������='
 @ 0, 38 SAY s.ncks COLOR W+/B 
 @ 0, 43 SAY '����-'
 @ 0, 48 SAY s.knb COLOR W+/B 
 RETURN
*
PROCEDURE poisk
 DEFINE WINDOW poshuk FROM 11, 27 TO 13, 64 FLOAT TITLE '������� ��� ��������� �㭪��' COLOR SCHEME 1
 ACTIVATE WINDOW poshuk
 k_op = '       '
 @ 0, 13 GET k_op PICTURE '9999999' COLOR ,W+/G 
 READ
 RELEASE WINDOW poshuk
 IF LASTKEY()=27
    RETURN
 ENDIF
 LOCATE FOR ALLTRIM(ident)=k_op
 IF  .NOT. FOUND()
    WAIT WINDOW TIMEOUT 2 ' ���a ��������� �㭪�� < '+k_op+' > ����� '
    GOTO TOP
 ENDIF
 RETURN
*
PROCEDURE poisk_f
 DEFINE WINDOW poshuk_f FROM 12, 15 TO 14, 64 FLOAT TITLE ' ������� ⥪�� ��� ���㪠 ������� ������ ' COLOR SCHEME 1
 ACTIVATE WINDOW poshuk_f
 slovo = SPACE(20)
 @ 0, 13 GET slovo VALID  .NOT. EMPTY(slovo) ERROR ' ����� ��� ���㪠 �� �������! ���ࠢ�� ! '
 READ
 IF LASTKEY()=13
    krit = ALLTRIM(slovo)
 ENDIF
 RELEASE WINDOW poshuk_f
 SET FILTER TO CHRTRAN(krit, sim_in, sim_out)$CHRTRAN(fio_k, sim_in, sim_out)=.T.
 COUNT TO sct
 IF sct=0
    WAIT WINDOW TIMEOUT 1 ' ������ ������� <'+ALLTRIM(slovo)+'> ����� ! '
    SET FILTER TO
    GOTO TOP
 ENDIF
 GOTO TOP
 RETURN
*
PROCEDURE s_reg
 PARAMETER par
 rr = par
 DEFINE WINDOW br_reg FROM 09, 30 TO 21, 58 FLOAT TITLE ' ������ ' COLOR SCHEME 10
 SELECT reg
 GOTO TOP
 BROWSE FIELDS kod :H = '�����' :W = .F., reg :H = '������㢠���' :W = .F. WINDOW br_reg
 SELECT we
 RELEASE WINDOW br_reg
 rr = ''
 RETURN
*
PROCEDURE s_ment
 PARAMETER par
 rr = par
 DEFINE WINDOW br_reg FROM 09, 20 TO 21, 68 FLOAT TITLE ' �x�஭� ' COLOR SCHEME 10
 SELECT ohr
 GOTO TOP
 BROWSE FIELDS kod :H = '���' :W = .F., nam :H = '      ������㢠���' :W = .F. WINDOW br_reg
 SELECT we
 RELEASE WINDOW br_reg
 rr = ''
 RETURN
*
PROCEDURE zam
 SELECT we
 DO CASE
    CASE rr='IND_PO'
       REPLACE we.ind_po WITH reg.kod
    CASE rr='TEL_PO'
       REPLACE we.tel_po WITH reg.kod
    CASE rr='KOD1'
       REPLACE we.kod1 WITH ohr.kod
    CASE rr='KOD2'
       REPLACE we.kod2 WITH ohr.kod
    CASE rr='KOD3'
       REPLACE we.kod3 WITH ohr.kod
 ENDCASE
 REPLACE we.dat WITH DATE()
 REPLACE we.time WITH TIME()
 REPLACE we.a_fio WITH _fio
 prizn = 1
 RETURN
*
PROCEDURE who
 REPLACE we.dat WITH DATE()
 REPLACE we.time WITH TIME()
 REPLACE we.a_fio WITH _fio
 prizn = 1
 RETURN
*
PROCEDURE kont1
 WAIT WINDOW NOWAIT ' ���� �� ��ॣ������ '
 RETURN
*
*** 
*** ReFox - all is not lost 
***
