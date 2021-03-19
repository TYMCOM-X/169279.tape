
  To:	Don Johnson

From:	Tim Kochmann

Date:	29-Aug-88

Subj:	August Status Report
----------------------------------------------------------------
	****		T.C.KOCHMANN		****
----------------------------------------------------------------

 1.	Accepted responsibilites as HTS unit level manager.

 2.	Scheduled group resources for Field support, NTD
	support, Marketing support, product demonstrations
	product documentation, direct customer support
	and on-going product "debug" evaluation.

 3.	Interviewed candidates for open RFPs in HTS unit.

 4.	Debugged failing upgraded Tymnet projects software
	and hardware.

 5.	Provided training and code for CSC manufacturing
	in Irvine for Tymnet engine system testing.

 6.	Provided training and code for CSC pilot engineering
	PICO engine.

 7.	Provided cable design for specific EPA sio-async
	to custom bridge interconnect.

 8.	Duplicated and presented NTD with isolated PICO
	async bug discovered at ANZ and verified resolution.

 9.	Upgraded and debugged 5 additional PICO engines
	for ANZ and shipped out.

10.	Completed thermal testing on individual PICO
	engine.

11.	Duplicated Emulated sync failure reported by EPA
	and Morgan Bank and passed ISIS patch provided by
	Paul Krumviede to STS ISIS support and NTD for
	evaluation/deployment.

12.	Worked with ISIS group to prepare version 10.01 to
	replace both versions 8.00/9.00 for release.

13.	Evaluated Telerate proposal of PICO application and
	began load testing under customer configuration.

14.	Scheduled classes for HTS group members for Sept
	through Dec 1988.

15.	Modified versions of Ed Mooring's SLSIO exercisor
	for NTD PICO efforts.

16.	Debugged 5 unique ANZ PICO related problems
	remotely with Melbourne office.

17.	Provided CSC staging PICO training and application
	testing guidelines.

18.	Support for SYMS Spirit/TSI proposal including
	TSI slot exercisor, TSI configuration guidelines
	and network configuration.

19.	Provided documentation with redlines to the PICO
	maint. manual, PICO specifications document and XL
	engine documents.

20.	Brought up network lines and worked with Pat Manley
	to test boot on OCL Micro IV on sync/sio/ocl lines.

21.	Traveled to Irvine twice for direct CSC support.

22.	Cross trained group members on PICO to broaden base
	of support.

23.	Investigating implementation of current MERLIN version
	4.00 for split-sup and tsi support under CMF.

24.	General support/training for PICO Beta sites and demos.

25.	The usual array of trouble calls, customer support CCB
	support, ...
     
----------------------------------------------------------------
	****		JIM STEIN		****
----------------------------------------------------------------

     
1.  5 DMA BACKPLANE:  NEW BACKPLANE ARRIVED LATE (8-11-88).  ALL FIVE DMA
    SLOTS TESTED COMPLETELY WITH WORST CASE PATTERN.  FOUR SIO MOTHERBOARDS
    EXERCISED SIMULTANEOUSLY ALONG WITH SLASYNC.  ALL DMA SLOTS TESTED WITH
    ASYNC AND AND SYNC SIMULTANEOUSLY ALONG WITH SLSIO.  TWO ASYNC BOARDS
    RUNNING SLASYNC TESTED IN ALL DMA SLOTS WHILE SLSYNC AND SLSIO WERE RUN.  
    SUPERVISOR CODE RUN SIMULTANEOUSLY WITH RAM HEAVILY ACCESSING BOTH DISK
    AND TAPE.  NO PROBLEMS OR ERRORS WERE ENCOUNTERED.  THE NEW 5 DMA ETCH 
    IS READY FOR SIGNOFF AND RELEASE.   
     
2.  SOUTHWEST BELL ISSUES:  RESEARCHED AND PREPARED ANSWERS TO NINE QUALITY
    ISSUES RAISED BY SWBELL.  RESULTS WERE SENT TO SUE HEISLER IN MEMO FORM.
     
