
(MACHINE CONFIGURATION)
(ISIS/NODE CODE)
TSI MAXIMUM DATA I/O PROCESSING CAPABILITY
TEST I-A
BENCHMARK DERIVED FROM XRAY DB CIRCUITS
MAXIMUM BPS = 237,600 BPS


CHAN MODE/PROTOCOL   BAUD RATE   IOC THROUGHPUT  BANDWIDTH UTILIZATION
------------------   ---------   --------------  --------------------- 

0 = DMA/HDLC         72.0 Kbps   5050 CPS I/O    55% of theoretical
1 = DMA/HDLC         72.0 Kbps   5050 CPS I/O    55% of theoretical
2 = HDLC             19.2 Kbps   2380 CPS I/O    99% of theoretical
3 = HDLC             19.2 Kbps   2380 CPS I/O    99% of theoretical

TOTAL NODAL THROUGHPUT (I+O) = 29.7KCPS = 98.8% of T201 absolute limit
              per this configuration
PACKET SIZE = 128 Bytes
CODE DELAYS = ROUND TRIP DELAY REPORTED UP TO 7 SECONDS UNDER LOAD (DD)
EXEC  LOOPS = 20 IPS AT LOW WATER.  Code delay increases dramatically
              when iterations decrease to 20.



TEST I-B
BENCHMARK DERIVED FROM THROUGHPUT HOST
MAXIMUM BPS = 128,000 BPS
TOTAL CPS = 16K CPS
THROUGHPUT LOAD = 53.8% OF DB MEASUREMENTS/ 27.8% OF DIAGNOSTIC TPUT
========================================================================

(ISIS/NODE CODE/X.25-75)

TEST II-A
BENCHMARK DERIVED FROM TPUT HOST REPORTS & XRAY/DDT "SNAPS"
MAXIMUM NODAL AGGREGATE BPS = 76,000 BPS

TOTAL NODAL THROUGHPUT (I+O) = 9.5KCPS = 59.4% of T201 only

NOTE:  Occassional frame rejects are seen when running X.25
       Increasing the T1 timer to the maximum value (256x)
       helps to reduce the occurrance but not 100%.  The
       XCOM can be patched to ignore the T1 timer which
       eliminates the rejects.  

       Monitoring the X.25 reveals the slot processing is
       extremely bursty in nature.  The slot occassionally
       gets behind in processing data and fails to ack the
       DTE in time to avoid having the data retransmitted
       to it.  The slot then acks the data and sees the 
       record it just acknowledged sent to it again and 
       rejects it.  The DCE and DTE synchronize again and
       continue on again until it gets behind again.  The
       user is oblivious to this exchange and will observe
       only a degraded response time if anything at all.

       Use of an X.25 T2 timer could eliminate the observed
       rejects.  The T2 parameter period would establish
       the amount of time available at the DCE/DTE before the
       acknowledging frame must be initiated in order to
       ensure its receipt by the DTE/DCE prior to the T1
       timer expiration.


TEST II-B
EXECUTING MBASE CONCURRENTLY HAD LITTLE PERCEPTIBLE EFFECT ON
NODAL I/O THROUGHPUT.

(ISIS/NODE CODE/SDLC)
TEST III-A

SDLC I/O TESTED AT 9.6KBPS
BENCHMARK DERIVED FROM DDT "SNAPS"
MAXIMUM NODAL AGGREGATE BPS = 62,000 BPS
SDLC I/O TIMING RATE = 1/2 X.25 RATE TESTED

TOTAL NODAL THROUGHPUT (I+0) = 7.7KCPS

NOTE:  The SDLC bacgound test facility was utilized to generate
       the I/O traffic load on the interface.  Total nodal
       throughput was less than the X.25 throughput reflecting
       the difference in I/O bandwidth available.

TEST III-B
EXECUTING MBASE CONCURRENTLY HAD LIITLE IMPACT ON NODAL I/O
THROUGHPUT.

(ISIS/NODE CODE/TYMCOMM)
TEST IV-A
BENCHMARK DERIVED FROM XRAY/DDT & PC I/O REPORTS
MAXIMUM NODAL AGGREGATE BPS = 88,000 BPS
SIO-ASYNC BAUD RATE = 9.6KBPS

