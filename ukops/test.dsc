............................................................................
:
:	ECONOMY NET - PRIVATE NETWORK SUPERVISOR
:...........................................................................
:****************************************************************************
:*******************  ISIS-II DISK & TAPE PARAMETERS   **********************
:****************************************************************************
        RA      0

        IF      NDISC+NTAPE+MSCDSK

:****************************************************************************
:*******************  ISIS CONFIGURATION CONSTRAINTS   **********************
:****************************************************************************

MXGLU   EQ      17      :Max number of distinct units or disc partitions
MSCDA0  EQ      0F8     :Controller zero address
NMSC0   EQ      1       :One drive on controller 0 ( 160 meg )
MSCCY0	EQ	$A 823	:Cylinders per drive
MSCTK0	EQ	$A 10	:Tracks per cylinder
MSCST0	EQ	$A 53	:Sectors per track

:****************************************************************************
:*******************  ISIS-II DISK & TAPE PARAMETERS   **********************
:****************************************************************************
:       ALLOCATION OF GLOBAL UNITS
:       EACH ENTRY HAS 5 PARAMETERS:
:       1-GLOBAL UNIT NUMBER,
:       2-CONTROLLER TYPE (DK, MT, MS),
:       3-DEVICE NUMBER,
:       4-START CYLINDER ( DISCS ONLY ),
:       5-NUMBER OF CYLINDERS ( DISCS ONLY ).
:****************************************************************************

        SGU.DEF(1,MS,0,0000,0008)       :Core Image Save Area
        SGU.DEF(2,MS,0,0008,0022)       :MUD
        SGU.DEF(3,MS,0,002A,002E)       :Accounting
        SGU.DEF(4,MS,0,0058,0010)       :Error Log
        SGU.DEF(5,MS,0,0068,0020)       :RAM Work Area
        SGU.DEF(6,MS,0,0088,0040)       :Netval LU 1
        SGU.DEF(7,MS,0,00C8,000A)       :Supervisor Save Area
        SGU.DEF(8,MS,0,00D2,0002)       :Class and Group Def
        SGU.DEF(9,MS,0,00D4,0001)       :Host Message Area
        SGU.DEF(0A,MS,0,00D5,0001)      :Supervisor History
        SGU.DEF(0B,MS,0,00D6,0001)      :Slave code save area
        SGU.DEF(0C,MS,0,00D7,0002)      :Utility slot save area
	SGU.DEF(0D,MS,0,00D9,0002)	:Source/dest file (future use)
        SGU.DEF(0E,MS,0,00DB,0002)      :Regional data set (future use)
        SGU.DEF(0F,MS,0,00DD,0003)      :Closure work file (future use)
	SGU.DEF(10,MS,0,00E0,0022)	:
        SGU.DEF(11,MS,0,0102,0200)      :ELF Database area 1
	SGU.DEF(16,MS,0,0302,10,FSYS)	:DDT SAV AREA
        SGU.DEF(13,MS,0,0000,0332)      :User Area
        SGU.DEF(14,MS,0,0000,0337)      :Format Area
        SGU.DEF(15,MT,0)                :Mag Tape 0

:****************************************************************************
:******************    FLAGS & GLOBAL UNIT ASSIGNMENTS     ******************
:****************************************************************************
:.           (SLOT,XLU,GLU,ACCESS)
:.    SLOT = Slot number assigned (decimal)
:.     XLU = Extended logical unit number for this slot (decimal)
:.     GLU = Global Unit number (hex)
:.  ACCESS = Licenses may be:
:.             RD = Read
:.             WR = Write
:.             AT = Attach
:.             SS = Save License
:****************************************************************************
:       SLOT 0 - NODE CODE
FSYS	EQ	$A 10		:COMMON LU FOR DDT IN ALL SLOTS
NXLU0   EQ      0C
:        SGU.REF(0,10,16,SS+RD+WR)


:****************************************************************************
:       SLOT 1 - Dummy or spare slot for the future
NXLU1   EQ      0C
:	SGU.REF(1,10,16,SS+RD+WR)	:DDT LU


:****************************************************************************
:       SLOT 2 - ELF
NXLU2   EQ      0C
	SGU.REF(2,0,11,SS+RD+WR)	:DDT LU
	SGU.REF(2,1,15,SS+RD+WR)	:DDT LU


