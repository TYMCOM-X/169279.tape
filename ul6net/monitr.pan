=============================================================================
09-Apr-85                   ENGINE MONITOR PANEL        (MGTNET:37)MONITR.PAN
=============================================================================
-----------------------------------------------------------------------------
In reference to our conversation concerning the monitor panel on the front of
the engine and how to recognize the appropriate EIA RS232 signals, I prepared
the following information:  

     ===================================================================
     |   |    BLACK   |   RED     |  ORANGE   |   GREEN   |   WHITE    |
     |   |--------------------------------------------------------------
     | A | T R   D D C|T R   D D C|T R   D D C|T R   D D C|T R   D D C |
     | S | M C   T S A|M C   T S A|M C   T S A|M C   T S A|M C   T S A |
     | Y | T V B L T R|T V B L T R|T V B L T R|T V B L T R|T V B L T R |
     | N |     U      |    U      |    U      |    U      |    U       |
     | C | D D S R R D|D D S R R D|D D S R R D|D D S R R D|D D S R R D |
     |   | T T Y D D E|T T Y D D E|T T Y D D E|T T Y D D E|T T Y D D E |
     |   | A A   Y Y T|A A   Y Y T|A A   Y Y T|A A   Y Y T|A A   Y Y T |
     ===================================================================
     |   |   |   WHITE  |  GREEN  |    BLACK      |      RED       |   |
     | S |   |----------------------------------------------------------
     | Y |   | T R T R R|T R T R R|T R T R D D C R|T R T R D D C R |   |
     | N |   | M C M C E|M C M C E|M C M C S T L E|M C M C S T L E |   |
     | C |   | T V T V Q|T V T V Q|T V T V T L R Q|T V T V T L R Q |   |
     |   |   |          |         |               |                |   |
     |   |   | D D C C S|D D C C S|D D C C R R S S|D D C C R R S S |   |
     |   |   | T T L L N|T T L L N|T T L L D D N N|T T L L D D N N |   |
     |   |   | A A K K D|A A K K D|A A K K Y Y D D|A A K K Y Y D D |   |
     ===================================================================
           G G G G G G G G G G G G G G G G G G G G G G G G G G G G G G 
           R R R R R R R R R R R R R R R R R R R R R R R R R R R R R R 

        / |     0     |     1     |     2     |     3     |     4     |
 ASYNC <  |     5     |     6     |     7     |     8     |     9     |
 PORTS  \ |    10     |    11     |    12     |    13     |    14     |
                                 ..., ETC!

           /  |    0    |    1    |       2       |       3       |
 SYNC     /   |    4    |    5    |       6       |       7       |
 PORTS    \   |    8    |    9    |      10       |      11       |
           \  |   12    |   13    |      14       |      15       |
                  ^         ^             ^              ^
                  |         |             |              |
                   PRIMITIVE                NON-PRIMITIVE    

In the async groups, the labels correspond to the following RS-232 pins:
  TMT DTA  =  TD (Transmit Data)
  RCV DTA  =  RD (Receive Data)
  BUSY     =  BUSY
  DTL RDY  =  DTR (Data Transmit Ready)
  DST RDY  =  DSR (Data Send Ready)
  CAR DET  =  DCD (Data Carrier Detect)
  
In the sync groups, white and green are "primitive" ports, ie, they do
not provide full modem signals.  Their labels translate as follows:
  TMT DTA  =  TD (Transmit Data)
  RCV DTA  =  RD (Receive Data)
  TMT CLK  =  TC (Transmitter Clock)
  RCV CLK  =  RC (Receiver Clock)
  REQ SND  =  RTS (Request To Send)

In the sync groups, black and red are "non-primitive" ports, ie, they pro-
vide full modem signals.  Their labels translate as follows:
  TMT DTA  =  TD (Transmit Data)
  RCV DTA  =  RD (Receive Data)
  TMT CLK  =  TC (Transmit Clock)
  RCV CLK  =  RC (Receive Clock)
  DST RDY  =  DSR (Data Send Ready)
  DTL RDY  =  DTR (Data Transmit Ready)
  CLR SND  =  CTS (Clear To Send)
  REQ SND  =  RTS (Request To Send)

On the back of the engine, the monitor cable is positioned by the upper row
of receptacles on the bottom-most port panel.  Starting from the far right,
the first four receptacles cover the 16 sync ports for the engine with four
ports per receptacle, numbering 0-3, 4-7, 8-11, and 12-15.  The first two
ports in each group correspond to "SYNC-WHITE" and "SYNC-GREEN" on the moni-
tor panel.  The second two ports in each group correspond to "SYNC-BLACK" 
and "SYNC-RED".  Continuing from right to left, the remaining receptacles
correspond to the async ports in groups of FIVE ports per receptacle, num-
bering 0-4, 5-9, 10-14, etc.  Each group of five corresponds to "ASYNC-
BLACK" through "ASYNC-WHITE" on the monitor panel.

Another feature of the monitor panel is the light sensitivity switch.  It is
located beside the green and red lights and is spring-loaded to stay in the
5 Volt position, but can be held in the .5 Volt position to detect the pre-
sence of signals that are too weak for the engine to recognize.

The last concept to recognize is the correspondence of the "A.REF(#)" in the
.TYM file for the node to the async port numbering on the back of the engine.
An async board of 32 ports is divided into two "references" of 16 ports each.
The addressing on the async board and the way the ribbon cables from that 
board are cabled to the async port panels on the back of the engine determine
the physical location of those ports.  On the first async board, the first
reference (A.REF(0)) corresponds to async ports 0-15, and the second reference
(A.REF(1)) to ports 16-31.  On the second async board, the third reference 
(A.REF(2)) corresponds to ports 32-47, and the fourth reference (A.REF(3)) to
ports 48-63.

Marc Green
Regional Technical Manager
Eastern Region Network Support
-----------------------------------------------------------------------------
    