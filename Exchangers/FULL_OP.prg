*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 SET TALK OFF
 SET CENTURY ON
 SET DATE german
 CLOSE ALL
 DEFINE WINDOW beg FROM 5, 20 TO 10, 50 NOCLOSE TITLE ' ��ॢ�ઠ ������ ' NOMINIMIZE COLOR SCHEME 10
 PUBLIC p_reestr, r_ident
 ACTIVATE WINDOW beg
 p_reestr = DATE()
 @ 1, 02 SAY ' ������ ���� ���⭮��� '
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
    WAIT WINDOW TIMEOUT 2 '����� �� ������ ���� � 䠩�� KURS.DBF ���� !'
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
    WAIT WINDOW TIMEOUT 2 '���ଠ��� �� ������� ����.����� � 䠩�� '+fal1
 ELSE
    WAIT WINDOW TIMEOUT 2 ' ����� ���ଠ��� �� �������� ����� �� ���� ����� '
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
*** 
*** ReFox - all is not lost 
***
