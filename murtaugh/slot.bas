'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'               ***  AUTOSLOT- Automatic reload code  ***
'ORIGIN:  J.L. Miller                              DATE:   05/13/91
'WARNING: This program is still under development. Please report problems to
'J.L. Miller/MANAGER VANCF..........................
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

COMMON SHARED com.speed$, com.port$, com.modem$    'OPEN.COM Data
COMMON SHARED xx$, yy$, id$                        'WIND data
COMMON SHARED in$, dd$, return$, no.return$        'COM In data
COMMON SHARED out$                                 'COM Out data

     SCREEN 0
     COLOR 7, 1, 7
     DIM in$(1000)
     s$ = ""
     in$ = ""
     p = 0
     AUX = 0
     pict1$ = CHR$(218) + CHR$(195) + CHR$(195) + CHR$(195) + CHR$(195) + CHR$(192)
     pict2$ = CHR$(192) + CHR$(193) + CHR$(193) + CHR$(193) + CHR$(193) + CHR$(193) + CHR$(217)
     pict3$ = CHR$(223) + CHR$(220)
     no.return$ = ""
    
     '===========================================================================
     '              ***  CONTROL UNIT - MAIN LINE  ***
     '===========================================================================
    
     GOSUB logon.mem.mod
     GOSUB logon.data

main:

     CLS
     ON ERROR GOTO 0
     ON ERROR GOTO err1

240
     FOR s = 1 TO 4
          PRINT
     NEXT s
     PRINT "                              R) RUN AUTOSLOT"
     PRINT "                              F) LIST FAILED HOSTS"
     PRINT "                              S) LIST COMPLETED HOSTS"
     PRINT "                              U) UPDATE DATA TABLES"
     PRINT "                              E) EXIT TO SYSTEM"
     PRINT "                              N) START AT HOST"
     PRINT
     PRINT "                              -----------------------"
     
     PRINT "                              Enter selection :";
main.1:
     s$ = INKEY$
     IF s$ = "" THEN GOTO main.1
     s$ = UCASE$(s$)
     IF s$ = "E" THEN
          SYSTEM
     END IF
     IF s$ = "F" THEN
          GOTO list.failed.hosts
     END IF
     IF s$ = "S" THEN
          GOTO list.completed
     END IF
     IF s$ = "R" THEN
          GOTO runner
     END IF
     IF s$ = "U" THEN
          GOTO GETPROBE
     END IF
    IF s$ = "N" THEN
          CLS
          INPUT "ENTER NODE# OF START POINT"; START
          GOTO runner
    END IF
    BEEP
    GOTO main.1

runner:
     VIEW PRINT 14 TO 15
     LOCATE 14, 1
     COLOR 7, 1, 7
     PRINT STRING$(80, 178)
     VIEW PRINT 16 TO 23
     COLOR 2, 0, 7
     CLS
     GOSUB mux.logon
     'GOSUB sys.logon
     COLOR 2, 0, 7
     CLS
380
     CLOSE #2: CLOSE #3
 
     OPEN "SOK.DAT" FOR OUTPUT AS #4
     OPEN "consat.rnd" FOR RANDOM AS #2 LEN = 19
     FIELD #2, 6 AS chost$, 6 AS cnode$, 6 AS ckh$, 1 AS cslot$
     OPEN "SFAIL.DAT" FOR OUTPUT AS #3
     OPEN "iscs.1" FOR INPUT AS #5

400
     IF EOF(5) THEN GOTO 480
     LINE INPUT #5, targ$
    
     node$ = MID$(targ$, 7, 5)
     slot$ = MID$(targ$, 19, 1)
     kh$ = MID$(targ$, 13, 5)
     
     
dc1:
     IF RIGHT$(node$, 1) = " " THEN node$ = LEFT$(node$, LEN(node$) - 1): GOTO dc1
     IF LEN(node$) = 4 THEN node$ = "0" + node$
     LOCATE 17, 2
     PRINT "Function", "Host", "Slot", "Node"
     LOCATE 18, 2
     PRINT "--------", "----", "----", "----"
     LOCATE 19, 2
     PRINT "Reloading", kh$, slot$, node$
     GOSUB ddt.logon
     GOSUB ddt.checker
     GOSUB reload.circuit
     GOSUB reload.slot
     
