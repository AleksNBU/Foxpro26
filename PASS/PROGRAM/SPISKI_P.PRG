************
*PROC spiski
*************
*** Modern Май     19, 1999
*** Modern Май     22, 1999
*** Modern Май     25, 1999
*** Modern ИЮНЬ    29, 1999
*** Correc Август  10, 1999.
*** Modern Август  21, 1999. отказ от выходных
*** Modern Ноябрь  22, 1999.
*** Modern Декабрь 22, 1999.
***
*** Modern Июнь     26, 2003. Поле -До кого клиїнт- вместо N_zona
****
*** Modern Ноябрь   27, 2006.  время прихода вместо 9 час на 8 час
************************************
SET ESCA OFF
************************************
LA=0 && Очиска от LASTKEY()
De=0 && Очиска 
EX_R=0  && ex_r=1 -> Просто вийти  
DEFINE WINDOW s_tr  FROM 00,00 TO 09,79 ;
   TITLE ' ЗАЯВА НА РАЗОВУ ПЕРЕПУСТКУ СПИСКОМ ';   
   COLOR SCHEME  05  
DEFINE WINDOW smotr  FROM 00,00 TO 09,79 ;
   TITLE ' ЗАЯВА НА РАЗОВУ ПЕРЕПУСТКУ СПИСКОМ ';   
   COLOR SCHEME  05  
DEFINE WINDOW w_br  FROM 08,00 TO 20,79 ;
   COLOR SCHEME  17
DEFINE WINDOW OKNO1 FROM 21,00 TO 24,79 ;
   FLOAT COLOR SCHEME 05 
DEFINE WINDOW INFO FROM 16,00 TO 24,79 ;
   FLOAT COLOR SCHEME 05 ; 
   TITLE ' Призначення Клавиш F3-F9 ';   
  FOOTER ' Для виходу натиснўть будь-яку клавўшу ! '
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
IF SP=0 && sp<>0 - Не 1-е обращение
  DO CH_R_P &&  Очистка общих рабочих полей
  ACTIV WIND s_tr 
  DO F_SHAP && Первое формирование общ.полей
 * IF EX_R=1.or.LastKey()=27 && EX_R=1 -> Просто вийти  
  IF EX_R=1.or.La=27 && EX_R=1 -> Просто вийти  
     RELEASE WINDOW S_tr
     RELEASE WINDOW smotr
     RELEASE WINDOW OKNO1
     RELEASE WINDOW w_br
     RELEASE WINDOW INFO
     RETURN
  ENDIF
  DEACTIV WIND s_tr
  APPEND BLANK  
  DO F_O_POLE  && заполнение общ.полей записи файла SPISOK 
 ELSE
  DO Z_V_SHAP && Перепись общ.полей из записи в раб.ячейки
 ENDIF
**********
IF EX_R=0 && EX_R=1 -> Просто вийти  
  DO C_BD && Работа с BROWS по файлу SPISOK 
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
* П Р О Ц Е Д У Р Ы
**********************************************
FUNCTION CH_R_P && Очистка общих рабочих полей
****************
* Очистка общих рабочих полей
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
* формирование общ.полей
FUNCTION F_SHAP  
**************
 RR=0 && все правильно (нач.значение)
 @ 00,20 SAY "Поточна дата: "+DTOC(DATE())
 @ 01,01 SAY "Початк.дата : "
 @ 01,15 GET R_DAT_Z1 SIZE 1,10 ;
         VALID KONT_1()
 @ 01,30 SAY "Кўнцева дата : "
 @ 01,45 GET R_DAT_Z2 SIZE 1,10 ;
         VALID KONT_2() 
 @ 02,01 SAY "Заявка на перепустку дўйсна"
 @ 03,01 SAY " з "
 @ 03,05 GET R_TN1 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '08','18'
 @ 03,08 SAY "год." 
 @ 03,13 GET R_TN2 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '00','60'
 @ 03,16 SAY "хвил."
 @ 03,22 SAY " по"
 @ 03,26 GET R_TK1 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '08','18' ;
    VALID  R_TN1<=R_TK1;
    ERROR 'Начальн.година <'+R_TN1+'> бўльше кўнцево∙ <'+;
           R_TK1+'>. Повторўть операцўю !'
 @ 03,29 SAY "год."
 @ 03,34 GET R_TK2 SIZE 1,2 ;
	PICTURE '99' ;
    RANGE '00','60' ;
    VALID KONT_T()
 @ 03,37 SAY "хвил." 
 @ 04,01 SAY "До кого клўїнт:"
 @ 04,17 GET R_KKOMY SIZE 1,25 ;
    VALID  R_KKOMY<>' ';
   ERROR  " Не заповнено поле <До кого клўїнт>. Повторўть операцўю ! "
 @ 05,01 SAY "Звўдки клўїнт: "
 @ 05,17 GET R_OTKUDA SIZE 1,40 ;
   VALID  R_OTKUDA<>' ';
   ERROR  " Не заповнено поле <Звўдки клўїнт>. Повторўть операцўю ! "

 @ 07,03 GET vih1;
     PICTURE "@*HN Продовжити роботу" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID val_vih()