3.  CPU3 SUP MICROCODE:  TESTED NEW CPU3 MICRO CODE PROMS WITH PUBLIC NET  
    ROUTING ALGORITHM.  NO PROBLEMS ENCOUNTERED RUNNING AS ACTIVE SUP IN   
    NTS NET.   
     
4.  PICO ENGINE:  STARTED LEARNING THIS EQUIPMENT FOR SUPPORT TO FIELD.    
     
5.  BANK OF AMERICA SUP 2 PROBLEM:  WORKED WITH LARRY IVERSON ON THIS 
    PROBLEM AND FOUND THAT PARTWAY THROUGH A "CONSISTENCY RUN" THE HEADS   
    ON THE DISK DRIVE WOULD UNLOAD DUE TO THE 10 MB AMPEX DRIVE SEEKING    
    BEYOND THE LEGAL TRACK LIMIT.  OLD SUP CODE DID NOT DO THIS.  PLAN IS  
    TO BRING UP SUP 2 TOMORROW IN THE NTS LAB AND PERFORM A CONSISTENCY    
    WITH THE NEW CODE.   
     
6.  SUBMITTED E.A.R. ON ERRONEOUS FRONT CONSOLE READINGS WITH SOME CPU3'S  
    RUNNING 10 MHZ. 
     
7.  PROCESSING LATEST GROUP OF E.C.O.'S INTO F.C.O.'S. 
     
8.  ASSISTING V.A. PROJECT PERSONNEL IN PROCESSING NUMEROUS SCDR'S TO GET  
    THE GDC MODEMS INSTALLED IN PLACE OF AT&T MODEMS.  
     
9.  PROCESSED NUMEROUS RFI'S AND FIELD REQUESTS FOR ASSISTANCE.  
     
     
----------------------------------------------------------------
	****		S.A.ECKEL		****
----------------------------------------------------------------

1.  TURBO ENGINE:
   _____________

   Participated in getting the NTS lab prepared for Turbo QA. This involved
reconfiguring the lab for a Turbo/Network interface as well as spotting the
Turbo hardware. We still need 2 phase power for the full Turbo. The test beds
are up and being used for QA at this time.
   Also got validated on the ANTARES system so I can start learning UNIX as 
well as C programing.
______________________________________________________________________________

2.  DSIO VERSION# 15 PROMS:
   _______________________

   Looks like this one is on permanent hold. Or,...at least until the Turbo
starts to fly with some sort of reliability. Have'nt heard a peep from build-
ing 'B' one way or another.
______________________________________________________________________________

3.  ONTYME HUNG SECESSION REPORTS:
   ______________________________

                                                                Page  2

   Had a total of 5 hung secession reports sent to me from the ONTYME group.
All 5 involved the ONTYME system. Could not find a network related problem.
The 5 reports were sent back to ONTYME with the results. Looks like it's ea-
sier for use to trace problems through the network than for themto trap the
problem if it origionates in ONTYME itself.
______________________________________________________________________________

4.  NETWATCH:
   _________

   Still waiting for TYMNET to decide wether or not to implement this unit
on the public net rotaries. After working with August on this unit, I would
highly recommend it on the hi volume rotaries as well as a floating unit to
test chronic rotaries. It would be nice to know if it's yes or no.
______________________________________________________________________________

5.  CRONIC 19.2 LINK PROBLEMS:
    __________________________

   We are still waiting for the below list;

1. A complete list of all 19.2 links currently in the network with locations,.
   etc.

2. A list of the most chronic links so we can assign priorities as to what
   links get addressed first.

3. A IBM compatible program that will monitor the 19.2 links currently in the
   net useing XRAY for use as a monitoring/diagnostic tool.

   According to Stan Mandy from NETQC has the information and was waiting for
us to pick it up. If I knew that I would have gone over there myself. We may 
also be experimenting with a MCI data link to see if our problems decrease.
Network Engineering will check it out and get back to us.
______________________________________________________________________________

6. LAB WORK:
   _________

  We need a full Engine back in the lab to test and maintaine the network per-
iferals and a area set aside in the node room for same. Dave Hussey has decid-
ed to let us put together some periferal test cabinets useing periferals from
both our labs to use on a shared basis. In return we'll provide assistance and
sometimes labor on the maintanence of same. I now will need some time to acco-
mplish this task.

  Got the NTS line printer back up and working by useing parts from a printer