1
3
          CLS
          COLOR 2, 0
          FOR yy = 16 TO 23
               LOCATE yy, 71
               PRINT " "
          NEXT yy
          GOTO 400
    
     FOR R = 1 TO 3
          BEEP
     NEXT R
480
     CLS
     LOCATE 23, 20
     PRINT "DONE SLOT RELOADS...RETURNING TO MENU..."
     CLOSE #3
     CLOSE #4
    
     FOR T = 1 TO 5000
     NEXT T

     CLS
     GOTO 240
     PRINT #1, "@Z";

mux.logon:
     LOCATE 17, 2
     PRINT "MUX Logon In Progress";
     LOCATE 18, 23
     COLOR 4, 0
     PRINT pict2$
     COLOR 2, 0
     LOCATE 17, 23
     COLOR 7, 0
     CLOSE #1
CALL OPEN.COM
CALL waiter
   
'*****
    
     in$ = ""
     return$ = "x"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 32000, 2
     in$ = ""

'*****

     PRINT #1, "a";

     return$ = "in:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, MXNAM$; CHR$(13);

     return$ = "password:"
CALL get.char
     
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""
   
'*****

     PRINT #1, MXPAS$; CHR$(13);
    
     return$ = mxrtrn$
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""
   
'*****

     PRINT #1, "CHAR 08"; CHR$(13);

     return$ = mxrtrn$
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""
   
'*****

     FOR ttu = 1 TO 10
          PRINT #1, "z"; CHR$(13);
     NEXT ttu
    
     return$ = "specified"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP

     return$ = mxrtrn$
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****
    
     COLOR 2, 0
     PRINT "Complete"
     SOUND 5000, 4
     RETURN

sys.logon:

     LOCATE 20, 71
     PRINT CHR$(219)
    
     LOCATE 19, 2
     PRINT "SYSTEM Logon In Progress";
     LOCATE 20, 26
     COLOR 4, 0
     PRINT pict2$
     COLOR 2, 0
     LOCATE 19, 26

'*****
    
     COLOR 7, 0
     PRINT #1, "M,"; sys$; CHR$(13);

     return$ = "in:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, gate$; CHR$(13);

     return$ = "in:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, SYSNAM$; ":"; sys$; ";"; SYSPAS$; CHR$(13);

     return$ = "login:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, REDNAM$; CHR$(13);

     return$ = "Password:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, REDPAS$; CHR$(13);

     return$ = "selection:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, "vt100"; CHR$(13);
    
     return$ = "%"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, CHR$(8) + "z";
   
     return$ = mxrtrn$
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****
    
     COLOR 2, 0
     PRINT "Complete"
     SOUND 5000, 4
     RETURN

reload.slot:

     LOCATE 20, 71
     PRINT CHR$(219)

'*****

     PRINT #1, "cd "; node$; CHR$(13);
  
     return$ = "%"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, "sload"; CHR$(13);
 
     return$ = "number:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

     LOCATE 18, 71
     PRINT CHR$(219)


'*****
     PRINT #1, kh$; CHR$(13);
 
     return$ = "Slot number:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****
     PRINT #1, slot$; CHR$(13);
 
     return$ = "file name:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: GOTO slot.in.use
     SOUND 5000, 4
     in$ = ""

'*****
     sslot$ = "n0" + slot$
     PRINT #1, sslot$; CHR$(13);

     return$ = "target:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****
    
     PRINT #1, lodpas$; CHR$(13);

     return$ = "Connecting to network"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****
     'CALL waiter
     'CALL waiter
     'CALL waiter
     return$ = "initializing mac"
CALL get.char
     IF no.return$ = "on" THEN
          no.return$ = ""
          py = INSTR(1, in$, "zapped")
          IF py <> 0 THEN GOTO zapped
          PRINT in$
          STOP
     END IF
     SOUND 5000, 4
     in$ = ""


     LOCATE 17, 71
     PRINT CHR$(219)


'*****

     return$ = "loaded and started."
     