:****************************************************************************
:       SLOT Q - SUPERVISOR - SLOT 3
Q       EQ      NSLOT+1
NXLU|Q| EQ      0C                      :Number of Extended Logical Units
        SGU.REF(Q,0,2,RD)               :MUD
        SGU.REF(Q,1,3,SS+RD+WR)         :ACCOUNTING DATA
        SGU.REF(Q,2,7,SS+RD+WR)         :SUPERVISOR SAVE AREA
        SGU.REF(Q,3,8,RD)               :CLASS AND GROUP DEFINITIONS
        SGU.REF(Q,5,4,SS+RD+WR)         :ERR LOG
        SGU.REF(Q,6,9,RD)               :HOST MESSAGE
        SGU.REF(Q,7,0A,SS+RD+WR)        :SUP HISTORY
        SGU.REF(Q,10,16,SS+RD+WR)	:DDT LU

:****************************************************************************
:       PROBE - SLOT 4
Q       EQ      Q+1
NXLU|Q| EQ      0C
        SGU.REF(Q,1,3,SS+RD+WR)         :ACCOUNTING
        SGU.REF(Q,4,0B,SS+RD+WR)        :SLAVE CODE SAVE AREA
        SGU.REF(Q,5,4,SS+RD+WR)         :ERROR LOG
        SGU.REF(Q,6,9,SS+RD+WR)         :HOST MESSAGE
        SGU.REF(Q,10,16,SS+RD+WR)	:DDT LU

:****************************************************************************
:       ERROR LOG - SLOT 5
Q       EQ      Q+1
NXLU|Q| EQ      0C
        SGU.REF(Q,4,0B,SS+RD+WR)        :SLAVE CODE SAVE AREA
        SGU.REF(Q,5,4,SS+RD+WR)         :ERROR LOG
        SGU.REF(Q,10,16,SS+RD+WR)	:DDT LU

:****************************************************************************
:       ACCOUNT - SLOT 6
Q       EQ      Q+1
NXLU|Q| EQ      0C
        SGU.REF(Q,1,3,SS+RD+WR)          :ACCOUNTING
        SGU.REF(Q,4,0B,SS+RD+WR)         :SLAVE CODE SAVE AREA
        SGU.REF(Q,10,16,SS+RD+WR)	:DDT LU

:****************************************************************************
:       SYSMSG - SLOT 7
Q       EQ      Q+1
NXLU|Q| EQ      0C
        SGU.REF(Q,4,0B,SS+RD+WR)        :SLAVE CODE SAVE AREA
        SGU.REF(Q,6,9,SS+RD+WR)         :HOST MESSAGE
        SGU.REF(Q,7,8,SS+RD+WR)         :CLASS AND GROUP DEFINITIONS
	SGU.REF(Q,10,16,SS+RD+WR)	:DDT LU

:****************************************************************************
:       UN2 - SLOT 8
Q       EQ      Q+1
NXLU|Q| EQ      0C
        SGU.REF(Q,0,2,SS+RD+WR)         :MUD
        SGU.REF(Q,4,0B,SS+RD+WR)        :SLAVE CODE SAVE AREA
        SGU.REF(Q,10,16,SS+RD+WR)	:DDT LU

:****************************************************************************
:       UTILITY - SLOT 9
Q       EQ      Q+1
NXLU|Q| EQ      0D
        SGU.REF(Q,0,2,SS+RD+WR+AT)      :MUD
        SGU.REF(Q,1,3,SS+RD+WR+AT)      :ACCOUNTING
        SGU.REF(Q,2,7,SS+RD+WR+AT)      :SUP SAVE AREA
        SGU.REF(Q,3,8,SS+RD+WR+AT)      :CLASS AND GROUP DEFINITIONS
        SGU.REF(Q,4,0B,SS+RD+WR+AT)     :SLAVE CODE SAVE AREA
        SGU.REF(Q,5,4,SS+RD+WR+AT)      :ERROR LOG
        SGU.REF(Q,6,9,SS+RD+WR+AT)      :HOST MESSAGES
        SGU.REF(Q,7,0A,SS+RD+WR+AT)     :SUPERVISOR HISTORY
	SGU.REF(Q,8,0C,SS+RD+WR+AT)	:UTILTY SLOT SAVE AREA
	SGU.REF(Q,9,10,SS+RD+WR+AT)	:
        SGU.REF(Q,10,16,SS+RD+WR)	:DDT SAVE AREA
        SGU.REF(Q,11,13,SS+RD+WR+AT)     :USER AREA (818DCYL)
        SGU.REF(Q,12,14,SS+RD+WR+AT)     :FORMAT AREA (823DCYL)

        EI      (NDISC+NTAPE+MSCDSK)
   