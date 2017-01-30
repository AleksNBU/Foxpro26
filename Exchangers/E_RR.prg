*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE e_rr
 PARAMETER erro
 er_rr = ' '
 DO CASE
    CASE erro=1
       WAIT WINDOW NOWAIT 'Помилковий маршрут ! Зайдўть у мережу !'
       = INKEY(2)
       WAIT CLEAR
       er_rr = '*'
    CASE erro=1705
       WAIT WINDOW NOWAIT 'Вўдмова у доступў - файли БД корегуються !'
       = INKEY(2)
       WAIT CLEAR
       er_rr = '*'
    OTHERWISE
       WAIT WINDOW NOWAIT 'Помилка ! Звернўться до програмўста ! Код помилки '+STR(erro, 4)
       = INKEY(2)
       WAIT CLEAR
       er_rr = '*'
 ENDCASE
 RETURN
*
*** 
*** ReFox - all is not lost 
***
