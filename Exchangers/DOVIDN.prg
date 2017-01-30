*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SET SAFETY OFF
 DEFINE POPUP vv FROM 3, 17 TO 6, 34 SHADOW COLOR SCHEME 20
 DEFINE BAR 1 OF vv PROMPT '  Охорона   '
 DEFINE BAR 2 OF vv PROMPT '  Райони    '
 ON SELECTION POPUP vv do WORK_SPR with bar()
 ACTIVATE POPUP vv
 DEACTIVATE POPUP vv
 RETURN
*
PROCEDURE work_spr
 PARAMETER var
 p_ath_1 = p_ath3+'s_ohr'
 SELECT 0
 use &p_ath_1 alias S
 INDEX ON kod TO dbfs\s_ind COMPACT
 p_ath_2 = p_ath3+'REE_PR'
 SELECT 0
 use &p_ath_2 alias L
 INDEX ON STR(nn, 2) TO dbfs\l_ind COMPACT
 DO CASE
    CASE var=1
       DO ved_ohr
    CASE var=2
       p_ath_3 = p_ath3+'R'
       SELECT 0
       use &p_ath_3 alias RA
       INDEX ON kod TO dbfs\r_ind COMPACT
       DO ved_reg
       USE
 ENDCASE
 CLOSE ALL
 ERASE DBFS\S_IND.IDX
 ERASE DBFS\L_IND.IDX
 ERASE DBFS\R_IND.IDX
 RETURN
*
*** 
*** ReFox - all is not lost 
***
