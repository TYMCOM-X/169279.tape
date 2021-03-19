:     Begin of DSC file                                                     :
         If NDISC+NTAPE+MSCDSK                                              :
:                                                                           :
:        ISIS System Configuration Constraints                              :
:        .....................................                              :
MXGLU    eq   1B                                                            :
:
:        Tape Unit Assignments
:        .....................
         Sgu.Def(10,MT,0)                  :Magnetic Tape drive 0
: 
:        Disc Unit 0 - Removable Platter Assignments
:        ...........................................
         Sgu.Def(01,DK,0,0000,0056)        :Core memory Image Save Area 
         Sgu.Def(02,DK,0,0056,0030)        :Supervisor Save Area 
         Sgu.Def(03,DK,0,0086,0100)        :Accounting Data Save Area
         Sgu.Def(04,DK,0,0186,0003)        :Host Msg Save Area
         Sgu.Def(05,DK,0,0189,0005)      :Utility (Slave) Save Area
         Sgu.Def(06,DK,0,018E,0005)        :Supervisor history area
         Sgu.Def(07,DK,0,0000,0156)        :MUD copy (Rem) - Utility Only
:                                          :
:        Disc Unit 1 - Fixed Platter Assignments 
:        .......................................
         Sgu.Def(08,DK,1,0000,0156)        :MUD 
         Sgu.Def(09,DK,1,0156,0020)        :Probe Error Log
         Sgu.Def(0A,DK,1,0176,0006)        :MUD change area
         Sgu.Def(0B,DK,1,017C,000D)        :Class & Group Definitions
:                                          :
:        Disc Space Assignments - Utility Use Only
:        .........................................
         Sgu.Def(14,DK,0,0000,0193)        :User Space   - 1st Rem.  Disk
         Sgu.Def(15,DK,1,0000,0193)        :User Space   - 1st Fixed Disk
         Sgu.Def(16,DK,0,0000,0198)        :Format Space - 1st Rem.  Disk
         Sgu.Def(17,DK,1,0000,0198)        :Format Space - 1st Fixed Disk
:                                          
:        Slot 0 - Node Code                     
:        ..................     
Nxlu0    eq   0                            :No. of extended logical units
:                                          :slot 0
:        Slot 1 - Netval                   :
:        .................                 :
Nxlu1    eq   4                            :
         Sgu.Ref(1,0,10,SS+RD+WR+AT)       :Magnetic Tape Drive 0
         Sgu.Ref(1,2,08,SS+RD+WR)          :MUD
         Sgu.Ref(1,3,0A,SS+RD+WR)          :MUD Change Area
:                                          :
:        Slot 2 - Spare Slot               :Spare Slot
:        ...................               :
Nxlu2    Eq   0                            :Slot 2
:                                          :
:        Slot Q - Supervisor [Slot Nslot +1]
:        ...................................
Q        eq   NSlot+1                    :
         RA   $A 10                        :
Nxlu|Q|  eq   8                            :No. of extended logical units
         Sgu.Ref(Q,0,08,RD)                :MUD
         Sgu.Ref(Q,1,03,SS+RD+WR)          :Accounting data
         Sgu.Ref(Q,2,02,SS+RD+WR)          :Supervisor save area
         Sgu.Ref(Q,3,0B,RD)                :Class & Group table save area
         Sgu.Ref(Q,5,09,SS+RD+WR)          :Probe Errorlog save area
         Sgu.Ref(Q,6,04,RD)                :Host Msg save area
         Sgu.Ref(Q,7,06,SS+RD+WR)          :Supervisor histroy
:                                          :
Q        eq   Q+1                          :
:        Probe (Slot - NSlot + 2)          :
:        ........................          :
         RA   $A 10                        :
Nxlu|Q|  eq   7                            :
         Sgu.Ref(Q,1,03,SS+RD+WR)          :Accounting data
         Sgu.Ref(Q,4,05,SS+RD+WR)          :Utility save area
         Sgu.Ref(Q,5,09,SS+RD+WR)          :Error Log save area
         Sgu.Ref(Q,6,04,SS+RD+WR)          :Host Msg save area
:                                          :
Q        eq   Q+1                          :
:        Errlog (Slot - NSlot + 3)         :
:        .........................         :
         RA   $A 10                        :
Nxlu|Q|  eq   6                            :
         Sgu.Ref(Q,4,05,SS+RD+WR)          :Utility save area
         Sgu.Ref(Q,5,09,SS+RD+WR)          :Error Log save area
:                                          :
Q        eq   Q+1                          :
:        Account (Slot - NSlot + 4)        :
:        ..........................        :
         RA   $A 10                        :
Nxlu|Q|  eq   5                            :
         RA   0                            : 
         Sgu.Ref(Q,1,03,SS+RD+WR)          :Accounting data
         Sgu.Ref(Q,4,05,SS+RD+WR)          :Utility save area
:                                          :
Q        eq   Q+1                          :
:        Sysmsg1 (Slot - NSlot + 5)        :
:        ..........................        :
         RA   $A 10                        :
Nxlu|Q|  eq   8                            :
         RA   0                            :
         Sgu.Ref(Q,4,05,SS+RD+WR)          :Utility save area
         Sgu.Ref(Q,6,04,SS+RD+WR)          :Host Msg area    
         Sgu.Ref(Q,7,0B,SS+RD+WR)          :Class & Group Definition area
:                                          :
Q        eq   Q+1                          :
:        UN2                               :
:        ...                               :
         RA   $A 10                        :
Nxlu|Q|  eq   5                            :
         RA   0                            :
         Sgu.Ref(Q,0,08,SS+RD+WR)          :MUD
         Sgu.Ref(Q,4,05,SS+RD+WR)          :Utility save area
:                                          :
Q        eq   Q+1                          :
:        Utility                           :
:        .......                           :
         RA   $A 10                        :
Nxlu|Q|  eq   $A 16                        :
         RA   0                            :
         Sgu.Ref(Q,00,08,SS+RD+WR+AT)      :MUD/CUD
         Sgu.Ref(Q,01,03,SS+RD+WR+AT)      :Accounting data save area
         Sgu.Ref(Q,02,02,SS+RD+WR+AT)      :Supervisor Save area
         Sgu.Ref(Q,03,0B,SS+RD+WR+AT)      :Class and Group Def. area
         Sgu.Ref(Q,04,05,SS+RD+WR+AT)      :Utility save area
         Sgu.Ref(Q,05,09,SS+RD+WR+AT)      :Probe Error Log 
         Sgu.Ref(Q,06,04,SS+RD+WR+AT)      :Host Msg area
         Sgu.Ref(Q,07,06,SS+RD+WR+AT)      :Supervisor history save area
         Sgu.Ref(Q,08,14,SS+RD+WR+AT)      :DK0 - Format space - Removable
         Sgu.Ref(Q,09,15,SS+RD+WR+AT)      :DK1 - Format space - Fixed
         Sgu.Ref(Q,10,10,RD+WR+AT)         :MT0 - Magnetic Tape 0
         Sgu.Ref(Q,11,01,SS+RD+WR+AT)      :Utility Slot Save Area
         Sgu.Ref(Q,12,07,SS+RD+WR+AT)      :MUD copy to removable platter
:                                          :
:        .................................................................
:
         EI   (NDISC+NTAPE+MSCDSK)
:
:    End of DSC file   
  
   
         