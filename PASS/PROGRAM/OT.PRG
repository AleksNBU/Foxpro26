********
* PROC MAIN_Z
*************
*** Begin  ���      10, 1999
*** Modern ���      18, 1999
*** Modern ���     29, 1999.
*** Modern ���     16, 1999.
*** Correc ������   10, 1999.
*** Correc ������   21, 1999. ��� ��� ��室���
*** Correc ������� 02, 1999. ����� �孮����� ��஫��
*** Modern ������� 13, 1999. ����� �孮����� ��஫��
*** Modern �����   25, 1999. 
*** Modern �������  01, 1999. 
*** Modern �������  27, 1999. 
*
*** Modern ���     26, 2003. ���� -�� ���� ������- ����� N_zona
*
*** Modern �����   18, 2004. ⥫.707-77-23
*
*** Modern �����   27, 2006.  �६� ��室� ����� 9 �� �� 8 ��
*
set talk off
SET ECHO OFF
set date german
*
CLEAR ALL
CLOSE ALL
CLOSE DATABASES
SET SYSMENU OFF
SET COLOR TO W/B
SET HOURS TO 24
SET SAFETY OFF && ��१�����
SET CENTURY ON && 1999, 2000
SET EXCLUSIVE ON
SET DELETED ON
SET EXACT ON   && �������� �ࠢ����� ᨬ�.��ப ࠧ�.�����
*
SET COLOR TO W+/B
*
SET COLOR OF SCHEME 17 TO W+/BG, GR+/B, GR+/RB, GR+/W, N+/W, GR+/GR, W+/B, N+/N, GR+/W, N+/W
SET COLOR OF SCHEME 18 TO W+/BG, GR+/B, GR+/w, GR+/W, N+/W, GR+/R, W+/B, N+/N, GR+/W, N+/W
SET COLOR OF SCHEME 20 TO N/BG, N/BG, N/BG, N/BG, W+/BG, W+/B, W+/BG, N/BG, N/BG
PUBLIC  R_PODR, R_FIO, R_NAM, R_OTH, R_DAT_Z, R_DAT_Z1, R_DAT_Z2
PUBLIC  NN, R_KKOMY, R_TN1, R_TN2, R_TK1, R_TK2, R_OTKUDA, TEXT1, EX, DE
PUBLIC TEXT2, VIX, SIM_IN, SIM_OUT, KRIT, KUDA, MY_BOX, DAT_R
PUBLIC _OTDEL, _FIO, NUSER, R_DEL
PUBLIC _NUSER, NAME_F 
STORE '������񦧨�������������������������' TO SIM_IN
STORE '�����������������������������������' TO SIM_OUT
KRIT=' ' && ��� ०��� ���᪠
VIX=.F.
R_DEL=0  && ���⪠ �ਧ���� : R_DEL=1 - ��୨஢���� 
DE=0 && De=1 -> ���� ᯨ᮪ � ᮮ�.䠩� ���᪠
EX=0 && ex=1 -> ���� ����
TEXT1=" ���㢠� ��� ?"
R_TIME=SUBSTR(TIME(),1,5)
*-------------*******************
sele 0
if file('dbfs\tmp.dbf')
   erase dbfs\tmp.dbf
