R (UPL)X22
O BASE2
UPD
USE KEY2

GO WAIT

DECLARE ALL UPD UPD BASE2.DMS

DAY
RENAME BASE6.DMS,BA6.DMS
R (UPL)X22
O BA6
FI ALL
DUMP TO BASE6
CLOSE
O BASE6
UPD
USE KEY6

GO WAIT

DECLARE ALL UPD UPD BASE6.DMS

DAY
RENAME CALBAK.DMS,BA8.DMS
R (UPL)X22
O BA8
FI ALL
DUMP TO CALBAK
CLOSE
O CALBAK
UPD
USE KEY8

GO WAIT

DECLARE ALL UPD UPD CALBAK.DMS

DAY

DIR *.DMS/TOD

;; NOW DELETE THE BA#.DMS FILES IF ALL WENT WELL

DEL BA#.DMS

GO REPORT
7
Q

;; NOW CHECK THE SIZE OF BASE5.

R (UPL)X22
O BASE5
FI ALL
PRI MAX SYSID
CLOSE
Q

;; IF MAX SYSID IS GREATER THAN 160,000 PLEASE NOTIFY JIM PARKER

DAY