@ 07,38 GET vih1;
     PICTURE "@*HN Вихўд" ;
     SIZE 1,9,1 ;
     DEFAULT 1 ;
     VALID ex_vih() && EX_R=1 формируется здесь
 READ CYCLE
 ******
LA=LastKey()
IF EX_R=1.or.LA=27 && Выход без формирования
   IF !FILE('Dbfs\TMP_S.DBF')
      sele TMS
      use && TMS
   ENDIF
   RETURN
ENDIF
******
RETURN 
*************************
FUNCTION KONT_1     &&  Контроль нач.даты
 IF R_DAT_Z1< DATE() 
    WAIT 'Поточн.дата <'+DTOC(DATE())+'> бўльше початково∙ <'+;
        DTOC(R_DAT_Z1)+'>.Повторўть !' WINDOW nowait
    =inkey(1)
    Wait Clear 
    _CUROBJ = OBJNUM(R_DAT_Z1)
 ENDIF
 ******
RETURN
*************************
FUNCTION KONT_2    &&  Контроль кўнц.даты
 IF R_DAT_Z2 < DATE().or.R_DAT_Z2 < R_DAT_Z1 
    WAIT 'Невўрна кўнц.дата -> '+DTOC(R_DAT_Z2)+' .Повторўть !' WINDOW nowait
    =inkey(1)
    Wait Clear 
    _CUROBJ = OBJNUM(R_DAT_Z2)
 ENDIF
 ******
RETURN
*************************
FUNCTION KONT_t     &&  Контроль часов-минут
 IF R_TN1=R_TK1.and.R_TN2>=R_TK2
    WAIT 'Нач.час <'+R_TN1+'-'+R_TN2+'> бўльше кўнцевого <'+R_TK1+'-'+R_TK2+'>. Повторўть операцўю !' WINDOW nowait
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
EX_R=1 && Выход без формирования
******
RETURN
**************************
FUNCTION F_O_POLE && заполнение общ.полей записи файла SPISOK 
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
* Перепись общ.полей из записи в раб.ячейки
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
PROC C_BD && Работа с BROWS по файлу SPISOK 
********
ON KEY LABEL F1 DO V_INFO && Вызов справки по F3-F9
ON KEY LABEL F3 do DEL_V  && Послать в БП заявку на аннулирование списка
ON KEY LABEL F4 do COR_K  && Скорректировать общие поля для списка
ON KEY LABEL F5 do ADD_K  && Добавить запись для нового клиента
ON KEY LABEL F6 do DEL_K  && Видалити даного клўїнта з списка
ON KEY LABEL F7 do SOHRAN && Выход (подчистка ненужн.записей) до след.раза
ON KEY LABEL F8 do OTKAZ && Анулировать Заявку
ON KEY LABEL F9 do F_MAIL && Данные для файла сформированы-отправить
ACTIVATE WINDOW OKNO1
@ 00,03 SAY 'У В А Г А ! Пўсля набора Фамўлў∙ необхўдно натиснути Кл.< ENTER > ';
       color w+/r