CALL get.char
     IF no.return$ = "on" THEN no.return$ = ""
     qrt = INSTR(1, in$, "space exceeded")
     IF qrt <> 0 THEN
          PRINT #3, "Host   -> "; host$
          PRINT #3, "Node   -> "; node$
          PRINT #3, "Status -> "; "Complete"
          PRINT #3, "Date   -> "; DATE$
          PRINT #3, "Time   -> "; TIME$
     END IF

     PRINT CHR$(175);
     SOUND 5000, 4
     
     in$ = ""

'*****
    
     return$ = "%"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$
     PRINT CHR$(175);
     SOUND 5000, 4
     in$ = ""

'*****
     PRINT #1, CHR$(8) + "z";
     return$ = mxrtrn$
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""
     SOUND 5000, 4
     IF qrt <> 0 THEN qrt = 0: GOTO qrt1
     GOSUB record.yes
qrt1:
     LOCATE 17, 71
     PRINT CHR$(219)

     RETURN
   
record.yes:
in$ = ""
PRINT #4, "Host   -> "; host$
PRINT #4, "Node   -> "; node$
PRINT #4, "Status -> "; "Complete"
PRINT #4, "Date   -> "; DATE$
PRINT #4, "Time   -> "; TIME$
PRINT #1, "z"; CHR$(13);
     return$ = mxrtrn$
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""


RETURN

record.no:

PRINT #3, "Host   -> "; host$
PRINT #3, "Node   -> "; node$
PRINT #3, "Status -> "; "Complete"
PRINT #3, "Date   -> "; DATE$
PRINT #3, "Time   -> "; TIME$
RETURN 3

list.failed.hosts:

CLOSE #3
     OPEN "SFAIL.DAT" FOR INPUT AS #3
     CLS

failed.1:

     IF EOF(3) THEN
          GOTO failed.2
     END IF
     INPUT #3, F$
     PRINT F$; "  ";
     LPRINT F$; "  ";
     GOTO failed.1

failed.2:

     INPUT "END OF LIST...DEPRESS ENTER/RETURN TO RETURN TO MENU..."; M$
     CLOSE (3)
     OPEN "FAILED.999" FOR APPEND AS #3
     GOTO main

list.completed:

     OPEN "SOK.DAT" FOR INPUT AS #4

completed.1:

     IF EOF(4) THEN
          GOTO completed.2
     END IF
     INPUT #4, DUM$
     PRINT DUM$; "  ";
     GOTO completed.1

completed.2:

     CLOSE #4
     PRINT
     PRINT
     PRINT
     INPUT "END OF LIST...DEPRESS ENTER/RETURN TO RETURN TO MENU..."; M$
     GOTO main

logon.data:
      '======================================================================
      '                 LOGON DATA
      '======================================================================
      COLOR 7, 1, 7
      CLS
      COLOR 7, 1, 7
      LOCATE 15, 20
      PRINT "LOGON IN PROGRESS...PLEASE WAIT"
      COLOR 7, 1, 7
     
      CLOSE #2
      OPEN "COMSPEED.DAT" FOR INPUT AS #2
      LINE INPUT #2, com.speed$

      CLOSE #2
      OPEN "COMPORT.DAT" FOR INPUT AS #2
      LINE INPUT #2, com.port$
      
      CLOSE #2
      OPEN "COMMODEM.DAT" FOR INPUT AS #2
      LINE INPUT #2, com.modem$

      CLOSE #2
      OPEN "RETURN.dat" FOR INPUT AS #2
      LINE INPUT #2, return$

      CLOSE #2
      OPEN "GATE.DAT" FOR INPUT AS #2
      LINE INPUT #2, gate$

      CLOSE #2
      OPEN "PRNAM.DAT" FOR INPUT AS #2
      LINE INPUT #2, prnam$

      CLOSE #2
      OPEN "PRPAS.DAT" FOR INPUT AS #2
      LINE INPUT #2, prpas$

      CLOSE #2
      OPEN "PROBE.DAT" FOR INPUT AS #2
      LINE INPUT #2, probe$

      CLOSE #2
      OPEN "sys.dat" FOR INPUT AS #2
      INPUT #2, sys$
     
      CLOSE #2
      OPEN "sysnam.dat" FOR INPUT AS #2
      INPUT #2, SYSNAM$

      CLOSE #2
      OPEN "syspas.dat" FOR INPUT AS #2
      INPUT #2, SYSPAS$
     
      CLOSE #2
      OPEN "ddtpas.dat" FOR INPUT AS #2
      INPUT #2, ddtpas$
     
      CLOSE #2
      OPEN "ddtnam.dat" FOR INPUT AS #2
      INPUT #2, ddtnam$
     
      CLOSE #2
      OPEN "mxnam.dat" FOR INPUT AS #2
      INPUT #2, MXNAM$
     
      CLOSE #2
      OPEN "mxpas.dat" FOR INPUT AS #2
      INPUT #2, MXPAS$

      CLOSE #2
      OPEN "mxrtrn.dat" FOR INPUT AS #2
      LINE INPUT #2, mxrtrn$
     
      CLOSE #2
      OPEN "lodpas.dat" FOR INPUT AS #2
      INPUT #2, lodpas$
     
      CLOSE #2
      OPEN "rednam.dat" FOR INPUT AS #2
      INPUT #2, REDNAM$
     
      CLOSE #2
      OPEN "redpas.dat" FOR INPUT AS #2
      INPUT #2, REDPAS$
     
      CLOSE #2
      RETURN