that Dave Hussey had laying around. Am in the process of identifying the parts
needed to get Daves printer back in operating condition and will turn it out
to FSC to get same. We still need new switches for our printer. Will include
that in the order to FSC.

  Hopefully, the power for the full Turbo will installed soon. At that time
power to the SUN system will be brought down. We will be moveing the terminals
connected to same to the back wall freing up some space for a periferal suppo-
rt area. Then we can start going through the periferals in the NTS as well as
NETQC labs.
______________________________________________________________________________
                                                                Page  3


7. THE USUAL TICKETS AND ESCALATIONS AND HORROR SHOWS.
   ___________________________________________________

   DIALOG was the chronic one for the month. RAM/tape drive problems. Correct-
ed by backing off to older code and replaceing the worn out tension arm drives
which,..hopefully,...will be upgraded to vacume collum drives by summer's end.

   THE FIELD IS STILL EXPERIENCING SPARES RELIABILITY PROBLEMS. Especially in
the romote sites were FSC management refuses to let the FEs' responsible for
same to have a lab machine. I've sent a memo to you as well as Don J. documen-
ting this latest comedy of errors from Lousianna. Maybe we can throw our supp-
ort behind the FEs' on this one. There are supposedly quit a few machines sit-
ting in the Zanker warehouse that are just DYING to LIVE again. A little admi-
nistrative jiggery pokery would get them out in the field were they would be 
of EXTREME BENIFIT. This should be brought up to FSC management by our manage-
ment. What do ya say guys????
_______________________________________________________________________________

8. ROTARY TESTING/EVALUATION:
   __________________________

   We are in somewhat of a dilemma reguarding remote testing of the public net
rotaries. With the exception of RV's acceptance testor, which is a modified 
version of Bob Rauscher's rotary test program, we really have to way of easily
testing rotaries during off peak hours. Bob's rotary testing program is origi-
onate modem sensitive. It currently runs on a Vadic 2400PA with outdated PROMS
or a Concord 2400AD MODEM. This limits our ability to test useing this program
To make matters worse, the program is written in BASIC for the TI PC as will
not be upgraded to a C-shell program. For the IBM yes. The TI no.
   Since Bob has been tied up developing software for FSC, maybe we can provi-
de assistance as far as modifying the source code to accept the more recent 
modems being used in the public net. This will require a copy of the source 
code which,..in the past,...Bob has been unwilling to part with. This may have
been due to the fact that Pat Diamond was his boss. Now that Curt Miller is
the new boss, getting the source code from Bob may be a little easier. Will
discuss this with Fergie and Curt as soon as possible.

   FSC is also developing a remote circuit analysis system made by Ameritec
for use in the public and,...maybe the private nets. Ameritec has just upgr-
aded the test unit in the NTS lab to allow it to test phase and gain hits and
droppouts. Bob Rauscher will be back working on the software for same around
the first part of next month. So far,..what he's turned out is very interesti-
ng. If it flys the way I think it will we may have remote circuit testing a 
reality by the end of the fourth quarter of this year. This should also be of
GREAT interest to NTS who spends as much time on link problems as FSC does.

----------------------------------------------------------------
	****		P.D.NELSON		****
----------------------------------------------------------------

1. * Talked to Dennis Ernst about the ATC, discovered a previously well kept
 secret, the ATC does not do ^D gouging. This information (which I verified
 by testing a recently installed 9600 configuration) means that I will have
 to modify the ATC Configuration guidelines, since the I extrapolated to
 9600 baud assuming that it would allow full throughput. The chance of
 overloading and crashing the ATC with 9600 lines is not as great as in
 my original estimate.

2. * Wrote memo to Bob Bockman @ Mfg emphasising the need for a Sun workstation
 in Mfg in order to run the Turbo bring-up tools. Also spent some time
 talking to Bob about general Turbo mfg issues.

3. * Spent part of a week in 'B' learing the Turbo setup, went to some meetings
 introducing Turbo code generation, hardware configuration, etc.