@ 01,03 SAY 'Додаткова ўнформацўя роботи ўз списоком - Kлавиша < F1 > '
*       color w+/r
*------------
ACTIV WIND smotr
DO POKAZ
DO WHILE .T. 
*-------------
 * EX_R здесь используется как признак выхода из цикла
 * после режима перв.формирования общ.полей, где у ЕХ был другой 
 * статус 
 EX_R=0 && присвоение режима первнач.входа в цикл 
 *======================
 BROW  TITLE ' Список вўдвўдувачев ' FIELDS ;
     FIO:H='       Фамўлўя' :24, ;
     NAM:H="         Ўм'я" :24,;
     OTH:H='      По батьковў':24;
     WINDOW w_br 
 *======================
 IF EX_R=0 && все правильно -выход из цикла DO WHILE and (EX_R=0) 
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
FUNCTION pokaz && через Brows предложение заполнения данных по клиенту 
**************************
 @ 00,15 SAY "Поточна дата: "  &&+DTOC(DATE())
 @ 00,29 SAY DTOC(DATE()) COLOR w+/g
 @ 01,01 SAY "Початк.дата : "
 @ 01,15 SAY R_DAT_Z1 COLOR w+/g
 @ 01,30 SAY "Кўнцева дата : "
 @ 01,45 SAY R_DAT_Z2 COLOR w+/g
*
 @ 02,01 SAY "Заявка на перепустку дўйсна"
 @ 03,01 SAY " з "
 @ 03,05 SAY R_TN1 COLOR w+/g
 @ 03,08 SAY "год." 
 @ 03,13 SAY R_TN2 COLOR w+/g
 @ 03,16 SAY "хвил." 
 @ 03,22 SAY " по"
 @ 03,26 SAY R_TK1 COLOR w+/g
 @ 03,29 SAY "год."
 @ 03,34 SAY R_TK2 COLOR w+/g
 @ 03,37 SAY "хвил."
 @ 04,01 SAY "До кого клўїнт:"
 @ 04,17 SAY R_KKOMY COLOR w+/g
 @ 05,01 SAY "Звўдки клўїнт: "
 @ 05,17 SAY R_OTKUDA COLOR w+/g
************
RETURN
**************************
PROC V_INFO && Вызов Информац.окна F3-F9
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
@ 00,02 SAY 'Заявка в Бюро Перепусток на анулювання списка      - Kлавиша < F3 > '
@ 01,02 SAY 'Скоригувати загальнў поля для Списка               - Kлавиша < F4 > '
@ 02,02 SAY 'Добавити нового клўїнта у Список                   - Kлавиша < F5 > '
@ 03,02 SAY 'Видалити даного клўїнта з Списка                   - Kлавиша < F6 >'
@ 04,02 SAY 'Зберегти  ўнформацўю ў закўнчити роботу з Списком  - Kлавиша < F7 >'
@ 05,02 SAY 'Анулювати данў Списка ў закўнчити роботу з Списком - Kлавиша < F8 >'
@ 06,02 SAY 'Вўдправити Список ў закўнчити роботу з Списком     - Kлавиша < F9 >'
READ
DEACTIV WIND INFO
ON KEY LABEL F1 DO V_INFO && Вызов справки по F3-F9
ON KEY LABEL F3 do DEL_V  && Послать в БП заявку на аннулирование списка
ON KEY LABEL F4 do COR_K  && Скорректировать общие поля для списка
ON KEY LABEL F5 do ADD_K  && Добавить запись для нового клиента
ON KEY LABEL F6 do DEL_K  && Видалити даного клўїнта з списка
ON KEY LABEL F7 do SOHRAN && Выход (подчистка ненужн.записей) до след.раза
ON KEY LABEL F8 do OTKAZ && Анулировать Заявку
ON KEY LABEL F9 do F_MAIL && Данные для файла сформированы-отправить
*******
return
**************************      
PROC DEL_V && Послать в БП заявку на аннулирование списка 
**************************
R_DEL=1
do F_MAIL
******
RETURN
**************************      
PROC COR_K  && Скорректировать общие поля для списка - F4
**************************
EX_R=0 && Очистка 
DEACTIV WIND smotr
ACTIV WIND s_tr
DO F_SHAP && формирование общ.полей
Sele SPI 
go top
IF EX_R=1.or.LA=27 && Выход- ЕХ=1-отказ от редактирования
    DO  Z_V_SHAP && Перепись общ.полей из записи в раб.ячейки
  ELSE
   GO TOP
   Do while !EOF()
     DO F_O_POLE  && заполнение общ.полей записи файла SPI      
     skip
   ENDDO         
