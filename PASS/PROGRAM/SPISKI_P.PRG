************
*PROC spiski
*************
*** Modern ���     19, 1999
*** Modern ���     22, 1999
*** Modern ���     25, 1999
*** Modern ����    29, 1999
*** Correc ������  10, 1999.
*** Modern ������  21, 1999. �⪠� �� ��室���
*** Modern �����  22, 1999.
*** Modern ������� 22, 1999.
***
*** Modern ���     26, 2003. ���� -�� ���� ������- ����� N_zona
****
*** Modern �����   27, 2006.  �६� ��室� ����� 9 �� �� 8 ��
************************************
SET ESCA OFF
************************************
LA=0 && ��᪠ �� LASTKEY()
De=0 && ��᪠ 
EX_R=0  && ex_r=1 -> ���� ����  
DEFINE WINDOW s_tr  FROM 00,00 TO 09,79 ;
   TITLE ' ����� �� ������ ���������� ������� ';   
   COLOR SCHEME  05  
DEFINE WINDOW smotr  FROM 00,00 TO 09,79 ;
   TITLE ' ����� �� ������ ���������� ������� ';   
   COLOR SCHEME  05  
DEFINE WINDOW w_br  FROM 08,00 TO 20,79 ;
   COLOR SCHEME  17
DEFINE WINDOW OKNO1 FROM 21,00 TO 24,79 ;
   FLOAT COLOR SCHEME 05 
DEFINE WINDOW INFO FROM 16,00 TO 24,79 ;
   FLOAT COLOR SCHEME 05 ; 
   TITLE ' �ਧ��祭�� ������ F3-F9 ';   
  FOOTER ' ��� ��室� ������� ���-�� ������� ! '
sele 0
if file('dbfs\tmp_s.dbf')
   erase dbfs\tmp_s.dbf
endif
create table Dbfs\TMP_S (dat_T d(10),;   
   F_TIME  c(05),;
   FIO     c(20),;
   NAM     c(20),;
   OTH     c(20),;
   DAT_Z   d(10),;
   B_TIME  c(04),;
   K_TIME  c(04),;
   KKOMY   c(25),;
   OTKUDA  c(40),;
   OTDEL   c(75),;
   FIO_OTD c(20),;
   NN_T    n(03),;
   DEL     n(01))
use
sele 0
*------
use Dbfs\TMP_S alias tms EXCLUSIVE
***********************
select SPI
*------
count to SP
go top
IF SP=0 && sp<>0 - �� 1-� ���饭��
  DO CH_R_P &&  ���⪠ ���� ࠡ��� �����
  ACTIV WIND s_tr 
  DO F_SHAP && ��ࢮ� �ନ஢���� ���.�����
 * IF EX_R=1.or.LastKey()=27 && EX_R=1 -> ���� ����  
  IF EX_R=1.or.La=27 && EX_R=1 -> ���� ����  
     RELEASE WINDOW S_tr
     RELEASE WINDOW smotr
     RELEASE WINDOW OKNO1
     RELEASE WINDOW w_br
     RELEASE WINDOW INFO
     RETURN
  ENDIF
  DEACTIV WIND s_tr
  APPEND BLANK  
  DO F_O_POLE  && ���������� ���.����� ����� 䠩�� SPISOK 
 ELSE
  DO Z_V_SHAP && ��९��� ���.����� �� ����� � ࠡ.�祩��
 ENDIF
**********
IF EX_R=0 && EX_R=1 -> ���� ����  
  DO C_BD && ����� � BROWS �� 䠩�� SPISOK 
