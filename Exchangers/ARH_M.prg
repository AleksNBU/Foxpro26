*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 DEFINE WINDOW beg FROM 013, 23 TO 015, 58 NOCLOSE NOMINIMIZE COLOR SCHEME 17
 p_ath_3 = p_ath3+'KURS'
 SELECT 0
 use &p_ath_3 alias ARH
 PUBLIC z_p
 GOTO TOP
 z_p = 1
 ey = YEAR(DATE())
 ACTIVATE WINDOW beg
 @ 0, 01 SAY ' ������ � ��� ��������� :'
 @ 0, 27 GET z_p SIZE 1, 2 PICTURE '99'
 @ 0, 30 GET ey SIZE 1, 4 PICTURE '9999'
 READ
 IF LASTKEY()=27
    RELEASE WINDOW beg
    RETURN
 ENDIF
 RELEASE WINDOW beg
 name0 = STRTRAN(STR(z_p, 2), ' ', '0')
 n_dat1 = STRTRAN(STR(z_p, 2), ' ', '0')+'_'+STRTRAN(STR(ey, 4), ' ', '0')
 name1 = p_ath6+n_dat1
 name2 = name1+'.DBF'
 name3 = p_ath6+n_dat1+'.ARJ'
 name4 = p_ath9+n_dat1+'.ARJ'
 WAIT WINDOW NOWAIT '��祪��� - �� १���� ஧��㭪�� �㤥 �����������!'
 = INKEY(2)
 WAIT CLEAR
 Copy to &NAME1  for (z_p=MONTH(DAT).AND.ey=YEAR(DAT))
 SELECT 0
 use &NAME2 alias Rab
 COUNT TO kz
 IF kz=0
    WAIT WINDOW NOWAIT '����� �� ������� '+STR(z_p, 2)+' ������ '+STR(ey, 4)+' ப� � ���� ����� ���� ! '
    = INKEY(2)
    WAIT CLEAR
    SELECT rab
    USE
    SELECT arh
    USE
    ERASE &NAME2 
    RETURN
 ENDIF
 USE
 IF  .NOT. FILE(name3)
    ! FOXSWAP ARJ97 A &NAME1 &NAME2 > dbfs\prot_a.txt
    RENAME &NAME3 TO &NAME4 
    ERASE &NAME2 
 ELSE
    WAIT WINDOW NOWAIT ' ����� �� ������� '+STR(z_p, 2)+' ������ '+STR(ey, 4)+' ப� ��� ���� ! '
    = INKEY(2)
    WAIT CLEAR
    SELECT arh
    USE
    ERASE &NAME2 
    RETURN
 ENDIF
 SELECT arh
 DELETE FOR (z_p=MONTH(dat) .AND. ey=YEAR(dat))
 USE
 SELECT 0
 use &p_ath_3 alias ARH EXCLUSIVE 
 PACK
 USE
 WAIT WINDOW NOWAIT '���� �� ������� '+STR(z_p, 2)+' ������ '+STR(ey, 4)+' ப� ��६�饭� � ����� ! '
 = INKEY(2)
 WAIT CLEAR
 RETURN
*
*** 
*** ReFox - all is not lost 
***
