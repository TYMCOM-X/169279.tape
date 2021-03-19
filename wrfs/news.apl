


                        SNA/CMT BETA TEST LOG (APL BETA SITE)
                        ============================================

  Date    Who   Event (in reverse chronical order)
======== ====   =====================================================
04/29/85  SL    To all concerns : 
6:00pm                        
                The test today at APL was quite successful.  We  have
                successfully logoned to APL Vtam application(Connews)
                and received "Eagle banner". We signed on TSO appli-
                cation, did test on PF9 and Clear keys. PF9 key stilll
                doesn't work at all. When we tested clear key, we got
                a beep from CMT TIF, however, when we tried Alt/c and
                Alt/l, they both worked - performed as clear function.
                This is just the way Tymnet CMT implemented. Therefor,
                I don't consider it is a major problem at present. 
                One of the major problems I have  observed during the
                test is when user sign off from TSO appllication, they
                supposely end up at Connews which means  they  suppose
                to receive/see an "Eagle banner" again,  so  user  can
                select other applications as well. However, this failed
                in the test. When user sign off from TSO application,
                We did not received "Eagle banner",  but  got  a  Vtam
                message again, I believe this is the similar problem
                to the previous losing "Eagle banner" prolbem.
                I've requested a native session  Vtam  trace  of sign
                on and off to/from APL applications. Since we are able
                to fix up losing "Eagle banner" problem in time, APL
                has more confidence with Tymnet right now.Customer has
                accepted request of Vtam trace. I shall deliver it as
                soon as I obtain the copy of trace.     
  
02/29/85  CHS   Steve,
2:15pm          I patched the SNA HIF and tried to log into APL host
                by using the 3278. I halt the SNA TIF to zap the circuit
                and then re-started the SNA TIF. The eagle shown up
                during initial logon and during the 2nd time logon.

02/28/85  CHS   Today, I used the 3274 CU located at the LAB of Bldg D
                of NTD to log into the SNA HIF of APL. 
                There were a few bugs on the SNA Interface. After
                corrected these bugs, I successfully loged into the
                APL's SNA host with the eagle displayed on the 3278.
                I believe that the CMT to SNA should work as well.

04/26/85  CHS   Steve and I continued to test the RSP(ACTLU) and
                NOTIFY stuff at APL. The test still did not go thru.
                However, some useful data and information were collected
                during the test.
                Later tonight, after I modified the SNA HIF a little more,
                finally the 'eagle showed up!'.
                Duirng these two days' tesing, we uncovered one bug on the
                SNA module scheduling routine and another one on the
                DLC module.
                
                Steve,
                There are two SNA HIF slot codes, CS5535.N01 and CS5535.N11.
                There are almost the same. Except CS5535.N11 contains the
                debugging and simulation test module. You can load either one
                into node 5535. I prefer to have CS5535.N11 loaded, in case
                there is any problem during the next test.

04/25/85  CHS   The test today at APL failed.
                The host did acknowledge the receiving of the NOTIFY
                sent from SNA HIF.  However, except this all others
                were exactly the same as before.
                I modified the tymfile CS5535.T01 to have the RSP(ACTLU)
                looked exactly like what was on the VTAM trace listing and
                re-assembled the SNA HIF. The code is still named CS5535.N01.
                Please re-load it.

04/24/85 CHS    The Vtam Trace showing:
                1. The CU returns RSP(ACTLU) with control vector field
                   indicating the LU not ready.
                2. The SSCP accepts NOTIFY.
                3. However, there is no indication the -RSP(BIND) with
                   0845 can be properly processed by the host.

                The code for -rsp(BIND,0845) and NOTIFY host when circuit
                built is ready for testing. A vtam or datascope trace
                will be necessary should there be any problem during the
                testing. The slot code is CS5535.N01. Please reload it.
                Should the testing (0845 & NOTIFY) not be able to produce
                satisfactory result, further investigation and study wil1
                be necessary.

04/24/85  DAN   A vtam buffer trace in a native environment has been
                forwarded to me by Stephen in person, and made copies to Chung and 
                Ping as well. Thanks, Stephen.
04/19/85  CHS   Daniel, Steve,
                Please obtain the trace for the folloing tests:
                Test 1
                a. Get a 3274 CU with at least one display (3278)
                b. Power on 3274 and IPL, but power off the 3278
                c. Direct connect (not go thru TYMNET) the 3274 to the
                   FEP
                d. Vary activate the 3274 and 3278
                e. Power on 3278, to see if the LOGO (eagle) is displayed
                   on the 3278.
                Test 2
                a. Vary activae the 3274 and 3278 with 3278 on.
                b. After the LOGO appeared on 3278, power off 3278 then
                   power on back. Check if the LOGO can be displayed.
                Test 3
                a. Use 3278 logon into application. Then, power off
                   the 3278 and power on. Check the screen display.
                It is important that NTD can get the trace listing for
                the above testing if we want to fix the logo missing problem.
                
