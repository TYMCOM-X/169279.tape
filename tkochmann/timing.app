









                         M E M O R A N D U M

                                          [] T Y M N E T, I N C
DATE>      18 FEB 87                         Network Technology Development

TO>        William Euske

COPIES>    Distribution

FROM>      Dennis Jonas


SUBJECT>   Tymnet Engine Timing Study Results

-----------------------------------------------------------------------

           Timing studies and analysis have been completed on eight
           different Engine configurations beginning with the MAC-I
           and ending with the CPU-III operating at 12 MHZ.  Since
           there is a considerable range of basic CPU power available, 
           I would suggest marketing, network engineering, and development
           personnel familiarize themselves with these documents.

           Reference tables are included drawing comparisons between
           relative CPU power of the various systems.  You will note
           modest improvements in system performance until the introduction
           of the MAC-III and substantial gains thereafter.

           The CPU-III/MAC-III combination operating at 12 MHZ clock rate
           is not available for production as of this date, but will
           provide for three times the power of the current MAC-II dynamic
           memory systems.

           DISTRIBUTION:

           Michael P. Cady
           Bert Novak
           Neil Sullivan
           Bob Tomasi
           Al Fenn
           Bob Barbour
           Rourke McCusker
           Don Johnson
           Gary Walker
           Jack Snavely
           A. Rajaraman
           Dave Alcorn
           Bill Euske
           Mike Rude
           Mary Ann Lubina
           Angela Long
           Ralph Brown








                      TYMNET ENGINE POWER RATIO TABLE


MACHINE        MACH   MACI   MACII  MACII  MACII  MACII  MACIII  MACIII  CPUIII
TYPE           RATE   CORE   CORE   DYNAM  MICRO  STATIC 8 MHZ   10 MHZ  12 MHZ

MACI   CORE    15.84   ---   1.074  1.131  1.199  1.485  2.295   2.869   3.444
MACII  CORE    17.02  1.074   ---   1.053  1.116  1.382  2.136   2.670   3.206
MACII  DYNAM   17.92  1.131  1.053   ---   1.060  1.313  2.029   2.536   3.045
MACII  MICRO   18.99  1.199  1.116  1.060   ---   1.239  1.915   2.393   2.873
MACII  STATIC  23.53  1.485  1.382  1.313  1.239   ---   1.545   1.932   2.319
MACIII 8  MHZ  36.36  2.295  2.136  2.029  1.915  1.545   ---    1.250   1.501
MACIII 10 MHZ  45.45  2.869  2.670  2.536  2.393  1.932  1.250    ---    1.200
CPUIII 12 MHZ  54.56  3.444  3.206  3.045  2.873  2.319  1.501   1.200     ---


                     TYMNET ENGINE POWER RATED BY
                 MILLION INSTRUCTIONS PER SECOND (MIPS)
      
                            ----------MIPS BY FORMAT TYPE-----------
      MACHINE        MACH     RX1    RX2    RX3    RI1    RI2    RR
      TYPE           MIPS   FORMAT FORMAT FORMAT FORMAT FORMAT FORMAT
      
      MACI   CORE    0.446  0.339  0.320  0.250  0.551  0.390  0.824
      MACII  CORE    0.476  0.361  0.341  0.267  0.593  0.421  0.875
      MACII  DYNAM   0.490  0.368  0.345  0.269  0.593  0.410  0.954
      MACII  MICRO   0.531  0.399  0.372  0.289  0.682  0.475  0.974
      MACII  STATIC  0.642  0.497  0.467  0.364  0.833  0.605  1.084
      MACIII 8  MHZ  0.898  0.741  0.685  0.505  1.221  0.969  1.264
      MACIII 10 MHZ  1.122  0.926  0.857  0.631  1.527  1.212  1.580
      CPUIII 12 MHZ  1.346  1.111  1.027  0.757  1.833  1.453  1.893
      
      
                        TYMNET ENGINE POWER RATED BY
              MAXIMUM INTERNAL DATA TRANSFER CAPABILITY (JPPU)
      
                            -----JPPU BY FORMAT TYPE-----
      MACHINE       MACHINE   RX1     RX2     RX3     RR
      TYPE           JPPU    JPPU    JPPU    JPPU    JPPU 
      
      MACI   CORE    15.84  114.55  114.04  110.83  117.76
      MACII  CORE    17.02  123.99  123.39  119.92  125.44
      MACII  DYNAM   17.92  139.66  137.93  133.56  143.36
      MACII  MICRO   18.99  151.42  151.00  145.97  148.48
      MACII  STATIC  23.53  184.86  183.53  177.18  153.60
      MACIII 8  MHZ  36.36  326.15  322.04  302.99  168.96
      MACIII 10 MHZ  45.45  407.64  402.52  378.70  215.04
      CPUIII 12 MHZ  54.56  489.18  483.06  454.45  256.00
      












                      DIVERGENCE OF INSTRUCTION POWER

        With the design of MACIII memory system, some peculiarities surfaced
        where relative power increases were asymmetrical.  Ratings are JPPU.

        The following set depicts a divergence between the LOAD fullword using
        a simple Load instruction vs. Load Multiple register 15 reference.
        The same phenomenon did not occur with the equivalent store functions.


INSTRUCTION     MACI    MACII   MACII   MACII  MACII  MACIII  MACIII  CPUIII
TYPE            CORE    CORE    DYNAM   MICRO  STATIC 8 MHZ   10 MHZ  12 MHZ

L       RX1     57.14   61.54   63.04   66.84  88.88  145.46  181.82  218.10
LM/R15  RX1     57.14   61.54   63.04   66.88  88.88 (160.00  200.00  240.10)
ST      RX1     55.18   59.26   65.12   72.62  84.22  133.34  166.66  200.00 
STM/R15 RX1     55.18   59.26   65.06   73.72  84.22  133.34  166.66  200.00       






        The set below indicates a divergence between the Load Multiple
        and Store Multiple combination vs. the Copy instruction.  All
        instructions involve 64 byte data transfers.  Ratings are JPPU.


