*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
*
PROCEDURE r_arh_kv
 otvdn = 0
 im2 = ' '
 i_file = ' '
 IF  .NOT. EMPTY(SYS(2000, p_ath9+'*.arj'))
    IF FILE('Dbfs\NAM_FILE')
       ERASE Dbfs\nam_file.dbf
    ENDIF
    CREATE DBF Dbfs\nam_file (nam C (12))
    USE Dbfs\nam_file ALIAS nam
    DIMENSION d_ir[ 1]
    k_at = ADIR(d_ir, p_ath9+'*.ARJ')
    FOR n = 1 TO k_at
       APPEND BLANK
       REPLACE nam WITH d_ir(n,1)
    ENDFOR
    DEFINE POPUP n_file FROM 3, 20 TO 20, 46 PROMPT FIELDS nam TITLE 'Виберўть файл' SHADOW MARGIN FOOTER 'Вибўр-Enter Вихўд-Esc' SCROLL COLOR SCHEME 4
    ON SELECTION POPUP n_file DO VybFile 
    ACTIVATE POPUP n_file
    IF LASTKEY()<>27
       IF otvdn=2
          im0 = p_ath3+'kurs.dbf'
          im1 = p_ath10+'KU'+SUBSTR(DTOC(DATE()), 1, 2)+SUBSTR(DTOC(DATE()), 4, 2)+SUBSTR(DTOC(DATE()), 10, 1)+SUBSTR(TIME(), 1, 1)+'.'+SUBSTR(TIME(), 2, 1)+SUBSTR(TIME(), 4, 2)
          ! FOXSWAP arj97 a  &im1 &im0 > NUL
       ENDIF
       IF otvdn=2 .OR. otvdn=0
          ! FOXSWAP arj32 e /y &im2 &p_ath9 > dbfs\prot_pku.txt
          p_ath_3 = p_ath3+'KURS'
          SELECT 0
          use &p_ath_3 alias KURS EXCLUSIVE 
          APPEND FROM &i_File  
          USE
          ERASE &im2    
          ERASE &i_File 
       ENDIF
    ENDIF
 ELSE
    WAIT WINDOW TIMEOUT 4 'У каталозў немаїт файлўв для розархўвацў∙'
 ENDIF
 SELECT nam
 USE
 ERASE Dbfs\nam_file.dbf
 RETURN
*
FUNCTION vybfile
 DEFINE WINDOW win_soob FROM 14, 33 TO 24, 70 SHADOW COLOR SCHEME 7
 ACTIVATE WINDOW win_soob
 @ 0, 0 SAY PADC('У В А Г А', 36)
 @ 1, 0 SAY PADC('При розархўвацў∙ арх.файла курсўв за', 36)
 @ 2, 0 SAY PADC('перўод ўнформацўя буде добавлена  у ', 36)
 @ 3, 0 SAY PADC('файл поточн.даних курсўв,ў архўвний ', 36)
 @ 4, 0 SAY PADC('файл курсўв за перўод буде ВИДАЛЕНО!', 36)
 @ 6, 0 SAY PADC('Розархўвирувати данў ?', 36)
 otvdn = 0
 @ 8, 9 GET otvdn SIZE 1, 3, 6 PICTURE '@*h Нў;Так'
 READ
 im2 = p_ath9+PROMPT()
 i_file = p_ath9+SUBSTR(PROMPT(), 1, 7)+'.DBF'
 DEACTIVATE WINDOW win_soob
 RELEASE WINDOW win_soob
 DEACTIVATE POPUP n_file
 RELEASE POPUP n_file
 RETURN im2
*
*** 
*** ReFox - all is not lost 
***