04/15/85  CHS   The crash (SNA415.H01) was caused by a bug which had been
                fixed on SNA 01.02.
                The problem of PC5535.N01 was because the response for the
                ACTPU was not properly set on the PC5535.T01. The PC5535.T01
                has been modified with proper G.PACPU macro. The re-assembled
                slot code is still named PC5535.N01. Reload the slot should
                be able to let the SNA HIF up and running.

04/11/85  DAN   Stephen and I visited APL San Mateo and Oakland data centers
                on 04/10 here is the report:
                1) We test thru all tests included in the test script
                   terminal type = vt100 (xtalk-xvi version 3.04)
                   all tests o.k. except
                   - TYMNET lost APL's logo that is a big  eagle.
                   - power down recovery test can not apply to terminal 
                     emulation package.
                   - customer complained no "HOME" key, that the terminal
                     operator have to use BACK TAB / TAB key to position the
                     home position, it is really inconvenient.
                2) several keyboard functions does not work on ADDs viewpoint
                   78 terminal. (see also Stepeh's 04/09 log entry.)
                3) I have obtained vtam traces, I'll send them to Chung Shaw and
                    to investigate.
                4) I also keep a copy of the vt100 emulation test result
                   initialed by APL's J. Bischop.
     
    
04/10/85  MIA   Please, check and record the following situation.
		In native mode with menu screen, power off the terminal
		and then power it on again. What is the picture after
		that? The rationale behind this (and maybe other questions
		of this kind which we may have later) is that HIF
		emulates power off condition when no TYMNET cicuit is
		built and power on when we connect from TIF to HIF.

04/09/85  SLI   FIRST OF ALL, LET ME RESTATE AND MAKE CLEAR LOGON 
                PROBLEM FROM MY ONTYME TO YOU ON APR-08-85. USUALLY 
                FOR USER LOGON TO THE HOST, THERE ARE TWO WAYS TO LOG
                ON. (1) AUTO-LOGON WHICH MEANS USER WILL AUTOMATICALLY
                LOGON TO CERTAIN APPLICATION, E.G. MENU SELECT. AND 
                FROM THERE USER CAN SIGN ON TO SOME PARTICULAR APPLI-
                CATION SUCH AS "TSO". (2) USER INITIATE LOGON WHICH 
                MEANS USER HAS TO SIGN ON TO VTAM FIRST IN ORDER TO
                GET TO SOME APPLICATION, E.G. MENU SELECT. AND THEN
                USER CAN SELECT SOME PARTICULAR APPLICATION SUCH AS
                "TSO". FROM APR-05TH TEST, WE FAILED TO DO THE USER
                AUTO-LOGON. HOWEVER, DURING USER LOGON, USER WAS LED
                TO VTAM LEVEL FIRST, THEN USER HAS TO SIGN ON TO VTAM
                AND GET MENU SELECT TO SELECT CERTAIN APPLICATION SUCH
                AS "TSO".     
                THE PROBLEM WITH PF AND OTHER KEYS, IT IS MOST LIKELY
                CMT PROBLEM. DURING THE TEST, I HAVEN'T SEEN ANY HIF
                MESSAGE SUCH AS "COMMAND UNRECOGNIZED". I'VE TALKED TO
                GORDON SMITH THIS MORNING ABOUT CMT PF KEY SUPPORT, I
                FOUND OUT THAT TYMNET IS CURRENTLY SUPPORTING ALL PF 
                AND OTHER KEY, BUT "HOME" KEY.  
                AS SCHEDULED WITH APL, WE WILL TEST THIS AGAIN ON 
                WEDNESDAY, APR-10-85. I WILL DUMP THE CMT FILE RIGHT
                AFTER TEST IF WE ARE GETTING THE SAME RESULTS AS FROM
                LAST FRIDAY.
                2ND BETA TEST WITH APL IS SCHEDULED AS WEDNESDAY, APR.
                10, 1985. 10:30 AM AT APL SAN MATEO DATA CENTER (TEST
                WITH VIEWPOINT-78), AND 1:30 PM AT APL OAKLAND DATA
                CENTER (TEST WITH VT-100). PING CHU, DANIEL LEE, AND
                I WILL BE AT CUSTOMER SIDE TO CONDUCT TESTS. 
04/09/85  MIA	We would be interested to examine the trace from VTAM
		which was taken during the test on Aplril 5th.
		I failed to understand from the ontyme with the
		account of events of this test what kind of logon
		did not work. If possible, attach the description
		of what happened and what was supposed to happen to
		the trace (preferably the scenario).
		The problem with PF and other keys does not sound to
		be related to HIF. One reminder, however: certain
		keys which come to HIF will be rejected with
		"COMMAND UNRECOGNIZED" message if received during
		SSCP-LU session. No status information is displayed
		at CMT, so practically it means that some of the
		keys will be rejected with this message during logon.
		It does not sound from ontyme that this was the nature
		of complaint. It rather looks like CMT problem,
		probably with SYSGEN.

