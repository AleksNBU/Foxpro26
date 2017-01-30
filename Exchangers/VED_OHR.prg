*** 
*** ReFox XI+  #QD566508  Mazal  EMBRACE [FP25]
***
 SELECT s
 DEFINE WINDOW ved_p FROM 7, 1 TO 21, 63 NOFLOAT NOCLOSE TITLE ' Довўдник охоронних пўдроздўлўв ' COLOR SCHEME 8
 DEFINE WINDOW controls FROM 7, 66 TO 21, 76 FLOAT NOCLOSE COLOR SCHEME 8
 DEFINE WINDOW br FROM 03, 10 TO 22, 58 FLOAT TITLE 'Охороннў пўдроздўли ' FOOTER ' Вихўд - Esc ' COLOR SCHEME 8
 PRIVATE m.adding, m.popupedit, m.editing, m.savereco, m.islocked, m.nodeling
 m.savereco = RECNO()
 m.adding = .F.
 m.popupedit = .F.
 m.editing = .F.
 m.islocked = .F.
 m.nodeling = .F.
 SET COLOR TO
 SET EXCLUSIVE OFF
 SCATTER BLANK MEMVAR
 PRIVATE m.choice, m.toprec, m.bottomrec, m.saverecno
 PRIVATE m.quitting
 m.quitting = .F.
 m.choice = 'OK'
 IF EOF()
    GOTO BOTTOM
 ENDIF
 m.saverecno = RECNO()
 GOTO TOP
 m.toprec = RECNO()
 GOTO BOTTOM
 m.bottomrec = RECNO()
 GOTO m.saverecno
 ACTIVATE WINDOW NOSHOW ved_p
 ON READERROR DO Errhand
 @ 1, 1 SAY 'Код пўдроздўла  '
 @ 1, 20 GET kod RANGE '1001','2999' PICTURE '9999'
 @ 3, 1 SAY 'Назва пўдроздўла '
 @ 4, 1 GET nam DEFAULT ' ' PICTURE '@K'
 @ 6, 1 SAY 'Адреса пўдроздўла '
 @ 7, 1 GET adr
 @ 9, 1 SAY 'Телефон пўдроздўла '
 @ 9, 23 GET tel PICTURE '999999'
 @ 11, 0 SAY ' ДЛЯ ПЕРЕСУВАННЯ ПО ГРАФАХ КОРИСТУЙТЕСЯ кл."TAB"'
 @ 12, 0 SAY '               ВИХЎД - кл. "Esc"                '
 @ 0, 50 TO 08, 59
 @ 1, 51 GET newrecord DEFAULT 1 SIZE 1, 8, 1 PICTURE '@*HN  \<Bвод ' VALID new_val()
 @ 3, 51 GET m.editrecord DEFAULT 1 SIZE 1, 8, 1 PICTURE '@*VN \<Pедаг.' VALID edit_val() WHEN edit_when()
 @ 5, 51 GET delet DEFAULT 1 SIZE 1, 8, 1 PICTURE '@*HN \<Вилуч.' VALID del_val()
 @ 7, 51 GET cancel DEFAULT 1 SIZE 1, 8, 1 PICTURE '@*HN \<Вўдм.' VALID can_val()
 IF WVISIBLE('controls')
    ACTIVATE WINDOW SAME controls
 ELSE
    ACTIVATE WINDOW NOSHOW controls
 ENDIF
 @ 1, 0 GET m.choice DEFAULT 1 SIZE 1, 9, 1 PICTURE '@*VN \<Наст;\<Попер;\<Почат;\<Кўнець;\<Пошук;\<Дв.БД' VALID cho_val()
 IF  .NOT. WVISIBLE('controls')
    ACTIVATE WINDOW controls
 ENDIF
 IF  .NOT. WVISIBLE('ved_p')
    ACTIVATE WINDOW ved_p
 ENDIF
 READ CYCLE SHOW read_show() ACTIVATE read_act() DEACTIVATE read_dea() WHEN read_when()
 RELEASE WINDOW controls
 RELEASE WINDOW ved_p
 IF m.quitting
    RELEASE WINDOW ved_p
    RELEASE WINDOW controls
    RELEASE WINDOW br
    RELEASE WINDOW poisk
    RELEASE WINDOW otkaz
 ENDIF