ENDIF
******
RELEASE WINDOW S_tr
RELEASE WINDOW smotr
RELEASE WINDOW OKNO1
RELEASE WINDOW w_br
RELEASE WINDOW INFO
*
SET ESCA ON
ON KEY LABEL F1
ON KEY LABEL F3
ON KEY LABEL F4
ON KEY LABEL F5
ON KEY LABEL F6
ON KEY LABEL F7
ON KEY LABEL F8
ON KEY LABEL F9
sele tms
USE
ERASE DBFS\TMP_S.DBF
******
RETURN
**********************************************
* � � � � � � � � �
**********************************************
FUNCTION CH_R_P && ���⪠ ���� ࠡ��� �����
****************
* ���⪠ ���� ࠡ��� �����
R_TIME=SUBSTR(TIME(),1,5)
R_DAT_Z1=DATE()
R_DAT_Z2=DATE()
R_KKOMY=SPACE(25)
R_TN1='  '
R_TN2='00'
R_TK1='  '
R_TK2='00'
R_OTKUDA=SPACE(40)
******
RETURN
**************************************
* �ନ஢���� ���.�����
FUNCTION F_SHAP  
**************
 RR=0 && �� �ࠢ��쭮 (���.���祭��)
 @ 00,20 SAY "���筠 ���: "+DTOC(DATE())
 @ 01,01 SAY "����.��� : "
 @ 01,15 GET R_DAT_Z1 SIZE 1,10 ;
         VALID KONT_1()
 @ 01,30 SAY "���楢� ��� : "
 @ 01,45 GET R_DAT_Z2 SIZE 1,10 ;
         VALID KONT_2() 
 @ 02,01 SAY "��� �� ��९���� ���᭠"
 @ 03,01 SAY " � "
 @ 03,05 GET R_TN1 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '08','18'
 @ 03,08 SAY "���." 
 @ 03,13 GET R_TN2 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '00','60'
 @ 03,16 SAY "墨�."
 @ 03,22 SAY " ��"
 @ 03,26 GET R_TK1 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '08','18' ;
    VALID  R_TN1<=R_TK1;
    ERROR '��砫�.������ <'+R_TN1+'> ����� ���楢�� <'+;
           R_TK1+'>. �������� ������� !'
 @ 03,29 SAY "���."
 @ 03,34 GET R_TK2 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '00','60' ;
    VALID KONT_T()
 @ 03,37 SAY "墨�." 
 @ 04,01 SAY "�� ���� ������:"
 @ 04,17 GET R_KKOMY SIZE 1,25 ;
    VALID  R_KKOMY<>' ';
   ERROR  " �� ��������� ���� <�� ���� ������>. �������� ������� ! "
 @ 05,01 SAY "������ ������: "
 @ 05,17 GET R_OTKUDA SIZE 1,40 ;
   VALID  R_OTKUDA<>' ';
   ERROR  " �� ��������� ���� <������ ������>. �������� ������� ! "

 @ 07,03 GET vih1;
     PICTURE "@*HN �த����� ஡���" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID val_vih()
@ 07,38 GET vih1;
     PICTURE "@*HN �����" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID ex_vih() && EX_R=1 �ନ����� �����
 READ CYCLE
 ******
LA=LastKey()
IF EX_R=1.or.LA=27 && ��室 ��� �ନ஢����
   IF !FILE('Dbfs\TMP_S.DBF')
      sele TMS
      use && TMS
   ENDIF
   RETURN
ENDIF
******
RETURN 
*************************
FUNCTION KONT_1     &&  ����஫� ���.����
 IF R_DAT_Z1< DATE() 
    WAIT '����.��� <'+DTOC(DATE())+'> ����� ���⪮��� <'+;
        DTOC(R_DAT_Z1)+'>.�������� !' WINDOW nowait
    =inkey(1)
    Wait Clear 
    _CUROBJ = OBJNUM(R_DAT_Z1)
 ENDIF
 ******
RETURN
*************************
FUNCTION KONT_2    &&  ����஫� ����.����
 IF R_DAT_Z2 < DATE().or.R_DAT_Z2 < R_DAT_Z1 
    WAIT '����ୠ ����.��� -> '+DTOC(R_DAT_Z2)+' .�������� !' WINDOW nowait
    =inkey(1)
    Wait Clear 
    _CUROBJ = OBJNUM(R_DAT_Z2)
 ENDIF
 ******
RETURN
*************************
FUNCTION KONT_t     &&  ����஫� �ᮢ-�����
 IF R_TN1=R_TK1.and.R_TN2>=R_TK2
    WAIT '���.�� <'+R_TN1+'-'+R_TN2+'> ����� ���楢��� <'+R_TK1+'-'+R_TK2+'>. �������� ������� !' WINDOW nowait
    =inkey(1)
    Wait Clear 
     _CUROBJ = OBJNUM(R_TK1)
 ENDIF
 ******
