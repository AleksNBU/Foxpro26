*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE e_rr
 PARAMETER erro
 er_rr = ' '
 DO CASE
    CASE erro=1
       WAIT WINDOW NOWAIT '���������� ������� ! ������� � ��०� !'
       = INKEY(2)
       WAIT CLEAR
       er_rr = '*'
    CASE erro=1705
       WAIT WINDOW NOWAIT '������� � ������ - 䠩�� �� ��ॣ������ !'
       = INKEY(2)
       WAIT CLEAR
       er_rr = '*'
    OTHERWISE
       WAIT WINDOW NOWAIT '������� ! ��������� �� �ணࠬ��� ! ��� ������� '+STR(erro, 4)
       = INKEY(2)
       WAIT CLEAR
       er_rr = '*'
 ENDCASE
 RETURN
*
*** 
*** ReFox - all is not lost 
***
