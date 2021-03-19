;;
;; To use this command file, do:
;;          R NAD
;;          ;X<this filename>
;; ---------------------------------------------------
;;    If you want to save all what you are going to process into a file, do:
;;         LOGIN TO PDP SYSTEM WHERE YOUR NIB FILE LOCATED.
;;         R (MPL)AUXIO
;;        *O <filename which you want to save>
;;        *C username:same PDP system
;;        <set licence>
;;        -R NAD
;;        ;X<this command file>
;; =====================================================
;;
;;

;;****NOTE: Whenever the process stops, pls hit <conrol D> to continue.
;;*********************************************************************
;;
;; PLEASE ENTER SLOT NIB FILENAME
;;
%F
%G;G
8%2
;;PLEASE ENTER USERNAME:14622 <C/R> THEN
;;ENTER %Risistech:host# THEN <ESC> AND ;r0#\
;C
;;
;;
;;
;;
;; HERE IS TO CHECK IF THE NIB FILE MATCHES THE CURRENT RUNNING SLOT FILE.
;; B.BAYS SHOULD MATCH BOTH IN IMAGE FILE AND SLOT MEMORY.
;; IF NOT THE SAME, HIT <ESC> TWICE TO EXIT AND FIND OUT WHICH NIB FILE
;; IS CORRECT.
;;-----------------------------------------------------------------------
:R B.DAYS,4

B.DAYS,4[

;;======================================================================
;;======================================================================


;;THE FOLLOWING TRACES ARE SAVED BY TRCSAV.403 PATCH.
;;-------------------------------------------------------------------
;;
;;(1). IRING
;;----------------
:R IRINGk,IRSIZE+4


;;
;;(2). ORING
;;----------------
:R ORINGk,ORSIZE+4

;;
;;(3). FRAME TRACE
;;---------------
:R FTRTBk,FTRLEN+20

;;
;;(4). PACKET TRACE (PT)
;;----------------------
:R PTRTBk,PTRLEN+20

;;
;;(5). OUTPUT SECTOR
;;-------------------

:R SECADR,NSCTRS*4


:R SECBIA,NLINES*2



:R CCURSE+k,1


:R OSTBk,RBUFk-TCCWk


;;
;;(6). RECEIVE BUFFER
;;--------------------
:R RRINDE+2*k,2


:R RCVTk,RBUFHS*2

;;
;;(7). ROTOR LIST
;;---------------------
:R TTCLk,(TCCWk-TCCLk)

;;
;;(8). TRAP/CRASH REGISTERS CONTENT
;;----------------------------------

:R REGSTk,40

;;
;;(9). MAPPING TABLES
;;----------------------------------

:R DI.MTk,2*NDPORT

:R ID.MTk,2*NIPORT

:R IE.MTk,2*NIPORT

:R EI.MTk,2*NEPORT

:R IL.MTk,NIPORT

;;
;;(10). DPORT,IPORT,EPORT,ELCI.
;;      (THESE VALUES ARE COPIED FROM THE CORRESPONDING MEMORY
;;       LOCATIONS. MAY NOT BE CORRECT--JUST THE SAME AS YOU 
;;       LOOK INTO THE DUMP AND THESE LOCATIONS MAY CONTAIN THE
;;       RIGHT VALUE.---BE SURE TO DOUBLE CHECK WITH PORT MAPPING
;;       TABLES IN (9).
;;-----------------------------------------------------------------

:R DPORTk,2


:R IPORTk,2


:R EPORTk,2


:R EPORTk,2


:R ELCIk,2


;;-----------------------
;; HERE IS THE VALUE TO CONVERT EPORT TO/FROM CHANNEL.
;;
;;    CHANNEL# - LCC.LT +EPB.LT = EPORT
;;
;;----------------------------------------------------

:R LCC.LT+2*k,2

:R EPB.LT+2*k,2


;;======================================================
;;END OF TRACES OUTPUT
;;=======================================================