*
PROCEDURE showsave
 IF NETWORK() .AND.  .NOT. m.editing
    WAIT WINDOW NOWAIT 'Плиз confirm changes'
 ENDIF
 SHOW GET m.newrecord DISABLE
 SHOW GET m.delet DISABLE
 SHOW GET m.cancel DISABLE
 SHOW GETS DISABLE ONLY WINDOW controls
 SET SKIP OF POPUP _MRECORD .T.
 SET SKIP OF BAR 1 OF reports .T.
 SET SKIP OF BAR 7 OF _MSYSTEM .T.
 m.editing = .T.
 m.nodeling = .T.
*
PROCEDURE new_val
 m.savereco = RECNO()
 LOCATE FOR DELETED() .AND. EMPTY(kod)
 IF  .NOT. FOUND()
    APPEND BLANK
 ELSE
    RECALL
 ENDIF
 m.adding = .T.
 SHOW GET m.newrecord DISABLE
 SHOW GET m.editrecord, 1 ENABLE PROMPT '\<Збер.'
 SHOW GET m.delet DISABLE
 SHOW GET m.cancel ENABLE
 _CUROBJ = OBJNUM(kod)
 SHOW GETS LOCK
 SHOW GETS DISABLE WINDOW controls
 SET SKIP OF POPUP _MRECORD .T.
 SET SKIP OF BAR 1 OF reports .T.
 SET SKIP OF BAR 7 OF _MSYSTEM .T.
*
FUNCTION edit_when
 IF  .NOT. (m.adding .OR. m.editing)
    RETURN .T.
 ENDIF
 IF EMPTY(kod)
    ?? CHR(7)
    WAIT WINDOW NOWAIT ' Введўть Код пўдроздўду '
    _CUROBJ = OBJNUM(kod)
    RETURN .F.
 ENDIF
*
PROCEDURE edit_val
 PRIVATE m.onoff
 IF NETWORK()
    IF m.editing=.F. .AND. m.adding=.F.
       SCATTER MEMVAR
       _CUROBJ = OBJNUM(kod)
       SHOW GETS LOCK
       IF m.islocked
          m.islocked = .F.
          RETURN
       ENDIF
       SHOW GET m.newrecord DISABLE
       SHOW GET m.editrecord, 1 ENABLE PROMPT '\<Збер.'
       SHOW GET m.delet DISABLE
       SHOW GET m.cancel ENABLE
       SHOW GETS DISABLE WINDOW controls
       m.editing = .T.
       m.onoff = .T.
    ELSE
       m.editing = .F.
       IF m.adding
          WAIT WINDOW NOWAIT 'Ўнформацўя буде збережена'
          m.adding = .F.
       ELSE
          WAIT WINDOW NOWAIT 'Змўни будуть збереженў'
       ENDIF
       _CUROBJ = OBJNUM(m.choice, 1)
       SHOW GET m.newrecord ENABLE
       SHOW GET m.delet DISABLE
       SHOW GET m.cancel DISABLE
       SHOW GET m.choice, 5 ENABLE
       SHOW GET m.choice, 6 ENABLE
       SHOW GET m.editrecord, 1 PROMPT '\<Peдаг.'
       SHOW GETS ENABLE WINDOW controls
       UNLOCK
       SHOW GETS
       m.onoff = .F.
    ENDIF
 ELSE
    m.adding = .F.
    WAIT WINDOW NOWAIT 'Ўнформацўя буде збережена'
    _CUROBJ = OBJNUM(m.choice, 1)
    SHOW GET m.newrecord ENABLE
    SHOW GET m.editrecord DISABLE
    SHOW GET m.choice, 5 ENABLE
    SHOW GET m.choice, 6 ENABLE
    SHOW GETS
    m.onoff = .F.
 ENDIF
 SET SKIP OF POPUP _MRECORD m.onoff
 SET SKIP OF BAR 1 OF reports m.onoff
 SET SKIP OF BAR 8 OF _MSYSTEM m.onoff