ENDIF
Go top
DEACTIV WIND s_tr
ACTIV WIND smotr
DO POKAZ
EX_R=1 && Сохранение режима работы в цикле с BROW
******
RETURN
**************************      
PROC ADD_K && Добавить запись для нового клиента - F5
**************************
*pack
COUNT TO SP
go top
IF SP=0.and.(R_TN1<>' '.or.R_TN2<>' ')  && Удалили запись и стала пустая БД
  APPEND BLANK  
  DO F_O_POLE  && заполнение общ.полей записи файла SPISOK 
ELSE
 DO Z_V_SHAP && Перепись общ.полей из записи в раб.ячейки
 IF FIO=' '
    WAIT " Не заповнена ФАМЎЛЎЯ. Повторўть операцўю ! " WINDOW NOWAIT 
    =Inkey(1)
    Wait Clear
    EX_R=1 && Неверно !
    RETURN 
  ENDIF
 APPEND BLANK  
 DO F_O_POLE  && заполнение общ.полей записи файла SPISOK 
ENDIF
******
RETURN
**************************      
PROC DEL_K && Удалить запись по клиенту - F6
**************************
 vix=.F.
 DO VARIANT WITH 'Видалити запис ?',vix,8   && ВИДАЛИТИ ЗАПИС
 IF vix && ВИДАЛИТИ ЗАПИС
    WAIT " Данў по клўїнту <"+ALLTRIM(FIO)+"> видаленў з Заявки ! " WINDOW NOWAIT
    =Inkey(1)
    Wait Clear
    DELETE
 ENDIF 
 ******
RETURN
**************************
PROC SOHRAN && Выход (подчистка ненужн.записей) до след.раза - F7
**************************
 IF R_DAT_Z1< DAT_R.or.R_DAT_Z2< DAT_R
    WAIT 'Поточн.дата > заказ.дат перўоду ' ;
        +'.Необхўдно корегуання Списку (Кл. F4) !' WINDOW nowait
    =Inkey(3)
    Wait Clear
    EX_R=1 && Неверно!
    RETURN
 ENDIF
  *****
 DO F_O_POLE  && заполнение общ.полей записи файла SPISOK 
 ******
 IF FIO=' '
    WAIT " Не заповнена ФАМЎЛЎЯ. Повторўть операцўю ! " WINDOW NOWAIT 
    =Inkey(1)
    Wait Clear
    EX_R=1 && Неверно!
    RETURN 
 ENDIF
 GO top
 DO While !EOF() && Удаление записей с пуст FIO
   IF ALLTRIM(FIO)=' '
     Delete
   ENDIF 
   skip
 ENDDO
 PACK && подчистка файла SPISOK от удаленных записей
 ***** одновременно используется для закрытия BROWs 
 EX_R=0 && Все правильно! Выход из цикла с Brows 
********
RETURN
*************************
PROC OTKAZ && Анулювати данў Заявки ў закўнчити роботу - F8
**********
 De=0 && Очиска 
 vix=.F.
 DO VARIANT WITH 'Анулювати СПИСОК ?',vix,8   && ВИДАЛИТИ Файл-СПИСОК
 IF vix && ВИДАЛИТИ СПИСОК
  WAIT " СПИСОК АНУЛЬОВАН !! ! " WINDOW NOWAIT 
  =Inkey(1)
  Wait Clear
  DE=1 && De=1 -> Анулювати список и соотв.файл Списка (в осн.Программе)
  EX_R=0 && Все правильно! Выход из цикла с Brows 
  PACK && Псевдоочистка для закрытия BROWs 
 ENDIF