RETURN
*************************
FUNCTION val_vih     &&  vihod VALID
CLEAR READ
******
RETURN
**************************
FUNCTION ex_vih     &&  EXIT
CLEAR READ
EX_R=1 && ��室 ��� �ନ஢����
******
RETURN
**************************
FUNCTION F_O_POLE && ���������� ���.����� ����� 䠩�� SPISOK 
**************************
  REPLACE  DAT_T      WITH DAT_R
  REPLACE  F_TIME     WITH R_TIME
  REPLACE  DAT_Z1      WITH R_DAT_Z1
  REPLACE  DAT_Z2      WITH R_DAT_Z2
  REPLACE  B_TIME     WITH R_TN1+R_TN2
  REPLACE  K_TIME     WITH R_TK1+R_TK2
  REPLACE  OTKUDA     WITH R_OTKUDA
  REPLACE  KKOMY       WITH R_KKOMY
  REPLACE  NN_T       WITH SHT.NN_T
******
RETURN
**************************************
* ��९��� ���.����� �� ����� � ࠡ.�祩��
FUNCTION Z_V_SHAP  
******
R_DAT_Z1=DAT_Z1
R_DAT_Z2=DAT_Z2
R_TN1=SUBSTR(B_TIME,1,2)
R_TN2=SUBSTR(B_TIME,3,2)
R_TK1=SUBSTR(K_TIME,1,2)
R_TK2=SUBSTR(K_TIME,3,2)
R_KKOMY=KKOMY
R_OTKUDA=OTKUDA
******
RETURN
**********************************************
PROC C_BD && ����� � BROWS �� 䠩�� SPISOK 
********
ON KEY LABEL F1 DO V_INFO && �맮� �ࠢ�� �� F3-F9
ON KEY LABEL F3 do DEL_V  && ��᫠�� � �� ��� �� ���㫨஢���� ᯨ᪠
ON KEY LABEL F4 do COR_K  && ����४�஢��� ��騥 ���� ��� ᯨ᪠
ON KEY LABEL F5 do ADD_K  && �������� ������ ��� ������ ������
ON KEY LABEL F6 do DEL_K  && ������� ������ ������ � ᯨ᪠
ON KEY LABEL F7 do SOHRAN && ��室 (�����⪠ ���㦭.����ᥩ) �� ᫥�.ࠧ�
ON KEY LABEL F8 do OTKAZ && ��㫨஢��� ���
ON KEY LABEL F9 do F_MAIL && ����� ��� 䠩�� ��ନ஢���-��ࠢ���
ACTIVATE WINDOW OKNO1
@ 00,03 SAY '� � � � � ! ���� ����� ������� ��������� ������ ��.< ENTER > ';
       color w+/r
@ 01,03 SAY '����⪮�� ���ଠ��� ஡�� �� ᯨ᮪�� - K����� < F1 > '
*       color w+/r
*------------
ACTIV WIND smotr
DO POKAZ
DO WHILE .T. 
*-------------
 * EX_R ����� �ᯮ������ ��� �ਧ��� ��室� �� 横��
 * ��᫥ ०��� ���.�ନ஢���� ���.�����, ��� � �� �� ��㣮� 
 * ����� 
 EX_R=0 && ��᢮���� ०��� ��ࢭ��.�室� � 横� 
 *======================
 BROW  TITLE ' ���᮪ ������㢠祢 ' FIELDS ;
     FIO:H='       �������' :24, ;
     NAM:H="         ��'�" :24,;
     OTH:H='      �� ���쪮��':24;
     WINDOW w_br 
 *======================
 IF EX_R=0 && �� �ࠢ��쭮 -��室 �� 横�� DO WHILE and (EX_R=0) 
    EXIT
 ENDIF
