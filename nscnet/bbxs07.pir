                                                                     Page-1
 1. Function summary
 
 
     Follwing product is designed to support end to end ID exchange.
    JAPAN OIL Co Ltd., is big custommer of NIS and they request to support
    ID exchange.  This patch is designed for FUJITSU BSC, but it  will be
    useful for other BSC devices such as IBM 3740 which needs ID exchange.
     The calling station dials and sends the ENQ, preceded by a maximum of
    15 graphic characters, to the called station as proof of identity.
    The called station answers, reads the ID ENQ sequence and verfies it.
    If the ID is valid, the station sends the ACK0 characters, preceded by
    a maximum of 15 ID characters of its own, to the calling station.
     Now terminal can send and receive data text.  To enable above sequence
    following option was designed for PVC port.  And following two options
    are need for assembly.
 
 
        OPTION(IDEX,YES)        : Enable ID exchange option
        OPTION(N,IDEX,YES)      : Enable ID exchange on this line.
 
 

                                                                     Page-2
 2. Exchange between foreground and background
 
  2-1 Exchange of ID TEXT
 
 
  (1) FFIDEQ is used as notice of receiving ID.ENQ from FG to BG and FFIDAK
      is used as notice of receiving ID.ACK.
      IEQMSG is used as notice of receiving ID.ENQ from BG to FG and IAKMSG
      is used as notice of receiving ID.ACK.
 
 
  (2) ID portion of ID.ENQ and ID.ACK is saved in 16 bytes table named TEXT1
      and TEXT2.  Number of these areas depends on number of lines.
 
      TEXT1 is used from FG to BG and TEXT2 is used from BG to FG.
 
      TEXT1 is written down in normal order bit, and TEXT2 is in reverse
      order bit to send text.
 
 
 
  2-2 Completion flag of ID receipt
 
  (1) ID.GET flag indicates the completion of ID receipt.  During no cuircuit
      ID.GET flag is set to 0, and if BBXS receives completely ID characters
      then ID.GET flag is set to 1.  After this process, ID.GET flag is kept
      as 1 until disconnect circuit.
 
 

                                                                     Page-3
  2-3 Flow of command and ID text is as follows
 
 
          /~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\ 
         /   (Terminal Interface)            (Host Interface)       \
        +-----------------------------+  +---------------------------+
        | TIF/FG            BG        |  | HIF/BG         FG         |
 ID.ENQ |                             |  |                           |
 -------+->  TEXT1                    |  |                           |
        |                             |  |                           |
        |    FFIDEQ  --->  IEQMSG     |  |                           |
        |                             |  |                           |
        |                 +--------+  |  |                           |
        |                 |IDSCF/2 |  |  |                           |
        |                 |   +    | -+--+-> TEXT2                   |
        |                 | TBIAS  |  |  |                           | ID.ENQ
        |                 +--------+  |  |   IEQMSG ---> FFIDEQ  ----+------>
        |                 |IEQMSG/2|  |  |                           |
        |                 |   +    |  |  |                           |
        |                 | TBIAS  |  |  |                           |
        |                 +--------+  |  |                           |
        |                 | TEXT1  |  |  |                           |
        |                 +--------+  |  |                           | ID.ACK
        |                 |IDEND/2 |  |  |               TEXT1   <---+-------
        |                 |   +    |  |  |                           |
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
 ID.ACK |                             |  |  | TBIAS  |               |
 <------+--   FFIDAK <---  IAKMSG     |  |  +--------+               |
        |                             |  |                           |
        +-----------------------------+  +---------------------------+
         \                                                           /
          \                       T Y M N E T                       /
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
        Figure-1  Flow of command and ID text
 
 

                                                                     Page-4
 3.   Foreground modification
 
 
 3-1. Additional four receive state tables
 
 (1) SWIDLE (TIF)
     SWIDLE state is defined instead of SIDLE state and is receive state in
     initial stage.  TIF is waiting for ID.ENQ but not waiting for ENQ, and
     TIF disregards ID.ENQ during building PVC circuit.  When TIF  receives
     ID.ENQ, receive routine is modified to return ENQ(This is applied only
     when ID.GET is zero.).
     IRIDEQ routine is activated by this trigger and TIF checks whether  PVC
     is LACTIVE or not, and if line is not LACTIVE then TIF reset ID.GET flag
     again and stays on SWIDLE state.  If line is LACTIVE then TIF sends
     FFIDEQ to background and changes state to SWIDAK.
 
 (2) SWIDAK (TIF)
     Receive state during TIF waits for ID.ACK from HIF.
     If TIF receives ID.ENQ from terminal again, TIF sends WACK to terminal
     (IRIDWK routine).
     When TIF recieved FFIDAK command from BG, TIF gets through this status.
 
 (3) TSRINT(TIF)
     Receive state for TIF expecting for recieve data from terminal after
     sending ID.ACK from host to terminal.  If TIF recieves ID.ENQ  again
     from terminal, TIF sends ID.ACK to terminal again(SIDACK routine).
     When TIF receives DLE.EOT or timeout occurs, BBXS jumps to SIDRST and
     resets the line.  At SIDRST routine, TIF sends FFDET to background and
     jumps to IDISC routine and disconnect the line.
 
 (4) SIDBID (HIF)
     Receive state for HIF receiving FFIDEQ from BG, BBXS changes to this
     state and waits for ID.ACK from host after sending ID.ENQ.
     When HIF recieves ID.ACK from host, HIF sends FFIDAK to BG and jumps to
     XINIT(RIDACK routine)
 
 

                                                                     Page-5
 3-2 Additional modification of one character receipt routine(Activation
     routine of RCV)
 
     This routine is added after establishment synchronization
     of BSCRCV module.
 
 (1) Process after establishment of synchronization
 
     BBXS is usually in RSIDMS at initialize stage.  But if this line is
     defined as ID exchange line(ID.EXP is ON) and ID.GET is 0 then both
     TIF and HIF move to RSIDCH as initial tables.
     RSIDCH table is set around RSYN80.  At the same time BBXS clears the
     1st byte of TEXT1(length field of TEXT1).
 
 
    RSIDCH table
   ( instead of RSIDMS)
 
   +----------------+
   | DATA | RPIDPT  |
   +------+---------+
   |      |         |
   +------+---------+
   | DLE  | RPIDDL  | -----> Table for next character of DLE
   +------+---------+
   |      |         |        RSID2C table
   +------+---------+        ( instead of RS2CHR)
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
 
   PRIDPT  In this routine TEXT1 is filled with data received by FG.
           When receiving data, if 1st byte of TEXT1(length size) is less
           than 15, BBXS put the receive character into TEXT1.
           And if more than 15, then return to RPUNID.
 
   RPIDDL  When BBXS receives the DLE, RST table is changed to RSID2C to
           check the next character.
 
   RPIDEQ  Routine is activated when BBXS recieves ENQ that is last data
           of ID.ENQ.
           BBXS sets ENQ reciept code and does RPDONE routine.
 
   RPIDAK  Routine is activated when BBXS receives ACK0 that is last data
           of ID.ACK.
           If TEXT1 length is more than 0, BBXS sets ID.GET to 1 and does
           RPDONE routine.
 
   RPIDEP  Routine for judging whether the next byte of DLE is ! (X'!') or
           not.  When BBXS receives  DLE.!, return code is  sets same as
           DLE.EOT.
 
 
 
 3-3 Modification of output routine
 
 
 (1) Additional command for ID message transmission
 
     XCIDEQ and XCIDAK commands are used for ID.ENQ and ID.ACK transmission
     routine.  Command is designed as follows:
 
     XCIDEQ  EQ      MAXOPC+3
     XCIDAK  EQ      MAXOPC+4
 
 
 
 (2) Text area of ID transmission
 
     ID characters are written into TEXT2 as reverse EBCDIC by BG.
 
 
       Length size ---+ +------ MAX 15 ------+
                      | |                    |
                      V V                    V
                    +---+--------------------+
          TEXT2  =  | L | ID character       |
                    +---+--------------------+
 
      Figure - 3     Format of TEXT2
 
 

                                                                     Page-7
 (3) Output routine
 
 
     At BSXW8 routine BBXS decode the transmission OP code of sync output
     command.  If BBXS activates by XCIDENQ or XCIDAK then BBXS  jumps to
     write routine of command list(BSXWID).
 
 
 (4) SYNC output command list
 
 
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
 
 
     BBXS copys ID from TEXT2(SEG 0) to TEXT2E(SEG 4), and adds the RENQ
     or RDLE.RACK0 code and checks the length size of ID.
     If length size is odd then BBXS adds the FF code at the end of string.
 

                                                                     Page-8 
 4. Background modification
 
 
    Background process is modified at following 4 items.
 
 4-1 Initial process
 
 
 (1) In case of slot start up
 
     When slot is start up process(IZQ), BBXS clears the TEXT areas and flags.
 
     TEXT1     : ID text save area from FG to BG
     TEXT2     : ID text save area from BG to FG
     TEXT3     : ID text save area used by extended DDT
     TEXT4     : ID text save area used by extended DDT
     COUNT     : Counter used when TEXT2 is saved
     SAVFLG    : Completion flag of ID saving
     ENQIN     : Indication flag of IEQMSG receipt
     ID.GET    : Indication flag of ID receipt from FG
 
 
 (2) In case of ending of communication
 
    When Line is end of communication from ACTIVE(DISC transaction), BBXS
    clears the TEXT areas and flags.
 
    TEXT1      : ID text save area from FG to BG
    TEXT2      : ID text save area from BG to FG
    COUNT      : Counter used when TEXT2 is saved
    SAVFLG     : Completion flag of ID saving
    ENQIN      : Indication flag of IEQMSG receipt
    ID.GET     : Indication flag of ID receipt from FG
 
 
    However, BBXS doesn't clear the TEXT3,TEXT4 at this point.
    Because extended DDT use these area.
 

                                                                     Page-9
 4-2 Transmission routine of  ID text into BB
 
     BBXS checks FFIDEQ(received ID.ENQ) or FFIDAK(recieved ID.ACK). If BBXS
     finds them then TEXT1 is output to oring by  writing following format
     into BB.
 
 
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
     |   ID.ACK )        |
     +-------------------+
     | IDEND/2 + TBIAS   |
     +-------------------+
 
     Figure- 6  Output format of ID.ACK to BB
 
 
     TEXT1 is translated into ASCII and saved on TEXT4, to display ID for
     extended DDT.
 
 
 4-3 Save routine from TEXT1 to TEXT2
 
     BBXS writes down TEXT2 with reverse order bit from TEXT1
     that is recieved in input ring.
 
 (1) MAXSCF value
 
     To find out ID.ENQ, ID.ACK or ID.END data from network, MAXSCF value
     is changed from 30 to 36 at GSCB transaction.
 

                                                                     Page-10
 (2) Session control table changed from 1R1SCF to 1R1SCX
 
     ID.ENQ , ID.ACK , ID.END transaction routine are added to SCF type
     process which is used when received legal control code.
 
 
    IR1EQ - When received ID.ENQ, BBXS jump to this routine.
            To write down the data preceded by this code  into TEXT2,
            BBXS sets the SAVFLG to 1 and then sets the next transaction
            address IR103 and return.
 
    IR1AK - When received ID.ACK, BBXS jump to this routine.
            To write down the data prceded by this code into TEXT2, BBXS
            sets the SAVFLG to 1 and then sets the next transaction
            address IR103 and return.
 
    IR1ED - When received ID.END, BBXS jump to this routine.
            BBXS sets the length size of ID to TEXT2.  BBXS checks the
            ENQIN flag and if this flag is 1 then BBXS  reports IEQMSG
            to FG and if this flag is 0 then BBXS reports IAKMSG to FG.
 
 
 
 4-4 Save process of TEXT2 and TEXT3
 
     TEXT2 is saved at non skip(+0) return from GSCB(IRPRESS).
     When writes down ID to TEXT3, to display ID with extended DDT, at
     the same time BBXS translates TEXT3 into TEXT2 with ASCII code in
     this routine.
 
 
 
 5. Display ID exchange by extended DDT
 
 
 5-1. ID.ACK and ID.ENQ and TEXT are displayed by SCOPE command and BSCTRC
      command.
 
 5-2  When there is difinition of TIMZON in tymfile, JST TIME header is
      displayed for HSCTRC, FGTRC, BSCTRC command.
 
 

                                                                     Page-11
 6. Fix some problems
 
 
 6-1. Patch name : (NSCNET)LHLTA.701
 
  (1) Description of problem
      New circuit for TIF is disconnected by TIF during waiting for timeout
      in LDETACH after receiving zap in LHLTA.  This problem occurs at the
      timing of normal session end.
 
  (2) Content of modification
      When BBXS received zap at LHLTA status, BBXS should't ignore zap.
      Changing status from LHLTA status to LDETACH status is necessary
      to zap the circuit.
 
 
 6-2. Patch name : (NSCNET)SLBID.701
 
  (1) Description of problem
      In case of terminal side modem powered off at SLBID status, TIF sends
      ENQ to terminal until receiving zap from HIF and go to LCLEAR after
      this sequence. But it's long time (about 70 sec) until receive zap.
 
      GOTPER flag is not reset sometimes.
 
  (2) Content of modification
      BBXS sends ENQ 3 times to terminal and goes to LHLTA status and sends
      ZAP when above case occured.
 
      Whenever BBXS sends FFREQ to BG, BBXS resets GOTPER flag.