*
PROCEDURE del_val
 PRIVATE m.onoff
 IF NETWORK()
    IF m.nodeling=.F.
       SCATTER MEMVAR
       _CUROBJ = OBJNUM(kod)
       SHOW GETS LOCK
       IF m.islocked
          m.islocked = .F.
          RETURN
       ENDIF
       SHOW GET m.newrecord DISABLE
       SHOW GET m.editrecord DISABLE
       SHOW GET m.delet, 1 ENABLE PROMPT '\<Тaк'
       SHOW GET m.cancel ENABLE
       SHOW GETS DISABLE WINDOW controls
       m.nodeling = .T.
       m.onoff = .T.
    ELSE
       IF m.nodeling
          DELETE
          WAIT WINDOW NOWAIT ' ЗАПИС ВИЛУЧАЇТЬСЯ !'
          m.nodeling = .F.
       ENDIF
       _CUROBJ = OBJNUM(m.choice, 1)
       SHOW GET m.newrecord ENABLE
       SHOW GET m.editrecord DISABLE
       SHOW GET m.cancel DISABLE
       SHOW GET m.choice, 5 ENABLE
       SHOW GET m.choice, 6 ENABLE
       SHOW GET m.delet, 1 PROMPT '\<Вилуч.'
       SHOW GETS ENABLE WINDOW controls
       UNLOCK
       SHOW GETS
       m.onoff = .F.
    ENDIF
 ELSE
    m.nodeling = .F.
    WAIT WINDOW NOWAIT ' ЗАПИС ВИЛУЧАЇТЬСЯ !'
    _CUROBJ = OBJNUM(m.choice, 1)
    SHOW GET m.newrecord ENABLE
    SHOW GET m.editrecord DISABLE
    SHOW GET m.choice, 5 ENABLE
    SHOW GET m.choice, 6 ENABLE
    SHOW GETS
    m.onoff = .F.
 ENDIF
 SET SKIP OF POPUP _MRECORD m.onoff
 SET SKIP OF BAR 1 OF reports m.onoff
 SET SKIP OF BAR 8 OF _MSYSTEM m.onoff
*
PROCEDURE can_val
 IF m.editing .OR. m.nodeling .OR.  .NOT. NETWORK()
    GATHER MEMVAR
 ENDIF
 IF m.adding
    DELETE
    GOTO m.savereco
 ENDIF
 m.adding = .F.
 m.popupedit = .F.
 m.editing = .F.
 m.nodeling = .F.
 IF NETWORK()
    SHOW GET m.editrecord, 1 PROMPT '\<Peдaг.'
    SHOW GET m.delet, 1 PROMPT '\<Вилуч.'
    SHOW GET m.cancel DISABLE
 ELSE
    SHOW GET m.editrecord DISABLE
 ENDIF
 UNLOCK
 SHOW GET m.delet ENABLE
 SHOW GET m.newrecord ENABLE
 SHOW GETS WINDOW controls
 SHOW GETS
 _CUROBJ = OBJNUM(m.choice, 1)
 SHOW GET m.choice, 5 ENABLE
 SHOW GET m.choice, 6 ENABLE
 SET SKIP OF POPUP _MRECORD .F.
 SET SKIP OF BAR 1 OF reports .F.
 SET SKIP OF BAR 7 OF _MSYSTEM .F.