4. * Did a great deal of housekeeping and configuration on the Sun systems;
 - Helped move Polaris to the HDLC lab
 - Got Turbo tools man pages set up on Polaris.
 - Assisted Shirley Chiang with setting up the Man on usr/tym.
 - Made several recommendations regarding directory configuration on Antares.
 - Learned to run the Sunwindows system on Polaris.
 - Created a Turbo test start-up script that is useful for low-level testing.
 - Did level 0 backup of Polaris to cartridge tape.

5. * Spent some time learning Unix tricks, setting up .rc files, etc...

6. * Created a script that can enter an NSR from the PC using my comm program.
 The script is useful as an example and test case, I will investigate creating
 a more useful version for simplifying NSR entry from the Sun, if we must
 continue to use the NSR system.

7. * Sent NSR regarding ATC & version 5.22 node code with HDLC link
 The ATC expects redundant checksum which 5.22 does not supply, so such a link
 does not come up. This was a P1 excalation.

8. * Experimented (on my own time) with PC to Sun communications, The existing
 tools (kermit, xmodem) have some interesting problems. I am looking at some
 new public domain software that may allow me to write a program that will
 keep my home PC updated automatically in order to be able to have the same

----------------------------------------------------------------
	****		A.CATTANEO		****
----------------------------------------------------------------


1.  DIALOG/DIALNET 
     
THE ON GOING UPGRADE AT DIALOG IS WINDING DOWN. THE UPGRADE SHOULD BE 
COMPLETE BY SEPT 1. I HAVE BEEN GOING OUT TO DIALOG EVERY NIGHT FOR THE    
PAST MONTH TO MAKE SURE DIALOG IS LEARNING HOW TO TROULBLESHOOT AND SET    
UP THERE TRIROCK MODEMS. EIGHT HUNDRED TRIROCK MODEM HAVE BEEN UPGRADED    
TO VERSION 2.06.    
     
2.  MEGACOMM  
     
THE NEW AT&T WATTS SERVICE IS BEING INSTALLED . THE NETWATCH UNIT WILL
BE INSTALLED ,BUT  I DON NOT KNOW WHAT CITY YET.  
     
3.  LOW SPEED ROTARIES  
     
TRIROCK MODEMS HAVE BEEN INSTALLED IN PLACE OF VADIC MODEMS IN LOW SPEED   
ROTARIES. THIS IS CAUSING A FEW PROBLEMS WITH 2400 BAUD USERES   
CONNECTING AT 2400 AND GETTING GARBAGE. I HAVE ADDED ON TO CFB 159 HOW
TO HARD STRAP THE CONCORD TRIROCK MODEM TO ANSWERE AT 1200 WITH FALLBACK   
TO 300 BPS.    
     
4.  ASYNC TICKETS  
     
5.  AVERAGE AMOUNT OF TROUBLE CALLS AND PROBLEMS WITH DIFFERENT VENDERS   
EQUIP.    

----------------------------------------------------------------
	****		S.B.RICHARDS		****
----------------------------------------------------------------


1.       T-1 Digital Exchange:
              Testing will proceed when time permits.
              For T-1 -- WHERE's our MICROWAVE......

2.       RLX-8:
              Nothing new.

3.       RLX-40 :
              Nothing new

4.       Major Assembly Codes:
              I still need response from people in the group for all products
              that were approved by HTS for the last year.

5.       Tracking Problems:

              Hayes
              Have sent all related Hayes connect problems to M. Wollin of
              Hayes and have received no response, Sun Life of Canada is
              pursuing directly with Hayes, supposedly.

              Tri-rock
              Dial-up problem with tri-rock at 300 baud, affects most
              Concord type users such as Ford. Reverse - engineered Eugene and
              Vancouver until fix works.

              19.2
              Meeting again Sep 8, chronic lines will be evaluated with
              Paradyne Network Management Equipment, severe lines will
              be given to ATT to fix, if not fixed will be re-ordered thru
              MCI.

6.       Sent Out:
              18 boards
7.       Received:
              29 boards from repair.

8.       Consignment From Zanker
              Tested three HDLC Micro's for ZANKER.
              Tested five BBU's for Zanker.
              Tested five MAC III sets diags and code for ZANKER.