*---------
ENDDO
*---------
DEACTIV WIND smotr
DEACTIV WIND INFO
ON KEY LABEL F1
ON KEY LABEL F3
ON KEY LABEL F4
ON KEY LABEL F5
ON KEY LABEL F6
ON KEY LABEL F7
ON KEY LABEL F8
ON KEY LABEL F9
******
RETURN
**************************
FUNCTION pokaz && �१ Brows �।������� ���������� ������ �� ������� 
**************************
 @ 00,15 SAY "���筠 ���: "  &&+DTOC(DATE())
 @ 00,29 SAY DTOC(DATE()) COLOR w+/g
 @ 01,01 SAY "����.��� : "
 @ 01,15 SAY R_DAT_Z1 COLOR w+/g
 @ 01,30 SAY "���楢� ��� : "
 @ 01,45 SAY R_DAT_Z2 COLOR w+/g
*
 @ 02,01 SAY "��� �� ��९���� ���᭠"
 @ 03,01 SAY " � "
 @ 03,05 SAY R_TN1 COLOR w+/g
 @ 03,08 SAY "���." 
 @ 03,13 SAY R_TN2 COLOR w+/g
 @ 03,16 SAY "墨�." 
 @ 03,22 SAY " ��"
 @ 03,26 SAY R_TK1 COLOR w+/g
 @ 03,29 SAY "���."
 @ 03,34 SAY R_TK2 COLOR w+/g
 @ 03,37 SAY "墨�."
 @ 04,01 SAY "�� ���� ������:"
 @ 04,17 SAY R_KKOMY COLOR w+/g
 @ 05,01 SAY "������ ������: "
 @ 05,17 SAY R_OTKUDA COLOR w+/g
************
RETURN
**************************
PROC V_INFO && �맮� ���ଠ�.���� F3-F9
*******
ON KEY LABEL F1 CLEAR READ
ON KEY LABEL F3 CLEAR READ
ON KEY LABEL F4 CLEAR READ
ON KEY LABEL F5 CLEAR READ
ON KEY LABEL F6 CLEAR READ
ON KEY LABEL F7 CLEAR READ
ON KEY LABEL F8 CLEAR READ
ON KEY LABEL F9 CLEAR READ
ACTIV WIND INFO
@ 00,02 SAY '��� � ��� ��९��⮪ �� ������ ᯨ᪠      - K����� < F3 > '
@ 01,02 SAY '���ਣ㢠� ������� ���� ��� ���᪠               - K����� < F4 > '
@ 02,02 SAY '������� ������ ������ � ���᮪                   - K����� < F5 > '
@ 03,02 SAY '������� ������ ������ � ���᪠                   - K����� < F6 >'
@ 04,02 SAY '���ॣ�  ���ଠ��� � ������� ஡��� � ���᪮�  - K����� < F7 >'
@ 05,02 SAY '���� ���� ���᪠ � ������� ஡��� � ���᪮� - K����� < F8 >'
@ 06,02 SAY '����ࠢ�� ���᮪ � ������� ஡��� � ���᪮�     - K����� < F9 >'
READ
DEACTIV WIND INFO
ON KEY LABEL F1 DO V_INFO && �맮� �ࠢ�� �� F3-F9
ON KEY LABEL F3 do DEL_V  && ��᫠�� � �� ��� �� ���㫨஢���� ᯨ᪠
ON KEY LABEL F4 do COR_K  && ����४�஢��� ��騥 ���� ��� ᯨ᪠
ON KEY LABEL F5 do ADD_K  && �������� ������ ��� ������ ������
ON KEY LABEL F6 do DEL_K  && ������� ������ ������ � ᯨ᪠
ON KEY LABEL F7 do SOHRAN && ��室 (�����⪠ ���㦭.����ᥩ) �� ᫥�.ࠧ�
ON KEY LABEL F8 do OTKAZ && ��㫨஢��� ���
ON KEY LABEL F9 do F_MAIL && ����� ��� 䠩�� ��ନ஢���-��ࠢ���
*******
return
**************************      
PROC DEL_V && ��᫠�� � �� ��� �� ���㫨஢���� ᯨ᪠ 
**************************
R_DEL=1
do F_MAIL
******
RETURN
**************************      
PROC COR_K  && ����४�஢��� ��騥 ���� ��� ᯨ᪠ - F4
**************************
EX_R=0 && ���⪠ 
DEACTIV WIND smotr
ACTIV WIND s_tr
DO F_SHAP && �ନ஢���� ���.�����
Sele SPI 
go top
IF EX_R=1.or.LA=27 && ��室- ��=1-�⪠� �� ।���஢����
    DO  Z_V_SHAP && ��९��� ���.����� �� ����� � ࠡ.�祩��
  ELSE
   GO TOP
   Do while !EOF()
     DO F_O_POLE  && ���������� ���.����� ����� 䠩�� SPI      
     skip
   ENDDO         