******
RETURN
**************************
PROC F_MAIL && Данные для файла сформированы-отправить - F9
**************************
* sele SPI
 IF R_DAT_Z1< DAT_R.or.R_DAT_Z2< DAT_R
   WAIT 'Поточн.дата > заказ.дат перўоду ' ;
       +'.Необхўдно корегуання Списку (Кл. F4) !' WINDOW nowait
   =Inkey(3)
   Wait Clear
   EX_R=1 && Неверно!
   RETURN
ENDIF
 *****
DO F_O_POLE  && заполнение общ.полей записи файла SPISOK 
******
IF FIO=' '
   WAIT " Не заповнена ФАМЎЛЎЯ. Повторўть операцўю ! " WINDOW NOWAIT
   =Inkey(1)
   Wait Clear
   EX_R=1 && Неверно !
   RETURN 
 ENDIF
IF R_DEL=1
  WAIT " ЗАЯВКА на Анулювання СПИСКУ вўдправляїться через Почту ! " WINDOW NOWAIT
ELSE
 WAIT " Сформована ЗАЯВКА вўдправляїться через Почту ! " WINDOW NOWAIT
ENDIF
=Inkey(1)
Wait Clear
GO top
DO While !EOF() && Пометка записей с пуст FIO
   IF ALLTRIM(FIO)=' '
     Delete
   ENDIF 
   skip
ENDDO
PACK && Предварительная очистка файла &R_NAM (список) перед отправкой
********
 Sele Tmp1 && Формир.файла для отправки из SPI
 ZAP && Очистка, если до этого был список
 sele SPI
 D1=DAT_Z1
 D2=DAT_Z2
 D_S=D1 && нач.шаг цикла
 DO WHILE D_S<=D2 && Цикл по датам - начальная и конечная
   sele tms && пром.раб файл с 1 полем DAT_Z
   R_PO=R_NAM+'.DBF'
   APPEND FROM &R_PO && в TMS(1 полe) из SPISOKов с 2 полями дат 
   REPLACE ALL DAT_Z WITH D_S  
   sele tmp1 && Формир.файла для отправки из SPI через TMS
   APPEND FROM dbfs\tmp_s.dbf
   sele tms && Очистка  TMS
   zap
  D_S=D_S+1 && след.день в цикле !
 ENDDO
*******
N_DAT=SUBSTR(DTOC(DATE()),1,2)+SUBSTR(DTOC(DATE()),4,2)
N_DBF=STRTRAN(STR(SHT.NN_T,3),' ','0')  && 00N !!!!
N_USN=STRTRAN(RIGHT(NUSER,2),' ','0')
*
NAME=FULLPATH('ZP'+N_USN+N_DAT+'.'+N_DBF)
*
Sele Tmp1 && Доформир.файла для отправки списка данными файла Е000.dbf
REPLACE ALL OTDEL      WITH _OTDEL
REPLACE ALL FIO_OTD    WITH _FIO
*  !!!!!
REPLACE ALL DEL        WITH R_DEL
* 
copy to &NAME
* sele ZAV
* APPEND FROM &NAME && Добавление в ВД отдела записей СПИСКА
* Дописываются только общие поля !
*********
 go top
 ! FOXSWAP ot_zajav.bat &name,&my_box,&kuda,&uzel > prot.txt
*********
* sele SPI
* REPLACE NN_T       WITH SHT.NN_T 
 NN=NN+1 && N след файла на 1 больше !
 sele SHT
 REPLACE NN_T       WITH NN
 sele SPI
 REPLACE NN_T       WITH SHT.NN_T 
 EX_R=0 && Все правильно! Выход из цикла с Brows
********
RETURN
*********
**************************************
**************************************