04/03/85  SL    BOTH HIF AND TIF HAVE BEEN LOADED THIS MORNING. I'VE
                TALKED TO CUSTOMER - JIM ELSWORTH, HE HAS BROUGHT LINE
                UP 2:45 THIS AFTERNOON, BOTH HIF & TIF WERE UP RUNNING
                FINE, I WAS ABLE TO LOGNO TO THE HOST. HOWEVER, I HAVE
                NOT DONE ANY FURTHER TESTS ON THE INTERFACES BECAUSE 
                CUSTOMER NEED TO DOWN LINE SYSTEM FOR SOME OTHER PURPOSE.
                WE WILL CONDUCT A FORMAL COMPLETE TESTING ON FRIDAY (
                BASED ON CUSTOMER'S REQUEST), BY THE TIME, JIM ELSWORTH
                WILL BE OVER THEIR DATA CENTER TO CORPORATE TEST WITH
                ME. DURING MY CONVERSATION WITH JIM ELSWORTH, JIM TOLD
                ME THAT HE HASN'T GOT A CHANCE TO READ TEST SCRIPT, BUT
                BASICALLY APL HAS AGREED TO FOLLOW DANIEL'S TEST SCRIPT
                FOR FRIDAY'S TEST.  BETWEEN NOW AND FRIDAY, THEY WILL GO
                OVER TEST SCRIPT AND ALSO PROVIDE THEIR OWN TEST SCRIPT.
                I WILL BE AT APL DATA CENTER TO DO TEST WITH APL TECH'S
                PEOPLE AT 1:30PM FRIDAY. IF I HAVE ANY PROBLEMS AND NEED
                ASSISTANCE, I WILL CALL YOU FROM THERE. PLEASE BE AWARE
                OF THIS. 
03/29/85  PCC   The SNA slot code is at (aplbeta:37)ND5535.#01, the
                nib file requires 228K of core for 1 CU and 16 deveices.
                The CMTI slot code is at (aplbeta:37)ND5535.#02, the
                nib fil requires 111K of core for 16 users.

                Stephen, the CROSS-TALK version 16 is not certified to
                work on IBM PC yet. Please check the version that APL
                is going to use.  And also, I can't find any document
                regarding to PCI-78 terminal, which APL is going to 
                use. Please find it out whether our CMTI can support
                this type of terminals or not.

03/27/85 SL     DANIEL AND PING, THE CURRENT UPDATES ON APL'S INSTALL
                AS OF I HAVE RECEIVED NODE # AND HOST # FROM OUR SALES
                REP'S. HOWEVER, ACCORDING TO MY UNDERSTANDING THAT PI
                (PROJECT IMPLEMENTATION) HAS NOT DONE NODE CODE YET.
                THEY WERE SAYING THAT THEY NEED 7 DAYS TO COMPLETE THE
                TYM FILE FROM TODAY. OUR SALES REPS. AND MY MANAGER - 
                KUSHI KULLAR ARE WORKING ON THIS MATTER NOW. IF THERE
                IS ANY NEW UPDATES, YOU WILL BE INFORMED AS SOON AS 
                POSSIBLE. INFORMATION ON NODE AND HOST AS FOLLOWING :
             
                          NODE # : 5535 
                          HOST # : 2167 (SNA/SDLC)
                          HOST # : 2169 (CMT) 
                          KERNEL : 7055 
              
                THE SLOT #'S HAVE NOT BEEN ASSIGNED YET SINCE THE TYM
                FILE HAS NOT BEEN COMPLETED AT THIS TIME. AS I LOOKED
                AT TYM FILE - (TYM4000)ND5535.TYM, THERE ARE ONLY TWO
                SLOTS AVAILABLE ON THAT NODE, SO I ASSUME THAT SLOT 1
                AND 2 SHOULD BE FOR DSLC AND CMT ACCORDINGLY. 
                BY THE WAY, I HAVE ONTYMED TYMNET VALIDATION PEOPLE TO
                VALIDATE USER NAME APLBETA AND PASSWORD SHIP TO THE CMT
                HOST (HOST # 2169), AND APLCMT AS A USER NAME WITH NO
                PASSWORD TO HOST # 2167 AS CMT USER NAME. HOPEFULLY, THIS
                CAN BE DONE BY FRIDAY. 
                I WILL BE OUT OF OFFICE TOMORROW, IF YOU HAVE ANY QUESTION
                REGARDING TO THE ORDER COMPLETION AND NEW UPDATES, YOU CAN
                CALL SUSAN DEBENHAM AND STEVE DEGOLIA WHO ARE THE ACCOUNT
                REPS. IN CHARDE APL ACCOUNT IN S.F. OFFICE. THEIR PHONE #
                IS (415)956-6792. 
                NOTE : TYM FILE - ND5525.TYM IS IN (TYM4000:25)
                ----------------------------------------------------------
03/27/84 DAN    Stephen, as a follow-up of our conversation over
                telephone regarding possible delay of installation,
                please keep us informed if there is any updates.
03/26/84 DAN    Stephen, the files of CMTI.ERS and SCRIPT.DOC has been
                copied into this directory, you can run your own copies.
                Currently, I am reviewing and updating SCRIPT.DOC version
                1.0, the new version 1.1 will be ready by 03/29.
   