ENDIF
Go top
DEACTIV WIND s_tr
ACTIV WIND smotr
DO POKAZ
EX_R=1 && ���࠭���� ०��� ࠡ��� � 横�� � BROW
******
RETURN
**************************      
PROC ADD_K && �������� ������ ��� ������ ������ - F5
**************************
*pack
COUNT TO SP
go top
IF SP=0.and.(R_TN1<>' '.or.R_TN2<>' ')  && ������� ������ � �⠫� ����� ��
  APPEND BLANK  
  DO F_O_POLE  && ���������� ���.����� ����� 䠩�� SPISOK 
ELSE
 DO Z_V_SHAP && ��९��� ���.����� �� ����� � ࠡ.�祩��
 IF FIO=' '
    WAIT " �� ��������� �������. �������� ������� ! " WINDOW NOWAIT 
    =Inkey(1)
    Wait Clear
    EX_R=1 && ����୮ !
    RETURN 
  ENDIF
 APPEND BLANK  
 DO F_O_POLE  && ���������� ���.����� ����� 䠩�� SPISOK 
ENDIF
******
RETURN
**************************      
PROC DEL_K && ������� ������ �� ������� - F6
**************************
 vix=.F.
 DO VARIANT WITH '������� ����� ?',vix,8   && �������� �����
 IF vix && �������� �����
    WAIT " ���� �� ������� <"+ALLTRIM(FIO)+"> �������� � ��� ! " WINDOW NOWAIT
    =Inkey(1)
    Wait Clear
    DELETE
 ENDIF 
 ******
RETURN
**************************
PROC SOHRAN && ��室 (�����⪠ ���㦭.����ᥩ) �� ᫥�.ࠧ� - F7
**************************
 IF R_DAT_Z1< DAT_R.or.R_DAT_Z2< DAT_R
    WAIT '����.��� > �����.��� ������� ' ;
        +'.��������� ��ॣ㠭�� ����� (��. F4) !' WINDOW nowait
    =Inkey(3)
    Wait Clear
    EX_R=1 && ����୮!
    RETURN
 ENDIF
  *****
 DO F_O_POLE  && ���������� ���.����� ����� 䠩�� SPISOK 
 ******
 IF FIO=' '
    WAIT " �� ��������� �������. �������� ������� ! " WINDOW NOWAIT 
    =Inkey(1)
    Wait Clear
    EX_R=1 && ����୮!
    RETURN 
 ENDIF
 GO top
 DO While !EOF() && �������� ����ᥩ � ���� FIO
   IF ALLTRIM(FIO)=' '
     Delete
   ENDIF 
   skip
 ENDDO
 PACK && �����⪠ 䠩�� SPISOK �� 㤠������ ����ᥩ
 ***** �����६���� �ᯮ������ ��� ������� BROWs 
 EX_R=0 && �� �ࠢ��쭮! ��室 �� 横�� � Brows 
********
RETURN
*************************
PROC OTKAZ && ���� ���� ��� � ������� ஡��� - F8
**********
 De=0 && ��᪠ 
 vix=.F.
 DO VARIANT WITH '���� ������ ?',vix,8   && �������� ����-������
 IF vix && �������� ������
  WAIT " ������ ��������� !! ! " WINDOW NOWAIT 
  =Inkey(1)
  Wait Clear
  DE=1 && De=1 -> ���� ᯨ᮪ � ᮮ�.䠩� ���᪠ (� ��.�ணࠬ��)
  EX_R=0 && �� �ࠢ��쭮! ��室 �� 横�� � Brows 
  PACK && �ᥢ�����⪠ ��� ������� BROWs 
 ENDIF