9.       Update for CFB 162  ECO/FCO quick check.

Special Note:     Will be gone 1,2,3,4,5 Sep gone camping. Isn't
		  that special?

----------------------------------------------------------------
	****		Bruce Shepherd		****
----------------------------------------------------------------
     
The following are the  major activities  or projects that I have worked    
on during the past month.  These do not include  the standard  lab work    
and normal daily trouble calls (TICKETS, TICKETS and more TICKETS).   
     
1.  TymSwitch (Gandalf  Data  Switch)  -   Removed the two cabinets and    
related cabling  from the  NTS lab and  stored it in  the heat lab.  In    
view of the fact that we are no longer marketing  the switch, Marketing    
is  supposed to be  trying to  find a  buyer for  the existing  Gandalf    
equipment.
     
2.  BOOT 9 -  NTD is  in the  process of  re-designing  the BOOT 9 code    
after finding a  major flaw  in the rewrite  last week.   Dave Comstock    
(who will leave TYMNET this Thursday) is supposed to have the boot code    
rewritten by Monday  (29 Aug) afternoon,  but the  QA effort  will need    
to be completely restarted due to the major changes.   The rewrite will    
eliminate the  multi-meg support (since there  is no  current method to    
load multi-meg  via the  network other  than NAD) and boot  relocation,    
which was the foundation of the modularization effort.   Release of the    
code will depend upon the amount of bugs found in the re-designed code.    
The status of the XPI load is still tain,  but NTD has  determined    
that  the code will be released  regardless of whether it works or not.    
It is my understanding that the NTD philosophy is that the debug and QA    
process will be concurrent, and once the debug effort is completed, the    
product will be shipped.  There remains a question of support (unless I    
QA the entire product myself, NTS should not be responsible for support    
of it) and documentation (which does not currently exist in the form of    
either a PIR, GID/GED or release documentation).  
     
3.  CSC Assistance - Continue to assist Nils Clawson (Test Engineering)    
during  his training  here and  as necessary  when he is in Irvine.   I    
have ordered  some documentation  to be  send to  Irvine which Nils has    
been unable to obtain through normal channels.    
     
4.  DSIO Version 4.0  -   Code  not completely  debugged nor  released.    
Little activity on this product this past month.  I suspect that  since    
Darrel Bender  has been  assigned BOOT  9 this project will go on  hold    
indefinitely.  
     
5.  Network Management  Upgrades for  DuPont and  Morgan  -   I  became    
involved in both of the TMCS/NEM  upgrades at  DuPont and  Morgan after    
each  had been  unsuccessful in  previous attempts.  This activity took    
several  days  (and nights) but  each was  upgraded successfully on the    
3rd  attempt.   In each case  there were  misunderstandings and several    
support and pilot errors that lead to upgrade failures.  The main areas    
of failure  were related to the outrageous  length of time it takes NEM    
to finish  collecting all  data from  network supervisors (DuPont  took    
6 hours,  Morgan 2.5  hours and  TYMNET Public  network 9.5 hours)  and    
poor product  documentation.    I have  submitted  a  PIR  on  the  NEM    
collection issue will have a PIR submitted this afternoon,  but NTD has    
indicated they will not put any  effort  into the product.  During  the    
delay  in  NEM  collection,  the  entire  network  management  facility    
(TMCS) is essentially useless as no monitoring capability exists.  From    
a  support standpoint  this is  unacceptable,  but  of relative  little    
importance to  NTD development  personnel  who do  not have  day to day    
involvement in either software upgrades or customer support.
     
6.  X.25 PAD Product Evaluations - We had been scheduled to have an OST    
X.25 PADs brought in and installed  in the  NTS lab this week, but this    
project has been put on hold  until a  replacement for Tom Chard can be    
hired and brought up to speed.
     
7.  Vacation -  AHHHHHH, Santa Barbara was fantastic !!!  I should work    
on this project monthly. 
     
----------------------------------------------------------------
	****		Alain Dazzi		****
----------------------------------------------------------------

     
Alain continued the major support for the group on TURBO.  His
status seems to be captured by the UNIX trolls on Antarres.



   9@+