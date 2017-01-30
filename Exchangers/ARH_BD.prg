*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE arh_bd
 PARAMETER baza
 nam1 = baza+SUBSTR(DTOC(DATE()), 1, 2)+SUBSTR(DTOC(DATE()), 4, 2)+SUBSTR(DTOC(DATE()), 10, 1)+SUBSTR(TIME(), 1, 1)+'.'+SUBSTR(TIME(), 2, 1)+SUBSTR(TIME(), 4, 2)
 name1 = p_ath10+nam1
 DO CASE
    CASE baza='R'
       name2 = p_ath3+'p1.DBF'
    CASE baza='N'
       name2 = p_ath3+'NAR.DBF'
 ENDCASE
 ! FOXSWAP ARJ97 A &NAME1 &NAME2 > dbfs\prot_ar.txt
 RETURN
*
*** 
*** ReFox - all is not lost 
***
