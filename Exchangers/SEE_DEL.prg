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
 er_rr = ' '
 ON ERROR do e_rr WITH ERROR()
 p_ath_3 = p_ath3+'r'
 SELECT 0
 use &p_ath_3 alias reg SHARED
 SELECT 0
 USE SHARED DBFS\KB_TVBV ALIAS s
 INDEX ON STR(mfo, 6)+bb_g TO dbfs\s_ind COMPACT
 p_ath_3 = p_ath3+'p1_del'
 SELECT 0
 use &p_ath_3 alias W SHARED
 IF er_rr='*'
    QUIT
 ENDIF
 INDEX ON STR(mfo, 6)+bb_g+DTOC(dat_reestr) TO dbfs\w_ind COMPACT
 COPY TO dbfs\rab
 SELECT 0
 USE SHARED dbfs\rab.dbf ALIAS r
 INDEX ON STR(mfo, 6)+bb_g+DTOC(dat_reestr) TO dbfs\r_ind COMPACT
 COUNT TO nn
 IF nn=0
    WAIT WINDOW TIMEOUT 2 '�����祭�� � �������� ����� � ���� ���� ! '
    RETURN
 ENDIF
 SET RELATION TO STR(mfo, 6)+bb_g INTO s
 RECALL ALL
 DEFINE WINDOW s_tr FROM 0, 0 TO 2, 79 COLOR SCHEME 17
 DEFINE WINDOW glob FROM 0, 0 TO 24, 79 FLOAT FOOTER ' ����� - Esc ' DOUBLE COLOR SCHEME 8
 ACTIVATE WINDOW glob
 @ 22, 2 SAY '��� ����� ���������� ���� �� ���᭨�� ������� < F7 >'
 GOTO TOP
 DO c_bd
 RELEASE WINDOW glob
 RELEASE WINDOW s_tr
 CLOSE ALL
 ERASE DBFS\W_IND.IDX
 ERASE DBFS\S_IND.IDX
 ERASE DBFS\RAB.DBF
 ERASE DBFS\R_IND.IDX
 RELEASE WINDOW s_tr
 RETURN
*
PROCEDURE c_bd
 ON KEY LABEL F7 do poisk
 ACTIVATE WINDOW s_tr
 DEFINE WINDOW w_br FROM 3, 0 TO 22, 79 COLOR SCHEME 17
 BROWSE FIELDS ident :H = '��� ��' :R, nn_del :H = 'N �����.' :R, dat_del :H = '��� �����.', nn_reestr :H = '������.N' :R, dat_reestr :H = '��� �����' :R, mfo :H = '��� ����' :R, bb_g :H = '������' :R, nazva_agen :H = '����� ������' :R, edrpou :H = '��� 􄐏��' :R, adres_ag :H = '���� ������' :R, adres_po :H = '���� O�' :R, fio_k :H = '������� ����' :R, fio_nr :H = '������.N' :R, fio_dat :H = '��� ������.' :R, tel_po :H = '�����' :R :W = s_reg('TEL_PO'), beg_end :H = 'P����a' :R, rest_time :H = '���ࢠ' :R, festival_d :H = '���.���' :R, festival_y :H = 'C���' :R WINDOW w_br TITLE ' �����祭�� � �������� ������� �㭪� ' PARTITION 9 WHEN pokaz()
 ON KEY LABEL F7
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
 DEFINE WINDOW poshuk FROM 10, 27 TO 12, 64 FLOAT TITLE '������� ��� ��������� �㭪��' COLOR SCHEME 1
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
    WAIT WINDOW TIMEOUT 2 ' ���� ��������� �㭪�� < '+k_op+' > ����� '
    GOTO TOP
 ENDIF
 RETURN
*
PROCEDURE s_reg
 PARAMETER par
 rr = par
 DEFINE WINDOW br_reg FROM 09, 30 TO 21, 58 FLOAT TITLE ' ������ ' COLOR SCHEME 10
 SELECT reg
 GOTO TOP
 BROWSE FIELDS kod :H = '�����' :W = .F., reg :H = '������㢠���' :W = .F. WINDOW br_reg
 SELECT w
 RELEASE WINDOW br_reg
 rr = ''
 RETURN
*
*** 
*** ReFox - all is not lost 
***
