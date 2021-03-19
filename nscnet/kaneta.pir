                                                                     Page-1
 1. Function summary
 
 
     Follwing product is designed to support end to end ID exchange.
    JAPAN OIL Co Ltd., is big custommer of NIS and they request to support
    ID exchange.  This patch is designed for FUJITSU BSC, but it will be
    useful for other BSC devices such as IBM 3740 which needs ID exchange.
     The calling station dials and sends the ENQ, preceded by a maximum of
    15 graphic characters, to the called station as proof of identity.
    The called station answers, reads the ID ENQ sequence and verfies it.
    If the ID is valid, the station sends the ACK0 characters, preceded by
    a maximum of 15 ID characters of its own, to the calling station.
     Now terminal can send and recieve data text.  To support enable above
    sequence following option was designed for PVC port.  And following two
    options are need for assembly.
 
 
        OPTION(IDEX,YES)        : Enable ID exchange option
        OPTION(N,IDEX,YES)      : Enable ID exchange on this line.
 
 

                                                                     Page-2
 2. Exchange of foreground and background
 
  2-1 Exchange of ID TEXT
 
 
  (1) Report of receive ID.ENQ from FG to BG make use of FFIDEQ and report of
      receive ID.ACK make use of FFIDAK.
 
 
  (2) Report of receive ID.ENQ from BG to FG make use of IEQMSG and report of
      receive ID.ACK make use of IAKMSG.
 
 
  (3) ID portion of ID.ENQ and ID.ACK make use of 16 bytes multiply line
      number table named TEXT1 and TEXT2.
 
      TEXT1 is used from FG to BG and TEXT2 is used from BG to FG.
 
      TEXT1 write down in normal order bit, and TEXT2 write down in reverse
      order bit to send text.
 
 
 
  2-2 Completion flag of ID receipt
 
  (1) ID flag is used to show the completion of ID receipt.  If there is no
      cuircuit ID.GET flag set to 0, and if BBXS received completly ID
      character lines then ID.GET flag set to 1.  After this process, ID.GET
      flag hold on 1 until disconnect cuircuit.
 
 

                                                                     Page-3
  2-3 Flow of command and ID text is as follows
 
 
          /~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\ 
         /   (Terminal Interface)            (Host Interface)       \
        +-----------------------------+  +---------------------------+
        | TIF/FG            BG        |  | HIF/BG         FG         |
 ID.ENQ |                             |  |                           |
 -------|->  TEXT1                    |  |                           |
        |             *               |  |                           |
        |    FFIDEQ  --->  IEQMSG     |  |                           |
        |                             |  |                           |
        |                 +--------+  |  |                           |
        |                 |IDSCF/2 |  |  |                           |
        |                 |   +    | -+--+-> TEXT2                   |
        |                 | TBIAS  |  |  |           *               | ID.ENQ
        |                 +--------+  |  |   IEQMSG ---> FFIDEQ  ----+------>
        |                 |IEQMSG/2|  |  |                           |
        |                 |   +    |  |  |                           |
        |                 +--------+  |  |                           |
        |                 | TEXT1  |  |  |                           |
        |                 +--------+  |  |                           | ID.ACK
        |                 |IDEND/2 |  |  |               TEXT1   <-----------
        |                 |   +    |  |  |            *              |
        |                 | TBIAS  |  |  |   IAKMSG <--- FFIDAK      |
        |                 +--------+  |  |                           |
        |                             |  |  +--------+               |
        |                             |  |  |IDSCF/2 |               |
        |                             |  |  |   +    |               |
        |                             |  |  | TBIAS  |               |
        |                             |  |  +--------+               |
        |                             |  |  |IAKMSG/2|               |
        |                             |  |  |   +    |               |
        |                             |  |  | TBIAS  |               |
        |                             |  |  +--------+               |
        |                             |  |  | TEXT1  |               |
        |                             |  |  +--------+               |
        |                             |  |  |IDEND/2 |               |
        |                  TEXT2   <--+--+- |   +    |               |
 ID.ACK |              *              |  |  | TBIAS  |               |
 <------+--   FFIDAK <---  IAKMSG     |  |  +--------+               |
        |                             |  |                           |
        +-----------------------------+  +---------------------------+
         \                                                           /
          \                       T Y M N E T                       /
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
        Figure-1  Flow of command and ID text
 
                           * 
                  Note : <--- symbole means complement 
 

                                                                     Page-4
      Content of foreground modification
 
 
      Add the four receive state tables
 
 (1) SWIDLE (TIF)
     SWIDLE state is instead of SIDLE state.
     Receive state for when TIF is in initialize state, TIF is waiting for
     ID.ENQ but not waiting for ENQ, and TIF disregard the ID.ENQ untill
     build the PVC cuircuit.
     In case of TIF recive ID.ENQ, in order to ENQ return, RCV routine was
     modified. (This is only apply ID.GET is zero.)
     At IRIDEQ routine act on by this trigger, TIF check the PVC line weather
     it is LACTIVE or not, and if line is not LACTIVE then again TIF reset
     ID.GET flag and hold on SWIDLE state.
     If line is LACTIVE then TIF send FFIDEQ to background and change state
     to SWIDAK.
 
 (2) SWIDAK (TIF)
     Receive state for TIF wait for ID.ACK from HIF.
     If TIF recive ID.ENQ from terminal again, TIF send wack to terminal
     (IRIDWK routine).
     When TIF recieved FFIDAK command from BG, TIF get through this status.
 
 (3) TSRINT(TIF)
     Receive state for TIF expecting for recieve data from terminal after
     sending ID.ACK to terminal from host.  If TIF recieve ID.ENQ again from
     terminal,TIF send again ID.ACK to terminal(SIDACK routine).  When TIF
     received DLE.EOT or become timeout, BBXS jump to SIDRST and reset the
     line. At SIDRST routine, TIF queuing FFDET to background and jump to
     IDISC routine and disconnect the line.
 
 (4) SIDBID (HIF)
     Receive state for when HIF receive FFIDEQ from BG, BBXS change to this
     state and wait for ID.ACK from host after send ID.ENQ.
     When HIF recieved ID.ACK from host, HIF send FFIDAK to BG and jump to
     XINIT(RIDACK routine)
 
 

                                                                     Page-5
 3-2 Addendum modification of one character reciept routine(Activation
     routine of RCV)
 
     We design this routine to add after establishment synchronization
     of BSCRCV module.
 
 (1) Transaction after establishment synchronization
 
     At initialize, BBXS is usually position to RSIDMS.  But if this line is
     object port (ID.EXP is ON) and ID.GET is 0 then both TIF and HIF change
     initialize the table to RSIDCH.
     In order to use this table, RSIDCH table is set around RSYN80.
     At the same time BBXS clear the header 1 byte (length of TEXT1) of TEXT1.
 
 
    RSIDCH table
 
   +----------------+
   | DATA | RPIDPT  |
   +------+---------+
   |      |         |
   +------+---------+
   | DLE  | RPIDDL  | -----> Table for check next character of DLE
   +------+---------+
   |      |         |        RSID2C table
   +------+---------+        ( This table is in stead of RS2CHR)
   | ENQ  | RPIDEQ  |
   +------+---------+        +----------------+
                             | ELSE | RPIDEP  |
                             +------+---------+
                             |      |         |
                             +------+---------+
                             | EOT  | RPC2H   |
                             +------+---------+
                             |      |         |
                             +------+---------+
                             | ACK0 | RPIDAK  |
                             +------+---------+
                             | WACK | RPC2CH  |
                             +------+---------+
 
   Figure-2  Initial table and table for next character
 

                                                                     Page-6
 (2) New routine designed for above table
 
   PRIDPT  Routine for BBXS write down data to TEXT1 that is received from FG.
           When BBXS received data, if the head(length size) of TEXT1 is less
           than 15 characters, BBXS write down the receive character to TEXT1.
           And if the head of TEXT1 is more than 15 characters then return to
           RPUNID.
 
   RPIDDL  Routine for when BBXS receive the DLE, to check the next character
           BBXS change the state.
           Change RST table to RSID2C.
 
   RPIDEQ  Routine for when BBXS recieve the ENQ that is last data of ID.ENQ.
           BBXS set the ENQ reciept code and transact RPDONE routine.
 
   RPIDAK  Routine for when BBXS received the ACK0 that is last data of ID.ACK.
           If TEXT1 length is more than 0, BBXS set ID.GET to 1 and transact
           RPDONE routine.
 
   RPIDEP  Routine for BBXS judge the next code of DLE wether it is ! code or
           not. When BBXS received DLE.!, BBXS handle return code as DLE.EOT.
 
 
 
 3-3 Modification of output routine
 
 
 (1) Addendum of command for ID message transmission
 
     It's specify with XCIDEQ or XCIDAK command for ID.ENQ and ID.ACK
     transmission routine. Command is designed add the following of message
     type definition.
 
     XCIDEQ  EQ      MAXOPC+3
     XCIDAK  EQ      MAXOPC+4
 
     Note :  MAXOPC is the transmission OP code for SYNC output command list.
 
 
 (2) Text area of ID transmission
 
     ID character line is written with reverse EBCDIC from BG to TEXT2.
 
 
       Length size ---+ +------ MAX 15 ------+
                      | |                    |
                      V V                    V
                    +---+--------------------+
          TEXT2  =  | L | ID character       |
                    +---+--------------------+
 
      Figure - 3     Format of TEXT2
 
 

                                                                     Page-7
 (3) Modification of output routine
 
 
     At BSXW8 routine BBXS decode the transmission OP code of sync output
     command, if BBXS activate by XCIDENQ or XCIDAK then BBXS jump to write
     routine(BSXWID) of command list.
 
 
 (4) Design of SYNC output command list
 
             In case of ID.ENQ
  RADE ----> +---------------+
             |               | }
             |               | }-----> List of SYNC (BSXWRT routine)
             +---------------+
             | 1  |  L       | }
             +----+----------+ |----> ID (using TEXT2 table)
             | ID charcter   | }
             +---------------+
             |               | }
             |               | | ---> List of ENQ, or list of ACK0.
             |               | }      XCENQ(01)       XCACK0(07)
             +---------------+
             |               | }
             |               | }----> List of PAD (BSXW60 routine)
             +---------------+
 
 
     Figure-4  Output command list
 
 
     BBXS copy ID from TEXT2(SEG 0) to TEXT2E(SEG 4), and add the RENQ
     or RDLE.RACK0 code and check the length size of ID.
     If length size is odd then BBXS add the FF code at the end of string.
 

                                                                     Page-8 
 4. Content of background modification
 
 
    Background process is constitute of following 4 items.
 
 4-1 Initial process
 
 
 (1) In case of slot start up
 
     When slot is start up(IZQ process, BBXS clear the TEXT areas (TEXT1 and
     TEXT2 and TEXT3 and TEXT4) and flags.
 
     TEXT1     : ID text save area from FG to BG
     TEXT2     : ID text save area from BG to FG
     TEXT3     : ID text save area to display extended DDT
     TEXT4     : ID text save area to display extended DDT
     COUNT     : Counter for using to save TEXT2
     SAVFLG    : Completion flag of ID saving
     ENQIN     : Indication flag of IEQMSG reception
     ID.GET    : Indication flag of ID reception from FG
 
 
 (2) In case of ending of communication
 
    When Line is end(DISC transaction) of communication from ACTIVE, BBXS
    clear the TEXT areas and flags.
 
    TEXT1      : ID text save area from FG to BG
    TEXT2      : ID text save area from BG to FG
    COUNT      : Counter for using to save TEXT2
    SAVFLG     : Completion flag of ID saving
    ENQIN      : Indication flag of IEQMSG reception
    ID.GET     : Indication flag of ID reception from FG
 
 
    Howerve, BBXS doesn't clear the TEXT3,TEXT4 at the end of communication
    to enable using with extended DDT.
 

                                                                     Page-9
 4-2 Transaction for BBXS transmit ID text to BB that is received from FG.
 
     Routine for BBXS write down ID text that is recived from FG.
 
     BBXS judge the report from FG to BG wethere it is FFIDEQ(received ID.ENQ)
     or FFIDAK(recieved ID.ACK), if BBXS find it then TEXT1 is output to
     oring by writing following format to BB.
 
 
 (1) In case of ID.ENQ
 
     +-------------------+
     | ID.SCF/2 + TBIAS  |
     +-------------------+
     | IEQMSG/2 + TBIAS  |
     +-------------------+
     | TEXT1             |
     | ( ID portion of   |
     |   ID.ENQ )        |
     +-------------------+
     | IDEND/2 + TBIAS   |
     +-------------------+
 
     Figure-5  Output format of ID.ENQ to BB
 
 
 (2) In case of ID.ACK
 
     +-------------------+
     | ID.SCF/2 + TBIAS  |
     +-------------------+
     | IAKMSG/2 + TBIAS  |
     +-------------------+
     | TEXT1             |
     | ( ID portion of   |
     |   ID.ENQ )        |
     +-------------------+
     | IDEND/2 + TBIAS   |
     +-------------------+
 
     Figure- 6  Output format of ID.ACK to BB
 
 
     When BBXS write down the ID to TEXT1, to display ID with extended DDT,
     at the same time in this routine BBXS translate TEXT1 into TEXT4 with
     ascii code.
 
 
 4-3 Transaction for write down TEXT1 to TEXT2 received at I/O interface.
 
     Routine for BBXS write down TEXT2 with reverse order bit from TEXT1
     that is recieved in input ring.
 
 (1) Modification of MAXSCF value
 
     To find out ID.ENQ,ID.ACK or ID.END data from network, We change the
     MAXSCF value from 30 to 36 at GSCB transaction.
 

                                                                     Page-10
 (2) Change the session control table from 1R1SCF to 1R1SCX
 
     Add the ID.ENQ , ID.ACK , ID.END transaction routine to SCF type
     transaction which is use in case of received legal control code.
 
 
    IR1EQ - When BBXS received ID.ENQ, BBXS jump to this routine.
            To write down the data to TEXT2 following after this code,
            BBXS set the SAVFLG to 1 and then set the next transaction
            address IR103 and return.
 
    IR1AK - When BBXS received ID.ACK, BBXS jump to this routine.
            To write down the data to TEXT2 following after this code,
            BBXS set the SAVFLG to 1 and then set the next transaction
            address IR103 and return.
 
    IR1ED - When BBXS received ID.END, BBXS jump to this routine.
            BBXS set the length size of ID to TEXT2.  BBXS check the
            ENQIN flag and if this flag is 1 then BBXS report IEQMSG
            to FG and if this flag is 0 then BBXS report IAKMSG to FG.
 
 
 
 4-4 Drawing up of TEXT2 and TEXT3
 
     When BBXS received TEXT2, BBXS non skip(+0) return from GSCB.
     So BBXS process write down TEXT2 at no skip return IRPREF return.
     When BBXS write down the ID to TEXT3, to display ID with extended
     DDT, at the same time BBXS translate TEXT3 into TEXT2 with ascii
     code in this routine.
 
 
 
 5. Modification to display ID exchange with extended DDT
 
 
 5-1. We modified to display the reciept code of ID.ACK and ID.ENQ for
      scope command.  At the same time we modified to display reciept TEXT.
 
 5-2  We modified to display the receiving code of ID.ACK and ID.ENQ for
      BSCTRC command.  At the same time we modified to display reciept TEXT.
 
 5-3  When there is difinition of TIMZON in tymfile, we modified to display
      the JST TIME header for HSCTRC, FGTRC, BSCTRC command.
 
 

                                                                     Page-11
 6. Fix source problem with patch
 
 
 6-1. Patch name : (NSCNET)LHLTA.701
 
      Description of problem
  (1) At the timing of normal session end, when disconnection order
      was over rapped from HIF and TIF, if there is a circuit and BBXS
      received zap at LHLTA status and wait for timeout in LDETACH
      condition, in case of occurence new calling it sometimes happens
      BBXS disconnect the new calling.
 
      Content of modificartion
  (1) When BBXS received zap at LHLTA status, BBXS should't ignore zap.
      And to fix this problem by changing status from LHLTA status to
      LDETACH status zap the circuit.
 
 
 6-2. Patch name : (NSCNET)SLBID.701
 
      Description of problem
  (1) In case of tal side modem power off at SLBID status, TIF send
      ENQ to terminal until receive zap from HIF and after this sequence
      go to LCLEAR. But it's long time (about 70 sec) until receive zap.
 
  (2) There happens sometimes BBXS don't reset the GOTPER flag.
 
      Content of modification
  (1) If it happened above case, BBXS send ENQ 3 times to terminal and go to
      LHLTA status and send ZAP.
 
  (2) Whenever BBXS send FFREQ to BG, BBXS reset GOTPER flag after send FFREQ.
      
 

~Nd<