******
RETURN
**************************
PROC F_MAIL && ����� ��� 䠩�� ��ନ஢���-��ࠢ��� - F9
**************************
* sele SPI
 IF R_DAT_Z1< DAT_R.or.R_DAT_Z2< DAT_R
   WAIT '����.��� > �����.��� ������� ' ;
       +'.��������� ��ॣ㠭�� ����� (��. F4) !' WINDOW nowait
   =Inkey(3)
   Wait Clear
   EX_R=1 && ����୮!
   RETURN
ENDIF
 *****
DO F_O_POLE  && ���������� ���.����� ����� 䠩�� SPISOK 
******
IF FIO=' '
   WAIT " �� ��������� �������. �������� ������� ! " WINDOW NOWAIT
   =Inkey(1)
   Wait Clear
   EX_R=1 && ����୮ !
   RETURN 
 ENDIF
IF R_DEL=1
  WAIT " ������ �� ������ ������ ����ࠢ������� �१ ����� ! " WINDOW NOWAIT
ELSE
 WAIT " ��ମ���� ������ ����ࠢ������� �१ ����� ! " WINDOW NOWAIT
ENDIF
=Inkey(1)
Wait Clear
GO top
DO While !EOF() && ����⪠ ����ᥩ � ���� FIO
   IF ALLTRIM(FIO)=' '
     Delete
   ENDIF 
   skip
ENDDO
PACK && �।���⥫쭠� ���⪠ 䠩�� &R_NAM (ᯨ᮪) ��। ��ࠢ���
********
 Sele Tmp1 && ��ନ�.䠩�� ��� ��ࠢ�� �� SPI
 ZAP && ���⪠, �᫨ �� �⮣� �� ᯨ᮪
 sele SPI
 D1=DAT_Z1
 D2=DAT_Z2
 D_S=D1 && ���.蠣 横��
 DO WHILE D_S<=D2 && ���� �� ��⠬ - ��砫쭠� � ����筠�
   sele tms && �஬.ࠡ 䠩� � 1 ����� DAT_Z
   R_PO=R_NAM+'.DBF'
   APPEND FROM &R_PO && � TMS(1 ���e) �� SPISOK�� � 2 ���ﬨ ��� 
   REPLACE ALL DAT_Z WITH D_S  
   sele tmp1 && ��ନ�.䠩�� ��� ��ࠢ�� �� SPI �१ TMS
   APPEND FROM dbfs\tmp_s.dbf
   sele tms && ���⪠  TMS
   zap
  D_S=D_S+1 && ᫥�.���� � 横�� !
 ENDDO
*******
N_DAT=SUBSTR(DTOC(DATE()),1,2)+SUBSTR(DTOC(DATE()),4,2)
N_DBF=STRTRAN(STR(SHT.NN_T,3),' ','0')  && 00N !!!!
N_USN=STRTRAN(RIGHT(NUSER,2),' ','0')
*
NAME=FULLPATH('ZP'+N_USN+N_DAT+'.'+N_DBF)
*
Sele Tmp1 && ���ନ�.䠩�� ��� ��ࠢ�� ᯨ᪠ ����묨 䠩�� �000.dbf
REPLACE ALL OTDEL      WITH _OTDEL
REPLACE ALL FIO_OTD    WITH _FIO
*  !!!!!
REPLACE ALL DEL        WITH R_DEL
* 
copy to &NAME
* sele ZAV
* APPEND FROM &NAME && ���������� � �� �⤥�� ����ᥩ ������
* �����뢠���� ⮫쪮 ��騥 ���� !
*********
 go top
 ! FOXSWAP ot_zajav.bat &name,&my_box,&kuda,&uzel > prot.txt
*********
* sele SPI
* REPLACE NN_T       WITH SHT.NN_T 
 NN=NN+1 && N ᫥� 䠩�� �� 1 ����� !
 sele SHT
 REPLACE NN_T       WITH NN
 sele SPI
 REPLACE NN_T       WITH SHT.NN_T 
 EX_R=0 && �� �ࠢ��쭮! ��室 �� 横�� � Brows
********
RETURN
*********
**************************************
**************************************