logon.mem.mod:
      '=======================================================================
      '                 LOGON MEM MOD
      '=======================================================================
      CLS
      COLOR 7, 1, 7
     
      LOCATE 15, 15
      PRINT "DO YOU NEED TO CHANGE LOGON NAMES/PASSWORDS...(Y/N) ?";
logon.mem.mod.1:
      an$ = INKEY$
      IF an$ = "" THEN GOTO logon.mem.mod.1
      IF an$ = "N" OR an$ = "n" THEN
          RETURN
      END IF
     
      CLOSE #2
      OPEN "sys.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter system number under which reload code is located..."; sys$
      PRINT #2, sys$
     
      CLOSE #2
      OPEN "sysnam.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter system user name..."; SYSNAM$
      PRINT #2, SYSNAM$
     
      CLOSE #2
      OPEN "syspas.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter system password..."; SYSPAS$
      PRINT #2, SYSPAS$
     
      CLOSE #2
      OPEN "PROB.DAT" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 10
      LINE INPUT "Please logon PROBE..."; PROB$
      PRINT #2, PROB$
     
      CLOSE #2
      OPEN "prnam.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter PROBE user name..."; prnam$
      PRINT #2, prnam$
     
      CLOSE #2
      OPEN "prpas.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter PROBE password..."; prpas$
      PRINT #2, prpas$
     
      CLOSE #2
      OPEN "ddtpas.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter DDT password..."; ddtpas$
      PRINT #2, ddtpas$
     
      CLOSE #2
      OPEN "DDTNAM.DAT" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter DDT user name..."; ddtnam$
      PRINT #2, ddtnam$
     
      CLOSE #2
      OPEN "mxnam.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter MUX user name..."; MXNAM$
      PRINT #2, MXNAM$
     
      CLOSE #2
      OPEN "mxpas.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter MUX password..."; MXPAS$
      PRINT #2, MXPAS$
     
      CLOSE #2
      OPEN "lodpas.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter LOADII password..."; lodpas$
      PRINT #2, lodpas$
     
      CLOSE #2
      OPEN "rednam.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter read license name..."; REDNAM$
      PRINT #2, REDNAM$
     
      CLOSE #2
      OPEN "redpas.dat" FOR OUTPUT AS #2
      CLS
      LOCATE 15, 20
      INPUT "Enter read license password..."; REDPAS$
      PRINT #2, REDPAS$
     
      CLOSE #2
      RETURN

er:

IF ERR = 57 THEN RESUME
ON ERROR GOTO 0
ON ERROR GOTO er
RESUME

err1:

IF ERR = 57 THEN RESUME
LOCATE 22, 2: PRINT ERR
RESUME

GETPROBE:

CLS
CLOSE #1
ON ERROR GOTO 0
ON ERROR GOTO err1
CLOSE #2
OPEN "host.dat " FOR OUTPUT AS #2

