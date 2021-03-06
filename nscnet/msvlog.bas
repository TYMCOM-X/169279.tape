10 'SAVE"C:PANDG.BAS",A
20 'SAVE"C.PANDG.BBB",A
30 '==========================================
40 '  X.PC MODEM AUTO SET UP
50 '
60 '  V1.01 : 24 APR 1987, by Y.FURUTA
70 '  V1.02 : 24 JUN 1987, by Y.FURUTA
80 '  V1.03 : 24 SEP 1987, by M YAMAUCHI
90 VR$="V1.02"
100 '==========================================
110 CLS  :DEFINT A-Z:DIM CLST$(10):CR$=CHR$(13)
120 '
130 '
140 '--- MAIN ---
150 LOCATE 6,20:PRINT"**************************************"
160 LOCATE 7,20:PRINT"*                                    *"
170 LOCATE 8,20:PRINT"*        ";:PRINT" x. pc      ";:PRINT" SETTER Ver.1.03*"
180 LOCATE 9,20:PRINT"*        ";:PRINT"CCITT2400/1200BPS";:PRINT"   90/06/04*"
190 LOCATE 10,20:PRINT"*         1. ANSWER MODE             *"
200 LOCATE 11,20:PRINT"*         2. ORIGINATE MODE          *"
210 LOCATE 12,20:PRINT"*         3. CONSAT OUTDIAL          *"
220 LOCATE 13,20:PRINT"*         4. MEMORY CHECK MODE       *"
230 LOCATE 14,20:PRINT"*         5. SETUP CHECK MODE        *"
240 LOCATE 15,20:PRINT"*                                    *"
250 LOCATE 16,20:PRINT"*         9. P&G MENU SERVER MESSAGE *"
260 LOCATE 17,20:PRINT"*         E. EXIT                    *"
270 LOCATE 18,20:PRINT"**************************************"
280 LOCATE 20,20:PRINT"SELECT >> ";
290 Y$=INKEY$:IF Y$="" THEN GOTO 290 ELSE PRINT Y$
300 IF Y$="1" THEN RESTORE 410     :GOSUB 470
310 IF Y$="2" THEN RESTORE 420     :GOSUB 470
320 IF Y$="3" THEN RESTORE 430     :GOSUB 470
330 IF Y$="4" THEN RUN"MODEM.BAS
340 IF Y$="5" THEN RUN"CHECK.BAS
350 IF Y$="9" THEN GOSUB 710
355 IF Y$="P" THEN GOSUB 710
360 IF Y$="E" OR Y$="e" THEN SYSTEM
370 CLS  :GOTO 150
380 '-----------------
390 ' TABLE
400 '-----------------
410 DATA 0,09,AT&F,ATX,ATB,ATM,ATS0=2,AT&S1,AT&C1,AT&D3,ATQ&W
420 DATA 1,06,AT&F,ATB,ATX3,AT&D3,ATL,AT&W
430 DATA 2,10,AT&F,ATB,ATX3,AT&D3,ATL,ATE0,ATV0,AT&C1,AT&S1,AT&W
440 '--------------------------
450 ' MODEM SET UP ROUTINE
460 '--------------------------
470               READ OPT,CNT
480 FOR I=1 TO CNT:READ CLST$(I):NEXT
490 CLS
500 IF Y$="1" THEN PRINT"ANSWER      ";
510 IF Y$="2" THEN PRINT "ORIGINATE         ";
520 IF Y$="3" THEN PRINT "CONSAT OUTDIAL         ";
530 PRINT"  MODE SET UP":PRINT
540 '----  LINE OPEN
550 PRINT"PLEASE CONNECT NEW MODEM TO PC PORT":PRINT"TYPE ANY KEY TO START SETUP":PRINT
560 YY$=INKEY$:IF YY$="" THEN 560
570 OPEN "COM1:2400,N,8,1,RS,CS,DS,CD" AS #1
580 PRINT#1,CR$;
590 FOR I=1 TO CNT
600    PRINT #1,CLST$(I);CR$;:PRINT CLST$(I),
610    IF CLST$(I)="ATQ1&W" THEN PRINT:GOTO 640
620    INPUT #1,W$
630    IF INSTR(W$,"OK")>0 OR INSTR(W$,"0") THEN PRINT "OK" ELSE GOTO 620
640    FOR J=1 TO  700:NEXT J
650 NEXT
660 CLOSE #1:PRINT:PRINT :PRINT"  more ? Y/N > "
670 YY$=INKEY$:IF YY$="" THEN GOTO 670
680 IF YY$="y" OR YY$="Y" THEN GOTO 300
690 RETURN
700 '----  TTY TERMINAL MODE
710 IF Y$="P" THEN LOGIN$="ISISTECH:1000;B2BOMBER" : GOTO 780 ELSE PRINT
720 INPUT "     Type in login user name and password >> ";LOGIN$
730 PRINT :PRINT "     Your login code is = "+LOGIN$ :PRINT
740 INPUT "     OK ?   Please type Y or N >> ";OK$
750 IF OK$="N" OR OK$="n" THEN CLS :GOTO 710
755 IF OK$="Y" OR OK$="y" THEN GOTO 780
760 PRINT :PRINT "     Invalide input. Try again"
770 FOR T=0 TO 30000 :NEXT T :CLS :GOTO 710
780 OPEN "COM1:1200,S,7,1,RS,CS,DS,CD" AS #1
790 ON COM(1) GOSUB 1240
800 COM(1) ON
810 GOSUB 1930 : GOSUB 1930' TIMER
820 PRINT #1,"A";
830 FOR T=0 TO 10000 :NEXT T
840 'LOGIN$="ISISTECH:1000;B2BOMBER"
850 FOR I=1 TO 23 :SEND$=MID$(LOGIN$,I,1)
860 FOR T=0 TO 300 :NEXT T
870 PRINT #1,SEND$;
880 NEXT I
890 PRINT #1,CR$;
900 'A$=INKEY$
910 'IF A$="" THEN GOTO 840
920 ' IF A$=CHR$(26) THEN GOTO 890
930 ' PRINT #1,A$;:GOTO  840
940 FOR T=0 TO 30000 :NEXT T
950 '*TICKLER MODE MENU
960 CLS
970 PRINT "      Enter MENU SERVER TICKLER mode"
980 PRINT
990 PRINT "      1. P&G Host down "
1000 PRINT "      2. Tymnet node down"
1010 PRINT "      3. Between tymnet and P&G line is down"
1020 PRINT "      4. PAD of P&G is hang up"
1030 PRINT
1040 PRINT
1050 PRINT "      5. Message clear"
1060 PRINT
1070 PRINT "         SELECT   > ";
1080 Y$=INKEY$  :IF Y$="" THEN GOTO 1080 ELSE PRINT Y$
1090 IF Y$="1" THEN TEXT$="HOST.MSG" :GOTO 1300
1100 IF Y$="2" THEN TEXT$="NODE.MSG" :GOTO 1300
1110 IF Y$="3" THEN TEXT$="LINE.MSG" :GOTO 1300
1120 IF Y$="4" THEN TEXT$="PAD.MSG"  :GOTO 1300
1130 IF Y$="5" THEN GOTO 1300
1140 IF Y$="M" OR Y$="m" THEN GOTO 1160
1150 GOTO 960
1160 PRINT
1170 INPUT "         TYPE IN TEXT FILE NAME >> "; TEXT$
1180 ON ERROR GOTO 1210
1190 OPEN "C:"+TEXT$ FOR INPUT AS #2
1200 IF LOF(2)>=2 THEN CLOSE #2: GOTO 1300 ELSE PRINT :PRINT "        "+TEXT$+" file not found. try again!!":PRINT :GOTO 1070
1210  PRINT :PRINT "        "+TEXT$+" file not found. try again!!":PRINT :GOTO 1070
1220 'GOTO 1200
1230 *RCV
1240 COM(1) STOP
1250 IF LOC(1)=0 THEN COM(1) ON:RETURN
1260 B$=INPUT$(1,1):IF (ASC(B$) AND &H7F)=&HD THEN GOTO 1250
1270 PRINT B$;:GOTO 1250
1280 RETURN
1290 *TEXT SEND
1300 FOR T=0 TO 10000 :NEXT T
1310 IF Y$="1" OR Y$="2" OR Y$="3" OR Y$="4" OR Y$="M" OR Y$="m"  THEN GOSUB 1760 :GOSUB 1340 :GOTO 1730
1320 IF Y$="5" THEN GOSUB 1510 :GOTO 1730
1330 '*TEXT WRITE
1340 GOSUB 1930
1350 PRINT #1, CHR$(4);
1360 GOSUB 1930
1370 PRINT #1, CHR$(13);
1380 GOSUB 1930
1390 PRINT #1, "Y";
1400 GOSUB 1930
1410 PRINT #1, "3";
1420 GOSUB 1930
1430 PRINT #1, CHR$(13);
1440 GOSUB 1930
1450 PRINT #1, "Y";
1460 GOSUB 1930
1470 PRINT #1, "4";
1480 GOSUB 1930
1490 RETURN
1500 '*TEXT CLEAR
1510 'GOSUB 1740 :GOSUB 1740
1520 PRINT #1, "1";
1530 GOSUB 1930
1540 PRINT #1, CHR$(4);
1550 GOSUB 1930
1560 PRINT #1, CHR$(13);
1570 GOSUB 1930
1580 PRINT #1, "Y";
1590 GOSUB 1930
1600 PRINT #1, "3";
1610 GOSUB 1930
1620 PRINT #1, CHR$(13);
1630 GOSUB 1930
1640 PRINT #1, "Y";
1650 GOSUB 1930
1660 CLS
1670 PRINT
1680 PRINT "   Now finished message clear !!":PRINT
1690 PRINT "   Thank you support." :PRINT
1700 PRINT #1, "4";
1710 GOSUB 1930
1720 RETURN
1730 A$=INKEY$
1740 IF A$="" THEN GOTO 1730 ELSE PRINT #1,A$; :GOTO 1730
1750 ' TEXT WRITE TO MENU SERVER MENU
1760 FOR T=0 TO 10000 :NEXT T
1770 PRINT #1, "1";
1780 FOR T=0 TO 10000 :NEXT T
1790  OPEN "C:"+TEXT$  FOR INPUT AS #2
1800   WHILE NOT EOF(2)
1810 INPUT #2,C$
1820 FOR I=1 TO 80 :SEND$=MID$(C$,I,1)
1830 FOR X=0 TO 100:NEXT X
1840 '
1850 '
1860 IF SEND$=CHR$(13) THEN GOTO 1880
1870 PRINT #1,SEND$;
1880 NEXT I
1890 PRINT #1,CR$;
1900   WEND:CLOSE #2
1910   RETURN
1920 ' TIMER ROUTINE '
1930 FOR T=0 TO 18000  :NEXT T :RETURN
   