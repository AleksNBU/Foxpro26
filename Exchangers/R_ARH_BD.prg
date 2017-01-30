*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE r_arh_bd
 PARAMETER vid
 otvdn = 0
 im2 = ' '
 IF .NOT. EMPTY(SYS(2000,p_ath10+'&Vid*.*')) 
    IF FILE('Dbfs\NAM_FILE.Dbf')
       ERASE Dbfs\nam_file.dbf
    ENDIF
    CREATE DBF Dbfs\nam_file (nam C (12))
    USE Dbfs\nam_file
    DIMENSION d_ir[ 1]
    k_at=ADIR(d_ir,p_ath10+'&Vid*.*')
    FOR n = 1 TO k_at
       APPEND BLANK
       REPLACE nam WITH d_ir(n,1)
    ENDFOR
    DEFINE POPUP n_file FROM 3, 40 TO 15, 66 PROMPT FIELDS nam TITLE 'Виберўть файл' SHADOW MARGIN FOOTER 'Вибўр-Enter Вихўд-Esc' SCROLL COLOR SCHEME 4
    ON SELECTION POPUP n_file DO VybFile 
    ACTIVATE POPUP n_file
    IF LASTKEY()<>27
       IF otvdn=2
          im1 = p_ath10+'SO'+SUBSTR(DTOC(DATE()), 1, 2)+SUBSTR(DTOC(DATE()), 4, 2)+SUBSTR(DTOC(DATE()), 10, 1)+SUBSTR(TIME(), 1, 1)+'.'+SUBSTR(TIME(), 2, 1)+SUBSTR(TIME(), 4, 2)
          ! FOXSWAP arj97 a  &im1 &p_ath3 > NUL
       ENDIF
       IF otvdn=2 .OR. otvdn=0
          ! FOXSWAP arj32 e /y &im2 &p_ath3 > dbfs\prot_rah.txt
       ENDIF
    ENDIF
 ELSE
    WAIT WINDOW TIMEOUT 4 'У каталозў немаїт файлўв для розархўвацў∙'
 ENDIF
 USE
 ERASE Dbfs\nam_file.dbf
 RETURN
*
FUNCTION vybfile
 DEFINE WINDOW win_soob FROM 14, 03 TO 24, 40 SHADOW COLOR SCHEME 7
 ACTIVATE WINDOW win_soob
 @ 0, 0 SAY PADC('У В А Г А', 36)
 @ 1, 0 SAY PADC('При розархўвацў∙ файлу уся поточна  ', 36)
 @ 2, 0 SAY PADC('ўнформацўя буде замўнена на ўнформа-', 36)
 @ 3, 0 SAY PADC('цўю з архўвного файлу ў вўдновленню', 36)
 @ 4, 0 SAY PADC('НЕ ПЎДЛЯГАЇ', 36)
 @ 6, 0 SAY PADC('Розархўвирувати данў ?', 36)
 otvdn = 0
 @ 8, 9 GET otvdn SIZE 1, 3, 6 PICTURE '@*h Нў;Так'
 READ
 im2 = p_ath10+PROMPT()
 DEACTIVATE WINDOW win_soob
 RELEASE WINDOW win_soob
 DEACTIVATE POPUP n_file
 RELEASE POPUP n_file
 RETURN im2
*
*** 
*** ReFox - all is not lost 
***