TOTAL NODAL THROUGHPUT = 11.0KCPS

EFFICIENCY:  37.5%

NOTE:  The highest observed actual data transfer was 360 bps or
       720 bps I+O on a 9.6K line.

TEST IV-B
EXECUTION OF MBASE CONCURRENTLY HAD NO IMPACT ON SIO-ASYNC
EFFICIENCY

(ISIS/NODE CODE/TYMSAT)
TEST V-A
BENCHMARK DERIVED AS IN TYMCOMM
MAXIMUM NODAL AGGREGATE BPS = 94,400 BPS
SIO-ASYNC BAUD RATE = 9.6KBPS

TOTAL NODAL THROUGHPUT (I+O) = 11.8KCPS

EFFICIENCY:  77.0%

NOTE:  The actual data transfer rate was over 2 times that of the
       TYMCOMM test.  Data transfer rate = 740 bps or 1480 bps
       I+O on a 9.6K line.

TEST V-B
EXECUTION OF MBASE CONCURRENTLY HAD NO IMPACT ON SIO-ASYNC
EFFICIENCY

=======================================================================

BISYNC TESTS:

3270 TIF, UTS TIF, UTS HIF INTERFACES WERE TESTED.

ALL BISYNC TESTING APPEARS TO PERFORM MARGINALLY AND IS EXTREMELY
VOLATILE.

THE MOST SUCCESSFUL CONFIGURATION WHEN IMPLEMENTING ANY BISYNC
APPLICATION IS TO RESERVE NO MORE THAN TWO (2) LOGICAL UNITS
FOR TYMNET "S.REFs", AND DO NOT EXCEED AN AGGREGATE I/O BIT
RATE OF 19,200 BPS.

CHANNELS 2 & 3 ARE THE ONLY CHANNELS CAPABLE OF BEING DOWNLINE
LOADED VIA TYMNET SYNCHRONOUS LINES AND SHOULD THEREFORE BE
RESERVED FOR NODE CODE IS TYMSYNCHRONOUS CONNECTIVITY IS
REQUIRED.  CHANNELS 0 & 1 SHOULD BE CONFIGURED FOR HDLC AND
THE MACHINE TYMFILE NSYNC EQUATE SET TO FOUR (4) TO ALLOW
INITIALIZATION OF EMULATED SYNC LINES 2 & 3.  AT NODE START-UP
ISIS WILL REPORT 2 ERROR MESSAGES FOR FAILING TO INITIALIZE
EMULATED SYNC PORTS 0 & 1 BUT AS THESE ARE NOT ASSIGNED TO
NODE CODE OR ANY SLOTS NO FURTHER ERROR SHOULD BE ENCOUNTERED.

ANY OTHER APPLICATIONS REQUIRING BISYNC SHOULD UTILIZE CHANNELS
0 & 1 WITH 2 & 3 CONFIGURED FOR HDLC.

TSI SYNCHRONOUS FIRMWARE HAS A BUG OBSERVED WHEN TOGGLING
CONTROL SIGNALS DTR/DSR, RTS/CTS FOR HANDSHAKE WHEN TRANSFERRING
DATA.  THE EFFECT IS THE SCC WILL FALL INTO A TRANSMIT ENDING
CONDITION FOREVER, SO ANY BISYNC INTERFACE BROUGHT UP AT THIS
TIME SHOULD SET THEIR HANDSHAKE (SWITCHED) EQUATES TO OFF.

=======================================================================

TSI TTY BOOT AND LOAD FACILITY TESTED SUCCESSFULLY AT 4800 BAUD, THE
DEFAULT BAUD RATE FOR THE TTY I/O.

IT MAY PROVE BENEFICIAL TO CHANGE THE DEFAULT BAUD RATE TO 1200 BAUD
TO PERMIT A WIDER VARIETY OF TERMINALS TO BE USED WITH THE TSI AS
WELL AS REDUCING THE AMOUNT OF MAILBOX TRANSACTIONS GENERATED BY
THE TTY PORT BY 4 TIMES.  

=======================================================================

 