inncount = 0
com.speed$ = "2400"
return$ = "x"

get.probe:

xx$ = "2"
yy$ = "8"
id$ = "Logon In Progess"
CALL wind(xx$, yy$, id$)

CALL OPEN.COM

CALL waiter

return$ = "x"

CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     in$ = ""

gp1:

IF LOC(1) = 0 THEN
     GOTO gp2
END IF

in$ = INPUT$(LOC(1), #1)

gp2:

PRINT #1, "a";

return$ = "in:"

in$ = ""

CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     in$ = ""

PLAY "MB T255 O5 L64 P34 P34 P34 P34 A- P64 P64 A-"
LOCATE 3, 30
PRINT "TYMNET Accessed"

IF gate$ = "XXXXX" THEN GOTO gp10
PRINT #1, gate$; CHR$(13);
return$ = "in:"
in$ = ""
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     in$ = ""

PLAY "MB T255 O5 L64 P34 P34 P34 P34 A- P64 P64 A-"
LOCATE 4, 30
PRINT "GATEWAY Accessed"

gp10:

PRINT #1, probe$; CHR$(13);
return$ = "NAME:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
in$ = ""

PRINT #1, prnam$; CHR$(13);
return$ = "PASSWORD:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
in$ = ""
PRINT #1, prpas$; CHR$(13);
return$ = ":"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
in$ = ""
PLAY "MB T255 O5 L64 P34 P34 P34 P34 A- P64 P64 A-"
LOCATE 5, 30
PRINT "PROBE Accessed"

PRINT #1, "host"; CHR$(13);
return$ = "host" + CHR$(13) + CHR$(10)
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
in$ = ""
PLAY "MB T255 O5 L64 P34 P34 P34 P34 A- P64 P64 A-"
L 6, 30
PRINT "HOST Command Entered"

xx$ = "18"
yy$ = "23"
id$ = "Collecting Host Data"
CALL wind(xx$, yy$, id$)

gp12:

IF LOC(1) = 0 THEN
     GOTO gp14
ELSE
     in$ = INPUT$(1, #1)
END IF

gp14:

IF in$ = ":" THEN
     GOTO gp16
END IF

IF in$ <> CHR$(10) THEN
     inn$ = inn$ + in$
     q = INSTR(1, inn$, CHR$(13))
     IF q <> 0 THEN
          LOCATE 20, 4
          PRINT SPACE$(60)
          LOCATE 20, 4
          PLAY "MB O0 b-"
          PRINT MID$(inn$, 1, 60)
          inncount = inncount + 1
          LOCATE 21, 4
          PRINT "Hosts Found --> "; inncount
          inn$ = ""
     END IF

END IF

GLOOP:

PRINT #2, in$;
in$ = ""
GOTO gp12

gp16:
VIEW PRINT
CALL HOSTE
CALL READER
CALL CONSAT
GOTO main


reload.circuit:
'*****
 
     COLOR 7, 0                         'check here for reload system
     PRINT #1, "M,"; host$; CHR$(13);   'availability

     return$ = "in:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****
  
     IF gate$ = "XXXXX" THEN
          GOTO reload.loop
     END IF

     PRINT #1, gate$; CHR$(13);

     return$ = "in:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

reload.loop:

'*****

     PRINT #1, SYSNAM$; ":"; sys$; ";"; SYSPAS$; CHR$(13);

     return$ = "login:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, REDNAM$; CHR$(13);

     return$ = "Password:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, REDPAS$; CHR$(13);

     return$ = "selection:"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, "vt100"; CHR$(13);
 
     return$ = "%"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****
     LOCATE 19, 71
     PRINT CHR$(219)
     SOUND 5000, 4

     RETURN
   
ddt.logon:
     
     LOCATE 19, 2

     FOR gt = 17 TO 23
          LOCATE gt, 50
          PRINT CHR$(179);
     NEXT gt
     COLOR 4, 0
     LOCATE 17, 70
     PRINT CHR$(201)
     LOCATE 18, 70
     PRINT CHR$(199)
     LOCATE 19, 70
     PRINT CHR$(199)
     LOCATE 20, 70
     PRINT CHR$(199)
     LOCATE 21, 70
     PRINT CHR$(199)
     LOCATE 22, 70
     PRINT CHR$(199)
     LOCATE 23, 70
     PRINT CHR$(200)
     'PRINT pict1$
     COLOR 2, 0
     
     
     LOCATE 16, 61
     PRINT "Complete"
     LOCATE 17, 51
     PRINT "Reload in Progress"
     LOCATE 18, 53
     PRINT "Reload Initiated"
     LOCATE 19, 53
     PRINT "Reload SYS Logon"
     LOCATE 20, 58
     PRINT "Slot Halted"
     LOCATE 21, 52
     PRINT "Host Verification"
     LOCATE 22, 60
     PRINT "DDT Logon"
     
     COLOR 7, 0
     LOCATE 22, 71
     PRINT CHR$(223);
     


'*****
     PRINT #1, "M,ddt"; CHR$(13);

     return$ = "in:"                   'check here for network availability
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****
     
     IF gate$ = "XXXXX" THEN
          GOTO ddt.logon.loop
     END IF

     PRINT #1, gate$; CHR$(13);

     return$ = "in:"                    'check here for gateway availability
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

ddt.logon.loop:

'*****
     in$ = ""
     ttic = 1
     
     PRINT #1, ddtnam$; ":"; kh$; ";"; ddtpas$; CHR$(13);

     return$ = "slot #:"                'check here for node availability
v1:
IF ttic >= 5000 THEN BEEP: BEEP: BEEP: GOTO zapped
IF LOC(1) = 0 THEN GOTO v2 ELSE in$ = in$ + INPUT$(LOC(1), #1)
v2:
p = INSTR(1, in$, "slot #:")
q = INSTR(1, in$, "in:")
q2 = INSTR(1, in$, "Zapped<")

IF q <> 0 OR q2 <> 0 THEN q = 0: ttic = 5001: GOTO v1
IF p = 0 THEN ttic = ttic + 1: GOTO v1


'call get.char
     
     IF no.return$ = "on" THEN
          no.return$ = ""
          PRINT in$
          GOTO zapped
     END IF
     SOUND 5000, 4
     in$ = ""

'*****

     PRINT #1, slot$;

     return$ = "*"
CALL get.char
     IF no.return$ = "on" THEN
          no.return$ = ""
          p = INSTR(1, in$, "in use")
          IF p <> 0 THEN GOTO slot.in.use
          PRINT in$
          STOP      'check here for errors, like
                                         'slot in use...............
          END IF
     SOUND 5000, 4
     in$ = ""
     RETURN

ddt.checker:
     
     LOCATE 21, 71
     PRINT CHR$(219)
    
'*****

'     PRINT #1, "?host"; CHR$(13);
     
'     return$ = host$
'CALL get.char
'     IF no.return$ = "on" THEN
'          no.return$ = ""
'          pp = INSTR(1, in$, "down")
'          IF pp <> 0 THEN in$ = "": GOTO exiter
'     END IF
     SOUND 5000, 4
     in$ = ""

'*****
     PRINT #1, "h";

     return$ = "*"
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

exiter:
'*****

     PRINT #1, "zz";

     return$ = mxrtrn$
CALL get.char
     IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
     SOUND 5000, 4
     in$ = ""

'*****
     SOUND 5000, 4

     LOCATE 20, 71
     PRINT CHR$(220)

     RETURN

slot.in.use:

PRINT #1, CHR$(8) + "z";
return$ = mxrtrn$
CALL get.char
IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
in$ = ""

PRINT #1, "z"; CHR$(13);
return$ = mxrtrn$
CALL get.char
IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
in$ = ""
GOTO record.no

slot.down:

slot = VAL(slot$)
PRINT #1, "zz";
return$ = mxrtrn$
CALL get.char
IF no.return$ = "on" THEN no.return$ = "": PRINT in$: STOP
in$ = ""
GOTO record.no

zapped:

py = 0
in$ = ""
PRINT #1, CHR$(8) + "z";
return$ = mxrtrn$
CALL get.char
IF no.return$ = "no" THEN no.return$ = "": PRINT in$: STOP
GOTO record.no

host.not:

 8 ¾