endif
create table Dbfs\TMP (dat_T d(10),;   
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
use Dbfs\TMP alias tmp EXCLUSIVE
COPY TO Dbfs\TMP1 
*-----
sele 0
use Dbfs\TMP1 alias tmp1 && ��� Append SPISOK.DBF
*-----------------------
* !!!!!!!!!!!! KUDA 
kuda='PEREPUST' 
*kuda='V241COMT' 
* !!!!!!!!!!!!!
*------------------------
DEFINE WINDOW glob FROM 0,0 TO 24,79 none;
   FLOAT COLOR SCHEME 8
ACTIVATE WINDOW glob
   @ 04, 21 SAY '    �����    ���������    �       �'
   @ 05, 21 SAY '   �� ���    ���   ���    ��     ��'
   @ 06, 21 SAY '  ��� ���    ���   ���    ���   ���'
   @ 07, 21 SAY ' ���  ���    ���   ���    ���� ����'
   @ 08, 21 SAY '���   ���    ���������    ���������'
   @ 09, 21 SAY '���������    ���          ���   ���'
   @ 10, 21 SAY '���   ���    ���          ���   ���'
   @ 13, 09 SAY '� � � � � � � � � �   � � � � � �   � �   � � � � � � � � � �'
   @ 15, 40 SAY '�. ����� ��� H��'
   @ 15, 58 SAY '⥫. 707-77-23'
 @ 21,5 SAY "�������� ��� ��'� � ������ (������ ��� ����� �� ������ - 'TAB' �� ''" 
 @ 22,25 SAY '��� ������� ������� "Esc" '
*------------------- �஢�ઠ  ��஫� ------
*  _user() && ��� ��������� ����� ������ � ��஫�
NUSER=_user(FULLPATH(''))
IF EMPTY(NUSER)              && 
  WAIT WINDOW  '����砩�. ��஫�  ����୨� !' TIMEOUT 2
  CLOSE ALL
  DEACTIVATE WINDOW glob
  RELEASE WINDOW glob
* RETURN
 QUIT
ENDIF
CLEAR
*
uzel='UUH0'
my_box=ALLTRIM(_user(FULLPATH(''),3,NUSER))
_OTDEL=_user(FULLPATH(''),1,NUSER)
_FIO=_user(FULLPATH(''),2,NUSER)
* _NOM=_user(FULLPATH(''),4,NUSER)
_NUSER=STRTRAN(RIGHT(NUSER,2),' ','0')
*
* �஢�ઠ ��
er_rr=' '
ap_disk='Q:\PROCARRY\'+my_box+'\APPL\'
p_disk='Q:\PROCARRY\'+my_box+'\IN\'
ON ERROR do e_rr WITH ERROR()
imFile=p_disk+'prov.txt'
COPY FILE prov.txt TO (imFile)
IF 	er_rr='*'
  CLOSE ALL  
  ERASE DBFS\TMP.DBF
  ERASE DBFS\TMP1.DBF
*  RETURN
  QUIT && ��室 �� �����
ENDIF
ON ERROR
*
*-------------------  ��砫� ���-------------------
sele 0
use shet alias sht EXCLUSIVE
sele 0
*-----
use Zajav alias ZAV EXCLUSIVE
index on DTOS(DAT_T)+STR(NN_T,3) to dbfs\d_ind 
Go BOTTOM
IF DAT_T # DATE().or.DAT_T={  .  .  }
   DAT_R=DATE()
   NN=1
   sele sht
   REPLACE NN_T  WITH NN
   sele zav
 Else   && ����୮� ����祭�� �ணࠬ�� � ⥪.����
   DAT_R=DAT_T
   sele sht
   NN=NN_T
   REPLACE NN_T  WITH NN
   sele zav
Endif   
*--------------------------------------------------
index on DTOS(DAT_Z) to dbfs\z_ind COMPACT
GO Top
SCATTER MEMVAR BLANK
*********
@ 00,02 SAY '���筠 ���: ' 
@ 00,16 SAY DTOC(DATE()) COLOR w+/b
@ 01,02 say _OTDEL && color w+/b
@ 02,00 say REPLICATE ("-",78)
@ 22,08 SAY ;
" <-,,,-> - ��६i饭��, Enter - ���㢠��� ��������� ������ " 
* COLOR W+/B
DEFINE POPUP debb FROM 3,1 TO 21,58  MARK '' ;
FOOTER '  ��� �� ��९����  ';
TITLE "�������     ��'�       ��� ��. ��� ��. �� ���� ";
  PROMPT FIELDS ' '+PADR(LTRIM(FIO),13)+' '+PADR(LTRIM(NAM),10)+' '+ ;
  PADR(DTOC(DAT_T),10)+'  '+PADR(F_TIME,5)+'   '+;
  PADR(DTOC(DAT_Z),10)  SCROLL
**
pop=1 && ��� 1-�� POPUP
@ 03,01 GET pop POPUP debb ;
        COLOR SCHEME 8     ; 
        VALID COR_Z() && ��ࠡ�⪠ �����
@ 04,60 GET tek ;
     PICTURE "@*HN ���� ���    " ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
     VALID NEW_Z()
@ 06,60 GET tek ;
     PICTURE "@*HN ���᪨-�ࠢ��  " ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
      VALID P_SPISOK()
@ 08,60 GET tek ;
     PICTURE "@*HN ����� ���᮪   " ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
      VALID W_SPISOK()
@ 10,60 GET tek ;
     PICTURE "@*HN ������� ���" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
     VALID DEL_Z()
@ 12,60 GET tek ;
     PICTURE "@*HN ���� �� �����." ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
     VALID POISK_F()
@ 14,60 GET tek ;
     PICTURE "@*HN ��ॣ�� ����� " ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
     VALID APLL()
@ 16,60 GET tek ;
     PICTURE "@*HN ����.���" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
     VALID STORN()
@ 19,60 GET tek ;
     PICTURE "@*HN ����� � ����� " ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     COLOR SCHEME 17 ;
     VALID val_vih()
 READ CYCLE
DEACTIVATE WINDOW glob
RELEASE WINDOW glob
******
SELE ZAV
PACK
******
CLOSE ALL
! del PROT_IN.TXT>prot.txt
ERASE DBFS\D_IND.IDX
ERASE DBFS\S_IND.IDX
ERASE DBFS\P_IND.IDX
ERASE DBFS\Z_IND.IDX
ERASE DBFS\TMP.DBF
ERASE DBFS\TMP_S.DBF
ERASE DBFS\TMP1.DBF
*****
 QUIT
* RETURN
**************************************
*  ���������
**************************************
PROC E_RR  && ��������� ������
*********
PARA ERRO
DO CASE
  CASE ERRO=202 && H����� ������� ��� ��� 䠩��
   WAIT WIND '���������� ������� ! ������� � ��०� !' NOWAIT 
   =Inkey(2)
   WAIT CLEAR
   er_rr='*'
  OTHERWISE
   WAIT WIND '������� ! ��������� �� �ணࠬ��� ! ��� ������� '+STR(ERRO,4) NOWAIT
   =Inkey(2)
   WAIT CLEAR
   er_rr='*'
ENDCASE
return
**************************************
PROCEDURE INIT
****
R_FIO=SPACE(20)
R_NAM=SPACE(20)
R_OTH=SPACE(60)
R_DAT_Z=DATE()
R_TN1='  '
R_TN2='00'
R_TK1='  '
R_TK2='00'
R_KKOMY=SPACE(25)
R_OTKUDA=SPACE(40)
R_DEL=0
******
RETURN
**************************************
PROCEDURE F_ZAP
****
R_FIO=FIO
R_NAM=NAM
R_OTH=OTH
R_DAT_Z=DAT_Z
R_TN1=SUBSTR(B_TIME,1,2)
R_TN2=SUBSTR(B_TIME,3,2)
R_TK1=SUBSTR(K_TIME,1,2)
R_TK2=SUBSTR(K_TIME,3,2)
R_KKOMY=KKOMY
R_OTKUDA=OTKUDA
******
RETURN
**************************************
**************************************
FUNCTION NEW_Z
***************
 DO INIT
 DO RAB_Z
_CUROBJ = 1
********
Return
**************************************
FUNCTION P_SPISOK && ���᮪-�ࠢ��
***************
sele 0
LA=0
use Per_spi ALIAS p_spi
index on N to dbfs\p_ind COMPACT 
count to SP
go top
IF SP=0 && sp=0 -  䠩� PER_SPI ���⮩
  WAIT " ���� ᯨ��� - �஡��� ����� ! " WINDOWS NOWAIT 
  =Inkey(1)
  Wait Clear
  use && Per_spi 
ELSE
  DEFINE POPUP deb FROM 7,50 TO 10,75  MARK '' ;
  FOOTER ' ������� - ��.Esc ';
  TITLE "  ����� ᯨ᪠  ";
    PROMPT FIELDS ' '+NAIM SCROLL
  ON SELECTION POPUP DEB DO VIB_SP WITH PROMPT() && �롮� ᯨ᪠
       *    COLOR SCHEME 8      
  ACTIVATE POPUP Deb
  LA=LastKey()
  IF LA=27  && ��室 ��� �ନ஢����
*  Sele P_spi
    use && Per_spi  
    RELEASE POPUPS deb
    sele ZAV
    _CUROBJ = 1
    SHOW GET POP
    Return
  ENDIF
  Sele 0  && ����⨥ 䠩�� � ������ �� Per_spi (���� NAM_POLE)
  Use &R_NAM alias SPI EXCLUSIVE
  * �������� FIO �� ��䠢���
 index on CHRTRAN(FIO,'���������󄤅���';
+'���������������������������������������',;
 'AABBCCDDEEFFGGHHIIJJKKLLMMNNOOPPQQRRSSTT';
+'UUVVWWXXYYZZaabbccddeeffgg') to dbfs\s_ind 
  ***
  DO SPISKI_P && �ணࠬ�� ࠡ��� � ᯨ᪠��
  IF DE=1 && De=1 -> ���� ᯨ᮪ � ᮮ�.䠩� ���᪠
    sele  P_spi 
    DELETE
    PACK
    use && Per_spi 
    sele Spi
    Use && SPI
    R_NAM=R_NAM+'.DBF'
    ERASE &R_NAM
   ELSE
    sele SPI
    Use && SPI
    sele P_spi
    use && Per_spi 
  ENDIF 
  RELEASE POPUPS deb
ENDIF
  sele ZAV
  _CUROBJ = 1
  SHOW GET POP
*******
Return
****************************************
FUNCTION VIB_SP && �롮� ᯨ᪠
parameters pole
R_NAM=NAM_POLE
DEACTIVATE POPUP Deb
******
Return
***************************************
FUNCTION W_SPISOK && ���� ᯨ᮪
***************
 DEFINE WINDOW SPISOK ;
   FROM 12,15 to 14,64 FLOAT;
   TITLE ' ������� ⥪�� ��� ����� ᯨ᪠ ' COLOR scheme 1
 activate window SPISOK 
 SLOVO = SPACE(20)
 @ 0,13 GET SLOVO valid !empty(SLOVO) ;
 error ' ����� ��� ����� ᯨ᪠ �� �������! �������� ! '
 READ
release window SPISOK
***********
IF SLOVO = SPACE(20) 
  sele ZAV
  _CUROBJ = 1
  SHOW GET POP
  Return
ENDIF
***********
sele 0
use Per_spi
index on N to dbfs\p_ind COMPACT 
count to SP
go top
IF SP=0 && sp=0 - 1-� 䠩� - SPISOK01
   APPEND BLANK
   REPLACE N WITH 1
   NOM=STRTRAN(STR(N,2),' ','0')  && 0N !!!!
   R_NAM='SPISOK'+NOM
   REPLACE NAM_POLE WITH R_NAM
   REPLACE NAIM WITH SLOVO
 ELSE
   go bottom
   R_N=N+1
   NOM=STRTRAN(STR(R_N,2),' ','0')  && 0N !!!!
   R_NAM='SPISOK'+NOM
   APPEND BLANK
   REPLACE N WITH R_N
   REPLACE NAM_POLE WITH R_NAM
   REPLACE NAIM WITH SLOVO
ENDIF
*****
use && Per_spi 
select 0
use SPISOK  && alias SPI EXCLUSIVE
Copy to &R_NAM && ����஢���� ����.䠩�� �����.��������
use
Sele 0 
Use &R_NAM alias SPI EXCLUSIVE
index on DTOS(DAT_T)+STR(NN_T,3) to dbfs\s_ind 
***
 DO SPISKI_P && �ணࠬ�� ࠡ��� � ᯨ᪠�� ��� ��室���
 sele Spi
 Use && SPI
***
sele ZAV
_CUROBJ = 1
SHOW GET POP
********
Return
**************************************
FUNCTION COR_Z
***************
 DO F_ZAP
 DO RAB_Z
_CUROBJ = 1
********
Return
**************************************
FUNCTION DEL_Z
***************
* WAIT " ������. ����� ���� � �� ����� ! " WINDOW TIMEOUT 1 
* _CUROBJ = 1
* Return
*******
 vix=.F.
 sh=4
 DO VARIANT WITH '������� �����.���',vix,5   && �������� �����
 IF vix && �������� �����
    DELETE
 ENDIF
_CUROBJ = 1
SHOW GET POP
********
Return
**************************************
FUNCTION RAB_Z
***************
 DEFINE WINDOW OKNO1 FROM 3,10 TO 20,68 DOUBLE &&;
*   FLOAT COLOR SCHEME 8
 activate window OKNO1
EX=0
LA=0
DO WHILE .T. 
*-------------
 RR=1
 @ 00,13 SAY "����� �� ������ ����������"
 @ 02,15 SAY "���筠 ���: "+DTOC(DATE())
 @ 04,15 SAY " ������ "
 @ 05,01 SAY "�������     : "
 @ 05,16 GET R_FIO SIZE 1,20 ; 
   VALID  R_FIO<>' ';
   ERROR  " �� ��������� ���� �������. �������� ������� ! "
 @ 06,01 SAY "��'�         : "
 @ 06,16 GET R_NAM SIZE 1,20  
 @ 07,01 SAY "�� ���쪮��  : "
 @ 07,16 GET R_OTH SIZE 1,20  
 @ 08,01 SAY "�� �� ����  : "
 @ 08,16 GET R_DAT_Z SIZE 1,10 ;
 VALID R_DAT_Z>=DATE() ;
 ERROR '����.��� <'+DTOC(DATE())+'> ����� ��������� <'+;
        DTOC(R_DAT_Z)+'>.�������� �������!' 
* @ 09,01 SAY "���⮪       "
* @ 10,01 SAY "������㢠���  "
 @ 09,01 SAY "��� �� ��९����"
 @ 10,01 SAY "    ���᭠  � "
 @ 10,16 GET R_TN1 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '08','18'
 @ 10,19 SAY "���." 
 @ 10,23 GET R_TN2 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '00','60'
 @ 10,26 SAY "墨�." 
 @ 11,01 SAY "           �� "
 @ 11,16 GET R_TK1 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '08','18';
    VALID  R_TN1<=R_TK1;
    ERROR '��砫�.������ <'+R_TN1+'> ����� ���楢�� <'+;
           R_TK1+'>. �������� ������� !'
 @ 11,19 SAY "���."
 @ 11,23 GET R_TK2 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '00','60' 
 @ 11,26 SAY "墨�."
 *
 @ 12,01 SAY "�� ���� ������:"
 @ 12,17 GET R_KKOMY SIZE 1,25 ;
   VALID  R_KKOMY<>' ';
   ERROR  " �� ��������� ���� <�� ���� ������>. �������� ������� ! "
 *
 @ 13,01 SAY "������ ������:"
 @ 13,16 GET R_OTKUDA SIZE 1,40 ;
   VALID  R_OTKUDA<>' ';
   ERROR  " �� ��������� ���� <������ ������>. �������� ������� ! "
*
 @ 15,03 GET vih ;
     PICTURE "@*HN ���㢠� ������" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID val_vih()
@ 15,38 GET vih ;
     PICTURE "@*HN �����" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID ex_vih()
 READ CYCLE
 LA=LastKey()
 IF EX=1.or.LA=27  && ��室 ��� �ନ஢����
    release window OKNO1
    set fiLter to && ��᫥ ०��� ���᪠
    SHOW GET POP
    RETURN
 Endif
 IF R_TN1=R_TK1.and.R_TN2>=R_TK2
    WAIT '���.�� <'+R_TN1+'-'+R_TN2+'> ����� ���楢��� <'+R_TK1+'-'+R_TK2+'>. �������� ������� !' WINDOW nowait
    =inkey(1)
     Wait Clear 
    RR=0 && ����୮ ! 
 ENDIF
 IF RR=1
   release window OKNO1
   EXIT
 Endif
*-----
ENDDO
*********
vix=.F.
sh=4
DO VARIANT WITH TEXT1,vix,5   && ������ �����
IF vix && ������ �����
    APPEND BLANK  
    * Sele zav
    R_DEL=0
    DO ZAPIS
ENDIF
***********
release window OKNO1
set fiLter to && ��᫥ ०��� ���᪠
SHOW GET POP
*******
return
*************************************
FUNCTION val_vih     &&  vihod VALID
CLEAR READ
******
RETURN
*************************************
FUNCTION ex_vih     &&  EXIT
CLEAR READ
EX=1
******
RETURN
**************************************
PROCEDURE ZAPIS && ������ � �� � ����뫪� �� ��.����
******
sele ZAV
*--------
REPLACE DAT_T      WITH DAT_R
REPLACE F_TIME     WITH SUBSTR(TIME(),1,5)
REPLACE FIO        WITH R_FIO
REPLACE NAM        WITH R_NAM
REPLACE OTH        WITH R_OTH
REPLACE DAT_Z      WITH R_DAT_Z
REPLACE B_TIME     WITH R_TN1+R_TN2
REPLACE K_TIME     WITH R_TK1+R_TK2
REPLACE OTKUDA     WITH R_OTKUDA
REPLACE NN_T       WITH SHT.NN_T
REPLACE KKOMY      WITH R_KKOMY
*-----------------------------
sele tmp
*-------
APPEND BLANK  
REPLACE DAT_T      WITH DAT_R
REPLACE F_TIME     WITH SUBSTR(TIME(),1,5)
REPLACE FIO        WITH R_FIO
REPLACE NAM        WITH R_NAM
REPLACE OTH        WITH R_OTH
REPLACE DAT_Z      WITH R_DAT_Z
REPLACE B_TIME     WITH R_TN1+R_TN2
REPLACE K_TIME     WITH R_TK1+R_TK2
REPLACE OTKUDA     WITH R_OTKUDA
REPLACE KKOMY      WITH R_KKOMY
REPLACE OTDEL      WITH _OTDEL
REPLACE FIO_OTD    WITH _FIO
REPLACE NN_T       WITH SHT.NN_T
REPLACE DEL        WITH R_DEL
*
N_DAT=SUBSTR(DTOC(DATE()),1,2)+SUBSTR(DTOC(DATE()),4,2)
N_DBF=STRTRAN(STR(SHT.NN_T,3),' ','0')  && 00N !!!!
N_USN=STRTRAN(RIGHT(NUSER,2),' ','0')
*
NAME=FULLPATH('ZP'+N_USN+N_DAT+'.'+N_DBF)
copy to &NAME
*
! FOXSWAP ot_zajav.bat &name,&my_box,&kuda,&uzel > prot_in.txt
* Tomail
	* ���⪠ 䠩�� ����� ��� ����� ������
zap
*-------
NN=NN+1 && N ᫥� 䠩�� �� 1 ����� !
sele SHT
REPLACE NN_T       WITH NN
*------------------------------------
sele ZAV
NAME_f='ZP'+N_USN+N_DAT+'.'+N_DBF
REPLACE NAM_F     WITH NAME_f && ��� ��ࠢ�.䠩��
******
RETURN
**************************************
PROCEDURE VARIANT && ���⢥ত���� �� �믮������ ��/���
 PARAMETERS text,vix,sh
str=17
stl=22
***
vibor=""
*
IF NOT WEXIST("y_n")
	DEFINE WINDOW y_n ;
		FROM str, stl ;
		TO str+4,stl+28 ;
		NOFLOAT ;
		NOCLOSE ;
		SHADOW ;
		COLOR SCHEME sh
ENDIF
IF WVISIBLE("y_n")
	ACTIVATE WINDOW y_n SAME
ELSE
	ACTIVATE WINDOW y_n NOSHOW
ENDIF
@ 0,4 SAY TEXT
@ 2,4 GET vibor ;
	PICTURE "@*HT  ��� ; �� " ;
	SIZE 1,7,5 ;
	DEFAULT 1 ;
	VALID KONEC()
IF NOT WVISIBLE("y_n")
	ACTIVATE WINDOW y_n
ENDIF
READ CYCLE
RELEASE WINDOW y_n
******
RETURN VIX
**************************************
FUNCTION KONEC  &&  vibor VALID
 IF ALLTRIM(vibor) = "���"
     vix =.T.
 ELSE
     vix =.F.   
 ENDIF
 CLEAR READ
 SHOW GETS
 RETURN VIX
**************************************      
FUNCTION POISK_F
*********
 DEFINE WINDOW poshuk ;
   FROM 12,15 to 14,64 FLOAT;
   TITLE ' ������� ⥪�� ��� ���㪠 ������� ������ ' COLOR scheme 1
 activate window poshuk 
 SLOVO = SPACE(20)
 @ 0,13 GET SLOVO valid !empty(SLOVO) ;
 error ' ����� ��� ���㪠 �� �������! ���ࠢ�� ! '
 READ
 if lastkey()=13
   KRIT = ALLTRIM(SLOVO)
 Endif
 release window poshuk
 set fiLter to chrtran(krit,sim_in,sim_out)$chrtran(FIO,sim_in,sim_out)=.T.
 count TO sct
 IF sct=0 
  wait ' ������ ������� <'+ALLTRIM(SLOVO)+'> ����� ! ' window TIMEOUT 1
  set fiLter to
 endif
 _CUROBJ = 1  
 SHOW GET POP
******
Return
**************************************
FUNCTION APLL
*********
SELE ZAV
DEFINE WINDOW glob_v FROM 03,00 TO 24,78 ;
   FLOAT COLOR SCHEME 2  ;
   FOOTER ' ������� - Esc '
*
if file('dbfs\tmp_0.dbf')
   erase dbfs\tmp_0.dbf
endif
COPY TO Dbfs\TMP_0 FOR YEAR(DATE( ))=YEAR(DAT_T)
sele 0
use Dbfs\TMP_0 alias tmp_0 EXCLUSIVE
* �������� �����-����� ZAJAV �� NAM_F
index on NAM_F to dbfs\temp_0 COMPACT
*
if file('dbfs\tmp_1.dbf')
   erase dbfs\tmp_1.dbf
endif
if file('dbfs\tmp_2.dbf')
   erase dbfs\tmp_2.dbf
endif
*----
create table Dbfs\TMP_1 (P1 C(15),;   
   IN_BOX  c(08),;
   HOST1   c(08),;
   OUT_BOX c(08),;
   HOST2   c(08),;
   TIM1    c(20),;
   TIM2    c(20),;
   TIM3    c(20),;
   NAM_F   c(13),;
   Y       c(01),;
   U       c(01),;
   NOM_S   c(04),;
   FIO     C(20))
use
*------
sele 0
use Dbfs\TMP_1 alias tmp_1 EXCLUSIVE
*********
ap_disk='Q:\PROCARRY\'+my_box+'\APPL\'
AP_DAT=SUBSTR(DTOC(DATE()),1,2)+SUBSTR(DTOC(DATE()),4,2);
+SUBSTR(DTOC(DATE()),9,2)
 im_Fil=ap_disk+'U'+AP_DAT+'.log'
IF .not.File(im_Fil) &&  䠩�� ���
  WAIT " ���� ��।���� ������ ��� ! " WINDOWS NOWAIT 
  =Inkey(1)
  Wait Clear
  sele TMP_0
  use && Dbfs\TMP_0
  sele TMP_1
  use && Dbfs\TMP_1
  sele ZAV
  _CUROBJ = 1
  SHOW GET POP
  RETURN
ENDIF  
* ���������� 䠩�� TMP_1 ����묨 ⥪.䠩�� U���.log �� PROCARRY  
 APPEND FROM &im_fil TYPE DELIMITED  WITH  ,
 COPY TO Dbfs\TMP_2 For OUT_BOX=KUDA.and._NUSER=SUBSTR(NAM_F,3,2)
*
 
* COPY TO Dbfs\TMP_2 For OUT_BOX='V241COMT'.and._NUSER=SUBSTR(NAM_F,3,2)
use && TMP_1
*
sele 0
use Dbfs\TMP_2 alias tmp_2 EXCLUSIVE
Count to k_vo
IF k_vo=0 &&  ����� ���
  WAIT " ���� ��।���� ������ ��� ! " WINDOWS NOWAIT 
  =Inkey(1)
  Wait Clear
  use && Dbfs\TMP_2
  sele TMP_0
  use && Dbfs\TMP_0
  sele ZAV
  _CUROBJ = 1
  SHOW GET POP
  RETURN
ENDIF  
go top
* ��離� �� ����� 䠩�� � ���� ���
set rela to NAM_F into TMP_0 
repla all FIO with TMP_0.FIO for NAM_F=TMP_0.NAM_F
ACTIVATE WINDOW glob_v
@ 19,02 SAY ;
 " <-,,,-> - ��६i饭��. <����� �� ०���> ��� ESC - ����� ��ॣ��� "
*
DEFINE POPUP debb3 FROM 00,00 TO 16,75  MARK '' ;
FOOTER '  ��⮪�� ஡�� �����஭��� ���� ' ; 
TITLE "�������      ����        ����ࠢ���  ��ਬ��   ��஡��� ";
  PROMPT FIELDS ' '+PADR(LTRIM(FIO),20)+' '+PADR(LTRIM(NAM_F),13)+'  '+SUBSTR(TIM1,11,8)+'  '+; 
  SUBSTR(TIM2,10,8)+'  '+SUBSTR(TIM3,10,8)  SCROLL
**
pop1=1 && ��� 3-�� POPUP
@ 00,00 GET pop1 POPUP debb3 ;
        COLOR SCHEME 8      
@ 18,30 GET vih ;
     PICTURE "@*HN ����� �� ०���" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID ex_vih()
READ CYCLE
*
DEACTIVATE WINDOW glob_v
*
USE && TMP2
ERASE DBFS\TMP_1.DBF
ERASE DBFS\TMP_2.DBF
Sele TMP_0
USE && TMP_0
ERASE DBFS\TMP_0.DBF
*
sele ZAV
_CUROBJ = 1
 SHOW GET POP
*********
RETURN
**************************************
FUNCTION STORN
***************
 DO F_ZAP
 DEFINE WINDOW OKNO1 FROM 3,10 TO 20,68 DOUBLE &&;
*   FLOAT COLOR SCHEME 8
 activate window OKNO1
EX=0
LA=0
DO WHILE .T. 
*-------------
 RR=1
 @ 00,13 SAY "����� �� ������ ����������"
 @ 02,15 SAY "���筠 ���: "+DTOC(DATE())
 @ 04,15 SAY " ������ "
 @ 05,01 SAY "�������     : "
 @ 05,16 SAY R_FIO 
 @ 06,01 SAY "��'�         : "
 @ 06,16 SAY R_NAM 
 @ 07,01 SAY "�� ���쪮��  : "
 @ 07,16 SAY R_OTH 
 @ 08,01 SAY "�� �� ����  : "
 @ 08,16 SAY R_DAT_Z 
* @ 09,01 SAY "���⮪       "
* @ 10,01 SAY "������㢠���  "
 @ 09,01 SAY "��� �� ��९����"
 @ 10,01 SAY "    ���᭠  � "
 @ 10,16 SAY R_TN1
 @ 10,19 SAY "���._" 
 @ 10,23 SAY R_TN2 
 @ 10,26 SAY "墨�." 
 *
* @ 11,01 SAY "�����祭��    "
* @ 12,01 SAY "������㢠���    "
 @ 11,01 SAY "           �� "
 @ 11,16 SAY R_TK1  
 @ 11,19 SAY "���."
 @ 11,23 SAY R_TK2  
 @ 11,26 SAY "墨�."
 *
 @ 12,01 SAY "�� ���� ������:"
 @ 12,17 SAY R_KKOMY 
 *
 @ 13,01 SAY "������ ������:"
 @ 13,16 SAY R_OTKUDA 
 @ 15,03 GET vih ;
     PICTURE "@*HN ���� ������" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID val_vih()
@ 15,38 GET vih ;
     PICTURE "@*HN �����" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID ex_vih()
 READ CYCLE
 LA=LastKey()
 IF EX=1.or.LA=27  && ��室 ��� �ନ஢����
    release window OKNO1
    set fiLter to && ��᫥ ०��� ���᪠
    SHOW GET POP
    RETURN
 Endif
 IF RR=1
   release window OKNO1
   SHOW GET POP
   _CUROBJ = 1
   EXIT
 Endif
*-----
ENDDO
*********
vix=.F.
sh=4
DO VARIANT WITH " ���� ��� ?",vix,5   && ������ �����
IF vix && ������ �����
  * Sele zav
    R_DEL=1 
    DO ZAPIS
ENDIF
***********
release window OKNO1
SHOW GET POP
_CUROBJ = 1
*********
RETURN
**************************************
**************************************
