DATE
R CKSUM
*BASE7.DMS
*
COPY BASE7.DMS,BASE7.TEM
R (UPL)FTX22
*OPEN BASE7.TEM
*F ALL
*DUMP BASE7.NEW
*OPEN BASE7.NEW
*KEY BUFFER 6 NULL 20 CORE 10 ALL
*QUIT
DECLARE ALL RD RD BASE7.NEW
DELETE BASE7.DMS
RENAME BASE7.NEW,BASE7.DMS
R (UPL)FTX22
*OPEN BASE7
*INFO ADMIT
*ADMIT 21477 632362 OWNER
*INFO ADMIT
*QUIT
R (UPL)FTX22
*OPEN BASE7 BASE7.TEM
*DBS 2
*F ALL
*INFORM ON BASE7.ADM ADMIT
*DBS 1
*F ALL
*USE BASE7.ADM
*INF ADM
*QUIT
DATE
R CKSUM
*BASE7.DMS
*
  