*
PROCEDURE cho_val
 DO CASE
    CASE m.choice='Наст'
       SKIP 1
       IF EOF() .OR. RECNO()=m.bottomrec
          GOTO BOTTOM
          SHOW GET m.choice, 1 DISABLE
          SHOW GET m.choice, 4 DISABLE
       ELSE
          IF RECNO()>m.toprec
             SHOW GET m.choice, 2 ENABLE
             SHOW GET m.choice, 3 ENABLE
          ENDIF
       ENDIF
    CASE m.choice='Попер'
       SKIP -1
       IF BOF() .OR. RECNO()=m.toprec
          GOTO TOP
          SHOW GET m.choice, 2 DISABLE
          SHOW GET m.choice, 3 DISABLE
       ELSE
          IF RECNO()<m.bottomrec
             SHOW GET m.choice, 1 ENABLE
             SHOW GET m.choice, 4 ENABLE
          ENDIF
       ENDIF
    CASE m.choice='Почат'
       GOTO TOP
       SHOW GET m.choice, 1 ENABLE
       SHOW GET m.choice, 2 DISABLE
       SHOW GET m.choice, 3 DISABLE
       SHOW GET m.choice, 4 ENABLE
    CASE m.choice='Кўнець'
       GOTO BOTTOM
       SHOW GET m.choice, 1 DISABLE
       SHOW GET m.choice, 2 ENABLE
       SHOW GET m.choice, 3 ENABLE
       SHOW GET m.choice, 4 DISABLE
    CASE m.choice='Дв.БД'
       n_zap = RECNO()
       GOTO TOP
       BROWSE FIELDS kod :H = 'Код' :W = .F., nam :H = 'Найменування' :W = .F. WINDOW br
       GOTO n_zap
    CASE m.choice='Пошук'
       n_zap = 0
       DO poshuk WITH n_zap
       m.saverecno = n_zap
       GOTO m.saverecno
 ENDCASE
 SHOW GETS
*
PROCEDURE read_when
 SET SKIP OF BAR 2 OF reports .T.
 SET SKIP OF BAR 3 OF reports .T.
 IF VAL(SYS(1001))<223000
    SET SKIP OF BAR 1 OF reports .T.
 ENDIF
 IF  .NOT. NETWORK()
    SHOW GET m.editrecord, 1 DISABLE PROMPT '\<Збер.'
 ENDIF
*
PROCEDURE read_act
 IF NETWORK() .AND.  .NOT. (m.editing .OR. m.adding)
    SHOW GET m.editrecord ENABLE
    SHOW GET m.delet ENABLE
    SHOW GET m.cancel DISABLE
 ENDIF
*
FUNCTION read_dea
 IF m.editing
    ?? CHR(4)
    WAIT WINDOW NOWAIT "Були змўни, необхўдмо нажтиснути Кл.'Збер.'"
    RETURN .F.
 ENDIF
 RETURN  .NOT. WREAD()
*
PROCEDURE read_show
 PRIVATE currwind
 STORE WOUTPUT() TO currwind
 IF EOF()
    GOTO BOTTOM
 ENDIF
 m.saverecno = RECNO()
 GOTO TOP
 m.toprec = RECNO()
 GOTO BOTTOM
 m.bottomrec = RECNO()
 GOTO m.saverecno
 IF RECNO()=m.bottomrec
    SHOW GET m.choice, 1 DISABLE
    SHOW GET m.choice, 2 ENABLE
    SHOW GET m.choice, 3 ENABLE
    SHOW GET m.choice, 4 DISABLE
 ELSE
    IF RECNO()=m.toprec
       SHOW GET m.choice, 1 ENABLE
       SHOW GET m.choice, 2 DISABLE
       SHOW GET m.choice, 3 DISABLE
       SHOW GET m.choice, 4 ENABLE
    ELSE
       SHOW GET m.choice ENABLE
    ENDIF
 ENDIF
 IF  .NOT. EMPTY(currwind)
    ACTIVATE WINDOW SAME (currwind)
 ENDIF
*
PROCEDURE errhand
 WAIT WINDOW TIMEOUT 1 'ПОМИЛКА, повторўть ввод !'
 RETURN
*
*** 
*** ReFox - all is not lost 
***