LM/STM  RX1    114.55  123.99  139.66  151.42 184.86 (326.15  407.64  489.18)
COPY    RR     115.20  124.16  138.88  145.28 149.76  168.32  210.56  252.80








        TYMNET ENGINE TIMING LIST DEFINITIONS

        FUNCTION - lists  the instruction mnemonic, instruction format
        type, and parameters peculiar  to the instruction being timed.

        e.g.  LM   RX1 REG 0    Load Multiple, RX1 format, 64 bytes
              WD   RX3 T/O      I/O instruction Timed Out

        LOOP TIMING -  the basic time to execute the test loop without
        an actual instruction inserted into the timing loop.  This forms
        the basis for establishing all other timings.

        MACHINE RATING - this rating is based on the JPPU rating described
        below.  It reflects the rate of transfer ability to move one byte of
        data from one memory location to another memory location via the
        lowest common denominator instruction set.  i.e.  Load/Store Byte.
        This provides us with a "horsepower" equivalent which can be used
        to determine relative power variations of different machines.
        e.g.  In relative terms, a machine rating of 45.45 would basically be
              2.536 times as as powerful as a machine rating of 17.92

        TIMING - average time stated in microseconds to execute the
        instruction.  This is averaged over the specified instruction sample
        rate.  Where the instruction sample rate is 180 seconds, the
        instruction loop is run for 180 seconds and calculations derived over
        this time period.  Refer to instruction calculation definitions for
        details.

        MIPS - million instructions per second is derived from the instruction
        timing where one microsecond instruction timing is equivalent to one
        MIP.

        JPPU -  Jonas's Processing Power Unit is a rating system designed to
        reflect the ability to do work.  The JPPU factor is a unit of power
        equal to moving 10,000 bytes of data from one memory location to
        another memory location within one second.

        e.g.  A JPPU rating of 106.56 indicates this instruction is capable
              of moving data internally at a rate of 1,065,600 bytes per
              second.

        The JPPU for a single phase instruction such as the Load RX2 takes
        into account a 4 byte transfer and one half transfer cycle in
        such a manner that if combined with a Store RX2, the relative power
        is the approximate average of the two.

        e.g.  If Load RX2 JPPU = 200
              & Store RX2 JPPU = 185

              The effective JPPU is:  (200+185)/2= 192.5
              192.5 x 10,000 = 1,925,000 bytes/second transfer capability








        RAW DATA - this column simply reflects test loop counts achieved
        during test execution over the period of time indicated in the sample
        rate.  This is only used for verification purposes.

        TOTAL AVERAGE MIPS - the average million instructions per second
        derived from total instruction time which reflects all instructions
        executed and timed.  This figure is used for verification purposes
        and is not intended to reflect true machine power since it includes
        duplicate and worst case timings.

        TOTAL INSTR TIME - total instruction  time is simply the addition
        of all instruction execution times and used for verification purposes.
        It is not intended to reflect true machine power since it includes
        duplicate and worst case timings.

        SELECTED TIMING STATISTICS - these timing statistics reflect true
        timings based on instruction format type.  Instructions marked with a
        (+) have been excluded for reasons of being redundant, special 
        application, or not normally utilized in the manner tested.

                TOTAL TIME - addition of all instruction timings for the
                specified instruction format.

                AVERAGE TIME - average time derived by dividing the total
                time by the number of instructions included in total time
                for the specified instruction format.

                TOTAL MIPS - addition of all instruction mips for the 
                specified instruction format.

                AVERAGE MIPS - average mips derived by dividing the total
                mips by the number of instructions included in total mips
                for the specified instruction format.









        TYMNET ENGINE INSTRUCTION TIMING CALCULATIONS


        Tymnet Engine Instruction Timing Calculations as implemented in
        the "TIMING.NAD" program are basically accomplished in the manner
        specified below.  The COPY, ARAND, and CKSUM instructions are
        calculated in the same manner, but with additional timing adjustments
        since execution of these instructions will destroy register setup
        contents.  The timing must be accomplished with no interrupts 
        occurring other than the special timing interrupt which in this
        example is set for 180 second intervals.  A special timing interrupt
        PC board must be installed on the Engine backplane along with a
        minor strap option on the multifunction card to allow proper
        operation of the special interrupter.


        A constant Timing Loop is established and timed consisting of:

        TLOOP   JALR    R14,R15
                AM      R11,CYCLES
                JNBS    TLOOP

        The JALR    R14,R15 always returns via a JR R14

        R15 is modified to allow insertion of each instruction being
        timed into the basic loop.  Timing is then calculated and adjusted
        to remove the basic loop timing.

        After the specified RATE which in this case is 180 seconds, an 
        interrupt occurs and timing calculated.








        FIND CYCLES PER SECOND
        Multiply Raw CYCLE count by 10 to facilitate rounding by 0.5
        Divide result by RATE (180)
        Add 5 to result
        Divide result by 10 to obtain raw cycles per second

        FIND AVERAGE TIME/CYCLE TO THE 12TH POWER
        Divide 1,000,000,000,000 by raw cycles per second obtained above
        Subtract basic loop time (in picoseconds) from quotient

        CONVERT OUTPUT FROM PICOSECONDS TO NANOSECONDS (ROUNDED)
        
        BASIC LOOP TIMING CALCULATION

        0310C33A        51430202        RAW LOOP COUNT DATA
            x 0A            x 10        MULTIPLY BY 10
        1EA7A044       514302020       
          -:- B4         -:- 180        DIVIDE BY INTERRUPT RATE
          2B9911         2857233 
             + 5             + 5        ROUND UP
          2B9916         2857238
          -:- 0A          -:- 10        DIVIDE BY 10
           45C1B          285723        RESULT = RAW CYCLES PER SECOND

        E8D4A51000      1,000,000,000,000       ESTABLISH PICOSECONDS
         -:- 45C1B            -:- 285,723       DIVIDE BY RAW CYCLES/SECOND
            356775              3,499,893       RESULT = BASIC LOOP TIMING

        INSTRUCTION TIMING EXAMPLE

        02551A46        39131718        RAW LOOP COUNT DATA
            x 0A            x 10
        175306BC       391317180        RESULT
          -:- B4         -:- 180        DIVIDE BY INTERRUPT RATE
          212C20         2173984
             + 5             + 5        ROUND UP
          212C25         2173989
          -:- 0A          -:- 10        DIVIDE BY 10
           35136          217398        RESULT = RAW CYCLES PER SECOND

        E8D4A51000      1,000,000,000,000       ESTABLISH PICOSECONDS
         -:- 35136            -:- 217,398       DIVIDE BY RAW CYCLES/SECOND
            463032              4,599,858       FULL INSTRUCTION LOOP TIMING
          - 356775            - 3,499,893       SUBTRACT BASIC LOOP TIMING
            10C8B1              1,099,953       
             + 1F4                  + 500       ROUND UP 500 PICOSECONDS
            10CAA5              1,100,453       
           -:- E38              -:- 1,000       CONVERT TO NANOSECONDS
               44C                  1,100       FINAL INSTRUCTION TIMING








        
                                   TYMNET ENGINE
        
                        MEMORY SYSTEM TIMING - MACI AMPEX CORE
        
        
        
        ENGINE INSTRUCTION SET TIMING - VERSION 1.01
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         9.437    .        .    01230BEB  
        MACHINE RATING      6.312    .      15.84  00AE659D  
        L    RX1            3.500  00.285   57.14  00D44F38  
        L    RX2            3.625  00.275   55.18  00D24717  
        L    RX3            4.437  00.225   45.08  00C5F6BD  
        LH   RX1            2.687  00.372   37.22  00E2894C  
        LH   RX2            2.812  00.355   35.56  00E03978  
        LH   RX3            3.625  00.275   27.59  00D2470D  
        LHI  RI1            1.750  00.571     .    00F584F9  
        LI   RI2            2.562  00.390     .    00E4E557  
        LR    RR            0.938  01.066     .    0108BF41  
        LIS   SF            0.937  01.067     .    0108BF48  
        LCS   SF            0.937  01.067     .    0108BF50  
        LA   RX1            2.000  00.500     .    00F02737  
        LA   RX2            2.125  00.470     .    00ED8E8A  
        LA   RX3            2.937  00.340     .    00DDF5AB  
        LHL  RX1            2.687  00.372   37.22  00E28946  
        LHL  RX2            2.812  00.355   35.56  00E03979  
        LHL  RX3            3.625  00.275   27.59  00D24709  
        LM   RX1 REG 0     27.874  00.035  114.88  00499D5C +
        LM   RX2 REG 0     27.998  00.035  114.24  00495E70 +
        LM   RX3 REG 0     28.811  00.034  111.04  0047CF79 +
        LM   RX1 REG 1     26.248  00.038  114.30  004CF77B +
        LM   RX2 REG 1     26.373  00.037  113.70  004CB2B6 +
        LM   RX3 REG 1     27.186  00.036  110.40  004AFF1E +
        LM   RX1 REG 8     14.874  00.067  107.52  0070FA0F +
        LM   RX2 REG 8     14.999  00.066  106.72  00706622 +
        LM   RX3 REG 8     15.812  00.063  101.12  006CC840 +
        LM   RX1 REG 15     3.500  00.285   57.14  00D44F2E  
        LM   RX2 REG 15     3.625  00.275   55.18  00D24707  
        LM   RX3 REG 15     4.437  00.225   45.08  00C5F6BF  
        LB   RX1            2.687  00.372   18.61  00E28948  
        LB   RX2            2.812  00.355   17.78  00E03972  
        LB   RX3            3.625  00.275   13.79  00D2470B  
        LBR   RR            0.938  01.066     .    0108BF3C  
        EXHR  RR            0.938  01.066     .    0108BF42  
        EXBR  RR            0.938  01.066     .    0108BF3D  
        ST   RX1            3.625  00.275   55.18  00D24710  
        ST   RX2            3.750  00.266   53.34  00D048CA  
        ST   RX3            4.562  00.219   43.84  00C4324A  
        STH  RX1            2.812  00.355   35.56  00E03972  
        STH  RX2            2.937  00.340   34.05  00DDF59B  
        STH  RX3            3.750  00.266   26.67  00D048D7  







        STM  RX1 REG 0     27.998  00.035  114.24  00495E72 +
        STM  RX2 REG 0     28.123  00.035  113.92  00491FF4 +
        STM  RX3 REG 0     28.936  00.034  110.72  00479398 +
        STM  RX1 REG 1     26.373  00.037  113.70  004CB2B2 +
        STM  RX2 REG 1     26.498  00.037  113.10  004C6E67 +
        STM  RX3 REG 1     27.310  00.036  109.80  004ABDD2 +
        STM  RX1 REG 8     14.999  00.066  106.72  00706624 +
        STM  RX2 REG 8     15.124  00.066  105.76  006FD3B6 +
        STM  RX3 REG 8     15.937  00.062  100.32  006C3F0A +
        STM  RX1 REG 15     3.625  00.275   55.18  00D24702  
        STM  RX2 REG 15     3.750  00.266   53.34  00D048C6  
        STM  RX3 REG 15     4.562  00.219   43.84  00C43249  
        STB  RX1            3.625  00.275   13.79  00D2470B  
        STB  RX2            3.750  00.266   13.33  00D048C3  
        STB  RX3            4.562  00.219   10.96  00C4323E  
        STBR  RR            0.938  01.066     .    0108BF31  
        COPY  RR 2   BYT    3.749  00.266   53.34  006F8B11 +
        COPY  RR 16  BYT   15.125  00.066  105.76  004C4C73 +
        COPY  RR 32  BYT   28.124  00.035  113.92  00380E5D +
        COPY  RR 64  BYT   55.684  00.017  115.20  0023E03A +
        COPY  RR 128 BYT  110.809  00.009  115.20  0014DBAB +
   COPY  RR 256 BYT  221.023  00.004  115.20  000B5A67 +
        COPY  RR 512 BYT  441.447  00.002  117.76  0005F091 +
        COPY  RR 1024 BY  882.469  00.001  112.64  00030A53 +
        N    RX1            3.500  00.285     .    00D44F20  
        N    RX2            3.625  00.275     .    00D2470F  
        N    RX3            4.437  00.225     .    00C5F6CE  
        NH   RX1            2.687  00.372     .    00E2894B  
        NH   RX2            2.812  00.355     .    00E03988  
        NH   RX3            3.625  00.275     .    00D24710  
        NHI  RI1            1.750  00.571     .    00F58503  
        NI   RI2            2.562  00.390     .    00E4E55B  
        NR    RR            0.937  01.067     .    0108BF48  
        O    RX1            3.500  00.285     .    00D44F34  
        O    RX2            3.625  00.275     .    00D24714  
        O    RX3            4.437  00.225     .    00C5F6C9  
        OH   RX1            2.687  00.372     .    00E28941  
        OH   RX2            2.812  00.355     .    00E03986  
        OH   RX3            3.625  00.275     .    00D2471E  
        OHI  RI1            1.750  00.571     .    00F58511  
        OI   RI2            2.562  00.390     .    00E4E55B  
        OR    RR            0.938  01.066     .    0108BF3E  
        X    RX1            3.500  00.285     .    00D44F2D  
        X    RX2            3.625  00.275     .    00D24718  
        X    RX3            4.437  00.225     .    00C5F6D5  
        XH   RX1            2.687  00.372     .    00E28943  
        XH   RX2            2.812  00.355     .    00E0397A  
        XH   RX3            3.625  00.275     .    00D24710  
        XHI  RI1            1.750  00.571     .    00F58510  
        XI   RI2            2.562  00.390     .    00E4E569  
        XR    RR            0.937  01.067     .    0108BF4A  







        ARAND RR 16/nm      4.062  00.246     .    006E2538 +
        ARAND RR 16/B 0     4.187  00.238     .    006D9897 +
        ARAND RR 16/B 1     4.312  00.231     .    006D0D5E +
        ARAND RR 16/B 2     4.437  00.225     .    006C8385 +
        ARAND RR 16/B 7     5.062  00.197     .    0069E621 +
        ARAND RR 16/B 13    5.812  00.172     .    0066EC3C +
        ARAND RR 16/B 14    5.937  00.168     .    00667164 +
        ARAND RR 16/B 15    6.062  00.164     .    0065F7B5 +
        ARAND RR 32/nm      7.437  00.134     .    006103FD +
        ARAND RR 32/B 0     7.562  00.132     .    006096D3 +
        ARAND RR 32/B 1     7.687  00.130     .    00602A98 +
        ARAND RR 32/B 2     7.812  00.128     .    005FBF50 +
        ARAND RR 32/B 15    9.437  00.105     .    005A9D4F +
        ARAND RR 32/B 16    4.187  00.238     .    006D989C +
        ARAND RR 32/B 17    4.312  00.231     .    006D0D62 +
        ARAND RR 32/B 30    5.937  00.168     .    00667168 +
        ARAND RR 32/B 31    6.062  00.164     .    0065F7B3 +
        THI  RI1            1.750  00.571     .    00F5850A  
        TI   RI2            2.562  00.390     .    00E4E561  
        SLL  RX1  0 POS     2.250  00.444     .    00EB0430 +
        SLL  RX1  1 POS     2.625  00.380     .    00E3B5CB  
        SLL  RX1  2 POS     2.750  00.363     .    00E15FDC +
        SLL  RX1  3 POS     2.875  00.347     .    00DF161D +
        SLL  RX1 32 POS     6.500  00.153     .    00AC5862 +
        SLLS  SF  0 POS     1.562  00.640     .    00F9B474 +
        SLLS  SF  1 POS     1.812  00.551     .    00F427E9  
        SLLS  SF  2 POS     1.937  00.516     .    00F17902 +
        SLLS  SF  3 POS     2.062  00.484     .    00EED912 +
        SLLS  SF 15 POS     3.562  00.280     .    00D349E2 +
        SRL  RX1  0 POS     2.250  00.444     .    00EB042F +
        SRL  RX1  1 POS     2.625  00.380     .    00E3B5CF  
        SRL  RX1  2 POS     2.750  00.363     .    00E15FE1 +
        SRL  RX1  3 POS     2.875  00.347     .    00DF161E +
        SRL  RX1 32 POS     6.500  00.153     .    00AC585D +
        SRLS  SF  0 POS     1.562  00.640     .    00F9B46D +
        SRLS  SF  1 POS     1.812  00.551     .    00F427EA  
        SRLS  SF  2 POS     1.937  00.516     .    00F17909 +
        SRLS  SF  3 POS     2.062  00.484     .    00EED915 +
        SLHL RX1  0 POS     2.250  00.444     .    00EB0421 +
        SLHL RX1  1 POS     2.875  00.347     .    00DF1623  
        SLHL RX1  2 POS     3.000  00.333     .    00DCD830 +
        SLHL RX1  3 POS     3.125  00.320     .    00DAA5A6 +
        SLHLS SF  0 POS     1.562  00.640     .    00F9B469 +
        SLHLS SF  1 POS     2.062  00.484     .    00EED911  
        SLHLS SF  2 POS     2.187  00.457     .    00EC479A +
        SLHLS SF  3 POS     2.312  00.432     .    00E9C428 +
        SRHL RX1  0 POS     2.250  00.444     .    00EB0434 +
        SRHL RX1  1 POS     2.875  00.347     .    00DF1626  
        SRHL RX1  2 POS     3.000  00.333     .    00DCD823 +
        SRHL RX1  3 POS     3.125  00.320     .    00DAA599 +
        SRHLS SF  0 POS     1.562  00.640     .    00F9B46D +
        SRHLS SF  1 POS     2.062  00.484     .    00EED922  
        SRHLS SF  2 POS     2.187  00.457     .    00EC47A3 +
        SRHLS SF  3 POS     2.312  00.432     .    00E9C41F +







        RLL  RX1  0 POS     2.250  00.444     .    00EB0421 +
        RLL  RX1  1 POS     2.625  00.380     .    00E3B5C5  
        RLL  RX1  2 POS     2.750  00.363     .    00E15FE8 +
        RLL  RX1  3 POS     2.875  00.347     .    00DF162B +
        RLL  RX1 32 POS     6.500  00.153     .    00AC585F +
        RRL  RX1  0 POS     2.250  00.444     .    00EB0421 +
        RRL  RX1  1 POS     2.625  00.380     .    00E3B5C3  
        RRL  RX1  2 POS     2.750  00.363     .    00E15FE6 +
        RRL  RX1  3 POS     2.875  00.347     .    00DF162E +
        RRL  RX1 32 POS     6.500  00.153     .    00AC5862 +
        TS   RX1            3.375  00.296     .    00D6616D  
        TS   RX2            3.500  00.285     .    00D44F2B  
        TS   RX3            4.312  00.231     .    00C7C389  
        TBT  RX1            3.062  00.326     .    00DBBD84  
        TBT  RX2            3.187  00.313     .    00D99087  
        TBT  RX3            4.000  00.250     .    00CC68CD  
        SBT  RX1            3.875  00.258     .    00CE5424  
        SBT  RX2            4.000  00.250     .    00CC68D1  
        SBT  RX3            4.812  00.207     .    00C0C12F  
        RBT  RX1            3.875  00.258     .    00CE5431  
        RBT  RX2            4.000  00.250     .    00CC68CE  
        RBT  RX3            4.812  00.207     .    00C0C121  
        CBT  RX1            4.000  00.250     .    00CC68CF  
        CBT  RX2            4.125  00.242     .    00CA868B  
        CBT  RX3            4.937  00.202     .    00BF1419  
        JF   RX1 M=1,C=2    1.875  00.533     .    00F2CE8A  
        JF   RX1 M=2,C=2    2.000  00.500     .    00F0272D  
        JF   RX2 M=1,C=2    2.000  00.500     .    00F02731  
        JF   RX2 M=2,C=2    2.125  00.470     .    00ED8E95  
        JF   RX3 M=1,C=2    2.812  00.355     .    00E0398B  
        JF   RX3 M=2,C=2    2.937  00.340     .    00DDF5B5  
        JFR   RR M=1,C=2    1.312  00.762     .    00FF82FE  
        JFR   RR M=2,C=2    0.938  01.066     .    0108BF3E  
        JFBS  SF M=1,C=2    1.187  00.842     .    0102848F  
        JFBS  SF M=2,C=2    0.937  01.067     .    0108BF52  
        JFFS  SF M=1,C=2    1.187  00.842     .    0102849B  
        JFFS  SF M=2,C=2    0.938  01.066     .    0108BF45  
        JT   RX1 M=2,C=2    1.875  00.533     .    00F2CE84  
        JT   RX1 M=1,C=2    2.000  00.500     .    00F02732  
        JT   RX2 M=2,C=2    2.000  00.500     .    00F0273C  
        JT   RX2 M=1,C=2    2.125  00.470     .    00ED8E9B  
        JT   RX3 M=2,C=2    2.812  00.355     .    00E03982  
        JT   RX3 M=1,C=2    2.937  00.340     .    00DDF5AC  
        JTR   RR M=2,C=2    1.312  00.762     .    00FF82FE  
        JTR   RR M=1,C=2    0.937  01.067     .    0108BF48  
        JTBS  SF M=2,C=2    1.187  00.842     .    0102849A  
        JTBS  SF M=1,C=2    0.937  01.067     .    0108BF4F  
        JTFS  SF M=2,C=2    1.187  00.842     .    0102848C  
        JTFS  SF M=1,C=2    0.938  01.066     .    0108BF40  
        NOP  RX1            2.000  00.500     .    00F02736  
        NOP  RX2            2.125  00.470     .    00ED8E99  
        NOP  RX3            2.937  00.340     .    00DDF5BA  
        NOPR  RR            0.938  01.066     .    0108BF43  







        J    RX1            1.875  00.533     .    00F2CE81  
        J    RX2            2.000  00.500     .    00F02732  
        J    RX3            2.812  00.355     .    00E03987  
        JR    RR            1.312  00.762     .    00FF8310  
        JBS   SF            1.187  00.842     .    01028490  
        JFS   SF            1.187  00.842     .    0102848B  
        JAL  RX1            1.875  00.533     .    00F2CE85  
        JAL  RX2            2.000  00.500     .    00F02737  
        JAL  RX3            2.812  00.355     .    00E0398A  
        JALR  RR            1.875  00.533     .    00F2CE91  
        JFFO  SF ALL  =0    1.562  00.640     .    00F9B463 +
        JFFO  SF BIT 0=1    1.687  00.592     .    00F6E623 +
        JFFO  SF BIT 1=1    1.625  00.615     .    00F84B43 +
        JFFO  SF BIT 2=1    1.750  00.571     .    00F58516 +
        JFFO  SF BIT30=1    5.250  00.190     .    00BB0356 +
        JFFO  SF BIT31=1    5.375  00.186     .    00B96F4B +
        JFFOH SF ALL  =0    1.562  00.640     .    00F9B463 +
        JFFOH SF BIT 0=1    1.687  00.592     .    00F6E628 +
        JFFOH SF BIT 1=1    1.625  00.615     .    00F84B49 +
        JFFOH SF BIT 2=1    1.750  00.571     .    00F5851A +
        JFFOH SF BIT14=1    3.250  00.307     .    00D87E28 +
        JFFOH SF BIT15=1    3.375  00.296     .    00D6616E +
        A    RX1            3.500  00.285     .    00D44F2D  
        A    RX2            3.625  00.275     .    00D24716  
        A    RX3            4.437  00.225     .    00C5F6D7  
        AH   RX1            2.687  00.372     .    00E2894A  
        AH   RX2            2.812  00.355     .    00E0397D  
        AH   RX3            3.625  00.275     .    00D2470E  
        AHI  RI1            1.750  00.571     .    00F5850D  
        AI   RI2            2.562  00.390     .    00E4E567  
        AR    RR            0.937  01.067     .    0108BF4D  
        AIS   SF            0.938  01.066     .    0108BF41  
        AM   RX1            5.625  00.177     .    00B65B5E  
        AM   RX2            5.750  00.173     .    00B4DB27  
        AM   RX3            6.562  00.152     .    00ABAC0C  
        AHM  RX1            3.750  00.266     .    00D048DC  
        AHM  RX2            3.875  00.258     .    00CE542A  
        AHM  RX3            4.687  00.213     .    00C275D0  
        S    RX1            3.500  00.285     .    00D44F2C  
        S    RX2            3.625  00.275     .    00D24718  
        S    RX3            4.437  00.225     .    00C5F6D7  
        SH   RX1            2.687  00.372     .    00E28949  
        SH   RX2            2.812  00.355     .    00E0397D  
        SH   RX3            3.625  00.275     .    00D2470F  
        SHI  RI1            1.750  00.571     .    00F5850F  
        SI   RI2            2.562  00.390     .    00E4E568  
        SR    RR            0.937  01.067     .    0108BF4C  
        SIS   SF            0.938  01.066     .    0108BF3F  







        CL   RX1            3.500  00.285     .    00D44F2A  
        CL   RX2            3.625  00.275     .    00D24713  
        CL   RX3            4.437  00.225     .    00C5F6D6  
        CLH  RX1            2.687  00.372     .    00E2894E  
        CLH  RX2            2.812  00.355     .    00E03980  
        CLH  RX3            3.625  00.275     .    00D2470E  
        CLHI RI1            1.750  00.571     .    00F5850A  
        CLI  RI2            2.562  00.390     .    00E4E565  
        CLR   RR            0.937  01.067     .    0108BF51  
        CLB  RX1            2.687  00.372     .    00E28946  
        CLB  RX2            2.812  00.355     .    00E0397C  
        CLB  RX3            3.625  00.275     .    00D24711  
        C    RX1            3.500  00.285     .    00D44F34  
        C    RX2            3.625  00.275     .    00D2471D  
        C    RX3            4.437  00.225     .    00C5F6D1  
        CH   RX1            2.687  00.372     .    00E28940  
        CH   RX2            2.812  00.355     .    00E0397D  
        CH   RX3            3.625  00.275     .    00D24716  
        CHI  RI1            1.750  00.571     .    00F58516  
        CI   RI2            2.562  00.390     .    00E4E564  
        CR    RR            0.938  01.066     .    0108BF40  
        M    RX1 0*0       15.874  00.062     .    006C837B +
        M    RX1 0*FFFF    17.874  00.055     .    0064914E +
        M    RX1 0*-1      19.874  00.050     .    005DB4B5 +
        M    RX2 0*0       15.999  00.062     .    006BFB00 +
        M    RX2 0*FFFF    17.999  00.055     .    00641C01 +
        M    RX2 0*-1      19.999  00.050     .    005D4ED2 +
        M    RX3 0*0       16.811  00.059     .    0068A35E +
        M    RX3 0*FFFF    18.812  00.053     .    00613AEE +
        M    RX3 0*-1      20.811  00.048     .    005ACD42 +
        MR    RR 0*0       13.999  00.071     .    007531DC +
        MR    RR 0*FFFF    15.999  00.062     .    006BFAFA +
        MR    RR 0*-1      17.999  00.055     .    00641C01 +
        MH   RX1 0*0        9.312  00.107     .    00927E56 +
        MH   RX1 0*FFFF    11.312  00.088     .    00845FAA +
        MH   RX2 0*0        9.437  00.105     .    009185F8 +
        MH   RX2 0*FFFF    11.437  00.087     .    008394B5 +
        MH   RX3 0*0       10.249  00.097     .    008B847D +
        MH   RX3 0*FFFF    10.249  00.097     .    008B8481 +
        D    RX1  n/0      12.124  00.082     .    007F62BD +
        D    RX1  0/n      23.748  00.042     .    0052C3C3 +
        D    RX1 -1/n      27.623  00.036     .    004A1C81 +
        D    RX2  n/0      12.249  00.081     .    007EA6BE +
        D    RX2  0/n      23.873  00.041     .    0052743F +
        D    RX2 -1/n      27.749  00.036     .    0049DCBF +
        D    RX3  n/0      13.062  00.076     .    007A13F3 +
        D    RX3  0/n      24.686  00.040     .    00507DAB +
        D    RX3 -1/n      28.561  00.035     .    0048486D +

        DR    RR  n/0      10.249  00.097     .    008B847F +
        DR    RR  0/n      21.874  00.045     .    0057B87D +
        DR    RR -1/n      25.748  00.038     .    004E0F7E +
        DH   RX1  n/0      12.124  00.082     .    007F62B7 +
        DH   RX1  0/n      23.748  00.042     .    0052C3BE +
        DH   RX1 -1/n      25.040  00.039     .    004FAA02 +
        DH   RX2  n/0      12.249  00.081     .    007EA6C3 +
        DH   RX2  0/n      23.873  00.041     .    00527443 +
        DH   RX2 -1/n      25.165  00.039     .    004F605A +
        DH   RX3  n/0      13.062  00.076     .    007A13EB +
        DH   RX3  0/n      24.686  00.040     .    00507DAA +
        DH   RX3 -1/n      25.978  00.038     .    004D8E2C +
        DHR   RR  n/0      10.249  00.097     .    008B8483 +
        DHR   RR  0/n      21.874  00.045     .    0057B87E +
        DHR   RR -1/n      25.748  00.038     .    004E0F79 +
        SRA  RI1  0 POS     2.250  00.444     .    00EB0423 +
        SRA  RI1  1 POS     2.625  00.380     .    00E3B5C5  
        SRA  RI1  2 POS     2.750  00.363     .    00E15FE7 +
        SRA  RI1  3 POS     2.875  00.347     .    00DF162C +
        SRA  RI1 32 POS     6.500  00.153     .    00AC5860 +
        LHR   RR            1.312  00.762     .    00FF8301  
        LPSW RX1            5.937  00.168     .    00B2A688  
        LPSW RX2            6.062  00.164     .    00B135BA  
        LPSW RX3            6.874  00.145     .    00A86223  
        UPSW RX1            4.687  00.213     .    00C275D7  
        UPSW RX2            4.812  00.207     .    00C0C122  
        UPSW RX3            5.625  00.177     .    00B65B60  
        LPSWR RR            1.937  00.516     .    00F17907  
        EPSR  RR            1.562  00.640     .    00F9B473  
        SVC  RX1            5.312  00.188     .    008EB03C  
        SVC  RX2            5.437  00.183     .    008DC48C  
        SVC  RX3            6.249  00.160     .    00880FDC  
        CIO   RR            3.562  00.280     .    00D349E4  
        SSR   RR            3.687  00.271     .    00D146C6  
        SSR   RR T/O        7.937  00.125     .    009E1623 +
        OC   RX1            5.437  00.183     .    00B8A7D3  
        OC   RX1 T/O        9.562  00.104     .    009090DA +
        OC   RX2            5.562  00.179     .    00B71DE9  
        OC   RX2 T/O        9.687  00.103     .    008F9F00 +
        OC   RX3            6.375  00.156     .    00ADB52E  
        OC   RX3 T/O       10.499  00.095     .    0089C4A0 +
        OCR   RR            3.187  00.313     .    00D99080  
        OCR   RR T/O        7.312  00.136     .    00A3FC35 +
        RDR   RR            3.062  00.326     .    00DBBD84  
        RDR   RR T/O        7.187  00.139     .    00A537DD +
        WD   RX1            5.312  00.188     .    00BA386F  
        WD   RX1 T/O        9.437  00.105     .    009185F1 +
        WD   RX2            5.437  00.183     .    00B8A7D7  
        WD   RX2 T/O        9.562  00.104     .    009090E2 +
        WD   RX3            6.250  00.160     .    00AF1786  
        WD   RX3 T/O       10.374  00.096     .    008AA326 +
        WDR   RR            3.062  00.326     .    00DBBD77  
        WDR   RR T/O        7.187  00.139     .    00A537D6 +







        CKSUM RR 16  CHR   12.436  00.080     .    00527442 +
        CKSUM RR 32  CHR   25.560  00.039     .    003B2645 +
        CKSUM RR 64  CHR   51.183  00.019     .    00261DC2 +
        CKSUM RR 96  CHR   76.811  00.013     .    001C1E23 +
        CKSUM RR 124 CHR  147.732  00.006     .    00104A03 +
         
        TOTAL AVERAGE MIPS 00.335
        TOTAL INST TIME  4199.506
        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1        160.741     3.214    16.954      .339
        RX2        149.991     3.408    14.085      .320
        RX3        185.735     4.221    11.013      .250
        RI1         18.375     1.837     5.519      .551
        RI2         23.058     2.562     3.510      .390
        RR          41.246     1.527    22.249      .824
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        
        
        
        







        
                                   TYMNET ENGINE
        
                    MEMORY SYSTEM TIMING - MACII WITH AMPEX CORE
        
        
        ENGINE INSTRUCTION SET TIMING - VERSION 1.01
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         8.874    .        .    01358230  
        MACHINE RATING      5.874    .      17.02  00BA3ACB  
        L    RX1            3.250  00.307   61.54  00E28C2E  
        L    RX2            3.375  00.296   59.26  00E03C62  
        L    RX3            4.125  00.242   48.48  00D34C95  
        LH   RX1            2.500  00.400   40.00  00F17C19  
        LH   RX2            2.625  00.380   38.10  00EEDC26  
        LH   RX3            3.375  00.296   29.63  00E03C64  
        LHI  RI1            1.625  00.615     .    01059BC9  
        LI   RI2            2.375  00.421     .    00F42AF2  
        LR    RR            0.875  01.142     .    0119BB63  
        LIS   SF            0.875  01.142     .    0119BB68  
        LCS   SF            0.875  01.142     .    0119BB6C  
        LA   RX1            1.875  00.533     .    00FF8645  
        LA   RX2            2.000  00.500     .    00FC965F  
        LA   RX3            2.750  00.363     .    00EC4A96  
        LHL  RX1            2.500  00.400   40.00  00F17C0D  
        LHL  RX2            2.625  00.380   38.10  00EEDC22  
        LHL  RX3            3.375  00.296   29.63  00E03C61  
        LM   RX1 REG 0     25.747  00.038  124.16  004F5521 +
        LM   RX2 REG 0     25.872  00.038  123.84  004F0C13 +
        LM   RX3 REG 0     26.622  00.037  120.32  004D608C +
        LM   RX1 REG 1     24.247  00.041  123.60  0052ECCA +
        LM   RX2 REG 1     24.372  00.041  123.00  00529CFC +
        LM   RX3 REG 1     25.122  00.039  119.40  0050CA77 +
        LM   RX1 REG 8     13.748  00.072  116.32  007968D3 +
        LM   RX2 REG 8     13.873  00.072  115.36  0078BE0C +
        LM   RX3 REG 8     14.623  00.068  109.44  0074E38F +
        LM   RX1 REG 15     3.250  00.307   61.54  00E28C32  
        LM   RX2 REG 15     3.375  00.296   59.26  00E03C65  
        LM   RX3 REG 15     4.125  00.242   48.48  00D34C96  
        LB   RX1            2.500  00.400   20.00  00F17C15  
        LB   RX2            2.625  00.380   19.05  00EEDC1F  
        LB   RX3            3.375  00.296   14.81  00E03C5E  
        LBR   RR            0.875  01.142     .    0119BB76  
        EXHR  RR            0.875  01.142     .    0119BB69  
        EXBR  RR            0.875  01.142     .    0119BB63  
        ST   RX1            3.375  00.296   59.26  00E03C52  
        ST   RX2            3.500  00.285   57.14  00DDF887  
        ST   RX3            4.250  00.235   47.06  00D1496B  
        STH  RX1            2.625  00.380   38.10  00EEDC27  
        STH  RX2            2.750  00.363   36.36  00EC4AA1  
        STH  RX3            3.500  00.285   28.57  00DDF884  







        STM  RX1 REG 0     25.872  00.038  123.84  004F0C13 +
        STM  RX2 REG 0     25.997  00.038  123.20  004EC38E +
        STM  RX3 REG 0     26.747  00.037  119.68  004D1B10 +
        STM  RX1 REG 1     24.372  00.041  123.00  00529CFF +
        STM  RX2 REG 1     24.497  00.040  122.40  00524DC7 +
        STM  RX3 REG 1     25.248  00.039  118.80  00507EB4 +
        STM  RX1 REG 8     13.873  00.072  115.36  0078BE10 +
        STM  RX2 REG 8     13.998  00.071  114.24  0078152A +
        STM  RX3 REG 8     14.748  00.067  108.48  00744541 +
        STM  RX1 REG 15     3.375  00.296   59.26  00E03C67  
        STM  RX2 REG 15     3.500  00.285   57.14  00DDF889  
        STM  RX3 REG 15     4.250  00.235   47.06  00D1496D  
        STB  RX1            3.375  00.296   14.81  00E03C66  
        STB  RX2            3.500  00.285   14.28  00DDF891  
        STB  RX3            4.250  00.235   11.76  00D14970  
        STBR  RR            0.875  01.142     .    0119BB76  
        COPY  RR 2   BYT    3.500  00.285   57.14  00776E0F +
        COPY  RR 16  BYT   13.999  00.071  114.24  0051FF2A +
        COPY  RR 32  BYT   25.998  00.038  123.20  003C5F09 +
        COPY  RR 64  BYT   51.495  00.019  124.16  0026B049 +
        COPY  RR 128 BYT  102.483  00.009  125.44  001683F7 +
        COPY  RR 256 BYT  204.466  00.004  125.44  000C434D +
        COPY  RR 512 BYT  408.401  00.002  122.88  00066B00 +
        COPY  RR 1024 BY  816.623  00.001  122.88  00034927 +
        N    RX1            3.250  00.307     .    00E28C3B  
        N    RX2            3.375  00.296     .    00E03C5F  
        N    RX3            4.125  00.242     .    00D34C90  
        NH   RX1            2.500  00.400     .    00F17C15  
        NH   RX2            2.625  00.380     .    00EEDC24  
        NH   RX3            3.375  00.296     .    00E03C62  
        NHI  RI1            1.625  00.615     .    01059BC7  
        NI   RI2            2.375  00.421     .    00F42AF9  
        NR    RR            0.875  01.142     .    0119BB6D  
        O    RX1            3.250  00.307     .    00E28C2A  
        O    RX2            3.375  00.296     .    00E03C62  
        O    RX3            4.125  00.242     .    00D34C9B  
        OH   RX1            2.500  00.400     .    00F17C1A  
        OH   RX2            2.625  00.380     .    00EEDC21  
        OH   RX3            3.375  00.296     .    00E03C5F  
        OHI  RI1            1.625  00.615     .    01059BC9  
        OI   RI2            2.375  00.421     .    00F42B02  
        OR    RR            0.875  01.142     .    0119BB7A  
        X    RX1            3.250  00.307     .    00E28C2B  
        X    RX2            3.375  00.296     .    00E03C5D  
        X    RX3            4.125  00.242     .    00D34C96  
        XH   RX1            2.500  00.400     .    00F17C20  
        XH   RX2            2.625  00.380     .    00EEDC2C  
        XH   RX3            3.375  00.296     .    00E03C60  
        XHI  RI1            1.625  00.615     .    01059BC4  
        XI   RI2            2.375  00.421     .    00F42AFC  
        XR    RR            0.875  01.142     .    0119BB75  







        ARAND RR 16/nm      3.874  00.258     .    00758396 +
        ARAND RR 16/B 0     4.000  00.250     .    0074E393 +
        ARAND RR 16/B 1     4.124  00.242     .    0074453B +
        ARAND RR 16/B 2     4.250  00.235     .    0073A894 +
        ARAND RR 16/B 7     4.875  00.205     .    0070B163 +
        ARAND RR 16/B 13    5.625  00.177     .    006D5437 +
        ARAND RR 16/B 14    5.750  00.173     .    006CC9AA +
        ARAND RR 16/B 15    5.875  00.170     .    006C4076 +
        ARAND RR 32/nm      7.124  00.140     .    00672B67 +
        ARAND RR 32/B 0     7.250  00.137     .    0066AFFD +
        ARAND RR 32/B 1     7.375  00.135     .    006635BA +
        ARAND RR 32/B 2     7.499  00.133     .    0065BC9A +
        ARAND RR 32/B 15    9.124  00.109     .    005FF617 +
        ARAND RR 32/B 16    4.000  00.250     .    0074E393 +
        ARAND RR 32/B 17    4.124  00.242     .    00744540 +
        ARAND RR 32/B 30    5.750  00.173     .    006CC9AB +
        ARAND RR 32/B 31    5.875  00.170     .    006C407B +
        THI  RI1            1.625  00.615     .    01059BDB  
        TI   RI2            2.375  00.421     .    00F42B07  
        SLL  RX1  0 POS     2.125  00.470     .    00F9B79F +
        SLL  RX1  1 POS     2.500  00.400     .    00F17C21  
        SLL  RX1  2 POS     2.625  00.380     .    00EEDC2C +
        SLL  RX1  3 POS     2.750  00.363     .    00EC4AAF +
        SLL  RX1 32 POS     6.374  00.156     .    00B41FC0 +
        SLLS  SF  0 POS     1.500  00.666     .    0108C2B1 +
        SLLS  SF  1 POS     1.750  00.571     .    010287E7  
        SLLS  SF  2 POS     1.875  00.533     .    00FF8654 +
        SLLS  SF  3 POS     2.000  00.500     .    00FC9675 +
        SLLS  SF 15 POS     3.500  00.285     .    00DDF898 +
        SRL  RX1  0 POS     2.125  00.470     .    00F9B7A6 +
        SRL  RX1  1 POS     2.500  00.400     .    00F17C1E  
        SRL  RX1  2 POS     2.625  00.380     .    00EEDC26 +
        SRL  RX1  3 POS     2.750  00.363     .    00EC4AAB +
        SRL  RX1 32 POS     6.374  00.156     .    00B41FBF +
        SRLS  SF  0 POS     1.500  00.666     .    0108C2B7 +
        SRLS  SF  1 POS     1.750  00.571     .    010287E6  
        SRLS  SF  2 POS     1.875  00.533     .    00FF864D +
        SRLS  SF  3 POS     2.000  00.500     .    00FC966E +
        SLHL RX1  0 POS     2.125  00.470     .    00F9B7A2 +
        SLHL RX1  1 POS     2.750  00.363     .    00EC4AAC  
        SLHL RX1  2 POS     2.875  00.347     .    00E9C720 +
        SLHL RX1  3 POS     3.000  00.333     .    00E75127 +
        SLHLS SF  0 POS     1.500  00.666     .    0108C2AB +
        SLHLS SF  1 POS     2.000  00.500     .    00FC966B  
        SLHLS SF  2 POS     2.125  00.470     .    00F9B7A0 +
        SLHLS SF  3 POS     2.250  00.444     .    00F6E959 +
        SRHL RX1  0 POS     2.125  00.470     .    00F9B79C +
        SRHL RX1  1 POS     2.750  00.363     .    00EC4AA0  
        SRHL RX1  2 POS     2.875  00.347     .    00E9C71E +
        SRHL RX1  3 POS     3.000  00.333     .    00E7512C +
        SRHLS SF  0 POS     1.500  00.666     .    0108C2B4 +
        SRHLS SF  1 POS     2.000  00.500     .    00FC966F  
        SRHLS SF  2 POS     2.125  00.470     .    00F9B799 +
        SRHLS SF  3 POS     2.250  00.444     .    00F6E952 +







        RLL  RX1  0 POS     2.125  00.470     .    00F9B79F +
        RLL  RX1  1 POS     2.500  00.400     .    00F17C21  
        RLL  RX1  2 POS     2.625  00.380     .    00EEDC2B +
        RLL  RX1  3 POS     2.750  00.363     .    00EC4AA5 +
        RLL  RX1 32 POS     6.374  00.156     .    00B41FB7 +
        RRL  RX1  0 POS     2.125  00.470     .    00F9B79E +
        RRL  RX1  1 POS     2.500  00.400     .    00F17C1F  
        RRL  RX1  2 POS     2.625  00.380     .    00EEDC29 +
        RRL  RX1  3 POS     2.750  00.363     .    00EC4AA6 +
        RRL  RX1 32 POS     6.374  00.156     .    00B41FB7 +
        TS   RX1            3.500  00.285     .    00DDF88C  
        TS   RX2            3.625  00.275     .    00DBC04C  
        TS   RX3            4.375  00.228     .    00CF4FFD  
        TBT  RX1            2.875  00.347     .    00E9C722  
        TBT  RX2            3.000  00.333     .    00E75125  
        TBT  RX3            3.750  00.266     .    00D9934C  
        SBT  RX1            3.625  00.275     .    00DBC04D  
        SBT  RX2            3.750  00.266     .    00D99351  
        SBT  RX3            4.499  00.222     .    00CD6001  
        RBT  RX1            3.625  00.275     .    00DBC052  
        RBT  RX2            3.750  00.266     .    00D99351  
        RBT  RX3            4.499  00.222     .    00CD6000  
        CBT  RX1            3.750  00.266     .    00D99356  
        CBT  RX2            3.875  00.258     .    00D77145  
        CBT  RX3            4.625  00.216     .    00CB7932  
        JF   RX1 M=1,C=2    1.750  00.571     .    010287E3  
        JF   RX1 M=2,C=2    1.875  00.533     .    00FF864F  
        JF   RX2 M=1,C=2    1.875  00.533     .    00FF8653  
        JF   RX2 M=2,C=2    2.000  00.500     .    00FC9672  
        JF   RX3 M=1,C=2    2.625  00.380     .    00EEDC2F  
        JF   RX3 M=2,C=2    2.750  00.363     .    00EC4AA6  
        JFR   RR M=1,C=2    1.250  00.800     .    010F4C39  
        JFR   RR M=2,C=2    0.875  01.142     .    0119BB78  
        JFBS  SF M=1,C=2    1.125  00.888     .    0112B064  
        JFBS  SF M=2,C=2    0.875  01.142     .    0119BB81  
        JFFS  SF M=1,C=2    1.125  00.888     .    0112B066  
        JFFS  SF M=2,C=2    0.875  01.142     .    0119BB78  
        JT   RX1 M=2,C=2    1.750  00.571     .    010287E5  
        JT   RX1 M=1,C=2    1.875  00.533     .    00FF8654  
        JT   RX2 M=2,C=2    1.875  00.533     .    00FF8654  
        JT   RX2 M=1,C=2    2.000  00.500     .    00FC966F  
        JT   RX3 M=2,C=2    2.625  00.380     .    00EEDC24  
        JT   RX3 M=1,C=2    2.750  00.363     .    00EC4AA1  
        JTR   RR M=2,C=2    1.250  00.800     .    010F4C37  
        JTR   RR M=1,C=2    0.875  01.142     .    0119BB78  
        JTBS  SF M=2,C=2    1.125  00.888     .    0112B065  
        JTBS  SF M=1,C=2    0.875  01.142     .    0119BB7A  
        JTFS  SF M=2,C=2    1.125  00.888     .    0112B05F  
        JTFS  SF M=1,C=2    0.875  01.142     .    0119BB77  
        NOP  RX1            1.875  00.533     .    00FF8653  
        NOP  RX2            2.000  00.500     .    00FC9672  
        NOP  RX3            2.750  00.363     .    00EC4AAB  
        NOPR  RR            0.875  01.142     .    0119BB74  







        J    RX1            1.750  00.571     .    010287E0  
        J    RX2            1.875  00.533     .    00FF8650  
        J    RX3            2.625  00.380     .    00EEDC2D  
        JR    RR            1.250  00.800     .    010F4C41  
        JBS   SF            1.125  00.888     .    0112B062  
        JFS   SF            1.125  00.888     .    0112B060  
        JAL  RX1            1.750  00.571     .    010287E5  
        JAL  RX2            1.875  00.533     .    00FF8652  
        JAL  RX3            2.625  00.380     .    00EEDC2E  
        JALR  RR            1.750  00.571     .    010287E6  
        JFFO  SF ALL  =0    1.500  00.666     .    0108C2AB +
        JFFO  SF BIT 0=1    1.625  00.615     .    01059BC9 +
        JFFO  SF BIT 1=1    1.625  00.615     .    01059BCC +
        JFFO  SF BIT 2=1    1.750  00.571     .    010287E8 +
        JFFO  SF BIT30=1    5.250  00.190     .    00C2785C +
        JFFO  SF BIT31=1    5.374  00.186     .    00C0C3A3 +
        JFFOH SF ALL  =0    1.500  00.666     .    0108C2AA +
        JFFOH SF BIT 0=1    1.625  00.615     .    01059BCA +
        JFFOH SF BIT 1=1    1.625  00.615     .    01059BCD +
        JFFOH SF BIT 2=1    1.750  00.571     .    010287E7 +
        JFFOH SF BIT14=1    3.250  00.307     .    00E28C34 +
        JFFOH SF BIT15=1    3.375  00.296     .    00E03C61 +
        A    RX1            3.250  00.307     .    00E28C2C  
        A    RX2            3.375  00.296     .    00E03C62  
        A    RX3            4.125  00.242     .    00D34C9A  
        AH   RX1            2.500  00.400     .    00F17C20  
        AH   RX2            2.625  00.380     .    00EEDC26  
        AH   RX3            3.375  00.296     .    00E03C5E  
        AHI  RI1            1.625  00.615     .    01059BC6  
        AI   RI2            2.375  00.421     .    00F42B00  
        AR    RR            0.875  01.142     .    0119BB79  
        AIS   SF            0.875  01.142     .    0119BB78  
        AM   RX1            5.250  00.190     .    00C27854  
        AM   RX2            5.374  00.186     .    00C0C39C  
        AM   RX3            6.124  00.163     .    00B7203C  
        AHM  RX1            3.500  00.285     .    00DDF88A  
        AHM  RX2            3.625  00.275     .    00DBC04D  
        AHM  RX3            4.375  00.228     .    00CF4FF9  
        S    RX1            3.250  00.307     .    00E28C28  
        S    RX2            3.375  00.296     .    00E03C5C  
        S    RX3            4.125  00.242     .    00D34C94  
        SH   RX1            2.500  00.400     .    00F17C19  
        SH   RX2            2.625  00.380     .    00EEDC24  
        SH   RX3            3.375  00.296     .    00E03C5A  
        SHI  RI1            1.625  00.615     .    01059BBD  
        SI   RI2            2.375  00.421     .    00F42AF7  
        SR    RR            0.875  01.142     .    0119BB6F  
        SIS   SF            0.875  01.142     .    0119BB71  







        CL   RX1            3.250  00.307     .    00E28C2D  
        CL   RX2            3.375  00.296     .    00E03C5A  
        CL   RX3            4.125  00.242     .    00D34C90  
        CLH  RX1            2.500  00.400     .    00F17C17  
        CLH  RX2            2.625  00.380     .    00EEDC24  
        CLH  RX3            3.375  00.296     .    00E03C61  
        CLHI RI1            1.625  00.615     .    01059BC1  
        CLI  RI2            2.375  00.421     .    00F42AF6  
        CLR   RR            0.875  01.142     .    0119BB6F  
        CLB  RX1            2.500  00.400     .    00F17C19  
        CLB  RX2            2.625  00.380     .    00EEDC26  
        CLB  RX3            3.375  00.296     .    00E03C5F  
        C    RX1            3.250  00.307     .    00E28C27  
        C    RX2            3.375  00.296     .    00E03C5D  
        C    RX3            4.125  00.242     .    00D34C96  
        CH   RX1            2.500  00.400     .    00F17C1B  
        CH   RX2            2.625  00.380     .    00EEDC26  
        CH   RX3            3.375  00.296     .    00E03C5D  
        CHI  RI1            1.625  00.615     .    01059BC2  
        CI   RI2            2.375  00.421     .    00F42AFD  
        CR    RR            0.875  01.142     .    0119BB76  
        M    RX1 0*0       15.623  00.064     .    00701E32 +
        M    RX1 0*FFFF    17.623  00.056     .    0067A7FD +
        M    RX1 0*-1      19.623  00.050     .    006061CF +
        M    RX2 0*0       15.748  00.063     .    006F8C7F +
        M    RX2 0*FFFF    17.748  00.056     .    00672B69 +
        M    RX2 0*-1      19.748  00.050     .    005FF614 +
        M    RX3 0*0       16.498  00.060     .    006C4077 +
        M    RX3 0*FFFF    18.498  00.054     .    006457CE +
        M    RX3 0*-1      20.498  00.048     .    005D82D9 +
        MR    RR 0*0       13.873  00.072     .    0078BE0D +
        MR    RR 0*FFFF    15.873  00.063     .    006EFC47 +
        MR    RR 0*-1      17.873  00.055     .    0066AFFF +
        MH   RX1 0*0        9.124  00.109     .    00989ADE +
        MH   RX1 0*FFFF    11.124  00.089     .    0089582D +
        MH   RX2 0*0        9.249  00.108     .    00978D72 +
        MH   RX2 0*FFFF    11.249  00.088     .    00887DCE +
        MH   RX3 0*0        9.999  00.100     .    009187D6 +
        MH   RX3 0*FFFF     9.999  00.100     .    009187D3 +
        D    RX1  n/0      11.874  00.084     .    00846153 +
        D    RX1  0/n      23.498  00.042     .    0054D893 +
        D    RX1 -1/n      27.372  00.036     .    004BC6B9 +
        D    RX2  n/0      11.998  00.083     .    00839669 +
        D    RX2  0/n      23.622  00.042     .    0054850B +
        D    RX2 -1/n      27.498  00.036     .    004B840E +
        D    RX3  n/0      12.749  00.078     .    007F0615 +
        D    RX3  0/n      24.372  00.041     .    00529CFB +
        D    RX3 -1/n      28.247  00.035     .    0049FD84 +







        DR    RR  n/0      10.124  00.098     .    009092BA +
        DR    RR  0/n      21.747  00.045     .    0059B1C0 +
        DR    RR -1/n      25.622  00.039     .    004F9EB5 +
        DH   RX1  n/0      11.874  00.084     .    00846153 +
        DH   RX1  0/n      23.498  00.042     .    0054D894 +
        DH   RX1 -1/n      24.789  00.040     .    0051973E +
        DH   RX2  n/0      11.998  00.083     .    00839668 +
        DH   RX2  0/n      23.622  00.042     .    00548507 +
        DH   RX2 -1/n      24.914  00.040     .    005149F8 +
        DH   RX3  n/0      12.749  00.078     .    007F0615 +
        DH   RX3  0/n      24.372  00.041     .    00529CFB +
        DH   RX3 -1/n      25.664  00.038     .    004F8621 +
        DHR   RR  n/0      10.124  00.098     .    009092B3 +
        DHR   RR  0/n      21.747  00.045     .    0059B1BE +
        DHR   RR -1/n      25.622  00.039     .    004F9EB6 +
        SRA  RI1  0 POS     2.125  00.470     .    00F9B798 +
        SRA  RI1  1 POS     2.500  00.400     .    00F17C1A  
        SRA  RI1  2 POS     2.625  00.380     .    00EEDC1E +
        SRA  RI1  3 POS     2.750  00.363     .    00EC4A9A +
        SRA  RI1 32 POS     6.374  00.156     .    00B41FB1 +
        LHR   RR            1.250  00.800     .    010F4C31  
        LPSW RX1            5.624  00.177     .    00BD70C9  
        LPSW RX2            5.749  00.173     .    00BBD249  
        LPSW RX3            6.499  00.153     .    00B2A8CA  
        UPSW RX1            4.375  00.228     .    00CF4FEF  
        UPSW RX2            4.499  00.222     .    00CD5FF1  
        UPSW RX3            5.250  00.190     .    00C2784F  
        LPSWR RR            1.875  00.533     .    00FF8647  
        EPSR  RR            1.500  00.666     .    0108C2A0  
        SVC  RX1            4.999  00.200     .    00978D6A  
        SVC  RX2            5.124  00.195     .    009683AE  
        SVC  RX3            5.875  00.170     .    009092B3  
        CIO   RR            3.500  00.285     .    00DDF886  
        SSR   RR            3.625  00.275     .    00DBC046  
        SSR   RR T/O        7.874  00.127     .    00A3FE48 +
        OC   RX1            5.250  00.190     .    00C2784F  
        OC   RX1 T/O        9.374  00.106     .    009683B1 +
        OC   RX2            5.374  00.186     .    00C0C3A0  
        OC   RX2 T/O        9.499  00.105     .    00957D96 +
        OC   RX3            6.124  00.163     .    00B7203D  
        OC   RX3 T/O       10.249  00.097     .    008FA0CD +
        OCR   RR            3.125  00.320     .    00E4E84A  
        OCR   RR T/O        7.249  00.137     .    00AA5984 +
        RDR   RR            3.000  00.333     .    00E75128  
        RDR   RR T/O        7.124  00.140     .    00ABAE39 +
        WD   RX1            5.124  00.195     .    00C434D0  
        WD   RX1 T/O        9.249  00.108     .    00978D6C +
        WD   RX2            5.250  00.190     .    00C27852  
        WD   RX2 T/O        9.374  00.106     .    009683B3 +
        WD   RX3            5.999  00.166     .    00B8AA34  
        WD   RX3 T/O       10.124  00.098     .    009092B4 +
        WDR   RR            3.000  00.333     .    00E75120  
        WDR   RR T/O        7.124  00.140     .    00ABAE34 +







        CKSUM RR 16  CHR   11.624  00.086     .    005840E2 +
        CKSUM RR 32  CHR   23.873  00.041     .    003F5431 +
        CKSUM RR 64  CHR   47.870  00.020     .    0028C529 +
        CKSUM RR 96  CHR   71.868  00.013     .    001E0FCC +
        CKSUM RR 124 CHR  138.231  00.007     .    001169B5 +
         
        TOTAL AVERAGE MIPS 00.354
        TOTAL INST TIME  3960.264
        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1        150.997     3.019    18.086      .361
        RX2        140.995     3.204    15.019      .341
        RX3        173.994     3.954    11.783      .267
        RI1         17.125     1.712     5.935      .593
        RI2         21.375     2.375     3.789      .421
        RR          39.500     1.462    23.646      .875
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        
        







        
                                TYMNET MICRO-ENGINE
                
                        MEMORY SYSTEM TIMING - MACII DYNAMIC
                
                
        ENGINE INSTRUCTION SET TIMING - VERSION 1.02
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         8.050    .        .    01552E91  
        MACHINE RATING      5.265    .      18.99  00CE47E5  
        L    RX1            2.992  00.334   66.84  00F8BDB3  
        L    RX2            3.243  00.308   61.68  00F33333  
        L    RX3            3.791  00.263   52.76  00E7F4EB  
        LH   RX1            2.335  00.428   42.83  01087A48  
        LH   RX2            2.406  00.415   41.56  0106AAB8  
        LH   RX3            3.250  00.307   30.77  00F30EFB  
        LHI  RI1            1.388  00.720     .    0123046C  
        LI   RI2            2.093  00.477     .    010EC67A  
        LR    RR            0.768  01.302     .    01377A7E  
        LIS   SF            0.770  01.298     .    01376477  
        LCS   SF            0.775  01.290     .    01373C2A  
        LA   RX1            1.698  00.588     .    0119C116  
        LA   RX2            1.875  00.533     .    0114B800  
        LA   RX3            2.567  00.389     .    0102B297  
        LHL  RX1            2.337  00.427   42.79  01086D29  
        LHL  RX2            2.386  00.419   41.91  01072C84  
        LHL  RX3            3.249  00.307   30.78  00F31252  
        LM   RX1 REG 0     24.110  00.041  132.80  00556740 +
        LM   RX2 REG 0     24.142  00.041  132.48  0055517F +
        LM   RX3 REG 0     24.928  00.040  128.32  005348D9 +
        LM   RX1 REG 1     22.690  00.044  132.30  00595974 +
        LM   RX2 REG 1     22.792  00.043  131.70  00590D57 +
        LM   RX3 REG 1     23.443  00.042  128.10  00573613 +
        LM   RX1 REG 8     12.856  00.077  124.48  00836055 +
        LM   RX2 REG 8     13.121  00.076  121.92  0081BAAD +
        LM   RX3 REG 8     13.642  00.073  117.28  007E9D9A +
        LM   RX1 REG 15     2.990  00.334   66.88  00F8C62B  
        LM   RX2 REG 15     3.248  00.307   61.58  00F319B3  
        LM   RX3 REG 15     3.773  00.265   53.00  00E84D04  
        LB   RX1            2.334  00.428   21.42  0108818B  
        LB   RX2            2.415  00.414   20.70  010671B9  
        LB   RX3            3.244  00.308   15.41  00F32D83  
        LBR   RR            0.775  01.290     .    013737CB  
        EXHR  RR            0.773  01.293     .    01374C7A  
        EXBR  RR            0.770  01.298     .    01376949  
        ST   RX1            2.754  00.363   72.62  00FE3592  
        ST   RX2            2.866  00.348   69.78  00FB9938  
        ST   RX3            3.715  00.269   53.84  00E974D2  
        STH  RX1            2.149  00.465   46.53  010D49C9  
        STH  RX2            2.369  00.422   42.21  01079D3B  
        STH  RX3            3.054  00.327   32.74  00F75727  







        STM  RX1 REG 0     18.156  00.055  176.32  0068CE8A +
        STM  RX2 REG 0     18.241  00.054  175.36  00687717 +
        STM  RX3 REG 0     18.916  00.052  169.28  0065DA48 +
        STM  RX1 REG 1     17.166  00.058  174.90  006CEBD5 +
        STM  RX2 REG 1     17.207  00.058  174.30  006CBE2E +
        STM  RX3 REG 1     17.989  00.055  166.80  00697A4A +
        STM  RX1 REG 8     10.009  00.099  159.84  00981779 +
        STM  RX2 REG 8     10.156  00.098  157.60  0096DCA3 +
        STM  RX3 REG 8     10.930  00.091  146.40  0090B5CC +
        STM  RX1 REG 15     2.713  00.368   73.72  00FF30BB  
        STM  RX2 REG 15     2.870  00.348   69.68  00FB81E9  
        STM  RX3 REG 15     3.712  00.269   53.88  00E97FDC  
        STB  RX1            2.958  00.338   16.90  00F98297  
        STB  RX2            3.035  00.329   16.47  00F7C38F  
        STB  RX3            3.750  00.266   13.33  00E8BFE5  
        STBR  RR            0.770  01.298     .    013768B8  
        COPY  RR 2   BYT    3.226  00.309   62.00  0081C82B +
        COPY  RR 16  BYT   12.005  00.083  133.28  005BBAC3 +
        COPY  RR 32  BYT   22.282  00.044  143.68  00444AA0 +
        COPY  RR 64  BYT   44.036  00.022  145.28  002C51A0 +
        COPY  RR 128 BYT   87.872  00.011  145.92  0019F50A +
        COPY  RR 256 BYT  175.039  00.005  145.92  000E3B7B +
        COPY  RR 512 BYT  349.845  00.002  148.48  0007777E +
        COPY  RR 1024 BY  699.938  00.001  143.36  0003D3C9 +
        N    RX1            2.992  00.334     .    00F8BD40  
        N    RX2            3.250  00.307     .    00F30ECF  
        N    RX3            3.793  00.263     .    00E7E948  
        NH   RX1            2.335  00.428     .    01087ACA  
        NH   RX2            2.412  00.414     .    010688FF  
        NH   RX3            3.245  00.308     .    00F32AF8  
        NHI  RI1            1.429  00.699     .    0121BD01  
        NI   RI2            2.096  00.477     .    010EB154  
        NR    RR            0.770  01.298     .    013765EE  
        O    RX1            2.986  00.334     .    00F8DE8F  
        O    RX2            3.241  00.308     .    00F33F3A  
        O    RX3            3.775  00.264     .    00E84167  
        OH   RX1            2.338  00.427     .    010864CB  
        OH   RX2            2.404  00.415     .    0106BB3B  
        OH   RX3            3.240  00.308     .    00F345A0  
        OHI  RI1            1.388  00.720     .    0123046E  
        OI   RI2            2.095  00.477     .    010EBD6F  
        OR    RR            0.774  01.291     .    0137460F  
        X    RX1            2.992  00.334     .    00F8BD39  
        X    RX2            3.243  00.308     .    00F33795  
        X    RX3            3.787  00.264     .    00E80709  
        XH   RX1            2.335  00.428     .    010877CC  
        XH   RX2            2.415  00.414     .    01067639  
        XH   RX3            3.248  00.307     .    00F31B09  
        XHI  RI1            1.429  00.699     .    0121BD03  
        XI   RI2            2.093  00.477     .    010EC6E3  
        XR    RR            0.769  01.300     .    01377111  







        ARAND RR 16/nm      3.624  00.275     .    007F62A3 +
        ARAND RR 16/B 0     3.883  00.257     .    007DDFD5 +
        ARAND RR 16/B 1     3.980  00.251     .    007D519C +
        ARAND RR 16/B 2     4.114  00.243     .    007C8E20 +
        ARAND RR 16/B 7     4.714  00.212     .    0079418D +
        ARAND RR 16/B 13    5.656  00.176     .    00746A7F +
        ARAND RR 16/B 14    5.606  00.178     .    0074AA1F +
        ARAND RR 16/B 15    5.647  00.177     .    0074756D +
        ARAND RR 32/nm      6.906  00.144     .    006E8F34 +
        ARAND RR 32/B 0     6.891  00.145     .    006E9F77 +
        ARAND RR 32/B 1     6.970  00.143     .    006E45C6 +
        ARAND RR 32/B 2     7.237  00.138     .    006D1A07 +
        ARAND RR 32/B 15    8.824  00.113     .    0066A227 +
        ARAND RR 32/B 16    3.886  00.257     .    007DDBCD +
        ARAND RR 32/B 17    3.974  00.251     .    007D59FE +
        ARAND RR 32/B 30    5.599  00.178     .    0074B31B +
        ARAND RR 32/B 31    5.626  00.177     .    00748FB4 +
        THI  RI1            1.388  00.720     .    0123047A  
        TI   RI2            2.096  00.477     .    010EB0F4  
        SLL  RX1  0 POS     1.974  00.506     .    0112019B +
        SLL  RX1  1 POS     2.354  00.424     .    0107FA84  
        SLL  RX1  2 POS     2.537  00.394     .    01036CCA +
        SLL  RX1  3 POS     2.564  00.390     .    0102C43A +
        SLL  RX1 32 POS     6.138  00.162     .    00C19599 +
        SLLS  SF  0 POS     1.471  00.679     .    01207867 +
        SLLS  SF  1 POS     1.664  00.600     .    011ABB45  
        SLLS  SF  2 POS     1.781  00.561     .    01175D47 +
        SLLS  SF  3 POS     1.935  00.516     .    01131213 +
        SLLS  SF 15 POS     3.350  00.298     .    00F0EB3D +
        SRL  RX1  0 POS     1.972  00.507     .    01120FC9 +
        SRL  RX1  1 POS     2.355  00.424     .    0107F47E  
        SRL  RX1  2 POS     2.542  00.393     .    0103503A +
        SRL  RX1  3 POS     2.606  00.383     .    0101BC6E +
        SRL  RX1 32 POS     6.138  00.162     .    00C19591 +
        SRLS  SF  0 POS     1.357  00.736     .    0123F9F5 +
        SRLS  SF  1 POS     1.664  00.600     .    011ABCB4  
        SRLS  SF  2 POS     1.787  00.559     .    0117362E +
        SRLS  SF  3 POS     1.929  00.518     .    011338A1 +
        SLHL RX1  0 POS     1.974  00.506     .    0111FCA9 +
        SLHL RX1  1 POS     2.563  00.390     .    0102CA8B  
        SLHL RX1  2 POS     2.638  00.379     .    0100FAFD +
        SLHL RX1  3 POS     2.855  00.350     .    00FBDAAC +
        SLHLS SF  0 POS     1.366  00.732     .    0123AEEC +
        SLHLS SF  1 POS     1.931  00.517     .    01132EB2  
        SLHLS SF  2 POS     2.045  00.488     .    011011AD +
        SLHLS SF  3 POS     2.093  00.477     .    010EC77C +
        SRHL RX1  0 POS     1.972  00.507     .    01120D84 +
        SRHL RX1  1 POS     2.543  00.393     .    01034982  
        SRHL RX1  2 POS     2.638  00.379     .    0100FAF1 +
        SRHL RX1  3 POS     2.857  00.350     .    00FBD107 +
        SRHLS SF  0 POS     1.429  00.699     .    0121BCF2 +
        SRHLS SF  1 POS     1.918  00.521     .    011386D4  
        SRHLS SF  2 POS     2.033  00.491     .    01106352 +
        SRHLS SF  3 POS     2.093  00.477     .    010EC776 +







        RLL  RX1  0 POS     1.973  00.506     .    01120569 +
        RLL  RX1  1 POS     2.354  00.424     .    0107FD53  
        RLL  RX1  2 POS     2.539  00.393     .    01035F50 +
        RLL  RX1  3 POS     2.574  00.388     .    01028371 +
        RLL  RX1 32 POS     6.138  00.162     .    00C19597 +
        RRL  RX1  0 POS     1.971  00.507     .    0112111D +
        RRL  RX1  1 POS     2.354  00.424     .    0107FC76  
        RRL  RX1  2 POS     2.537  00.394     .    01036D01 +
        RRL  RX1  3 POS     2.606  00.383     .    0101BC0C +
        RRL  RX1 32 POS     6.138  00.162     .    00C19591 +
        TS   RX1            2.877  00.347     .    00FB5911  
        TS   RX2            2.982  00.335     .    00F8F4D5  
        TS   RX3            3.711  00.269     .    00E98928  
        TBT  RX1            2.652  00.377     .    0100A628  
        TBT  RX2            2.796  00.357     .    00FD3A2B  
        TBT  RX3            3.493  00.286     .    00EDF162  
        SBT  RX1            3.165  00.315     .    00F4E325  
        SBT  RX2            3.288  00.304     .    00F23F45  
        SBT  RX3            4.057  00.246     .    00E2D8FC  
        RBT  RX1            3.171  00.315     .    00F4C2A8  
        RBT  RX2            3.290  00.303     .    00F23482  
        RBT  RX3            4.026  00.248     .    00E36E5C  
        CBT  RX1            3.288  00.304     .    00F23D6C  
        CBT  RX2            3.350  00.298     .    00F0EB30  
        CBT  RX3            4.101  00.243     .    00E2090D  
        JF   RX1 M=1,C=2    1.513  00.660     .    011F3692  
        JF   RX1 M=2,C=2    1.698  00.588     .    0119C052  
        JF   RX2 M=1,C=2    1.696  00.589     .    0119CD09  
        JF   RX2 M=2,C=2    1.877  00.532     .    0114AD37  
        JF   RX3 M=1,C=2    2.403  00.416     .    0106BED5  
        JF   RX3 M=2,C=2    2.567  00.389     .    0102B11F  
        JFR   RR M=1,C=2    1.156  00.865     .    012A5400  
        JFR   RR M=2,C=2    0.773  01.293     .    01374BBA  
        JFBS  SF M=1,C=2    1.065  00.938     .    012D5176  
        JFBS  SF M=2,C=2    0.771  01.297     .    01375C50  
        JFFS  SF M=1,C=2    1.062  00.941     .    012D6D0E  
        JFFS  SF M=2,C=2    0.769  01.300     .    01376C9E  
        JT   RX1 M=2,C=2    1.513  00.660     .    011F3697  
        JT   RX1 M=1,C=2    1.698  00.588     .    0119BDF8  
        JT   RX2 M=2,C=2    1.697  00.589     .    0119C963  
        JT   RX2 M=1,C=2    1.875  00.533     .    0114B82B  
        JT   RX3 M=2,C=2    2.403  00.416     .    0106C19D  
        JT   RX3 M=1,C=2    2.538  00.394     .    01036737  
        JTR   RR M=2,C=2    1.156  00.865     .    012A542F  
        JTR   RR M=1,C=2    0.774  01.291     .    0137429C  
        JTBS  SF M=2,C=2    1.063  00.940     .    012D6540  
        JTBS  SF M=1,C=2    0.770  01.298     .    01376973  
        JTFS  SF M=2,C=2    1.062  00.941     .    012D6D11  
        JTFS  SF M=1,C=2    0.770  01.298     .    013763BA  
        NOP  RX1            1.700  00.588     .    0119B3D1  
        NOP  RX2            1.881  00.531     .    01149085  
        NOP  RX3            2.570  00.389     .    01029C99  
        NOPR  RR            0.769  01.300     .    01376A4B  







        J    RX1            1.513  00.660     .    011F3691  
        J    RX2            1.696  00.589     .    0119CE22  
        J    RX3            2.385  00.419     .    01073455  
        JR    RR            1.159  00.862     .    012A3CF2  
        JBS   SF            1.062  00.941     .    012D6B9E  
        JFS   SF            1.062  00.941     .    012D6D03  
        JAL  RX1            1.513  00.660     .    011F3699  
        JAL  RX2            1.697  00.589     .    0119CAD8  
        JAL  RX3            2.396  00.417     .    0106EEFF  
        JALR  RR            1.513  00.660     .    011F3686  
        JFFO  SF ALL  =0    1.471  00.679     .    01207851 +
        JFFO  SF BIT 0=1    1.513  00.660     .    011F3689 +
        JFFO  SF BIT 1=1    1.513  00.660     .    011F3692 +
        JFFO  SF BIT 2=1    1.697  00.589     .    0119CB28 +
        JFFO  SF BIT30=1    5.218  00.191     .    00CF026B +
        JFFO  SF BIT31=1    5.349  00.186     .    00CCF95B +
        JFFOH SF ALL  =0    1.362  00.734     .    0123CE1C +
        JFFOH SF BIT 0=1    1.513  00.660     .    011F368F +
        JFFOH SF BIT 1=1    1.513  00.660     .    011F3692 +
        JFFOH SF BIT 2=1    1.696  00.589     .    0119CD7A +
        JFFOH SF BIT14=1    3.246  00.308     .    00F32237 +
        JFFOH SF BIT15=1    3.288  00.304     .    00F23F34 +
        A    RX1            2.988  00.334     .    00F8D596  
        A    RX2            3.240  00.308     .    00F3434E  
        A    RX3            3.773  00.265     .    00E84D12  
        AH   RX1            2.337  00.427     .    01086865  
        AH   RX2            2.386  00.419     .    01072DAC  
        AH   RX3            3.245  00.308     .    00F32860  
        AHI  RI1            1.388  00.720     .    0123046C  
        AI   RI2            2.093  00.477     .    010EC75C  
        AR    RR            0.771  01.297     .    0137605A  
        AIS   SF            0.773  01.293     .    01374962  
        AM   RX1            4.427  00.225     .    00DC2145  
        AM   RX2            4.664  00.214     .    00D8085F  
        AM   RX3            5.301  00.188     .    00CDB988  
        AHM  RX1            3.071  00.325     .    00F6F8ED  
        AHM  RX2            3.172  00.315     .    00F4BE47  
        AHM  RX3            3.789  00.263     .    00E7FC3A  
        S    RX1            2.992  00.334     .    00F8BD01  
        S    RX2            3.243  00.308     .    00F3376F  
        S    RX3            3.773  00.265     .    00E84D16  
        SH   RX1            2.337  00.427     .    01086DCB  
        SH   RX2            2.396  00.417     .    0106EC4D  
        SH   RX3            3.250  00.307     .    00F3112F  
        SHI  RI1            1.388  00.720     .    01230470  
        SI   RI2            2.093  00.477     .    010EC722  
        SR    RR            0.769  01.300     .    01376DC7  
        SIS   SF            0.771  01.297     .    01376007  







        CL   RX1            2.992  00.334     .    00F8BEE5  
        CL   RX2            3.247  00.307     .    00F31D99  
        CL   RX3            3.793  00.263     .    00E7EC18  
        CLH  RX1            2.335  00.428     .    010876C8  
        CLH  RX2            2.414  00.414     .    01067A7F  
        CLH  RX3            3.243  00.308     .    00F33290  
        CLHI RI1            1.388  00.720     .    0123047E  
        CLI  RI2            2.096  00.477     .    010EB3C4  
        CLR   RR            0.770  01.298     .    01376227  
        CLB  RX1            2.335  00.428     .    01087937  
        CLB  RX2            2.412  00.414     .    010689C4  
        CLB  RX3            3.244  00.308     .    00F3328B  
        C    RX1            3.086  00.324     .    00F6A335  
        C    RX2            3.248  00.307     .    00F31B81  
        C    RX3            3.934  00.254     .    00E52F1B  
        CH   RX1            2.335  00.428     .    010877AF  
        CH   RX2            2.415  00.414     .    01067494  
        CH   RX3            3.245  00.308     .    00F32753  
        CHI  RI1            1.471  00.679     .    01207856  
        CI   RI2            2.138  00.467     .    010D97B6  
        CR    RR            0.809  01.236     .    01360B02  
        M    RX1 0*0       15.493  00.064     .    0074AA19 +
        M    RX1 0*FFFF    17.366  00.057     .    006C104F +
        M    RX1 0*-1      19.346  00.051     .    006440B2 +
        M    RX2 0*0       15.555  00.064     .    00745ACD +
        M    RX2 0*FFFF    17.439  00.057     .    006BC1FB +
        M    RX2 0*-1      19.506  00.051     .    0063AC57 +
        M    RX3 0*0       16.185  00.061     .    0071551E +
        M    RX3 0*FFFF    18.211  00.054     .    00689645 +
        M    RX3 0*-1      20.180  00.049     .    00614AB2 +
        MR    RR 0*0       13.711  00.072     .    007E36F6 +
        MR    RR 0*FFFF    15.638  00.063     .    0073F23D +
        MR    RR 0*-1      17.820  00.056     .    006A2B92 +
        MH   RX1 0*0        8.900  00.112     .    00A208B5 +
        MH   RX1 0*FFFF    10.826  00.092     .    0091823A +
        MH   RX2 0*0        8.951  00.111     .    00A18EB1 +
        MH   RX2 0*FFFF    11.071  00.090     .    008FA39B +
        MH   RX3 0*0        9.638  00.103     .    009B4719 +
        MH   RX3 0*FFFF     9.638  00.103     .    009B471F +
        D    RX1  n/0      11.713  00.085     .    008AF964 +
        D    RX1  0/n      23.301  00.042     .    00579BE9 +
        D    RX1 -1/n      27.256  00.036     .    004DCB6F +
        D    RX2  n/0      11.708  00.085     .    008B024E +
        D    RX2  0/n      23.467  00.042     .    00572533 +
        D    RX2 -1/n      27.388  00.036     .    004D8086 +
        D    RX3  n/0      12.481  00.080     .    0085C68C +
        D    RX3  0/n      24.118  00.041     .    00556250 +
        D    RX3 -1/n      27.942  00.035     .    004C4FB9 +







        DR    RR  n/0       9.962  00.100     .    00987C59 +
        DR    RR  0/n      21.650  00.046     .    005C7A3E +
        DR    RR -1/n      25.518  00.039     .    0051D1CA +
        DH   RX1  n/0      11.726  00.085     .    008AE2ED +
        DH   RX1  0/n      23.303  00.042     .    00579A04 +
        DH   RX1 -1/n      24.614  00.040     .    00541635 +
        DH   RX2  n/0      11.708  00.085     .    008B0212 +
        DH   RX2  0/n      23.472  00.042     .    005721EB +
        DH   RX2 -1/n      24.912  00.040     .    0053537B +
        DH   RX3  n/0      12.456  00.080     .    0085EFE2 +
        DH   RX3  0/n      24.107  00.041     .    005568BD +
        DH   RX3 -1/n      25.399  00.039     .    00521CA1 +
        DHR   RR  n/0       9.955  00.100     .    00988AC5 +
        DHR   RR  0/n      21.653  00.046     .    005C7842 +
        DHR   RR -1/n      25.522  00.039     .    0051D009 +
        SRA  RI1  0 POS     1.972  00.507     .    01120971 +
        SRA  RI1  1 POS     2.354  00.424     .    0107FA73  
        SRA  RI1  2 POS     2.538  00.394     .    010364D1 +
        SRA  RI1  3 POS     2.573  00.388     .    01028C38 +
        SRA  RI1 32 POS     6.138  00.162     .    00C1958C +
        LHR   RR            1.169  00.855     .    0129EC4A  
        LPSW RX1            5.277  00.189     .    00CE1749  
        LPSW RX2            5.441  00.183     .    00CB94B7  
        LPSW RX3            6.083  00.164     .    00C257F3  
        UPSW RX1            4.003  00.249     .    00E3DE61  
        UPSW RX2            4.165  00.240     .    00E0DB9F  
        UPSW RX3            4.893  00.204     .    00D43279  
        LPSWR RR            1.787  00.559     .    011736E1  
        EPSR  RR            1.471  00.679     .    0120784D  
        SVC  RX1            4.848  00.206     .    00A3B387  
        SVC  RX2            4.944  00.202     .    00A2C567  
        SVC  RX3            5.788  00.172     .    009B039A  
        CIO   RR            3.490  00.286     .    00EE0103  
        SSR   RR            3.570  00.280     .    00EC5F1A  
        SSR   RR T/O        7.807  00.128     .    00AD337F +
        OC   RX1            5.076  00.197     .    00D13C99  
        OC   RX1 T/O        9.161  00.109     .    009F94FD +
        OC   RX2            5.147  00.194     .    00D01CA8  
        OC   RX2 T/O        9.276  00.107     .    009E84EA +
        OC   RX3            6.052  00.165     .    00C2C382  
        OC   RX3 T/O        9.961  00.100     .    00987D76 +
        OCR   RR            2.985  00.335     .    00F8E4EF  
        OCR   RR T/O        7.143  00.139     .    00B4C7E0 +
        RDR   RR            2.927  00.341     .    00FA367A  
        RDR   RR T/O        7.036  00.142     .    00B60FF7 +
        WD   RX1            4.962  00.201     .    00D3133D  
        WD   RX1 T/O        8.975  00.111     .    00A15200 +
        WD   RX2            5.081  00.196     .    00D128A3  
        WD   RX2 T/O        9.166  00.109     .    009F8978 +
        WD   RX3            6.055  00.165     .    00C2BA7D  
        WD   RX3 T/O        9.852  00.101     .    00996AE1 +
        WDR   RR            2.925  00.341     .    00FA3E71  
        WDR   RR T/O        7.043  00.141     .    00B5F9F1 +







        CKSUM RR 16  CHR   11.601  00.086     .    005CFC5A +
        CKSUM RR 32  CHR   24.425  00.040     .    0040D59E +
        CKSUM RR 64  CHR   48.139  00.020     .    00299115 +
        CKSUM RR 96  CHR   71.814  00.013     .    001E99F6 +
        CKSUM RR 124 CHR  137.948  00.007     .    00119EA8 +
         
        TOTAL AVERAGE MIPS 00.387
        TOTAL INST TIME  3591.899
        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1        137.463     2.749    19.955      .399
        RX2        129.418     2.941    16.410      .372
        RX3        161.304     3.666    12.723      .289
        RI1         15.011     1.501     6.821      .682
        RI2         18.893     2.099     4.283      .475
        RR          36.912     1.367    26.313      .974
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        
        







        
                                   TYMNET ENGINE
        
                        MEMORY SYSTEM TIMING - MACII DYNAMIC
        
        
        ENGINE INSTRUCTION SET TIMING - VERSION 1.01
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         8.607    .        .    013F1EF8  
        MACHINE RATING      5.579    .      17.92  00C19CD1  
        L    RX1            3.173  00.315   63.04  00E92832  
        L    RX2            3.410  00.293   58.66  00E49105  
        L    RX3            4.104  00.243   48.74  00D813BA  
        LH   RX1            2.462  00.406   40.62  00F823E9  
        LH   RX2            2.655  00.376   37.66  00F3E570  
        LH   RX3            3.410  00.293   29.33  00E49106  
        LHI  RI1            1.628  00.614     .    010C5C41  
        LI   RI2            2.431  00.411     .    00F8D59B  
        LR    RR            0.788  01.269     .    012459DB  
        LIS   SF            0.767  01.303     .    01250020  
        LCS   SF            0.788  01.269     .    012459CD  
        LA   RX1            1.939  00.515     .    010471E8  
        LA   RX2            1.903  00.525     .    010558B3  
        LA   RX3            2.804  00.356     .    00F0B0EA  
        LHL  RX1            2.464  00.405   40.58  00F81AFF  
        LHL  RX2            2.605  00.383   38.39  00F4FBCC  
        LHL  RX3            3.410  00.293   29.33  00E4910B  
        LM   RX1 REG 0     25.811  00.038  123.84  004FCD70 +
        LM   RX2 REG 0     26.088  00.038  122.56  004F29D4 +
        LM   RX3 REG 0     26.827  00.037  119.36  004D836A +
        LM   RX1 REG 1     24.390  00.041  123.00  00533D22 +
        LM   RX2 REG 1     24.473  00.040  122.70  00530773 +
        LM   RX3 REG 1     25.327  00.039  118.50  0050F078 +
        LM   RX1 REG 8     13.891  00.071  115.20  007A1569 +
        LM   RX2 REG 8     13.951  00.071  114.72  0079C17B +
        LM   RX3 REG 8     14.745  00.067  108.48  00759E4A +
        LM   RX1 REG 15     3.173  00.315   63.04  00E92822  
        LM   RX2 REG 15     3.410  00.293   58.66  00E4910F  
        LM   RX3 REG 15     4.108  00.243   48.68  00D80514  
        LB   RX1            2.464  00.405   20.29  00F81AF5  
        LB   RX2            2.655  00.376   18.83  00F3E56E  
        LB   RX3            3.410  00.293   14.66  00E4910D  
        LBR   RR            0.767  01.303     .    01250019  
        EXHR  RR            0.788  01.269     .    012459DB  
        EXBR  RR            0.788  01.269     .    012459DB  
        ST   RX1            3.071  00.325   65.12  00EB31E5  
        ST   RX2            3.142  00.318   63.66  00E9C732  
        ST   RX3            3.906  00.256   51.20  00DB81A8  
        STH  RX1            2.450  00.408   40.82  00F867E7  
        STH  RX2            2.605  00.383   38.39  00F4FBD3  
        STH  RX3            3.335  00.299   29.99  00E601CD  







        STM  RX1 REG 0     20.015  00.049  160.00  005FF5F9 +
        STM  RX2 REG 0     20.313  00.049  157.44  005EF8B9 +
        STM  RX3 REG 0     21.092  00.047  151.68  005C7AF0 +
        STM  RX1 REG 1     19.423  00.051  154.50  0061FD8D +
        STM  RX2 REG 1     19.421  00.051  154.50  0061FF0F +
        STM  RX3 REG 1     19.765  00.050  151.80  0060CE70 +
        STM  RX1 REG 8     11.091  00.090  144.32  008B6F7D +
        STM  RX2 REG 8     11.141  00.089  143.68  008B15AA +
        STM  RX3 REG 8     11.946  00.083  133.92  0085A347 +
        STM  RX1 REG 15     3.074  00.325   65.06  00EB25A4  
        STM  RX2 REG 15     3.100  00.322   64.52  00EA9BDF  
        STM  RX3 REG 15     3.906  00.256   51.20  00DB81A2  
        STB  RX1            3.152  00.317   15.86  00E991E4  
        STB  RX2            3.310  00.302   15.10  00E679F2  
        STB  RX3            4.079  00.245   12.26  00D880F3  
        STBR  RR            0.788  01.269     .    012459D2  
        COPY  RR 2   BYT    3.347  00.298   59.76  0078EDCF +
        COPY  RR 16  BYT   12.568  00.079  127.36  00560215 +
        COPY  RR 32  BYT   23.130  00.043  138.24  0040A1EC +
        COPY  RR 64  BYT   46.157  00.021  138.88  0029EB2F +
        COPY  RR 128 BYT   91.598  00.010  139.52  0018C098 +
        COPY  RR 256 BYT  182.778  00.005  140.80  000D9615 +
        COPY  RR 512 BYT  365.102  00.002  138.24  00072494 +
        COPY  RR 1024 BY  729.698  00.001  143.36  0003AAF3 +
        N    RX1            3.173  00.315     .    00E92820  
        N    RX2            3.410  00.293     .    00E49102  
        N    RX3            4.107  00.243     .    00D808CA  
        NH   RX1            2.464  00.405     .    00F81AFD  
        NH   RX2            2.655  00.376     .    00F3E561  
        NH   RX3            3.410  00.293     .    00E4910D  
        NHI  RI1            1.627  00.614     .    010C62BE  
        NI   RI2            2.437  00.410     .    00F8B599  
        NR    RR            0.788  01.269     .    012459DD  
        O    RX1            3.173  00.315     .    00E9282C  
        O    RX2            3.410  00.293     .    00E490FE  
        O    RX3            4.104  00.243     .    00D813BD  
        OH   RX1            2.464  00.405     .    00F81AFA  
        OH   RX2            2.605  00.383     .    00F4FB9F  
        OH   RX3            3.410  00.293     .    00E4908B  
        OHI  RI1            1.629  00.613     .    010C5647  
        OI   RI2            2.437  00.410     .    00F8B61A  
        OR    RR            0.767  01.303     .    0125001A  
        X    RX1            3.173  00.315     .    00E92828  
        X    RX2            3.410  00.293     .    00E48F96  
        X    RX3            4.109  00.243     .    00D7FDAC  
        XH   RX1            2.464  00.405     .    00F81AE9  
        XH   RX2            2.655  00.376     .    00F3E56E  
        XH   RX3            3.410  00.293     .    00E4910D  
        XHI  RI1            1.630  00.613     .    010C4FD7  
        XI   RI2            2.437  00.410     .    00F8B4F0  
        XR    RR            0.788  01.269     .    012459DA  







        ARAND RR 16/nm      4.080  00.245     .    007525D4 +
        ARAND RR 16/B 0     4.091  00.244     .    007518A0 +
        ARAND RR 16/B 1     4.040  00.247     .    0075590F +
        ARAND RR 16/B 2     4.174  00.239     .    0074AE81 +
        ARAND RR 16/B 7     4.793  00.208     .    0071B123 +
        ARAND RR 16/B 13    5.611  00.178     .    006DF77E +
        ARAND RR 16/B 14    5.916  00.169     .    006CA3CF +
        ARAND RR 16/B 15    5.919  00.168     .    006CA094 +
        ARAND RR 32/nm      7.126  00.140     .    0067AE31 +
        ARAND RR 32/B 0     7.329  00.136     .    0066E47F +
        ARAND RR 32/B 1     7.424  00.134     .    006686D8 +
        ARAND RR 32/B 2     7.483  00.133     .    00664CE9 +
        ARAND RR 32/B 15    8.944  00.111     .    0061051F +
        ARAND RR 32/B 16    4.007  00.249     .    0075837F +
        ARAND RR 32/B 17    4.047  00.247     .    00754FAC +
        ARAND RR 32/B 30    5.920  00.168     .    006CA03B +
        ARAND RR 32/B 31    5.919  00.168     .    006CA044 +
        THI  RI1            1.630  00.613     .    010C4BCA  
        TI   RI2            2.432  00.411     .    00F8CFDF  
        SLL  RX1  0 POS     2.124  00.470     .    00FFF4D1 +
        SLL  RX1  1 POS     2.464  00.405     .    00F81AEB  
        SLL  RX1  2 POS     2.663  00.375     .    00F3B653 +
        SLL  RX1  3 POS     2.692  00.371     .    00F3163C +
        SLL  RX1 32 POS     6.406  00.156     .    00B6F3B9 +
        SLLS  SF  0 POS     1.446  00.691     .    01113965 +
        SLLS  SF  1 POS     1.709  00.585     .    010A419C  
        SLLS  SF  2 POS     1.939  00.515     .    010471DC +
        SLLS  SF  3 POS     1.905  00.524     .    01054CD6 +
        SLLS  SF 15 POS     3.454  00.289     .    00E3B885 +
        SRL  RX1  0 POS     2.124  00.470     .    00FFF61C +
        SRL  RX1  1 POS     2.464  00.405     .    00F81AF6  
        SRL  RX1  2 POS     2.614  00.382     .    00F4C981 +
        SRL  RX1  3 POS     2.692  00.371     .    00F3163C +
        SRL  RX1 32 POS     6.410  00.156     .    00B6E6F9 +
        SRLS  SF  0 POS     1.446  00.691     .    01113979 +
        SRLS  SF  1 POS     1.709  00.585     .    010A41AF  
        SRLS  SF  2 POS     1.939  00.515     .    010471EB +
        SRLS  SF  3 POS     1.905  00.524     .    01054BBE +
        SLHL RX1  0 POS     2.126  00.470     .    00FFE55F +
        SLHL RX1  1 POS     2.692  00.371     .    00F31627  
        SLHL RX1  2 POS     2.881  00.347     .    00EF1875 +
        SLHL RX1  3 POS     3.071  00.325     .    00EB32D2 +
        SLHLS SF  0 POS     1.446  00.691     .    0111395C +
        SLHLS SF  1 POS     1.970  00.507     .    0103ACEF  
        SLHLS SF  2 POS     2.124  00.470     .    00FFF32F +
        SLHLS SF  3 POS     2.209  00.452     .    00FDEF03 +
        SRHL RX1  0 POS     2.124  00.470     .    00FFF6A8 +
        SRHL RX1  1 POS     2.692  00.371     .    00F3154F  
        SRHL RX1  2 POS     2.886  00.346     .    00EEFA2B +
        SRHL RX1  3 POS     3.074  00.325     .    00EB2197 +
        SRHLS SF  0 POS     1.446  00.691     .    01113972 +
        SRHLS SF  1 POS     1.970  00.507     .    0103ACF7  
        SRHLS SF  2 POS     2.124  00.470     .    00FFF628 +
        SRHLS SF  3 POS     2.209  00.452     .    00FDEEFE +







        RLL  RX1  0 POS     2.125  00.470     .    00FFEDC1 +
        RLL  RX1  1 POS     2.464  00.405     .    00F81AF9  
        RLL  RX1  2 POS     2.605  00.383     .    00F4FBCC +
        RLL  RX1  3 POS     2.692  00.371     .    00F31635 +
        RLL  RX1 32 POS     6.409  00.156     .    00B6E8BC +
        RRL  RX1  0 POS     2.126  00.470     .    00FFEB0F +
        RRL  RX1  1 POS     2.464  00.405     .    00F81AF8  
        RRL  RX1  2 POS     2.605  00.383     .    00F4FBCA +
        RRL  RX1  3 POS     2.692  00.371     .    00F3163E +
        RRL  RX1 32 POS     6.407  00.156     .    00B6EEE8 +
        TS   RX1            3.073  00.325     .    00EB27D6  
        TS   RX2            3.163  00.316     .    00E95D03  
        TS   RX3            4.073  00.245     .    00D89C03  
        TBT  RX1            2.881  00.347     .    00EF1878  
        TBT  RX2            3.071  00.325     .    00EB343D  
        TBT  RX3            3.751  00.266     .    00DE4037  
        SBT  RX1            3.428  00.291     .    00E43A3F  
        SBT  RX2            3.560  00.280     .    00E1BE3A  
        SBT  RX3            4.358  00.229     .    00D3D8C7  
        RBT  RX1            3.428  00.291     .    00E43A44  
        RBT  RX2            3.559  00.280     .    00E1C547  
        RBT  RX3            4.333  00.230     .    00D4428D  
        CBT  RX1            3.559  00.280     .    00E1C1DF  
        CBT  RX2            3.664  00.272     .    00DFD67C  
        CBT  RX3            4.406  00.226     .    00D31072  
        JF   RX1 M=1,C=2    1.709  00.585     .    010A41AE  
        JF   RX1 M=2,C=2    1.939  00.515     .    010471DD  
        JF   RX2 M=1,C=2    1.939  00.515     .    010471EE  
        JF   RX2 M=2,C=2    1.905  00.524     .    01054A07  
        JF   RX3 M=1,C=2    2.655  00.376     .    00F3E568  
        JF   RX3 M=2,C=2    2.797  00.357     .    00F0DB16  
        JFR   RR M=1,C=2    1.223  00.817     .    01176720  
        JFR   RR M=2,C=2    0.788  01.269     .    012459DA  
        JFBS  SF M=1,C=2    1.099  00.909     .    011AFCB4  
        JFBS  SF M=2,C=2    0.788  01.269     .    012459E0  
        JFFS  SF M=1,C=2    1.099  00.909     .    011AFCAD  
        JFFS  SF M=2,C=2    0.788  01.269     .    012459E3  
        JT   RX1 M=2,C=2    1.709  00.585     .    010A41B7  
        JT   RX1 M=1,C=2    1.939  00.515     .    010471DA  
        JT   RX2 M=2,C=2    1.939  00.515     .    010471ED  
        JT   RX2 M=1,C=2    1.903  00.525     .    0105569B  
        JT   RX3 M=2,C=2    2.605  00.383     .    00F4FBE2  
        JT   RX3 M=1,C=2    2.751  00.363     .    00F1D4C3  
        JTR   RR M=2,C=2    1.223  00.817     .    01176724  
        JTR   RR M=1,C=2    0.788  01.269     .    012459D7  
        JTBS  SF M=2,C=2    1.099  00.909     .    011AFCAF  
        JTBS  SF M=1,C=2    0.767  01.303     .    0125001A  
        JTFS  SF M=2,C=2    1.099  00.909     .    011AFCAE  
        JTFS  SF M=1,C=2    0.788  01.269     .    012459D3  
        NOP  RX1            1.939  00.515     .    010471E1  
        NOP  RX2            1.905  00.524     .    01054B3E  
        NOP  RX3            2.747  00.364     .    00F1E8C1  
        NOPR  RR            0.767  01.303     .    0125001C  







        J    RX1            1.709  00.585     .    010A41B3  
        J    RX2            1.939  00.515     .    010471F1  
        J    RX3            2.661  00.375     .    00F3C1B6  
        JR    RR            1.223  00.817     .    01176735  
        JBS   SF            1.099  00.909     .    011AFCBB  
        JFS   SF            1.099  00.909     .    011AFCB1  
        JAL  RX1            1.709  00.585     .    010A41B7  
        JAL  RX2            1.939  00.515     .    010471DF  
        JAL  RX3            2.655  00.376     .    00F3E134  
        JALR  RR            1.709  00.585     .    010A41B6  
        JFFO  SF ALL  =0    1.481  00.675     .    011041D4 +
        JFFO  SF BIT 0=1    1.611  00.620     .    010CCD85 +
        JFFO  SF BIT 1=1    1.615  00.619     .    010CAFE6 +
        JFFO  SF BIT 2=1    1.665  00.600     .    010B6544 +
        JFFO  SF BIT30=1    5.412  00.184     .    00C3EAF1 +
        JFFO  SF BIT31=1    5.381  00.185     .    00C45BBB +
        JFFOH SF ALL  =0    1.446  00.691     .    01113979 +
        JFFOH SF BIT 0=1    1.612  00.620     .    010CC93A +
        JFFOH SF BIT 1=1    1.602  00.624     .    010D0C84 +
        JFFOH SF BIT 2=1    1.665  00.600     .    010B653F +
        JFFOH SF BIT14=1    3.142  00.318     .    00E9C6E6 +
        JFFOH SF BIT15=1    3.437  00.290     .    00E40EF4 +
        A    RX1            3.173  00.315     .    00E92832  
        A    RX2            3.410  00.293     .    00E490AE  
        A    RX3            4.110  00.243     .    00D7FB40  
        AH   RX1            2.464  00.405     .    00F81AF8  
        AH   RX2            2.605  00.383     .    00F4FBDE  
        AH   RX3            3.410  00.293     .    00E49115  
        AHI  RI1            1.628  00.614     .    010C5944  
        AI   RI2            2.437  00.410     .    00F8B4FF  
        AR    RR            0.788  01.269     .    012459D6  
        AIS   SF            0.767  01.303     .    0125002D  
        AM   RX1            4.871  00.205     .    00CBC982  
        AM   RX2            5.019  00.199     .    00C991A1  
        AM   RX3            5.642  00.177     .    00C0C37A  
        AHM  RX1            3.362  00.297     .    00E579B6  
        AHM  RX2            3.428  00.291     .    00E43A40  
        AHM  RX3            4.203  00.237     .    00D6699F  
        S    RX1            3.173  00.315     .    00E92827  
        S    RX2            3.410  00.293     .    00E49107  
        S    RX3            4.107  00.243     .    00D805F5  
        SH   RX1            2.464  00.405     .    00F81AFE  
        SH   RX2            2.655  00.376     .    00F3E572  
        SH   RX3            3.410  00.293     .    00E49107  
        SHI  RI1            1.626  00.615     .    010C6862  
        SI   RI2            2.437  00.410     .    00F8B50B  
        SR    RR            0.788  01.269     .    012459CD  
        SIS   SF            0.767  01.303     .    01250024  







        CL   RX1            3.173  00.315     .    00E9282B  
        CL   RX2            3.410  00.293     .    00E4910F  
        CL   RX3            4.104  00.243     .    00D813BB  
        CLH  RX1            2.464  00.405     .    00F81AFB  
        CLH  RX2            2.656  00.376     .    00F3DC65  
        CLH  RX3            3.410  00.293     .    00E49115  
        CLHI RI1            1.625  00.615     .    010C6D5C  
        CLI  RI2            2.434  00.410     .    00F8C1B7  
        CLR   RR            0.788  01.269     .    012459DE  
        CLB  RX1            2.464  00.405     .    00F81AFD  
        CLB  RX2            2.655  00.376     .    00F3E55A  
        CLB  RX3            3.410  00.293     .    00E49113  
        C    RX1            3.173  00.315     .    00E92825  
        C    RX2            3.410  00.293     .    00E49116  
        C    RX3            4.110  00.243     .    00D7F9F1  
        CH   RX1            2.464  00.405     .    00F81AF2  
        CH   RX2            2.655  00.376     .    00F3E56C  
        CH   RX3            3.410  00.293     .    00E4910B  
        CHI  RI1            1.627  00.614     .    010C6225  
        CI   RI2            2.437  00.410     .    00F8B504  
        CR    RR            0.767  01.303     .    01250023  
        M    RX1 0*0       15.632  00.063     .    0071509A +
        M    RX1 0*FFFF    17.607  00.056     .    0068C6AC +
        M    RX1 0*-1      19.516  00.051     .    0061AAB6 +
        M    RX2 0*0       15.716  00.063     .    0070EC94 +
        M    RX2 0*FFFF    17.725  00.056     .    00684E72 +
        M    RX2 0*-1      19.640  00.050     .    00613C1A +
        M    RX3 0*0       16.598  00.060     .    006CF8A1 +
        M    RX3 0*FFFF    18.491  00.054     .    00655C42 +
        M    RX3 0*-1      20.461  00.048     .    005E7CC4 +
        MR    RR 0*0       13.854  00.072     .    007A498E +
        MR    RR 0*FFFF    15.953  00.062     .    006FD516 +
        MR    RR 0*-1      17.839  00.056     .    0067DB88 +
        MH   RX1 0*0        9.016  00.110     .    009BD9F7 +
        MH   RX1 0*FFFF    11.104  00.090     .    008B58DD +
        MH   RX2 0*0        9.252  00.108     .    0099CBAB +
        MH   RX2 0*FFFF    11.268  00.088     .    008A31F7 +
        MH   RX3 0*0       10.100  00.099     .    0092D396 +
        MH   RX3 0*FFFF    10.100  00.099     .    0092D39E +
        D    RX1  n/0      11.891  00.084     .    0085FE2D +
        D    RX1  0/n      23.444  00.042     .    0055B22B +
        D    RX1 -1/n      27.370  00.036     .    004C57DD +
        D    RX2  n/0      11.954  00.083     .    008595B5 +
        D    RX2  0/n      23.611  00.042     .    00553FF2 +
        D    RX2 -1/n      27.467  00.036     .    004C2324 +
        D    RX3  n/0      12.781  00.078     .    00806B68 +
        D    RX3  0/n      24.391  00.040     .    00533C29 +
        D    RX3 -1/n      28.280  00.035     .    004A7600 +







        DR    RR  n/0      10.173  00.098     .    009240B2 +
        DR    RR  0/n      21.750  00.045     .    005A7A25 +
        DR    RR -1/n      25.601  00.039     .    00504A7E +
        DH   RX1  n/0      11.890  00.084     .    0085FFDC +
        DH   RX1  0/n      23.452  00.042     .    0055ACBB +
        DH   RX1 -1/n      24.777  00.040     .    005245FC +
        DH   RX2  n/0      11.965  00.083     .    0085831E +
        DH   RX2  0/n      23.607  00.042     .    00554314 +
        DH   RX2 -1/n      24.921  00.040     .    0051EB87 +
        DH   RX3  n/0      12.783  00.078     .    00806777 +
        DH   RX3  0/n      24.394  00.040     .    005339FD +
        DH   RX3 -1/n      25.701  00.038     .    00500ED5 +
        DHR   RR  n/0      10.080  00.099     .    0092FB93 +
        DHR   RR  0/n      21.749  00.045     .    005A7B62 +
        DHR   RR -1/n      25.600  00.039     .    00504AD2 +
        SRA  RI1  0 POS     2.126  00.470     .    00FFEA8E +
        SRA  RI1  1 POS     2.464  00.405     .    00F81AF0  
        SRA  RI1  2 POS     2.658  00.376     .    00F3CFB1 +
        SRA  RI1  3 POS     2.692  00.371     .    00F3162E +
        SRA  RI1 32 POS     6.406  00.156     .    00B6F22C +
        LHR   RR            1.217  00.821     .    011794B3  
        LPSW RX1            5.517  00.181     .    00C2782F  
        LPSW RX2            5.642  00.177     .    00C0C37C  
        LPSW RX3            6.472  00.154     .    00B62646  
        UPSW RX1            4.428  00.225     .    00D2B833  
        UPSW RX2            4.479  00.223     .    00D1E2CF  
        UPSW RX3            5.392  00.185     .    00C434B1  
        LPSWR RR            1.939  00.515     .    010471EC  
        EPSR  RR            1.481  00.675     .    011041E0  
        SVC  RX1            4.863  00.205     .    0099F572  
        SVC  RX2            5.084  00.196     .    00981396  
        SVC  RX3            5.792  00.172     .    00925679  
        CIO   RR            3.454  00.289     .    00E3B873  
        SSR   RR            3.592  00.278     .    00E12796  
        SSR   RR T/O        7.777  00.128     .    00A7A455 +
        OC   RX1            5.423  00.184     .    00C3C4D7  
        OC   RX1 T/O        9.435  00.105     .    00983CD8 +
        OC   RX2            5.410  00.184     .    00C3F239  
        OC   RX2 T/O        9.454  00.105     .    00981396 +
        OC   RX3            6.169  00.162     .    00B9E387  
        OC   RX3 T/O       10.266  00.097     .    009187B9 +
        OCR   RR            3.079  00.324     .    00EB0700  
        OCR   RR T/O        7.183  00.139     .    00ADF1E2 +
        RDR   RR            2.971  00.336     .    00ED39A1  
        RDR   RR T/O        7.173  00.139     .    00AE0F5C +
        WD   RX1            5.431  00.184     .    00C3AA21  
        WD   RX1 T/O        9.264  00.107     .    0099B152 +
        WD   RX2            5.390  00.185     .    00C43A82  
        WD   RX2 T/O        9.454  00.105     .    009813AC +
        WD   RX3            6.073  00.164     .    00BB181C  
        WD   RX3 T/O       10.183  00.098     .    00922CF0 +
        WDR   RR            2.969  00.336     .    00ED43FC  
        WDR   RR T/O        7.165  00.139     .    00AE255E +







        CKSUM RR 16  CHR   11.765  00.084     .    00583ACB +
        CKSUM RR 32  CHR   23.880  00.041     .    003F82C8 +
        CKSUM RR 64  CHR   48.202  00.020     .    0028A63E +
        CKSUM RR 96  CHR   72.252  00.013     .    001DFAC6 +
        CKSUM RR 124 CHR  139.139  00.007     .    001153E7 +
         
        TOTAL AVERAGE MIPS 00.367
        TOTAL INST TIME  3739.403
        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1        147.502     2.950    18.443      .368
        RX2        138.744     3.153    15.205      .345
        RX3        172.038     3.909    11.863      .269
        RI1         17.114     1.711     5.930      .593
        RI2         21.919     2.435     3.692      .410
        RR          37.816     1.400    25.781      .954
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        







                
                                   TYMNET ENGINE
        
                        MEMORY SYSTEM TIMING - MACII STATIC RAM
        
        ENGINE INSTRUCTION SET TIMING - VERSION 1.01
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         6.624    .        .    019E9FB9  
        MACHINE RATING      4.250    .      23.53  00FC9641  
        L    RX1            2.250  00.444   88.88  01358210  
        L    RX2            2.375  00.421   84.22  0131359C  
        L    RX3            2.875  00.347   69.56  01212551  
        LH   RX1            1.750  00.571   57.14  0147FC7D  
        LH   RX2            1.875  00.533   53.33  014329B7  
        LH   RX3            2.375  00.421   42.11  013135A0  
        LHI  RI1            1.125  00.888     .    01626FD0  
        LI   RI2            1.625  00.615     .    014CF499  
        LR    RR            0.625  01.600     .    017AE167  
        LIS   SF            0.625  01.600     .    017AE16D  
        LCS   SF            0.625  01.600     .    017AE16F  
        LA   RX1            1.375  00.727     .    01575C47  
        LA   RX2            1.500  00.666     .    015213F6  
        LA   RX3            2.125  00.470     .    0139EDFA  
        LHL  RX1            1.750  00.571   57.14  0147FC73  
        LHL  RX2            1.875  00.533   53.33  014329B9  
        LHL  RX3            2.375  00.421   42.11  013135A0  
        LM   RX1 REG 0     17.248  00.057  185.60  00730D82 +
        LM   RX2 REG 0     17.373  00.057  184.32  00727411 +
        LM   RX3 REG 0     17.998  00.055  177.92  006F8C6B +
        LM   RX1 REG 1     16.248  00.061  184.50  00781512 +
        LM   RX2 REG 1     16.373  00.061  183.30  00776E01 +
        LM   RX3 REG 1     16.998  00.058  176.40  0074452A +
        LM   RX1 REG 8      9.249  00.108  172.96  00AD082E +
        LM   RX2 REG 8      9.374  00.106  170.72  00ABAE1C +
        LM   RX3 REG 8      9.999  00.100  160.00  00A539D9 +
        LM   RX1 REG 15     2.250  00.444   88.88  01358200  
        LM   RX2 REG 15     2.375  00.421   84.22  013135A4  
        LM   RX3 REG 15     3.000  00.333   66.66  011D6406  
        LB   RX1            1.875  00.533   26.66  014329B7  
        LB   RX2            2.000  00.500   25.00  013E7ABE  
        LB   RX3            2.625  00.380   19.05  0128F5E9  
        LBR   RR            0.625  01.600     .    017AE179  
        EXHR  RR            0.625  01.600     .    017AE168  
        EXBR  RR            0.750  01.333     .    01747574  
        ST   RX1            2.375  00.421   84.22  01313593  
        ST   RX2            2.500  00.400   80.00  012D074F  
        ST   RX3            3.125  00.320   64.00  0119BB5A  
        STH  RX1            1.875  00.533   53.33  014329BB  
        STH  RX2            2.000  00.500   50.00  013E7ABE  
        STH  RX3            2.625  00.380   38.10  0128F5E2  







        STM  RX1 REG 0     17.373  00.057  184.32  0072741A +
        STM  RX2 REG 0     17.498  00.057  182.72  0071DC40 +
        STM  RX3 REG 0     18.123  00.055  176.64  006EFC2F +
        STM  RX1 REG 1     16.373  00.061  183.30  00776DFA +
        STM  RX2 REG 1     16.498  00.060  181.80  0076C8B4 +
        STM  RX3 REG 1     17.123  00.058  175.20  0073A87A +
        STM  RX1 REG 8      9.374  00.106  170.72  00ABAE18 +
        STM  RX2 REG 8      9.499  00.105  168.48  00AA5964 +
        STM  RX3 REG 8     10.124  00.098  158.08  00A3FE2C +
        STM  RX1 REG 15     2.375  00.421   84.22  013135A5  
        STM  RX2 REG 15     2.500  00.400   80.00  012D0761  
        STM  RX3 REG 15     3.125  00.320   64.00  0119BB66  
        STB  RX1            2.375  00.421   21.05  013135B0  
        STB  RX2            2.500  00.400   20.00  012D075F  
        STB  RX3            3.125  00.320   16.00  0119BB66  
        STBR  RR            0.750  01.333     .    01747592  
        COPY  RR 2   BYT    2.750  00.363   72.72  00A3FE3C +
        COPY  RR 16  BYT   11.499  00.086  139.20  006BB896 +
        COPY  RR 32  BYT   21.498  00.046  148.80  004D6081 +
        COPY  RR 64  BYT   42.745  00.023  149.76  00306738 +
        COPY  RR 128 BYT   85.237  00.011  149.76  001BAD28 +
        COPY  RR 256 BYT  170.231  00.005  151.04  000EE890 +
        COPY  RR 512 BYT  340.235  00.002  148.48  0007C10B +
        COPY  RR 1024 BY  679.964  00.001  153.60  0003F4E4 +
        N    RX1            2.250  00.444     .    013581FA  
        N    RX2            2.375  00.421     .    01313591  
        N    RX3            2.875  00.347     .    01212548  
        NH   RX1            1.750  00.571     .    0147FC6B  
        NH   RX2            1.875  00.533     .    014329A7  
        NH   RX3            2.375  00.421     .    01313595  
        NHI  RI1            1.125  00.888     .    01626FC8  
        NI   RI2            1.625  00.615     .    014CF49F  
        NR    RR            0.750  01.333     .    01747568  
        O    RX1            2.250  00.444     .    0135820A  
        O    RX2            2.375  00.421     .    01313599  
        O    RX3            2.875  00.347     .    01212548  
        OH   RX1            1.750  00.571     .    0147FC6F  
        OH   RX2            1.875  00.533     .    014329A7  
        OH   RX3            2.375  00.421     .    0131358F  
        OHI  RI1            1.125  00.888     .    01626FC1  
        OI   RI2            1.625  00.615     .    014CF4A2  
        OR    RR            0.750  01.333     .    01747578  
        X    RX1            2.250  00.444     .    0135820F  
        X    RX2            2.375  00.421     .    01313594  
        X    RX3            2.875  00.347     .    01212546  
        XH   RX1            1.750  00.571     .    0147FC7E  
        XH   RX2            1.875  00.533     .    014329B9  
        XH   RX3            2.375  00.421     .    0131359C  
        XHI  RI1            1.125  00.888     .    01626FCB  
        XI   RI2            1.625  00.615     .    014CF4A3  
        XR    RR            0.750  01.333     .    0174757B  







        ARAND RR 16/nm      3.124  00.320     .    00A066EB +
        ARAND RR 16/B 0     3.250  00.307     .    009F3D5B +
        ARAND RR 16/B 1     3.375  00.296     .    009E1811 +
        ARAND RR 16/B 2     3.500  00.285     .    009CF709 +
        ARAND RR 16/B 7     4.124  00.242     .    00978D65 +
        ARAND RR 16/B 13    4.874  00.205     .    009187C9 +
        ARAND RR 16/B 14    4.999  00.200     .    009092AF +
        ARAND RR 16/B 15    5.124  00.195     .    008FA0C4 +
        ARAND RR 32/nm      5.874  00.170     .    008A3541 +
        ARAND RR 32/B 0     5.999  00.166     .    0089581D +
        ARAND RR 32/B 1     6.124  00.163     .    00887DB9 +
        ARAND RR 32/B 2     6.249  00.160     .    0087A609 +
        ARAND RR 32/B 15    7.874  00.127     .    007D9265 +
        ARAND RR 32/B 16    3.250  00.307     .    009F3D5B +
        ARAND RR 32/B 17    3.375  00.296     .    009E1816 +
        ARAND RR 32/B 30    4.999  00.200     .    009092A6 +
        ARAND RR 32/B 31    5.124  00.195     .    008FA0C1 +
        THI  RI1            1.125  00.888     .    01626FCC  
        TI   RI2            1.625  00.615     .    014CF4A5  
        SLL  RX1  0 POS     1.625  00.615     .    014CF4A2 +
        SLL  RX1  1 POS     2.000  00.500     .    013E7AB2  
        SLL  RX1  2 POS     2.125  00.470     .    0139EDF6 +
        SLL  RX1  3 POS     2.250  00.444     .    01358212 +
        SLL  RX1 32 POS     5.874  00.170     .    00DBC032 +
        SLLS  SF  0 POS     1.250  00.800     .    015CCF8F +
        SLLS  SF  1 POS     1.500  00.666     .    01521400  
        SLLS  SF  2 POS     1.625  00.615     .    014CF4A2 +
        SLLS  SF  3 POS     1.750  00.571     .    0147FC73 +
        SLLS  SF 15 POS     3.250  00.307     .    01162A69 +
        SRL  RX1  0 POS     1.625  00.615     .    014CF4BE +
        SRL  RX1  1 POS     2.000  00.500     .    013E7ACC  
        SRL  RX1  2 POS     2.125  00.470     .    0139EE0A +
        SRL  RX1  3 POS     2.250  00.444     .    0135821F +
        SRL  RX1 32 POS     5.874  00.170     .    00DBC03C +
        SRLS  SF  0 POS     1.250  00.800     .    015CCF98 +
        SRLS  SF  1 POS     1.500  00.666     .    01521409  
        SRLS  SF  2 POS     1.625  00.615     .    014CF4B0 +
        SRLS  SF  3 POS     1.750  00.571     .    0147FC79 +
        SLHL RX1  0 POS     1.625  00.615     .    014CF4AB +
        SLHL RX1  1 POS     2.250  00.444     .    01358219  
        SLHL RX1  2 POS     2.375  00.421     .    0131359E +
        SLHL RX1  3 POS     2.500  00.400     .    012D074D +
        SLHLS SF  0 POS     1.250  00.800     .    015CCF8E +
        SLHLS SF  1 POS     1.750  00.571     .    0147FC78  
        SLHLS SF  2 POS     1.875  00.533     .    014329B4 +
        SLHLS SF  3 POS     2.000  00.500     .    013E7ABF +
        SRHL RX1  0 POS     1.625  00.615     .    014CF4AF +
        SRHL RX1  1 POS     2.250  00.444     .    01358215  
        SRHL RX1  2 POS     2.375  00.421     .    01313598 +
        SRHL RX1  3 POS     2.500  00.400     .    012D0749 +
        SRHLS SF  0 POS     1.250  00.800     .    015CCF93 +
        SRHLS SF  1 POS     1.750  00.571     .    0147FC7E  
        SRHLS SF  2 POS     1.875  00.533     .    014329B7 +
        SRHLS SF  3 POS     2.000  00.500     .    013E7ABA +







        RLL  RX1  0 POS     1.625  00.615     .    014CF4A9 +
        RLL  RX1  1 POS     2.000  00.500     .    013E7ABA  
        RLL  RX1  2 POS     2.125  00.470     .    0139EE00 +
        RLL  RX1  3 POS     2.250  00.444     .    0135821A +
        RLL  RX1 32 POS     5.874  00.170     .    00DBC034 +
        RRL  RX1  0 POS     1.625  00.615     .    014CF4A8 +
        RRL  RX1  1 POS     2.000  00.500     .    013E7ABA  
        RRL  RX1  2 POS     2.125  00.470     .    0139EDFF +
        RRL  RX1  3 POS     2.250  00.444     .    01358217 +
        RRL  RX1 32 POS     5.874  00.170     .    00DBC035 +
        TS   RX1            2.375  00.421     .    0131359A  
        TS   RX2            2.500  00.400     .    012D0744  
        TS   RX3            3.125  00.320     .    0119BB53  
        TBT  RX1            2.125  00.470     .    0139EDFF  
        TBT  RX2            2.250  00.444     .    01358216  
        TBT  RX3            2.750  00.363     .    01250042  
        SBT  RX1            2.625  00.380     .    0128F5DF  
        SBT  RX2            2.750  00.363     .    0125003F  
        SBT  RX3            3.250  00.307     .    01162A5F  
        RBT  RX1            2.625  00.380     .    0128F5E5  
        RBT  RX2            2.750  00.363     .    01250044  
        RBT  RX3            3.250  00.307     .    01162A5E  
        CBT  RX1            2.750  00.363     .    01250040  
        CBT  RX2            2.875  00.347     .    01212551  
        CBT  RX3            3.375  00.296     .    0112B042  
        JF   RX1 M=1,C=2    1.250  00.800     .    015CCF92  
        JF   RX1 M=2,C=2    1.375  00.727     .    01575C4E  
        JF   RX2 M=1,C=2    1.375  00.727     .    01575C4E  
        JF   RX2 M=2,C=2    1.500  00.666     .    01521400  
        JF   RX3 M=1,C=2    2.000  00.500     .    013E7ABB  
        JF   RX3 M=2,C=2    2.125  00.470     .    0139EE01  
        JFR   RR M=1,C=2    1.000  01.000     .    01683F48  
        JFR   RR M=2,C=2    0.625  01.600     .    017AE16F  
        JFBS  SF M=1,C=2    0.875  01.142     .    016E4050  
        JFBS  SF M=2,C=2    0.625  01.600     .    017AE176  
        JFFS  SF M=1,C=2    0.875  01.142     .    016E405A  
        JFFS  SF M=2,C=2    0.625  01.600     .    017AE174  
        JT   RX1 M=2,C=2    1.250  00.800     .    015CCF8A  
        JT   RX1 M=1,C=2    1.375  00.727     .    01575C4B  
        JT   RX2 M=2,C=2    1.375  00.727     .    01575C4D  
        JT   RX2 M=1,C=2    1.500  00.666     .    01521401  
        JT   RX3 M=2,C=2    2.000  00.500     .    013E7ABC  
        JT   RX3 M=1,C=2    2.125  00.470     .    0139EDFB  
        JTR   RR M=2,C=2    1.000  01.000     .    01683F3E  
        JTR   RR M=1,C=2    0.625  01.600     .    017AE16F  
        JTBS  SF M=2,C=2    0.875  01.142     .    016E4053  
        JTBS  SF M=1,C=2    0.625  01.600     .    017AE174  
        JTFS  SF M=2,C=2    0.875  01.142     .    016E4050  
        JTFS  SF M=1,C=2    0.625  01.600     .    017AE16A  
        NOP  RX1            1.375  00.727     .    01575C4A  
        NOP  RX2            1.500  00.666     .    015213FD  
        NOP  RX3            2.125  00.470     .    0139EDFF  
        NOPR  RR            0.625  01.600     .    017AE16D  







        J    RX1            1.250  00.800     .    015CCF84  
        J    RX2            1.375  00.727     .    01575C48  
        J    RX3            2.000  00.500     .    013E7AB6  
        JR    RR            1.000  01.000     .    01683F44  
        JBS   SF            0.875  01.142     .    016E4050  
        JFS   SF            0.875  01.142     .    016E404D  
        JAL  RX1            1.250  00.800     .    015CCF86  
        JAL  RX2            1.375  00.727     .    01575C4C  
        JAL  RX3            2.000  00.500     .    013E7ABE  
        JALR  RR            1.250  00.800     .    015CCF90  
        JFFO  SF ALL  =0    1.250  00.800     .    015CCF89 +
        JFFO  SF BIT 0=1    1.625  00.615     .    014CF4A9 +
        JFFO  SF BIT 1=1    1.625  00.615     .    014CF4AC +
        JFFO  SF BIT 2=1    1.750  00.571     .    0147FC7D +
        JFFO  SF BIT30=1    5.249  00.190     .    00E75110 +
        JFFO  SF BIT31=1    5.374  00.186     .    00E4E836 +
        JFFOH SF ALL  =0    1.250  00.800     .    015CCF8B +
        JFFOH SF BIT 0=1    1.625  00.615     .    014CF4AB +
        JFFOH SF BIT 1=1    1.625  00.615     .    014CF4AE +
        JFFOH SF BIT 2=1    1.750  00.571     .    0147FC7F +
        JFFOH SF BIT14=1    3.250  00.307     .    01162A65 +
        JFFOH SF BIT15=1    3.375  00.296     .    0112B03E +
        A    RX1            2.250  00.444     .    01358213  
        A    RX2            2.375  00.421     .    0131359A  
        A    RX3            2.875  00.347     .    01212550  
        AH   RX1            1.750  00.571     .    0147FC7A  
        AH   RX2            1.875  00.533     .    014329AE  
        AH   RX3            2.375  00.421     .    01313597  
        AHI  RI1            1.125  00.888     .    01626FCC  
        AI   RI2            1.625  00.615     .    014CF4A8  
        AR    RR            0.750  01.333     .    0174757E  
        AIS   SF            0.625  01.600     .    017AE170  
        AM   RX1            3.750  00.266     .    0108C289  
        AM   RX2            3.875  00.258     .    01059BA7  
        AM   RX3            4.375  00.228     .    00F9B77E  
        AHM  RX1            2.500  00.400     .    012D0749  
        AHM  RX2            2.625  00.380     .    0128F5E3  
        AHM  RX3            3.250  00.307     .    01162A5A  
        S    RX1            2.250  00.444     .    0135820F  
        S    RX2            2.375  00.421     .    01313599  
        S    RX3            2.875  00.347     .    01212550  
        SH   RX1            1.750  00.571     .    0147FC7B  
        SH   RX2            1.875  00.533     .    014329AF  
        SH   RX3            2.375  00.421     .    0131359B  
        SHI  RI1            1.125  00.888     .    016270E6  
        SI   RI2            1.625  00.615     .    014CF4CD  
        SR    RR            0.750  01.333     .    017475A6  
        SIS   SF            0.625  01.600     .    017AE19A  







        CL   RX1            2.250  00.444     .    0135827F  
        CL   RX2            2.375  00.421     .    01313606  
        CL   RX3            2.875  00.347     .    0121256C  
        CLH  RX1            1.750  00.571     .    0147FD8B  
        CLH  RX2            1.875  00.533     .    014329D3  
        CLH  RX3            2.375  00.421     .    013135B0  
        CLHI RI1            1.125  00.888     .    01626FE0  
        CLI  RI2            1.625  00.615     .    014CF4BB  
        CLR   RR            0.750  01.333     .    01747591  
        CLB  RX1            1.750  00.571     .    0147FC8C  
        CLB  RX2            1.875  00.533     .    014329C0  
        CLB  RX3            2.500  00.400     .    012D0751  
        C    RX1            2.500  00.400     .    012D0753  
        C    RX2            2.625  00.380     .    0128F5EE  
        C    RX3            3.125  00.320     .    0119BB62  
        CH   RX1            1.875  00.533     .    014329C2  
        CH   RX2            2.000  00.500     .    013E7AC1  
        CH   RX3            2.500  00.400     .    012D0751  
        CHI  RI1            1.375  00.727     .    01575C5D  
        CI   RI2            1.875  00.533     .    014329C4  
        CR    RR            0.875  01.142     .    016E4068  
        M    RX1 0*0       14.623  00.068     .    008143E6 +
        M    RX1 0*FFFF    16.623  00.060     .    00762548 +
        M    RX1 0*-1      18.623  00.053     .    006CC99F +
        M    RX2 0*0       14.748  00.067     .    00808263 +
        M    RX2 0*FFFF    16.748  00.059     .    0075838E +
        M    RX2 0*-1      18.748  00.053     .    006C406F +
        M    RX3 0*0       15.248  00.065     .    007D926A +
        M    RX3 0*FFFF    17.248  00.057     .    00730D85 +
        M    RX3 0*-1      19.248  00.051     .    006A28ED +
        MR    RR 0*0       13.373  00.074     .    00895827 +
        MR    RR 0*FFFF    15.373  00.065     .    007CDBC6 +
        MR    RR 0*-1      17.373  00.057     .    0072741D +
        MH   RX1 0*0        8.374  00.119     .    00B72030 +
        MH   RX1 0*FFFF    10.374  00.096     .    00A194E0 +
        MH   RX2 0*0        8.499  00.117     .    00B59CC3 +
        MH   RX2 0*FFFF    10.499  00.095     .    00A066F3 +
        MH   RX3 0*0        8.999  00.111     .    00AFCCFD +
        MH   RX3 0*FFFF     8.999  00.111     .    00AFCCFA +
        D    RX1  n/0      10.999  00.090     .    009BDA08 +
        D    RX1  0/n      22.748  00.043     .    005D82D3 +
        D    RX1 -1/n      26.622  00.037     .    00529CF6 +
        D    RX2  n/0      11.124  00.089     .    009AC10E +
        D    RX2  0/n      22.873  00.043     .    005D1D62 +
        D    RX2 -1/n      26.747  00.037     .    00524DC0 +
        D    RX3  n/0      11.624  00.086     .    009683AD +
        D    RX3  0/n      23.372  00.042     .    005B901A +
        D    RX3 -1/n      27.246  00.036     .    005116C4 +







        DR    RR  n/0       9.749  00.102     .    00A7BFB1 +
        DR    RR  0/n      21.498  00.046     .    0061AAC5 +
        DR    RR -1/n      25.373  00.039     .    0055D719 +
        DH   RX1  n/0      10.999  00.090     .    009BDA0C +
        DH   RX1  0/n      22.748  00.043     .    005D82D5 +
        DH   RX1 -1/n      24.039  00.041     .    0059928A +
        DH   RX2  n/0      11.124  00.089     .    009AC111 +
        DH   RX2  0/n      22.873  00.043     .    005D1D63 +
        DH   RX2 -1/n      24.164  00.041     .    00593573 +
        DH   RX3  n/0      11.624  00.086     .    009683AD +
        DH   RX3  0/n      23.372  00.042     .    005B901A +
        DH   RX3 -1/n      24.664  00.040     .    0057C887 +
        DHR   RR  n/0       9.749  00.102     .    00A7BFAF +
        DHR   RR  0/n      21.497  00.046     .    0061AAC6 +
        DHR   RR -1/n      25.373  00.039     .    0055D719 +
        SRA  RI1  0 POS     1.625  00.615     .    014CF4BE +
        SRA  RI1  1 POS     2.000  00.500     .    013E7AC8  
        SRA  RI1  2 POS     2.125  00.470     .    0139EE0B +
        SRA  RI1  3 POS     2.250  00.444     .    01358226 +
        SRA  RI1 32 POS     5.874  00.170     .    00DBC040 +
        LHR   RR            1.000  01.000     .    01683F5C  
        LPSW RX1            4.375  00.228     .    00F9B78A  
        LPSW RX2            4.499  00.222     .    00F6E93B  
        LPSW RX3            5.124  00.195     .    00E9C70B  
        UPSW RX1            3.125  00.320     .    0119BB5D  
        UPSW RX2            3.250  00.307     .    01162A6A  
        UPSW RX3            3.875  00.258     .    01059BB4  
        LPSWR RR            1.625  00.615     .    014CF4B0  
        EPSR  RR            1.250  00.800     .    015CCF93  
        SVC  RX1            4.000  00.250     .    00C5F947  
        SVC  RX2            4.125  00.242     .    00C434C6  
        SVC  RX3            4.625  00.216     .    00BD70C0  
        CIO   RR            3.500  00.285     .    010F4C1F  
        SSR   RR            3.375  00.296     .    0112B042  
        SSR   RR T/O        7.624  00.131     .    00C0C38D +
        OC   RX1            4.499  00.222     .    00F6E93D  
        OC   RX1 T/O        8.624  00.115     .    00B41FA8 +
        OC   RX2            4.624  00.216     .    00F42AEB  
        OC   RX2 T/O        8.749  00.114     .    00B2A8BF +
        OC   RX3            5.124  00.195     .    00E9C707  
        OC   RX3 T/O        9.249  00.108     .    00AD083B +
        OCR   RR            2.875  00.347     .    0121255B  
        OCR   RR T/O        6.999  00.142     .    00C99B39 +
        RDR   RR            2.750  00.363     .    0125004C  
        RDR   RR T/O        6.874  00.145     .    00CB7915 +
        WD   RX1            4.375  00.228     .    00F9B785  
        WD   RX1 T/O        8.499  00.117     .    00B59CBD +
        WD   RX2            4.499  00.222     .    00F6E93E  
        WD   RX2 T/O        8.624  00.115     .    00B41FA5 +
        WD   RX3            4.999  00.200     .    00EC4A8B  
        WD   RX3 T/O        9.124  00.109     .    00AE67C9 +
        WDR   RR            2.750  00.363     .    0125004B  
        WDR   RR T/O        6.874  00.145     .    00CB7918 +







        CKSUM RR 16  CHR   11.249  00.088     .    006CC99E +
        CKSUM RR 32  CHR   23.497  00.042     .    00494011 +
        CKSUM RR 64  CHR   47.370  00.021     .    002CC17A +
        CKSUM RR 96  CHR   71.238  00.014     .    002038B6 +
        CKSUM RR 124 CHR  137.356  00.007     .    0012256F +
         
        TOTAL AVERAGE MIPS 00.459
        TOTAL INST TIME  3342.724
        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1        111.124     2.222    24.877      .497
        RX2        104.122     2.366    20.581      .467
        RX3        128.497     2.920    16.042      .364
        RI1         12.375     1.237     8.331      .833
        RI2         14.875     1.652     5.453      .605
        RR          34.000     1.259    29.275     1.084
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        
        







        
                                   TYMNET ENGINE
        
                        MEMORY SYSTEM TIMING - MACIII @ 8 MHZ
        
        
        ENGINE INSTRUCTION SET TIMING - VERSION 1.00
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         4.375    .        .    0273DB72  
        MACHINE RATING      2.750    .      36.36  018186BD  
        L    RX1            1.375  00.727  145.46  01DDB79C  
        L    RX2            1.500  00.666  133.34  01D38DA1  
        L    RX3            1.875  00.533  106.66  01B78001  
        LH   RX1            1.125  00.888   88.89  01F36E8B  
        LH   RX2            1.250  00.800   80.00  01E85550  
        LH   RX3            1.625  00.615   61.54  01C9CFFF  
        LHI  RI1            0.750  01.333     .    0217F9C5  
        LI   RI2            1.000  01.000     .    01FF0C06  
        LR    RR            0.625  01.600     .    0225601E  
        LIS   SF            0.625  01.600     .    0225601A  
        LCS   SF            0.625  01.600     .    0225601B  
        LA   RX1            0.875  01.142     .    020B36FB  
        LA   RX2            1.000  01.000     .    01FF0C06  
        LA   RX3            1.625  00.615     .    01C9D01A  
        LHL  RX1            1.125  00.888   88.89  01F36EA5  
        LHL  RX2            1.250  00.800   80.00  01E85550  
        LHL  RX3            1.625  00.615   61.54  01C9CFFF  
        LM   RX1 REG 0     10.624  00.094  301.12  00B72000 +
        LM   RX2 REG 0     10.749  00.093  297.60  00B59C92 +
        LM   RX3 REG 0     11.374  00.087  281.28  00AE679F +
        LM   RX1 REG 1      9.999  00.100  300.00  00BF1642 +
        LM   RX2 REG 1     10.124  00.098  296.40  00BD708C +
        LM   RX3 REG 1     10.749  00.093  279.00  00B59C91 +
        LM   RX1 REG 8      5.624  00.177  284.48  0112B003 +
        LM   RX2 REG 8      5.749  00.173  278.24  010F4BDC +
        LM   RX3 REG 8      6.374  00.156  251.04  00FF85F4 +
        LM   RX1 REG 15     1.250  00.800  160.00  01E85553  
        LM   RX2 REG 15     1.375  00.727  145.46  01DDB7A7  
        LM   RX3 REG 15     2.000  00.500  100.00  01AEE1E4  
        LB   RX1            1.375  00.727   36.36  01DDB7AA  
        LB   RX2            1.500  00.666   33.33  01D38D9E  
        LB   RX3            2.125  00.470   23.53  01A6989A  
        LBR   RR            0.625  01.600     .    02255FFA  
        EXHR  RR            0.625  01.600     .    0225601E  
        EXBR  RR            0.750  01.333     .    0217F9E3  
        ST   RX1            1.500  00.666  133.34  01D38DBA  
        ST   RX2            1.625  00.615  123.08  01C9D001  
        ST   RX3            2.250  00.444   88.88  019E9F63  
        STH  RX1            1.125  00.888   88.89  01F36E88  
        STH  RX2            1.250  00.800   80.00  01E85556  
        STH  RX3            1.875  00.533   53.33  01B78002  







        STM  RX1 REG 0      8.999  00.111  355.52  00CD5FB4 +
        STM  RX2 REG 0      9.124  00.109  350.72  00CB78E4 +
        STM  RX3 REG 0      9.749  00.102  328.32  00C27810 +
        STM  RX1 REG 1      8.499  00.117  353.10  00D55979 +
        STM  RX2 REG 1      8.624  00.115  348.00  00D34C51 +
        STM  RX3 REG 1      9.249  00.108  324.30  00C99B04 +
        STM  RX1 REG 8      4.999  00.200  320.00  01250003 +
        STM  RX2 REG 8      5.124  00.195  312.32  01212510 +
        STM  RX3 REG 8      5.749  00.173  278.24  010F4BDA +
        STM  RX1 REG 15     1.500  00.666  133.34  01D38DA2  
        STM  RX2 REG 15     1.625  00.615  123.08  01C9D009  
        STM  RX3 REG 15     2.250  00.444   88.88  019E9F6D  
        STB  RX1            1.375  00.727   36.36  01DDB7AE  
        STB  RX2            1.500  00.666   33.33  01D38DA0  
        STB  RX3            2.125  00.470   23.53  01A6989F  
        STBR  RR            0.750  01.333     .    0217F9C8  
        COPY  RR 2   BYT    2.125  00.470   94.12  00F9B757 +
        COPY  RR 16  BYT    9.999  00.100  160.00  009187A4 +
        COPY  RR 32  BYT   18.998  00.052  168.32  00628AE9 +
        COPY  RR 64  BYT   37.995  00.026  168.32  003A999A +
        COPY  RR 128 BYT   75.994  00.013  168.96  00205D20 +
        COPY  RR 256 BYT  151.975  00.006  168.96  00111318 +
        COPY  RR 512 BYT  303.919  00.003  168.96  0008C78B +
        COPY  RR 1024 BY  608.029  00.001  163.84  000473F0 +
        N    RX1            1.375  00.727     .    01DDB7AE  
        N    RX2            1.500  00.666     .    01D38DB8  
        N    RX3            1.875  00.533     .    01B7801B  
        NH   RX1            1.125  00.888     .    01F36EAF  
        NH   RX2            1.250  00.800     .    01E85577  
        NH   RX3            1.625  00.615     .    01C9D020  
        NHI  RI1            0.750  01.333     .    0217F9E2  
        NI   RI2            1.000  01.000     .    01FF0C05  
        NR    RR            0.750  01.333     .    0217F9E4  
        O    RX1            1.375  00.727     .    01DDB7C6  
        O    RX2            1.500  00.666     .    01D38DBD  
        O    RX3            1.875  00.533     .    01B7801A  
        OH   RX1            1.125  00.888     .    01F36EA5  
        OH   RX2            1.250  00.800     .    01E85572  
        OH   RX3            1.625  00.615     .    01C9D01F  
        OHI  RI1            0.750  01.333     .    0217F9E7  
        OI   RI2            1.000  01.000     .    01FF0C0A  
        OR    RR            0.750  01.333     .    0217F9E2  
        X    RX1            1.375  00.727     .    01DDB7C1  
        X    RX2            1.500  00.666     .    01D38DBB  
        X    RX3            1.875  00.533     .    01B7801D  
        XH   RX1            1.125  00.888     .    01F36EAD  
        XH   RX2            1.250  00.800     .    01E85574  
        XH   RX3            1.625  00.615     .    01C9D019  
        XHI  RI1            0.750  01.333     .    0217F9E2  
        XI   RI2            1.000  01.000     .    01FF0C0B  
        XR    RR            0.750  01.333     .    0217F9E6  







        ARAND RR 16/nm      2.500  00.400     .    00F17BD7 +
        ARAND RR 16/B 0     2.875  00.347     .    00E9C6DF +
        ARAND RR 16/B 1     3.000  00.333     .    00E750E7 +
        ARAND RR 16/B 2     3.125  00.320     .    00E4E812 +
        ARAND RR 16/B 7     3.750  00.266     .    00D99315 +
        ARAND RR 16/B 13    4.500  00.222     .    00CD5FC3 +
        ARAND RR 16/B 14    4.624  00.216     .    00CB78F2 +
        ARAND RR 16/B 15    2.125  00.470     .    00F9B755 +
        ARAND RR 32/nm      4.874  00.205     .    00C7C5DF +
        ARAND RR 32/B 0     5.249  00.190     .    00C27821 +
        ARAND RR 32/B 1     5.374  00.186     .    00C0C36C +
        ARAND RR 32/B 2     5.499  00.181     .    00BF1650 +
        ARAND RR 32/B 15    7.124  00.140     .    00ABAE0B +
        ARAND RR 32/B 16    2.875  00.347     .    00E9C6DD +
        ARAND RR 32/B 17    3.000  00.333     .    00E750E8 +
        ARAND RR 32/B 30    4.624  00.216     .    00CB78F3 +
        ARAND RR 32/B 31    4.750  00.210     .    00C99B12 +
        THI  RI1            0.750  01.333     .    0217F9EA  
        TI   RI2            1.000  01.000     .    01FF0C04  
        SLL  RX1  0 POS     1.250  00.800     .    01E85571 +
        SLL  RX1  1 POS     1.500  00.666     .    01D38DC3  
        SLL  RX1  2 POS     1.625  00.615     .    01C9D023 +
        SLL  RX1  3 POS     1.750  00.571     .    01C0784C +
        SLL  RX1 32 POS     5.374  00.186     .    0119BB25 +
        SLLS  SF  0 POS     1.125  00.888     .    01F36EA8 +
        SLLS  SF  1 POS     1.250  00.800     .    01E85575  
        SLLS  SF  2 POS     1.375  00.727     .    01DDB7CB +
        SLLS  SF  3 POS     1.500  00.666     .    01D38DC3 +
        SLLS  SF 15 POS     3.000  00.333     .    01747541 +
        SRL  RX1  0 POS     1.250  00.800     .    01E85574 +
        SRL  RX1  1 POS     1.500  00.666     .    01D38DC0  
        SRL  RX1  2 POS     1.625  00.615     .    01C9D022 +
        SRL  RX1  3 POS     1.750  00.571     .    01C0784D +
        SRL  RX1 32 POS     5.374  00.186     .    0119BB28 +
        SRLS  SF  0 POS     1.125  00.888     .    01F36EAF +
        SRLS  SF  1 POS     1.250  00.800     .    01E85578  
        SRLS  SF  2 POS     1.375  00.727     .    01DDB7CC +
        SRLS  SF  3 POS     1.500  00.666     .    01D38DC3 +
        SLHL RX1  0 POS     1.250  00.800     .    01E8557B +
        SLHL RX1  1 POS     1.750  00.571     .    01C0784D  
        SLHL RX1  2 POS     1.875  00.533     .    01B7801C +
        SLHL RX1  3 POS     2.000  00.500     .    01AEE205 +
        SLHLS SF  0 POS     1.125  00.888     .    01F36EB5 +
        SLHLS SF  1 POS     1.500  00.666     .    01D38DC3  
        SLHLS SF  2 POS     1.625  00.615     .    01C9D01D +
        SLHLS SF  3 POS     1.750  00.571     .    01C07845 +
        SRHL RX1  0 POS     1.250  00.800     .    01E85577 +
        SRHL RX1  1 POS     1.750  00.571     .    01C0784C  
        SRHL RX1  2 POS     1.875  00.533     .    01B7801C +
        SRHL RX1  3 POS     2.000  00.500     .    01AEE1FF +
        SRHLS SF  0 POS     1.125  00.888     .    01F36EA9 +
        SRHLS SF  1 POS     1.500  00.666     .    01D38DBD  
        SRHLS SF  2 POS     1.625  00.615     .    01C9D022 +
        SRHLS SF  3 POS     1.750  00.571     .    01C0784C +







        RLL  RX1  0 POS     1.250  00.800     .    01E85578 +
        RLL  RX1  1 POS     1.500  00.666     .    01D38DBD  
        RLL  RX1  2 POS     1.625  00.615     .    01C9D01E +
        RLL  RX1  3 POS     1.750  00.571     .    01C0784E +
        RLL  RX1 32 POS     5.374  00.186     .    0119BB29 +
        RRL  RX1  0 POS     1.250  00.800     .    01E8557A +
        RRL  RX1  1 POS     1.500  00.666     .    01D38DBC  
        RRL  RX1  2 POS     1.625  00.615     .    01C9D01B +
        RRL  RX1  3 POS     1.750  00.571     .    01C0784C +
        RRL  RX1 32 POS     5.374  00.186     .    0119BB2A +
        TS   RX1            1.250  00.800     .    01E8557A  
        TS   RX2            1.375  00.727     .    01DDB7C5  
        TS   RX3            2.000  00.500     .    01AEE1F8  
        TBT  RX1            1.375  00.727     .    01DDB7C4  
        TBT  RX2            1.500  00.666     .    01D38DBE  
        TBT  RX3            1.875  00.533     .    01B7801D  
        SBT  RX1            1.625  00.615     .    01C9D01E  
        SBT  RX2            1.750  00.571     .    01C07845  
        SBT  RX3            2.125  00.470     .    01A698B9  
        RBT  RX1            1.625  00.615     .    01C9D022  
        RBT  RX2            1.750  00.571     .    01C0784A  
        RBT  RX3            2.125  00.470     .    01A698BA  
        CBT  RX1            1.750  00.571     .    01C07842  
        CBT  RX2            1.875  00.533     .    01B7801A  
        CBT  RX3            2.250  00.444     .    019E9F84  
        JF   RX1 M=1,C=2    1.000  01.000     .    01FF0C0F  
        JF   RX1 M=2,C=2    0.875  01.142     .    020B3702  
        JF   RX2 M=1,C=2    1.125  00.888     .    01F36EAD  
        JF   RX2 M=2,C=2    1.000  01.000     .    01FF0C07  
        JF   RX3 M=1,C=2    1.750  00.571     .    01C07849  
        JF   RX3 M=2,C=2    1.625  00.615     .    01C9D023  
        JFR   RR M=1,C=2    0.750  01.333     .    0217F9E8  
        JFR   RR M=2,C=2    0.375  02.666     .    02424A40  
        JFBS  SF M=1,C=2    0.625  01.600     .    02256021  
        JFBS  SF M=2,C=2    0.375  02.666     .    02424A44  
        JFFS  SF M=1,C=2    0.625  01.600     .    0225602A  
        JFFS  SF M=2,C=2    0.375  02.666     .    02424A49  
        JT   RX1 M=2,C=2    1.000  01.000     .    01FF0C10  
        JT   RX1 M=1,C=2    0.875  01.142     .    020B36F9  
        JT   RX2 M=2,C=2    1.125  00.888     .    01F36EAA  
        JT   RX2 M=1,C=2    1.000  01.000     .    01FF0C0D  
        JT   RX3 M=2,C=2    1.750  00.571     .    01C0784B  
        JT   RX3 M=1,C=2    1.625  00.615     .    01C9D020  
        JTR   RR M=2,C=2    0.750  01.333     .    0217F9E3  
        JTR   RR M=1,C=2    0.375  02.666     .    02424A3B  
        JTBS  SF M=2,C=2    0.625  01.600     .    02256025  
        JTBS  SF M=1,C=2    0.375  02.666     .    02424A49  
        JTFS  SF M=2,C=2    0.625  01.600     .    0225602D  
        JTFS  SF M=1,C=2    0.375  02.666     .    02424A45  
        NOP  RX1            0.875  01.142     .    020B36FD  
        NOP  RX2            1.000  01.000     .    01FF0C0B  
        NOP  RX3            1.625  00.615     .    01C9D022  
        NOPR  RR            0.375  02.666     .    02424A48  







        J    RX1            1.000  01.000     .    01FF0C0D  
        J    RX2            1.125  00.888     .    01F36EA9  
        J    RX3            1.750  00.571     .    01C07846  
        JR    RR            0.750  01.333     .    0217F9E8  
        JBS   SF            0.625  01.600     .    02256028  
        JFS   SF            0.625  01.600     .    0225602B  
        JAL  RX1            1.000  01.000     .    01FF0C0C  
        JAL  RX2            1.125  00.888     .    01F36EAA  
        JAL  RX3            1.750  00.571     .    01C0784A  
        JALR  RR            1.000  01.000     .    01FF0C11  
        JFFO  SF ALL  =0    1.000  01.000     .    01FF0C0F +
        JFFO  SF BIT 0=1    1.625  00.615     .    01C9D024 +
        JFFO  SF BIT 1=1    1.625  00.615     .    01C9D01F +
        JFFO  SF BIT 2=1    1.750  00.571     .    01C0784B +
        JFFO  SF BIT30=1    5.249  00.190     .    011D63D6 +
        JFFO  SF BIT31=1    5.374  00.186     .    0119BB2C +
        JFFOH SF ALL  =0    1.000  01.000     .    01FF0C11 +
        JFFOH SF BIT 0=1    1.625  00.615     .    01C9D01F +
        JFFOH SF BIT 1=1    1.625  00.615     .    01C9D021 +
        JFFOH SF BIT 2=1    1.750  00.571     .    01C0784F +
        JFFOH SF BIT14=1    3.250  00.307     .    01683F11 +
        JFFOH SF BIT15=1    3.375  00.296     .    01626F99 +
        A    RX1            1.375  00.727     .    01DDB7CB  
        A    RX2            1.500  00.666     .    01D38DBB  
        A    RX3            1.875  00.533     .    01B7801F  
        AH   RX1            1.125  00.888     .    01F36EB2  
        AH   RX2            1.250  00.800     .    01E8557A  
        AH   RX3            1.625  00.615     .    01C9D021  
        AHI  RI1            0.750  01.333     .    0217F9E2  
        AI   RI2            1.000  01.000     .    01FF0C0C  
        AR    RR            0.750  01.333     .    0217F9EB  
        AIS   SF            0.625  01.600     .    0225602B  
        AM   RX1            2.250  00.444     .    019E9F87  
        AM   RX2            2.375  00.421     .    0196F1E2  
        AM   RX3            2.750  00.363     .    018186D9  
        AHM  RX1            1.625  00.615     .    01C9D029  
        AHM  RX2            1.750  00.571     .    01C07856  
        AHM  RX3            2.375  00.421     .    0196F1EF  
        S    RX1            1.375  00.727     .    01DDB7CF  
        S    RX2            1.500  00.666     .    01D38DC2  
        S    RX3            1.875  00.533     .    01B78027  
        SH   RX1            1.125  00.888     .    01F36EBC  
        SH   RX2            1.250  00.800     .    01E85585  
        SH   RX3            1.625  00.615     .    01C9D02C  
        SHI  RI1            0.750  01.333     .    0217F9E9  
        SI   RI2            1.000  01.000     .    01FF0C12  
        SR    RR            0.750  01.333     .    0217F9F2  
        SIS   SF            0.625  01.600     .    0225602F  







        CL   RX1            1.375  00.727     .    01DDB7D0  
        CL   RX2            1.500  00.666     .    01D38DC0  
        CL   RX3            1.875  00.533     .    01B78021  
        CLH  RX1            1.125  00.888     .    01F36EB7  
        CLH  RX2            1.250  00.800     .    01E8557F  
        CLH  RX3            1.625  00.615     .    01C9D027  
        CLHI RI1            0.750  01.333     .    0217F9ED  
        CLI  RI2            1.000  01.000     .    01FF0C0B  
        CLR   RR            0.750  01.333     .    0217F9EA  
        CLB  RX1            1.375  00.727     .    01DDB7D0  
        CLB  RX2            1.500  00.666     .    01D38DC4  
        CLB  RX3            2.125  00.470     .    01A698C0  
        C    RX1            1.750  00.571     .    01C07848  
        C    RX2            1.875  00.533     .    01B7801F  
        C    RX3            2.250  00.444     .    019E9F87  
        CH   RX1            1.375  00.727     .    01DDB7D0  
        CH   RX2            1.500  00.666     .    01D38DC5  
        CH   RX3            1.875  00.533     .    01B78024  
        CHI  RI1            1.125  00.888     .    01F36EB2  
        CI   RI2            1.375  00.727     .    01DDB7CF  
        CR    RR            0.875  01.142     .    020B3707  
        M    RX1 0*0       13.623  00.073     .    00989AB7 +
        M    RX1 0*FFFF    15.623  00.064     .    0089580B +
        M    RX1 0*-1      17.623  00.056     .    007CDBAC +
        M    RX2 0*0       13.749  00.072     .    00978D4B +
        M    RX2 0*FFFF    15.748  00.063     .    00887DAB +
        M    RX2 0*-1      17.748  00.056     .    007C2719 +
        M    RX3 0*0       14.123  00.070     .    00947ADD +
        M    RX3 0*FFFF    16.123  00.062     .    0085FE7B +
        M    RX3 0*-1      18.123  00.055     .    007A155E +
        MR    RR 0*0       12.999  00.076     .    009E17FE +
        MR    RR 0*FFFF    14.999  00.066     .    008DC63E +
        MR    RR 0*-1      16.998  00.058     .    0080824A +
        MH   RX1 0*0        7.624  00.131     .    00E4E812 +
        MH   RX1 0*FFFF     9.624  00.103     .    00C434A0 +
        MH   RX2 0*0        7.749  00.129     .    00E28BF1 +
        MH   RX2 0*FFFF     9.749  00.102     .    00C27822 +
        MH   RX3 0*0        8.124  00.123     .    00DBC011 +
        MH   RX3 0*FFFF     8.124  00.123     .    00DBC011 +
        D    RX1  n/0      10.249  00.097     .    00BBD21B +
        D    RX1  0/n      21.997  00.045     .    006825A4 +
        D    RX1 -1/n      25.873  00.038     .    005ACE50 +
        D    RX2  n/0      10.374  00.096     .    00BA3AA5 +
        D    RX2  0/n      22.123  00.045     .    0067A7E3 +
        D    RX2 -1/n      25.998  00.038     .    005A6EA5 +
        D    RX3  n/0      10.749  00.093     .    00B59C9F +
        D    RX3  0/n      22.498  00.044     .    0066359E +
        D    RX3 -1/n      26.372  00.037     .    00595453 +







        DR    RR  n/0       9.624  00.103     .    00C434A4 +
        DR    RR  0/n      21.373  00.046     .    006AACC6 +
        DR    RR -1/n      25.247  00.039     .    005CB8BC +
        DH   RX1  n/0      10.249  00.097     .    00BBD21C +
        DH   RX1  0/n      21.997  00.045     .    006825A6 +
        DH   RX1 -1/n      23.290  00.042     .    006348E9 +
        DH   RX2  n/0      10.374  00.096     .    00BA3AA5 +
        DH   RX2  0/n      22.123  00.045     .    0067A7E3 +
        DH   RX2 -1/n      23.414  00.042     .    0062D696 +
        DH   RX3  n/0      10.749  00.093     .    00B59CA3 +
        DH   RX3  0/n      22.498  00.044     .    006635A1 +
        DH   RX3 -1/n      23.789  00.042     .    006185B9 +
        DHR   RR  n/0       9.624  00.103     .    00C434A8 +
        DHR   RR  0/n      21.373  00.046     .    006AACC7 +
        DHR   RR -1/n      25.247  00.039     .    005CB8BF +
        SRA  RI1  0 POS     1.250  00.800     .    01E85589 +
        SRA  RI1  1 POS     1.500  00.666     .    01D38DD4  
        SRA  RI1  2 POS     1.625  00.615     .    01C9D031 +
        SRA  RI1  3 POS     1.750  00.571     .    01C07857 +
        SRA  RI1 32 POS     5.374  00.186     .    0119BB2F +
        LHR   RR            0.875  01.142     .    020B3715  
        LPSW RX1            3.125  00.320     .    016E4027  
        LPSW RX2            3.250  00.307     .    01683F18  
        LPSW RX3            3.875  00.258     .    014CF47E  
        UPSW RX1            2.125  00.470     .    01A698C2  
        UPSW RX2            2.250  00.444     .    019E9F8E  
        UPSW RX3            2.875  00.347     .    017AE142  
        LPSWR RR            1.375  00.727     .    01DDB7D9  
        EPSR  RR            1.125  00.888     .    01F36EBD  
        SVC  RX1            3.375  00.296     .    010F4BF1  
        SVC  RX2            3.500  00.285     .    010BFCF8  
        SVC  RX3            3.875  00.258     .    010287A0  
        CIO   RR            3.500  00.285     .    015CCF5F  
        SSR   RR            3.125  00.320     .    016E4022  
        SSR   RR T/O        7.374  00.135     .    00E9C6E2 +
        OC   RX1            3.875  00.258     .    014CF47C  
        OC   RX1 T/O        7.999  00.125     .    00DDF853 +
        OC   RX2            4.000  00.250     .    0147FC51  
        OC   RX2 T/O        8.124  00.123     .    00DBC016 +
        OC   RX3            4.375  00.228     .    0139EDD6  
        OC   RX3 T/O        8.499  00.117     .    00D5598B +
        OCR   RR            2.625  00.380     .    0188694B  
        OCR   RR T/O        6.749  00.148     .    00F6E915 +
        RDR   RR            2.500  00.400     .    018F8BCB  
        RDR   RR T/O        6.624  00.150     .    00F9B75C +
        WD   RX1            3.750  00.266     .    015213CE  
        WD   RX1 T/O        7.874  00.127     .    00E03C27 +
        WD   RX2            3.875  00.258     .    014CF47D  
        WD   RX2 T/O        7.999  00.125     .    00DDF853 +
        WD   RX3            4.250  00.235     .    013E7A8E  
        WD   RX3 T/O        8.374  00.119     .    00D77103 +
        WDR   RR            2.500  00.400     .    018F8BC4  
        WDR   RR T/O        6.624  00.150     .    00F9B75C +







        CKSUM RR 16  CHR   10.999  00.090     .    00A7BF93 +
        CKSUM RR 32  CHR   23.248  00.043     .    005FF5FA +
        CKSUM RR 64  CHR   47.119  00.021     .    0034524E +
        CKSUM RR 96  CHR   70.991  00.014     .    0023F736 +
        CKSUM RR 124 CHR  137.116  00.007     .    001346BE +
         
        TOTAL AVERAGE MIPS 00.612
        TOTAL INST TIME  2904.517
        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1         76.000     1.520    37.063      .741
        RX2         72.000     1.636    30.172      .685
        RX3         93.250     2.119    22.230      .505
        RI1          8.625      .862    12.218     1.221
        RI2          9.375     1.041     8.727      .969
        RR          30.750     1.138    34.145     1.264
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        
        







        
                                   TYMNET ENGINE
        
                        MEMORY SYSTEM TIMING - MACIII @ 10 MHZ
        
        
        ENGINE INSTRUCTION SET TIMING - VERSION 1.00
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         3.500    .        .    0310C33A  
        MACHINE RATING      2.200    .      45.45  01E1DF3D  
        L    RX1            1.100  00.909  181.82  02551A46  
        L    RX2            1.200  00.833  166.66  024865CE  
        L    RX3            1.500  00.666  133.34  02255574  
        LH   RX1            0.900  01.111  111.11  02703E36  
        LH   RX2            1.000  01.000  100.00  02625EFA  
        LH   RX3            1.300  00.769   76.92  023C390D  
        LHI  RI1            0.600  01.666     .    029DEB61  
        LI   RI2            0.800  01.250     .    027EC2BA  
        LR    RR            0.500  02.000     .    02AEAAEC  
        LIS   SF            0.500  02.000     .    02AEAAEF  
        LCS   SF            0.500  02.000     .    02AEAAF6  
        LA   RX1            0.700  01.428     .    028DF82D  
        LA   RX2            0.800  01.250     .    027EC2C4  
        LA   RX3            1.300  00.769     .    023C391B  
        LHL  RX1            0.900  01.111  111.11  02703E4C  
        LHL  RX2            1.000  01.000  100.00  02625EF5  
        LHL  RX3            1.300  00.769   76.92  023C3909  
        LM   RX1 REG 0      8.500  00.117  376.32  00E4E39F +
        LM   RX2 REG 0      8.600  00.116  372.16  00E2FF5B +
        LM   RX3 REG 0      9.100  00.109  351.68  00D9FD56 +
        LM   RX1 REG 1      8.000  00.125  375.00  00EED73D +
        LM   RX2 REG 1      8.100  00.123  370.50  00ECC826 +
        LM   RX3 REG 1      8.600  00.116  348.90  00E2FF5B +
        LM   RX1 REG 8      4.500  00.222  355.52  01575570 +
        LM   RX2 REG 8      4.600  00.217  347.84  01531853 +
        LM   RX3 REG 8      5.100  00.196  313.76  013F614F +
        LM   RX1 REG 15     1.000  01.000  200.00  02625EF3  
        LM   RX2 REG 15     1.100  00.909  181.82  02551A1C  
        LM   RX3 REG 15     1.600  00.625  125.00  021A9009  
        LB   RX1            1.100  00.909   45.45  02551A25  
        LB   RX2            1.200  00.833   41.66  024865D1  
        LB   RX3            1.700  00.588   29.41  0210349E  
        LBR   RR            0.500  02.000     .    02AEAACE  
        EXHR  RR            0.500  02.000     .    02AEAAF0  
        EXBR  RR            0.600  01.666     .    029DEB77  
        ST   RX1            1.200  00.833  166.66  024865F0  
        ST   RX2            1.300  00.769  153.84  023C3907  
        ST   RX3            1.800  00.555  111.12  02063D49  
        STH  RX1            0.900  01.111  111.11  02703E31  
        STH  RX2            1.000  01.000  100.00  02625EF5  
        STH  RX3            1.500  00.666   66.67  0225557A  







        STM  RX1 REG 0      7.200  00.138  444.48  0100B2B7 +
        STM  RX2 REG 0      7.300  00.136  438.40  00FE523C +
        STM  RX3 REG 0      7.800  00.128  410.24  00F3116B +
        STM  RX1 REG 1      6.800  00.147  441.30  010AAAB9 +
        STM  RX2 REG 1      6.900  00.144  434.70  01081A52 +
        STM  RX3 REG 1      7.400  00.135  405.30  00FBFCF0 +
        STM  RX1 REG 8      4.000  00.250  400.00  016E38FE +
        STM  RX2 REG 8      4.100  00.243  390.24  01696761 +
        STM  RX3 REG 8      4.600  00.217  347.84  0153184E +
        STM  RX1 REG 15     1.200  00.833  166.66  024865D0  
        STM  RX2 REG 15     1.300  00.769  153.84  023C3908  
        STM  RX3 REG 15     1.800  00.555  111.12  02063D53  
        STB  RX1            1.100  00.909   45.45  02551A22  
        STB  RX2            1.200  00.833   41.66  024865C9  
        STB  RX3            1.700  00.588   29.41  0210349D  
        STBR  RR            0.600  01.666     .    029DEB56  
        COPY  RR 2   BYT    1.700  00.588  117.64  01381F28 +
        COPY  RR 16  BYT    8.000  00.125  200.00  00B5E60F +
        COPY  RR 32  BYT   15.200  00.065  210.56  007B2B45 +
        COPY  RR 64  BYT   30.398  00.032  210.56  00493E97 +
        COPY  RR 128 BYT   60.798  00.016  209.92  002873A1 +
        COPY  RR 256 BYT  121.600  00.008  209.92  00155775 +
        COPY  RR 512 BYT  243.213  00.004  209.92  000AF937 +
        COPY  RR 1024 BY  486.484  00.002  215.04  000590D1 +
        N    RX1            1.100  00.909     .    02551A1A  
        N    RX2            1.200  00.833     .    024865E2  
        N    RX3            1.500  00.666     .    0225558C  
        NH   RX1            0.900  01.111     .    02703E52  
        NH   RX2            1.000  01.000     .    02625F16  
        NH   RX3            1.300  00.769     .    023C3921  
        NHI  RI1            0.600  01.666     .    029DEB6D  
        NI   RI2            0.800  01.250     .    027EC2B6  
        NR    RR            0.600  01.666     .    029DEB74  
        O    RX1            1.100  00.909     .    02551A37  
        O    RX2            1.200  00.833     .    024865EE  
        O    RX3            1.500  00.666     .    02255589  
        OH   RX1            0.900  01.111     .    02703E47  
        OH   RX2            1.000  01.000     .    02625F0C  
        OH   RX3            1.300  00.769     .    023C391E  
        OHI  RI1            0.600  01.666     .    029DEB78  
        OI   RI2            0.800  01.250     .    027EC2BC  
        OR    RR            0.600  01.666     .    029DEB69  
        X    RX1            1.100  00.909     .    02551A2E  
        X    RX2            1.200  00.833     .    024865E7  
        X    RX3            1.500  00.666     .    0225558F  
        XH   RX1            0.900  01.111     .    02703E55  
        XH   RX2            1.000  01.000     .    02625F09  
        XH   RX3            1.300  00.769     .    023C3917  
        XHI  RI1            0.600  01.666     .    029DEB73  
        XI   RI2            0.800  01.250     .    027EC2BD  
        XR    RR            0.600  01.666     .    029DEB78  







        ARAND RR 16/nm      2.000  00.500     .    012DD4FA +
        ARAND RR 16/B 0     2.300  00.434     .    012432F0 +
        ARAND RR 16/B 1     2.400  00.416     .    01211F8D +
        ARAND RR 16/B 2     2.500  00.400     .    011E1C90 +
        ARAND RR 16/B 7     3.000  00.333     .    010FF299 +
        ARAND RR 16/B 13    3.600  00.277     .    0100B2BF +
        ARAND RR 16/B 14    3.700  00.270     .    00FE5243 +
        ARAND RR 16/B 15    1.700  00.588     .    01381F26 +
        ARAND RR 32/nm      3.900  00.256     .    00F9B287 +
        ARAND RR 32/B 0     4.200  00.238     .    00F31179 +
        ARAND RR 32/B 1     4.300  00.232     .    00F0EFA2 +
        ARAND RR 32/B 2     4.400  00.227     .    00EED745 +
        ARAND RR 32/B 15    5.700  00.175     .    00D69569 +
        ARAND RR 32/B 16    2.300  00.434     .    012432F5 +
        ARAND RR 32/B 17    2.400  00.416     .    01211F91 +
        ARAND RR 32/B 30    3.700  00.270     .    00FE524A +
        ARAND RR 32/B 31    3.800  00.263     .    00FBFCF5 +
        THI  RI1            0.600  01.666     .    029DEB6C  
        TI   RI2            0.800  01.250     .    027EC2B4  
        SLL  RX1  0 POS     1.000  01.000     .    02625F0D +
        SLL  RX1  1 POS     1.200  00.833     .    024865F0  
        SLL  RX1  2 POS     1.300  00.769     .    023C3921 +
        SLL  RX1  3 POS     1.400  00.714     .    02308B85 +
        SLL  RX1 32 POS     4.300  00.232     .    01602323 +
        SLLS  SF  0 POS     0.900  01.111     .    02703E4E +
        SLLS  SF  1 POS     1.000  01.000     .    02625F13  
        SLLS  SF  2 POS     1.100  00.909     .    02551A3F +
        SLLS  SF  3 POS     1.200  00.833     .    024865E7 +
        SLLS  SF 15 POS     2.400  00.416     .    01D18991 +
        SRL  RX1  0 POS     1.000  01.000     .    02625F09 +
        SRL  RX1  1 POS     1.200  00.833     .    024865E7  
        SRL  RX1  2 POS     1.300  00.769     .    023C391D +
        SRL  RX1  3 POS     1.400  00.714     .    02308B90 +
        SRL  RX1 32 POS     4.300  00.232     .    01602323 +
        SRLS  SF  0 POS     0.900  01.111     .    02703E47 +
        SRLS  SF  1 POS     1.000  01.000     .    02625F0F  
        SRLS  SF  2 POS     1.100  00.909     .    02551A38 +
        SRLS  SF  3 POS     1.200  00.833     .    024865F3 +
        SLHL RX1  0 POS     1.000  01.000     .    02625F0F +
        SLHL RX1  1 POS     1.400  00.714     .    02308B83  
        SLHL RX1  2 POS     1.500  00.666     .    02255586 +
        SLHL RX1  3 POS     1.600  00.625     .    021A901D +
        SLHLS SF  0 POS     0.900  01.111     .    02703E56 +
        SLHLS SF  1 POS     1.200  00.833     .    024865F0  
        SLHLS SF  2 POS     1.300  00.769     .    023C3916 +
        SLHLS SF  3 POS     1.400  00.714     .    02308B84 +
        SRHL RX1  0 POS     1.000  01.000     .    02625F0E +
        SRHL RX1  1 POS     1.400  00.714     .    02308B90  
        SRHL RX1  2 POS     1.500  00.666     .    02255596 +
        SRHL RX1  3 POS     1.600  00.625     .    021A901D +
        SRHLS SF  0 POS     0.900  01.111     .    02703E48 +
        SRHLS SF  1 POS     1.200  00.833     .    024865E5  
        SRHLS SF  2 POS     1.300  00.769     .    023C391E +
        SRHLS SF  3 POS     1.400  00.714     .    02308B93 +







        RLL  RX1  0 POS     1.000  01.000     .    02625F17 +
        RLL  RX1  1 POS     1.200  00.833     .    024865E2  
        RLL  RX1  2 POS     1.300  00.769     .    023C3916 +
        RLL  RX1  3 POS     1.400  00.714     .    02308B8C +
        RLL  RX1 32 POS     4.300  00.232     .    01602329 +
        RRL  RX1  0 POS     1.000  01.000     .    02625F19 +
        RRL  RX1  1 POS     1.200  00.833     .    024865E4  
        RRL  RX1  2 POS     1.300  00.769     .    023C3913 +
        RRL  RX1  3 POS     1.400  00.714     .    02308B88 +
        RRL  RX1 32 POS     4.300  00.232     .    01602327 +
        TS   RX1            1.000  01.000     .    02625F19  
        TS   RX2            1.100  00.909     .    02551A35  
        TS   RX3            1.600  00.625     .    021A9013  
        TBT  RX1            1.100  00.909     .    02551A2D  
        TBT  RX2            1.200  00.833     .    024865E6  
        TBT  RX3            1.500  00.666     .    02255591  
        SBT  RX1            1.300  00.769     .    023C3924  
        SBT  RX2            1.400  00.714     .    02308B83  
        SBT  RX3            1.700  00.588     .    021034B0  
        RBT  RX1            1.300  00.769     .    023C391A  
        RBT  RX2            1.400  00.714     .    02308B8C  
        RBT  RX3            1.700  00.588     .    021034C0  
        CBT  RX1            1.400  00.714     .    02308B8A  
        CBT  RX2            1.500  00.666     .    02255584  
        CBT  RX3            1.800  00.555     .    02063D5E  
        JF   RX1 M=1,C=2    0.800  01.250     .    027EC2BA  
        JF   RX1 M=2,C=2    0.700  01.428     .    028DF827  
        JF   RX2 M=1,C=2    0.900  01.111     .    02703E52  
        JF   RX2 M=2,C=2    0.800  01.250     .    027EC2B1  
        JF   RX3 M=1,C=2    1.400  00.714     .    02308B82  
        JF   RX3 M=2,C=2    1.300  00.769     .    023C391A  
        JFR   RR M=1,C=2    0.600  01.666     .    029DEB77  
        JFR   RR M=2,C=2    0.300  03.333     .    02D2CEEB  
        JFBS  SF M=1,C=2    0.500  02.000     .    02AEAAE9  
        JFBS  SF M=2,C=2    0.300  03.333     .    02D2CED5  
        JFFS  SF M=1,C=2    0.500  02.000     .    02AEAAEA  
        JFFS  SF M=2,C=2    0.300  03.333     .    02D2CEE2  
        JT   RX1 M=2,C=2    0.800  01.250     .    027EC2C2  
        JT   RX1 M=1,C=2    0.700  01.428     .    028DF824  
        JT   RX2 M=2,C=2    0.900  01.111     .    02703E43  
        JT   RX2 M=1,C=2    0.800  01.250     .    027EC2B2  
        JT   RX3 M=2,C=2    1.400  00.714     .    02308B87  
        JT   RX3 M=1,C=2    1.300  00.769     .    023C3920  
        JTR   RR M=2,C=2    0.600  01.666     .    029DEB7D  
        JTR   RR M=1,C=2    0.300  03.333     .    02D2CEDB  
        JTBS  SF M=2,C=2    0.500  02.000     .    02AEAAE3  
        JTBS  SF M=1,C=2    0.300  03.333     .    02D2CEDB  
        JTFS  SF M=2,C=2    0.500  02.000     .    02AEAAF0  
        JTFS  SF M=1,C=2    0.300  03.333     .    02D2CEEB  
        NOP  RX1            0.700  01.428     .    028DF824  
        NOP  RX2            0.800  01.250     .    027EC2B1  
        NOP  RX3            1.300  00.769     .    023C3916  
        NOPR  RR            0.300  03.333     .    02D2CEE1  







        J    RX1            0.800  01.250     .    027EC2BF  
        J    RX2            0.900  01.111     .    02703E54  
        J    RX3            1.400  00.714     .    02308B83  
        JR    RR            0.600  01.666     .    029DEB69  
        JBS   SF            0.500  02.000     .    02AEAAEA  
        JFS   SF            0.500  02.000     .    02AEAAF2  
        JAL  RX1            0.800  01.250     .    027EC2C5  
        JAL  RX2            0.900  01.111     .    02703E4B  
        JAL  RX3            1.400  00.714     .    02308B81  
        JALR  RR            0.800  01.250     .    027EC2B4  
        JFFO  SF ALL  =0    0.800  01.250     .    027EC2B9 +
        JFFO  SF BIT 0=1    1.300  00.769     .    023C3925 +
        JFFO  SF BIT 1=1    1.300  00.769     .    023C3923 +
        JFFO  SF BIT 2=1    1.400  00.714     .    02308B84 +
        JFFO  SF BIT30=1    4.200  00.238     .    0164B5E0 +
        JFFO  SF BIT31=1    4.300  00.232     .    01602325 +
        JFFOH SF ALL  =0    0.800  01.250     .    027EC2C1 +
        JFFOH SF BIT 0=1    1.300  00.769     .    023C3927 +
        JFFOH SF BIT 1=1    1.300  00.769     .    023C391B +
        JFFOH SF BIT 2=1    1.400  00.714     .    02308B82 +
        JFFOH SF BIT14=1    2.600  00.384     .    01C2461C +
        JFFOH SF BIT15=1    2.700  00.370     .    01BB02ED +
        A    RX1            1.100  00.909     .    02551A3B  
        A    RX2            1.200  00.833     .    024865EA  
        A    RX3            1.500  00.666     .    02255583  
        AH   RX1            0.900  01.111     .    02703E44  
        AH   RX2            1.000  01.000     .    02625F0A  
        AH   RX3            1.300  00.769     .    023C391F  
        AHI  RI1            0.600  01.666     .    029DEB7A  
        AI   RI2            0.800  01.250     .    027EC2B3  
        AR    RR            0.600  01.666     .    029DEB66  
        AIS   SF            0.500  02.000     .    02AEAAE8  
        AM   RX1            1.800  00.555     .    02063D62  
        AM   RX2            1.900  00.526     .    01FCA491  
        AM   RX3            2.200  00.454     .    01E1DF3F  
        AHM  RX1            1.300  00.769     .    023C3912  
        AHM  RX2            1.400  00.714     .    02308B82  
        AHM  RX3            1.900  00.526     .    01FCA48A  
        S    RX1            1.100  00.909     .    02551A38  
        S    RX2            1.200  00.833     .    024865EC  
        S    RX3            1.500  00.666     .    02255584  
        SH   RX1            0.900  01.111     .    02703E43  
        SH   RX2            1.000  01.000     .    02625F09  
        SH   RX3            1.300  00.769     .    023C391E  
        SHI  RI1            0.600  01.666     .    029DEB7B  
        SI   RI2            0.800  01.250     .    027EC2B6  
        SR    RR            0.600  01.666     .    029DEB65  
        SIS   SF            0.500  02.000     .    02AEAAE5  







        CL   RX1            1.100  00.909     .    02551A33  
        CL   RX2            1.200  00.833     .    024865EA  
        CL   RX3            1.500  00.666     .    0225558D  
        CLH  RX1            0.900  01.111     .    02703E41  
        CLH  RX2            1.000  01.000     .    02625F02  
        CLH  RX3            1.300  00.769     .    023C3917  
        CLHI RI1            0.600  01.666     .    029DEB71  
        CLI  RI2            0.800  01.250     .    027EC2BE  
        CLR   RR            0.600  01.666     .    029DEB69  
        CLB  RX1            1.100  00.909     .    02551A26  
        CLB  RX2            1.200  00.833     .    024865DF  
        CLB  RX3            1.700  00.588     .    021034B5  
        C    RX1            1.400  00.714     .    02308B8D  
        C    RX2            1.500  00.666     .    0225558A  
        C    RX3            1.800  00.555     .    02063D57  
        CH   RX1            1.100  00.909     .    02551A2A  
        CH   RX2            1.200  00.833     .    024865E2  
        CH   RX3            1.500  00.666     .    0225558D  
        CHI  RI1            0.900  01.111     .    02703E52  
        CI   RI2            1.100  00.909     .    02551A29  
        CR    RR            0.700  01.428     .    028DF812  
        M    RX1 0*0       10.900  00.091     .    00BEBDB1 +
        M    RX1 0*FFFF    12.500  00.080     .    00ABAABB +
        M    RX1 0*-1      14.100  00.070     .    009C0F95 +
        M    RX2 0*0       11.000  00.090     .    00BD6CF0 +
        M    RX2 0*FFFF    12.600  00.079     .    00AA99C2 +
        M    RX2 0*-1      14.200  00.070     .    009B2DDB +
        M    RX3 0*0       11.300  00.088     .    00B995FB +
        M    RX3 0*FFFF    12.899  00.077     .    00A77ADE +
        M    RX3 0*-1      14.500  00.068     .    009897C3 +
        MR    RR 0*0       10.400  00.096     .    00C59A27 +
        MR    RR 0*FFFF    12.000  00.083     .    00B1345C +
        MR    RR 0*-1      13.600  00.073     .    00A09FBF +
        MH   RX1 0*0        6.100  00.163     .    011E1C90 +
        MH   RX1 0*FFFF     7.700  00.129     .    00F53D0F +
        MH   RX2 0*0        6.200  00.161     .    011B2971 +
        MH   RX2 0*FFFF     7.800  00.128     .    00F31172 +
        MH   RX3 0*0        6.500  00.153     .    0112AAC4 +
        MH   RX3 0*FFFF     6.500  00.153     .    0112AAC7 +
        D    RX1  n/0       8.200  00.121     .    00EAC21C +
        D    RX1  0/n      17.599  00.056     .    00822C88 +
        D    RX1 -1/n      20.699  00.048     .    00717FAF +
        D    RX2  n/0       8.300  00.120     .    00E8C4C8 +
        D    RX2  0/n      17.700  00.056     .    00818F58 +
        D    RX2 -1/n      20.799  00.048     .    00710820 +
        D    RX3  n/0       8.600  00.116     .    00E2FF62 +
        D    RX3  0/n      17.999  00.055     .    007FC089 +
        D    RX3 -1/n      21.099  00.047     .    006FA73C +







        DR    RR  n/0       7.700  00.129     .    00F53D0B +
        DR    RR  0/n      17.100  00.058     .    00855563 +
        DR    RR -1/n      20.200  00.049     .    0073E4B0 +
        DH   RX1  n/0       8.200  00.121     .    00EAC215 +
        DH   RX1  0/n      17.599  00.056     .    00822C87 +
        DH   RX1 -1/n      18.633  00.053     .    007C18B8 +
        DH   RX2  n/0       8.300  00.120     .    00E8C4C9 +
        DH   RX2  0/n      17.700  00.056     .    00818F5A +
        DH   RX2 -1/n      18.733  00.053     .    007B89D6 +
        DH   RX3  n/0       8.600  00.116     .    00E2FF5C +
        DH   RX3  0/n      17.999  00.055     .    007FC08A +
        DH   RX3 -1/n      19.033  00.052     .    0079E4C7 +
        DHR   RR  n/0       7.700  00.129     .    00F53D0D +
        DHR   RR  0/n      17.100  00.058     .    00855564 +
        DHR   RR -1/n      20.200  00.049     .    0073E4AD +
        SRA  RI1  0 POS     1.000  01.000     .    02625F03 +
        SRA  RI1  1 POS     1.200  00.833     .    024865E5  
        SRA  RI1  2 POS     1.300  00.769     .    023C391D +
        SRA  RI1  3 POS     1.400  00.714     .    02308B91 +
        SRA  RI1 32 POS     4.300  00.232     .    01602323 +
        LHR   RR            0.700  01.428     .    028DF817  
        LPSW RX1            2.500  00.400     .    01C9C744  
        LPSW RX2            2.600  00.384     .    01C2461E  
        LPSW RX3            3.100  00.322     .    01A0298C  
        UPSW RX1            1.700  00.588     .    021034B8  
        UPSW RX2            1.800  00.555     .    02063D58  
        UPSW RX3            2.300  00.434     .    01D99057  
        LPSWR RR            1.100  00.909     .    02551A31  
        EPSR  RR            0.900  01.111     .    02703E50  
        SVC  RX1            2.700  00.370     .    0153185F  
        SVC  RX2            2.800  00.357     .    014EF5B4  
        SVC  RX3            3.100  00.322     .    0143233C  
        CIO   RR            2.800  00.357     .    01B3FABC  
        SSR   RR            2.500  00.400     .    01C9C749  
        SSR   RR T/O        5.900  00.169     .    012432F6 +
        OC   RX1            3.100  00.322     .    01A02989  
        OC   RX1 T/O        6.400  00.156     .    01157100 +
        OC   RX2            3.200  00.312     .    0199F368  
        OC   RX2 T/O        6.500  00.153     .    0112AAC4 +
        OC   RX3            3.500  00.285     .    018861B0  
        OC   RX3 T/O        6.800  00.147     .    010AAAC6 +
        OCR   RR            2.100  00.476     .    01EA7A11  
        OCR   RR T/O        5.400  00.185     .    01349D57 +
        RDR   RR            2.000  00.500     .    01F36509  
        RDR   RR T/O        5.300  00.188     .    01381F27 +
        WD   RX1            3.000  00.333     .    01A69099  
        WD   RX1 T/O        6.300  00.158     .    011845C1 +
        WD   RX2            3.100  00.322     .    01A02982  
        WD   RX2 T/O        6.400  00.156     .    01157102 +
        WD   RX3            3.400  00.294     .    018E1178  
        WD   RX3 T/O        6.700  00.149     .    010D480F +
        WDR   RR            2.000  00.500     .    01F3650C  
        WDR   RR T/O        5.300  00.188     .    01381F20 +







        CKSUM RR 16  CHR    8.800  00.113     .    00D1AB63 +
        CKSUM RR 32  CHR   18.599  00.053     .    0077F123 +
        CKSUM RR 64  CHR   37.699  00.026     .    0041659D +
        CKSUM RR 96  CHR   56.799  00.017     .    002CF425 +
        CKSUM RR 124 CHR  109.699  00.009     .    001817F6 +
         
        TOTAL AVERAGE MIPS 00.766
        TOTAL INST TIME  2323.880
        
        
        
        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1         60.800     1.216    46.348      .926
        RX2         57.600     1.309    37.726      .857
        RX3         74.600     1.695    27.791      .631
        RI1          6.900      .690    15.272     1.527
        RI2          7.500      .833    10.909     1.212
        RR          24.600      .911    42.684     1.580
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        
        







        
                                   TYMNET ENGINE
                
                        MEMORY SYSTEM TIMING - CPUIII @ 12 MHZ
                
                
        
        
        ENGINE INSTRUCTION SET TIMING - VERSION 1.01
        INSTRUCTION SAMPLE RATE =  180 SECONDS
        
        FUNCTION         -TIMING-  -MIPS-  -JPPU-  RAW DATA
        
        LOOP TIMING         2.917    .        .    03ADB843  
        MACHINE RATING      1.833    .      54.56  02423FD6  
        L    RX1            0.917  01.090  218.10  02CC86B4  
        L    RX2            1.000  01.000  200.00  02BD47D1  
        L    RX3            1.250  00.800  160.00  0293342E  
        LH   RX1            0.750  01.333  133.33  02ED1862  
        LH   RX2            0.833  01.200  120.05  02DC72DD  
        LH   RX3            1.083  00.923   92.34  02AEABB0  
        LHI  RI1            0.500  02.000     .    0323E82A  
        LI   RI2            0.667  01.499     .    02FE842D  
        LR    RR            0.417  02.398     .    03380155  
        LIS   SF            0.417  02.398     .    03380157  
        LCS   SF            0.417  02.398     .    03380157  
        LA   RX1            0.583  01.715     .    0310C454  
        LA   RX2            0.667  01.499     .    02FE8436  
        LA   RX3            1.083  00.923     .    02AEABBD  
        LHL  RX1            0.750  01.333  133.33  02ED1876  
        LHL  RX2            0.833  01.200  120.05  02DC72DE  
        LHL  RX3            1.083  00.923   92.34  02AEABAE  
        LM   RX1 REG 0      7.083  00.141  451.84  0112AB12 +
        LM   RX2 REG 0      7.166  00.139  446.40  011065F6 +
        LM   RX3 REG 0      7.583  00.131  422.08  010596BA +
        LM   RX1 REG 1      6.666  00.150  450.00  011E9C3D +
        LM   RX2 REG 1      6.750  00.148  444.30  011C23BC +
        LM   RX3 REG 1      7.166  00.139  418.50  011065F6 +
        LM   RX1 REG 8      3.750  00.266  426.72  019C009E +
        LM   RX2 REG 8      3.833  00.260  417.44  0196EA7D +
        LM   RX3 REG 8      4.250  00.235  376.48  017F420E +
        LM   RX1 REG 15     0.833  01.200  240.10  02DC72D6  
        LM   RX2 REG 15     0.917  01.090  218.10  02CC869D  
        LM   RX3 REG 15     1.333  00.750  150.04  0286473E  
        LB   RX1            0.917  01.090   54.52  02CC86A2  
        LB   RX2            1.000  01.000   50.00  02BD47D7  
        LB   RX3            1.417  00.705   35.28  0279D98E  
        LBR   RR            0.417  02.398     .    03380130  
        EXHR  RR            0.417  02.398     .    0338014D  
        EXBR  RR            0.500  02.000     .    0323E855  
        ST   RX1            1.000  01.000  200.00  02BD47F5  
        ST   RX2            1.083  00.923  184.68  02AEABB0  
        ST   RX3            1.500  00.666  133.34  026DE3F1  
        STH  RX1            0.750  01.333  133.33  02ED1864  
        STH  RX2            0.833  01.200  120.05  02DC72D3  
        STH  RX3            1.250  00.800   80.00  02933429  







        STM  RX1 REG 0      6.000  00.166  533.44  01340A08 +
        STM  RX2 REG 0      6.083  00.164  526.08  01312FDD +
        STM  RX3 REG 0      6.500  00.153  492.16  0123AEE1 +
        STM  RX1 REG 1      5.666  00.176  529.50  0140007A +
        STM  RX2 REG 1      5.750  00.173  521.70  013CECC4 +
        STM  RX3 REG 1      6.166  00.162  486.60  012E6314 +
        STM  RX1 REG 8      3.333  00.300  480.00  01B77822 +
        STM  RX2 REG 8      3.417  00.292  468.32  01B1AFD1 +
        STM  RX3 REG 8      3.833  00.260  417.44  0196EA7C +
        STM  RX1 REG 15     1.000  01.000  200.00  02BD47DC  
        STM  RX2 REG 15     1.083  00.923  184.68  02AEABAF  
        STM  RX3 REG 15     1.500  00.666  133.34  026DE3E7  
        STB  RX1            0.917  01.090   54.52  02CC869E  
        STB  RX2            1.000  01.000   50.00  02BD47DE  
        STB  RX3            1.417  00.705   35.28  0279D98F  
        STBR  RR            0.500  02.000     .    0323E838  
        COPY  RR 2   BYT    1.417  00.705  141.14  01768C3F +
        COPY  RR 16  BYT    6.666  00.150  240.00  00DA4787 +
        COPY  RR 32  BYT   12.666  00.078  252.80  0093CDB3 +
        COPY  RR 64  BYT   25.333  00.039  252.80  0057E4D3 +
        COPY  RR 128 BYT   50.664  00.019  252.16  00308AD1 +
        COPY  RR 256 BYT  101.334  00.009  253.44  00199C2F +
        COPY  RR 512 BYT  202.678  00.004  250.88  000D2B14 +
        COPY  RR 1024 BY  405.268  00.002  256.00  0006ADCA +
        N    RX1            0.917  01.090     .    02CC8699  
        N    RX2            1.000  01.000     .    02BD47F0  
        N    RX3            1.250  00.800     .    0293344B  
        NH   RX1            0.750  01.333     .    02ED1880  
        NH   RX2            0.833  01.200     .    02DC72F8  
        NH   RX3            1.083  00.923     .    02AEABCB  
        NHI  RI1            0.500  02.000     .    0323E84F  
        NI   RI2            0.667  01.499     .    02FE8430  
        NR    RR            0.500  02.000     .    0323E856  
        O    RX1            0.917  01.090     .    02CC86BF  
        O    RX2            1.000  01.000     .    02BD47F4  
        O    RX3            1.250  00.800     .    02933448  
        OH   RX1            0.750  01.333     .    02ED187E  
        OH   RX2            0.833  01.200     .    02DC72ED  
        OH   RX3            1.083  00.923     .    02AEABC6  
        OHI  RI1            0.500  02.000     .    0323E85C  
        OI   RI2            0.667  01.499     .    02FE843C  
        OR    RR            0.500  02.000     .    0323E856  
        X    RX1            0.917  01.090     .    02CC86BE  
        X    RX2            1.000  01.000     .    02BD47EE  
        X    RX3            1.250  00.800     .    0293343E  
        XH   RX1            0.750  01.333     .    02ED1882  
        XH   RX2            0.833  01.200     .    02DC7300  
        XH   RX3            1.083  00.923     .    02AEABCA  
        XHI  RI1            0.500  02.000     .    0323E857  
        XI   RI2            0.667  01.499     .    02FE843A  
        XR    RR            0.500  02.000     .    0323E84A  







        ARAND RR 16/nm      1.667  00.599     .    016A3339 +
        ARAND RR 16/B 0     1.917  00.521     .    015EA3FE +
        ARAND RR 16/B 1     2.000  00.500     .    015AF319 +
        ARAND RR 16/B 2     2.083  00.480     .    015755E6 +
        ARAND RR 16/B 7     2.500  00.400     .    014656B8 +
        ARAND RR 16/B 13    3.000  00.333     .    01340A11 +
        ARAND RR 16/B 14    3.083  00.324     .    01312FE6 +
        ARAND RR 16/B 15    3.167  00.315     .    012E6325 +
        ARAND RR 32/nm      3.250  00.307     .    012BA36A +
        ARAND RR 32/B 0     3.500  00.285     .    0123AEED +
        ARAND RR 32/B 1     3.583  00.279     .    01211FEA +
        ARAND RR 32/B 2     3.666  00.272     .    011E9C4D +
        ARAND RR 32/B 15    4.750  00.210     .    01018069 +
        ARAND RR 32/B 16    1.917  00.521     .    015EA3F9 +
        ARAND RR 32/B 17    2.000  00.500     .    015AF31B +
        ARAND RR 32/B 30    3.083  00.324     .    01312FEA +
        ARAND RR 32/B 31    3.167  00.315     .    012E6324 +
        THI  RI1            0.500  02.000     .    0323E85B  
        TI   RI2            0.667  01.499     .    02FE8433  
        SLL  RX1  0 POS     0.833  01.200     .    02DC72F2 +
        SLL  RX1  1 POS     1.000  01.000     .    02BD47FB  
        SLL  RX1  2 POS     1.083  00.923     .    02AEABCF +
        SLL  RX1  3 POS     1.167  00.856     .    02A0A84B +
        SLL  RX1 32 POS     3.583  00.279     .    01A6911B +
        SLLS  SF  0 POS     0.750  01.333     .    02ED1883 +
        SLLS  SF  1 POS     0.833  01.200     .    02DC72F4  
        SLLS  SF  2 POS     0.917  01.090     .    02CC86BA +
        SLLS  SF  3 POS     1.000  01.000     .    02BD47FE +
        SLLS  SF 15 POS     2.000  00.500     .    022EA5CF +
        SRL  RX1  0 POS     0.833  01.200     .    02DC72FE +
        SRL  RX1  1 POS     1.000  01.000     .    02BD47F9  
        SRL  RX1  2 POS     1.083  00.923     .    02AEABC4 +
        SRL  RX1  3 POS     1.167  00.856     .    02A0A844 +
        SRL  RX1 32 POS     3.583  00.279     .    01A6911E +
        SRLS  SF  0 POS     0.750  01.333     .    02ED1887 +
        SRLS  SF  1 POS     0.833  01.200     .    02DC72FD  
        SRLS  SF  2 POS     0.917  01.090     .    02CC86BF +
        SRLS  SF  3 POS     1.000  01.000     .    02BD47F2 +
        SLHL RX1  0 POS     0.833  01.200     .    02DC72F5 +
        SLHL RX1  1 POS     1.167  00.856     .    02A0A850  
        SLHL RX1  2 POS     1.250  00.800     .    0293344D +
        SLHL RX1  3 POS     1.333  00.750     .    02864759 +
        SLHLS SF  0 POS     0.750  01.333     .    02ED1883 +
        SLHLS SF  1 POS     1.000  01.000     .    02BD47F8  
        SLHLS SF  2 POS     1.083  00.923     .    02AEABC2 +
        SLHLS SF  3 POS     1.167  00.856     .    02A0A84B +
        SRHL RX1  0 POS     0.833  01.200     .    02DC7306 +
        SRHL RX1  1 POS     1.167  00.856     .    02A0A84F  
        SRHL RX1  2 POS     1.250  00.800     .    02933448 +
        SRHL RX1  3 POS     1.333  00.750     .    02864759 +
        SRHLS SF  0 POS     0.750  01.333     .    02ED187E +
        SRHLS SF  1 POS     1.000  01.000     .    02BD47EF  
        SRHLS SF  2 POS     1.083  00.923     .    02AEABD1 +
        SRHLS SF  3 POS     1.167  00.856     .    02A0A853 +







        RLL  RX1  0 POS     0.833  01.200     .    02DC72FF +
        RLL  RX1  1 POS     1.000  01.000     .    02BD47F9  
        RLL  RX1  2 POS     1.083  00.923     .    02AEABCA +
        RLL  RX1  3 POS     1.167  00.856     .    02A0A842 +
        RLL  RX1 32 POS     3.583  00.279     .    01A6911C +
        RRL  RX1  0 POS     0.833  01.200     .    02DC7306 +
        RRL  RX1  1 POS     1.000  01.000     .    02BD47FB  
        RRL  RX1  2 POS     1.083  00.923     .    02AEABCB +
        RRL  RX1  3 POS     1.167  00.856     .    02A0A84C +
        RRL  RX1 32 POS     3.583  00.279     .    01A69118 +
        TS   RX1            0.833  01.200     .    02DC72F8  
        TS   RX2            0.917  01.090     .    02CC86C5  
        TS   RX3            1.333  00.750     .    02864759  
        TBT  RX1            0.917  01.090     .    02CC86BE  
        TBT  RX2            1.000  01.000     .    02BD47F6  
        TBT  RX3            1.250  00.800     .    02933444  
        SBT  RX1            1.083  00.923     .    02AEABC2  
        SBT  RX2            1.167  00.856     .    02A0A84B  
        SBT  RX3            1.417  00.705     .    0279D9AB  
        RBT  RX1            1.083  00.923     .    02AEABCB  
        RBT  RX2            1.167  00.856     .    02A0A847  
        RBT  RX3            1.417  00.705     .    0279D9A7  
        CBT  RX1            1.167  00.856     .    02A0A841  
        CBT  RX2            1.250  00.800     .    02933448  
        CBT  RX3            1.500  00.666     .    026DE411  
        JF   RX1 M=1,C=2    0.667  01.499     .    02FE843F  
        JF   RX1 M=2,C=2    0.583  01.715     .    0310C458  
        JF   RX2 M=1,C=2    0.750  01.333     .    02ED1882  
        JF   RX2 M=2,C=2    0.667  01.499     .    02FE8432  
        JF   RX3 M=1,C=2    1.167  00.856     .    02A0A847  
        JF   RX3 M=2,C=2    1.083  00.923     .    02AEABD3  
        JFR   RR M=1,C=2    0.500  02.000     .    0323E85A  
        JFR   RR M=2,C=2    0.250  04.000     .    03635FBD  
        JFBS  SF M=1,C=2    0.417  02.398     .    0338015A  
        JFBS  SF M=2,C=2    0.250  04.000     .    03635FBA  
        JFFS  SF M=1,C=2    0.417  02.398     .    03380152  
        JFFS  SF M=2,C=2    0.250  04.000     .    03635FC5  
        JT   RX1 M=2,C=2    0.667  01.499     .    02FE8442  
        JT   RX1 M=1,C=2    0.583  01.715     .    0310C458  
        JT   RX2 M=2,C=2    0.750  01.333     .    02ED1882  
        JT   RX2 M=1,C=2    0.667  01.499     .    02FE8438  
        JT   RX3 M=2,C=2    1.167  00.856     .    02A0A843  
        JT   RX3 M=1,C=2    1.083  00.923     .    02AEABD1  
        JTR   RR M=2,C=2    0.500  02.000     .    0323E85E  
        JTR   RR M=1,C=2    0.250  04.000     .    03635FBF  
        JTBS  SF M=2,C=2    0.417  02.398     .    0338015A  
        JTBS  SF M=1,C=2    0.250  04.000     .    03635FBE  
        JTFS  SF M=2,C=2    0.417  02.398     .    03380150  
        JTFS  SF M=1,C=2    0.250  04.000     .    03635FC0  
        NOP  RX1            0.583  01.715     .    0310C45D  
        NOP  RX2            0.667  01.499     .    02FE843D  
        NOP  RX3            1.083  00.923     .    02AEABCD  
        NOPR  RR            0.250  04.000     .    03635FBB  







        J    RX1            0.667  01.499     .    02FE8431  
        J    RX2            0.750  01.333     .    02ED1882  
        J    RX3            1.167  00.856     .    02A0A850  
        JR    RR            0.500  02.000     .    0323E85A  
        JBS   SF            0.417  02.398     .    0338015A  
        JFS   SF            0.417  02.398     .    0338015C  
        JAL  RX1            0.667  01.499     .    02FE8433  
        JAL  RX2            0.750  01.333     .    02ED187D  
        JAL  RX3            1.167  00.856     .    02A0A851  
        JALR  RR            0.667  01.499     .    02FE8441  
        JFFO  SF ALL  =0    0.667  01.499     .    02FE843C +
        JFFO  SF BIT 0=1    1.083  00.923     .    02AEABCF +
        JFFO  SF BIT 1=1    1.083  00.923     .    02AEABCB +
        JFFO  SF BIT 2=1    1.167  00.856     .    02A0A842 +
        JFFO  SF BIT30=1    3.500  00.285     .    01AC0E03 +
        JFFO  SF BIT31=1    3.583  00.279     .    01A6911F +
        JFFOH SF ALL  =0    0.667  01.499     .    02FE8441 +
        JFFOH SF BIT 0=1    1.083  00.923     .    02AEABCF +
        JFFOH SF BIT 1=1    1.083  00.923     .    02AEABCD +
        JFFOH SF BIT 2=1    1.167  00.856     .    02A0A843 +
        JFFOH SF BIT14=1    2.167  00.461     .    021C54D1 +
        JFFOH SF BIT15=1    2.250  00.444     .    02139DCE +
        A    RX1            0.917  01.090     .    02CC86C3  
        A    RX2            1.000  01.000     .    02BD47F7  
        A    RX3            1.250  00.800     .    02933449  
        AH   RX1            0.750  01.333     .    02ED187E  
        AH   RX2            0.833  01.200     .    02DC72F3  
        AH   RX3            1.083  00.923     .    02AEABCF  
        AHI  RI1            0.500  02.000     .    0323E85D  
        AI   RI2            0.667  01.499     .    02FE843E  
        AR    RR            0.500  02.000     .    0323E859  
        AIS   SF            0.417  02.398     .    03380158  
        AM   RX1            1.500  00.666     .    026DE403  
        AM   RX2            1.583  00.631     .    02625FD3  
        AM   RX3            1.833  00.545     .    02423FD9  
        AHM  RX1            1.083  00.923     .    02AEABCD  
        AHM  RX2            1.167  00.856     .    02A0A84A  
        AHM  RX3            1.583  00.631     .    02625FD2  
        S    RX1            0.917  01.090     .    02CC86B6  
        S    RX2            1.000  01.000     .    02BD47F1  
        S    RX3            1.250  00.800     .    0293344F  
        SH   RX1            0.750  01.333     .    02ED1884  
        SH   RX2            0.833  01.200     .    02DC72FC  
        SH   RX3            1.083  00.923     .    02AEABCD  
        SHI  RI1            0.500  02.000     .    0323E853  
        SI   RI2            0.667  01.499     .    02FE8433  
        SR    RR            0.500  02.000     .    0323E85E  
        SIS   SF            0.417  02.398     .    03380162  







        CL   RX1            0.917  01.090     .    02CC86C1  
        CL   RX2            1.000  01.000     .    02BD47F6  
        CL   RX3            1.250  00.800     .    02933447  
        CLH  RX1            0.750  01.333     .    02ED1877  
        CLH  RX2            0.833  01.200     .    02DC72FB  
        CLH  RX3            1.083  00.923     .    02AEABD4  
        CLHI RI1            0.500  02.000     .    0323E85C  
        CLI  RI2            0.667  01.499     .    02FE843E  
        CLR   RR            0.500  02.000     .    0323E859  
        CLB  RX1            0.917  01.090     .    02CC86BA  
        CLB  RX2            1.000  01.000     .    02BD47EE  
        CLB  RX3            1.417  00.705     .    0279D9AC  
        C    RX1            1.167  00.856     .    02A0A851  
        C    RX2            1.250  00.800     .    0293344A  
        C    RX3            1.500  00.666     .    026DE40B  
        CH   RX1            0.917  01.090     .    02CC86BC  
        CH   RX2            1.000  01.000     .    02BD47EC  
        CH   RX3            1.250  00.800     .    02933449  
        CHI  RI1            0.750  01.333     .    02ED1889  
        CI   RI2            0.917  01.090     .    02CC86BF  
        CR    RR            0.583  01.715     .    0310C456  
        M    RX1 0*0        9.083  00.110     .    00E4E3EF +
        M    RX1 0*FFFF    10.416  00.096     .    00CE0055 +
        M    RX1 0*-1      11.750  00.085     .    00BB461F +
        M    RX2 0*0        9.166  00.109     .    00E34FD5 +
        M    RX2 0*FFFF    10.500  00.095     .    00CCB8CA +
        M    RX2 0*-1      11.833  00.084     .    00BA3745 +
        M    RX3 0*0        9.416  00.106     .    00DEB443 +
        M    RX3 0*FFFF    10.750  00.093     .    00C8FA15 +
        M    RX3 0*-1      12.083  00.082     .    00B71CBD +
        MR    RR 0*0        8.666  00.115     .    00ED1FB6 +
        MR    RR 0*FFFF    10.000  00.100     .    00D4A585 +
        MR    RR 0*-1      11.333  00.088     .    00C0BFF2 +
        MH   RX1 0*0        5.083  00.196     .    015755E6 +
        MH   RX1 0*FFFF     6.416  00.155     .    012649A2 +
        MH   RX2 0*0        5.166  00.193     .    0153CBC4 +
        MH   RX2 0*FFFF     6.500  00.153     .    0123AEEC +
        MH   RX3 0*0        5.416  00.184     .    01499A2A +
        MH   RX3 0*FFFF     5.416  00.184     .    01499A27 +
        D    RX1  n/0       6.833  00.146     .    0119B613 +
        D    RX1  0/n      14.666  00.068     .    009C35A5 +
        D    RX1 -1/n      17.249  00.057     .    00883301 +
        D    RX2  n/0       6.916  00.144     .    011752E3 +
        D    RX2  0/n      14.749  00.067     .    009B7904 +
        D    RX2 -1/n      17.333  00.057     .    0087A386 +
        D    RX3  n/0       7.166  00.139     .    01106602 +
        D    RX3  0/n      14.999  00.066     .    00994DA6 +
        D    RX3 -1/n      17.583  00.056     .    0085FC10 +







        DR    RR  n/0       6.416  00.155     .    0126499D +
        DR    RR  0/n      14.249  00.070     .    00A00043 +
        DR    RR -1/n      16.833  00.059     .    008B129A +
        DH   RX1  n/0       6.833  00.146     .    0119B614 +
        DH   RX1  0/n      14.666  00.068     .    009C35A5 +
        DH   RX1 -1/n      15.527  00.064     .    0094EAA8 +
        DH   RX2  n/0       6.916  00.144     .    011752E5 +
        DH   RX2  0/n      14.749  00.067     .    009B7901 +
        DH   RX2 -1/n      15.611  00.064     .    00943F31 +
        DH   RX3  n/0       7.166  00.139     .    01106603 +
        DH   RX3  0/n      14.999  00.066     .    00994DA7 +
        DH   RX3 -1/n      15.861  00.063     .    009245EC +
        DHR   RR  n/0       6.416  00.155     .    012649A0 +
        DHR   RR  0/n      14.249  00.070     .    00A00042 +
        DHR   RR -1/n      16.833  00.059     .    008B1297 +
        SRA  RI1  0 POS     0.833  01.200     .    02DC7306 +
        SRA  RI1  1 POS     1.000  01.000     .    02BD47FF  
        SRA  RI1  2 POS     1.083  00.923     .    02AEABCC +
        SRA  RI1  3 POS     1.167  00.856     .    02A0A84E +
        SRA  RI1 32 POS     3.583  00.279     .    01A6911A +
        LHR   RR            0.583  01.715     .    0310C455  
        LPSW RX1            2.083  00.480     .    02255644  
        LPSW RX2            2.167  00.461     .    021C54DC  
        LPSW RX3            2.583  00.387     .    01F365AD  
        UPSW RX1            1.417  00.705     .    0279D9A9  
        UPSW RX2            1.500  00.666     .    026DE40D  
        UPSW RX3            1.917  00.521     .    02384789  
        LPSWR RR            0.917  01.090     .    02CC86BB  
        EPSR  RR            0.750  01.333     .    02ED188C  
        SVC  RX1            2.250  00.444     .    0196EA90  
        SVC  RX2            2.333  00.428     .    0191F42D  
        SVC  RX3            2.583  00.387     .    0183C467  
        CIO   RR            2.333  00.428     .    020B2D8D  
        SSR   RR            2.083  00.480     .    02255635  
        SSR   RR T/O        4.917  00.203     .    015EA3FC +
        OC   RX1            2.750  00.363     .    01E4B58A  
        OC   RX1 T/O        5.333  00.187     .    014CEE74 +
        OC   RX2            2.833  00.352     .    01DDAF2C  
        OC   RX2 T/O        5.416  00.184     .    01499A25 +
        OC   RX3            3.083  00.324     .    01C9C7DD  
        OC   RX3 T/O        5.666  00.176     .    01400083 +
        OCR   RR            1.750  00.571     .    024C9349  
        OCR   RR T/O        4.500  00.222     .    017256EC +
        RDR   RR            1.833  00.545     .    02423FD8  
        RDR   RR T/O        4.416  00.226     .    01768C41 +
        WD   RX1            2.667  00.374     .    01EBF18A  
        WD   RX1 T/O        5.250  00.190     .    01505421 +
        WD   RX2            2.750  00.363     .    01E4B582  
        WD   RX2 T/O        5.333  00.187     .    014CEE77 +
        WD   RX3            3.000  00.333     .    01D03A7A  
        WD   RX3 T/O        5.583  00.179     .    014323AC +
        WDR   RR            1.833  00.545     .    02423FD8  
        WDR   RR T/O        4.416  00.226     .    01768C3F +







        CKSUM RR 16  CHR    7.333  00.136     .    00CF4C02 +
        CKSUM RR 32  CHR   15.500  00.064     .    00803FF7 +
        CKSUM RR 64  CHR   31.415  00.031     .    00499269 +
        CKSUM RR 96  CHR   47.332  00.021     .    003394B7 +
        CKSUM RR 124 CHR   91.417  00.010     .    001C3828 +
         
        TOTAL AVERAGE MIPS 00.917
        TOTAL INST TIME  1939.493



        







                    SELECTED TIMING STATISTICS
        INST TYPE TOTAL     AVERAGE   TOTAL     AVERAGE
                  TIME      TIME      MIPS      MIPS
        
        RX1         51.004     1.020    55.558     1.111
        RX2         48.332     1.098    45.223     1.027
        RX3         62.497     1.420    33.317      .757
        RI1          5.750      .575    18.333     1.833
        RI2          6.253      .694    13.082     1.453
        RR          20.833      .771    51.115     1.893
        
        (+)       INSTRUCTIONS EXCLUDED FROM SUMMARY
        
        
   E.fxÿ