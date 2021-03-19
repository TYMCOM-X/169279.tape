	
	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 1

        SECTION U14.1.0 OVERVIEW
        ------------------------

        TYMNET SDLC interfaces with  primary  and  secondary  ports  provide
        access  between  SDLC  protocol terminals and hosts utilizing the 
        packetswitching data transmission services of  TYMNET.   Both
        Normal  Response Mode (NRM) and Normal Disconnect Mode (NDM) are
        supported.  No hardware or software changes are normally required  
        at  the  host computer.  Nonswitched, full or half duplex,
        point-to-point or multipoint links to hosts are supported.
        A secondary port will appear to  the  host computer  as  a single
        secondary station on a point-to-point link or as a number of secondary
        stations on a multipoint link.  No hardware or software changes are
        required at the remote terminal.  Nonswitched,  full  or half duplex,
        point-to-point or multipoint links to terminals  are  supported.
        A  primary  port  will  appear  to  attached terminals on a
        point-to-point or multipoint link as a primary station.  The TYMNET
        SDLC interface supports Physical Unit types 1, 2, and  4, and is
        transparent to all Logical Unit types.





        SECTION U14.1.1 Application of Support
        --------------------------------------

        TYMNET SDLC terminal and host interfaces  can  be  used  to  replace
        leased  lines  between hosts using SDLC protocol and SDLC terminals.
        The following diagram illustrates  the  interconnection  of  SDLC
        hosts  and terminals using TYMNET.

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 2

                        ----------              ----------
                        |        |              |        |
                        |  IBM   |              |  IBM   |
                        |   370  |              |   370  |
                        |        |              |        |
                        ----------              ----------
                             |                       |
                             |                       |
                         --------                --------
                         |      |                |      |
                         | 370X |                | 370X |
                         |      |    +++++++     |      |
                         --------   +       +    --------       --------
                            |      +         +       /          | 3276 |
             --------       |     +           +     /           --------
             |      |       ++++++             +++++++         /
             | 3274 |-------+                         +       / --------
             |      |        +                         +--------| 3276 |
             --------         +                        +        --------
                               +                       +
                     --------   +      TYMNET          +        --------
                     |      |   +                     +---------| 3276 |
                     | 8100 |---+                  +++          --------
                     |      |   +                 +
                     --------   +                +     --------
                                +                +-----| 3275 |
                                 +              +      --------
                                / +        +++++
                               /   +      +     |
             --------         /     ++++++      |
             | 5251 |--------/        |         --------
             --------                 |         | 3271 |
                                      |         --------
                                   --------
                                   |      |
                                   | 3777 |
                                   |      |
                                   --------


	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 3

        SECTION U14.1.2 Constraints
        ---------------------------

        o SDLC command/response frames not handled  by  the  TYMNET  SDLC
            Interface include:

                   UP   - unnumbered poll
                   CFGR - configure
                   BCN  - beacon


        o Direct channel attachment (local 3270  or  3770  mode)  is  not
            supported.


        o Connection to a loop data link is not supported.


        o Only Normal Response Mode  (NRM)  and  Normal  Disconnect  Mode
            (NDM) are supported.


        o NRZI (Non-Return to Zero Inverted) transmission coding  is  not
            supported.


        o A maximum of 16 primary or secondary ports can be supported  by
            a single TYMNET SDLC interface.


        o A maximum of 32 stations can be supported on a  single  primary
            or secondary port.


        o ASCII code set is not supported.



	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 4

        SECTION U14.1.3 External Support
        --------------------------------

        U14.1.3.1 Hosts
        -----------

        The following table is a summary of host software  which
        the TYMNET SDLC interface is compatible with.

        ========================================================
        | System     | Programs   | RJE        | Program       | 
        | Control    |            | Subsystems | Products      | 
        --------------------------------------------------------
        | DOS/VS(E)  | NCP/VS     | POWER/VSE  | ACF/NCP/VS    |
        |            | VTAM       |            | ACF/VTAM      |
        |            |            |            | CICS/VS       |
        |            |            |            | EXTM          |
        |            |            |            | ACF/VTAME     |
        --------------------------------------------------------
        | OS/VS1     | NCP/VS     | RES        | ACF/NCP/VS    |
        |            | VTAM       | JES        | ACF/VTAM      |
        |            | TCAM       |            | ACF/TCAM
        |            |            |            | CICS/VS       |
        |            |            |            | IMS/VS        |
        --------------------------------------------------------
        | MVS        | NCP/VS     | JES2       | ACF/NCP/VS    |
        |            | VTAM       | JES3       | ACF/VTAM      |
        |            | TCAM       |            | ACF/TCAM      |
        |            |            |            | TSO ACF/TCAM  |
        |            |            |            | TSO ACF/VTAM  |
        |            |            |            | CICS/VS       |
        |            |            |            | IMS/VS        |
        |            |            |            | JES2NJE       |
        |            |            |            | JES3/NJP      |
        |            |            |            | JES3/RJP      |
        ========================================================

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 5 

        U14.1.3.2 Terminals
        -------------------

        The TYMNET SDLC primary interface is  compatible  with  3270
        terminal  equipment  and  3770  communication  terminals.  TYMNET
        representatives should be consulted to  verify  compatibility  of
        specific non-IBM devices.  Compatible IBM devices are:

        ================================================================
        |     5251-12              |       Control Unit                |
        |     3271-11,12           |       Control Unit                |
        |     3274-1C              |       Control Unit                |
        |     3275-11,12           |       Control Unit                |
        |     3276-1,2,3,4         |       Control Unit Display Station|
        |     3276-11,12,13,14     |       Control Unit Display Station|
        |                          |                                   |
        ----------------------------------------------------------------
        |                          |                                   |
        |     3771-1,2,3           |       Communication Terminal      |
        |     3774-p1,p2           |       Communication Terminal      |
        |     3775-p1              |       Communication Terminal      |
        |     3776-1,2,3,4         |       Communication Terminal      |
        |     3777-1,3             |       Communication Terminal      |
        |                          |                                   |
        ----------------------------------------------------------------
        |                          |                                   |
        |     8775                 |       Control Unit Display        |
        |                          |                                   |
        ================================================================

        U14.1.3.3 Systems
        -----------------

        TYMNET SDLC Primary and Secondary interface ports  are  also
        compatible  with  a  variety  of  IBM  computer systems operating
        either as Primary Stations or Secondary Stations on a  particular
        link.  These systems include:

                         o    SERIES-1

                         o    System 32

                         o    System 34

                         o    System 38

                         o    8100

                         o    3705

			 o    3725

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 6

        U14.2.0 ANZ specific
        --------------------

        In addition to the devices mentioned in sections 14.1.3 thru 14.1.3.3,
        the ANZ has a further requirement to support the IBM 4701 control
        unit with attached Burroughs model 315 terminals.  Tymnet understands
        this requirement and the level of importance attached to it.  In
        regard to this requirement, Tymnet recommends that these devices be
        the first to go thru this software acceptance procedure.



        U14.3.0 SCOPE
        -------------

        To test functionality of the SDLC interface including:
        
        1) Operations monitor

        2) Extended DDT functions

        3) Development traffic over Physical Unit Types 2 and 4.

        4) To test both point-to-point and multi-drop configurations.


	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 7

        U14.4.0 ANZ special function and application
        --------------------------------------------

        This is to insure data transparency of the SDLC interface,
	as 4700's will be down line loaded with load modules.


        U14.4.1 Device testing
        ----------------------

        A large variety of devices are capable of communicating over SDLC
	links and each device is not restricted to using the same SDLC
	parameters.  The capability of the SDLC interface to support
	variations in maximum RU length, window size and switched lines
	needs to be proved before acceptance of the product.  In order
	to provide this proof a variety of services have been identified 
	for functional testing.

	Additional features offered by the SDLC interface must also be tested.
	Services utilising Secondary Host Targeting, Multidropping from
	within the network and the high speed interface have been included
	for functional testing.

	Upon completion of the installation phase all software and
	hardware has to be satisfactorily tested before acceptance.  The
	acceptance testing consists of three stages.  The first two stages are
	primarily simple functional test and the third stage is virtually
	a production environment.

	TYPES OF SERVICES TO BE CONNECTED DURING ACCEPTANCE TESTING

	1. Dial up 4700 via Tymnet.  (complete)

	2) Dial up access with Tymnet supplying IDNUM and IDBLK.

	3) Point to point with secondary targeting, 4700 to 3725.

	4) Point to point with secondary targeting, 3274  to 3725.

	5) Point to point 5251 to S38.

	6) Point to point 3274 emulation to 3705.
           IDNUM and IDBBLK not on sdlc level, Tymnet does supply
           on level 2 (SDLC), we may transport it.

	7) Replaced with 13.

	8) Multidrop, 5251 and 5251 to S38.

	9) External multidrop with multihost targeting, 4700 x 2 to 3725.

	10) Internal multidrop with high speed I/F, 3274 x 3 to 3725.

	11) Multidrop 4701, 3274 to 3225 (SYD DPD).

	12) Multidrop 4701, 3274 to 3725 (Pitt St.).

        13) System 34 runnig 2770 to a 3725. (Souty Yarra.




	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 8

        U14.5.0 PROCEDURE
        -----------------


        U14.5.1 OVERVIEW
        ----------------

	The Tymnet SDLC extension cord interface, in functionality,
	is as its name implies.  That is, it is a transparent 
	transmission medium.  As far as the protocol is concerned,
	there should be no difference over a Tymnet network as opposed
	to a real SNA connection.  Therefore, it is not necessary
	to discuss how the interface responds to different SNA data
	link control frames.
	
	Once the Tymnet equipment has been installed the functional
	testing stage can begin.  Service types 3, 4, 5, and 6
	will be tested and after completion of testing all services will
	be restored to their original method of connection.

	See attached diagrams, this testing is scheduled to begin 10/29/85.


	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 9

	5.1 SEQUENCE OF EVENTS
	----------------------

	Record the results from commands issued in the operations monitor on
	page 11 and DDT commands on page 12 next to the appropiate command.

	 1) Select a point to point 4701 circuit to be placed on the network.

	 2) Assign a second front end port for testing purposes.  This line
	    should have a different line and device address than the one 
	    above.  This line should be unused.

	 3) Assign 3 host numbers for the test and validate the usernames.
	    Assignments should be as follows.  
	    NOTE: There should be two slots one TIF and one HIF.

	    USERNAME	HOST #
	    --------	------
	    TEST1	????	Username to access real host 1) above.
	    TEST2	????	Username to access test host 2) above.
	    MONnnnn	????	Username for SDLC monitor TIF.
	    MONnnnn	????	Username for SDLC monitor HIF.

	 4) Provide the necessary information to Tymnet to generate
	    the slot code.

	 5) Connect both host lines to the SDLC HIF.
	    Ensure both lines a inactive (down).

	 6) Connect 4701 to the SDLC TIF.

	 7) Log into both the TIF and HIF SDLC monitors to prepare for 
	    test.  NOTE: This will require two ASYNC hardcopy terminals.
	                 Request the "DISPLAY STAT" command.

	 8) Start the destination host line (vary active) this is the 
	    host associated with username TEST1.

	    Observe the two hard copy terminals to insure that PVC
	    has been established.

	 9) The terminal operator should now log into host and perform
	    all functions as described in section 4.0.  When complete
	    log off application.

	10) Bring down the host line for 5 minutes.  Then reactivate the 
	    host line.  

	    Observe the hardcopy terminals to see host line go down
	    and up.  When host is brought back up the PVC should be
	    reestablished.

	    The operator should now logon to application and log off.

	    This procedure is to insure circuit tear down and PVC rebuild.

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 10

	11) Deactivate the TEST1 host line.
    	    Activate the TEST2 host line.

	12) From the terminal connected to the TIF SDLC monitor complete
	    the following commands:

	    A. Shut the line using the "SHUT" command.

	    B. Change the username from TEST1 to TEST2 using the
	       "CHANGE LOGON" command.

	    C. Change the destination line address to match TEST2
	       host using the "CHANGE LOGON DESTINATION LINE ADDRESS"
	       command.

	    D. Change the destination station address to match TEST2
	       host using the "CHANGE LOGON DESTINATION STATION ADDRESS"
	       command.

	    E. Remove the shut using the "RSHUT" command.

	    F. Activate TEST2 host line.  PVC should now be established
	       to TEST2 host.

	    G. Operator should log onto application  and log off.

	    H. Shut line as in step A above.

	    I. Restore username, destination line address, and destination
	       station address to original specification. Like steps
	       B, C and D above.

	    J. Remove shut as in step E above.

	    K. Ensure PVC can not be built.

	13) Activate TEST1 host line.
	    Deactivate TEST2 host line.
	    PVC should now rebuild to TEST1 host.

	14) While the operator is on line, take the ASYNC hardcopy terminal
	    which is loged into the host interface and log it into
	    extended DDT on the host interface.  Do the same thing with
	    the TIF terminal.

	15) Perform all commands in section 5.3 on the TIF and HIF.

	16) Halt the host slot.  This should drop the operator.

	17) Restart the host slot. It may be necessary to
	    restart the host line if it has timed out.  This depends
	    if ISTATUS = to INACTIVE or ACTIVE.

	18) Ensure PVC has been established and operator logs back 
	    into application.

	19) Repeat steps 16, 17 and 18 above from the TIF terminal.

	20) From both the TIF and HIF SDLC monitors perform all
	    commands not done in step 12 from section 5.2.

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14                 PAGE 11


	U14.5.2 SDLC monitor
        --------------------

        Log into the SDLC monitor on both the HIF and TIF and
        check the following commands:

        DISPLAY Commands			     RESULTS
        ----------------			     -------

           DISPLAY HOST..............................

           DISPLAY CONFIG............................

           DISPLAY STAT............................
           DISPLAY LOGON.............................

           DISPLAY EIA or DISPLAY RSC................

           DISPLAY PARAMETER.........................

        SHUT  Command................................

        RSHUT Command................................

        CHANGE Commands
        ---------------

           CHANGE LOGON..............................

           CHANGE STATION POLLING ADDRESS............

           CHANGE LOGON DESTINATION STATION ADDRESS..

           CHANGE LOGON DESTINATION LINE ADDRESS.....

           CHANGE WINDOW.............................

           CHANGE MAXFRAME...........................

        EXIT Command.................................

        REFRESH Command..............................

        LOGTABLE Command.............................

        WHO Command..................................

	ACCEPTED.....................................



	SOFTWARE ACCEPTANCE MANUAL - UNIT  14              PAGE 12

        U14.5.3 Extended DDT
        --------------------

        Log into extended DDT on both the HIF and TIF and check 
        the following commands:

        Display Rings Commands			RESULTS
        ----------------------			-------

          DIR...................................

          DOR...................................

          DR....................................

        Display Symbol Addresses Command
        --------------------------------

          SYM...................................

        Real Time SDLC Line Display
        ---------------------------

          SCOPE.................................

        Display Menu Command
        ---------------------

          HELP..................................

          ?.....................................

        Terminate Extended DDT Mode
        ---------------------------

          EXI...................................

          ZZ....................................

          Q.....................................

	  ACCEPTED..............................

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14        PAGE 13

	U14.5.4.0 ANZ SEQUENCE OF EVENTS
	--------------------------------

	U14.5.4.1 DIRECT POINT TO POINT
	-------------------------------
	In this test the ability of the network to  perform normal
	link functions, as would be seen if modem link was used, will be
	proved.  Transparency of the interface to the data and end to end
	transmission of commands such as SNRM's will be proved.

	ACTIONS:

	1) Connect the HIF to the 3725 port (as per service type 3)
	and the 4700 controller (powered OFF) to the TIF.

	2) With the 3725 port inactive, confirm that no polling is 
	active on either the HIF or TIF.

	3) Activate the 3725 port.  A SNRM should be sent to the HIF
	and from the TIF.

	4) Confirm no acknowledgement to the SNRM is sent by the HIF.

	5) Power up the 4700 controller.  The 4700 should start responding
	to polls as should the HIF.

	6) Confirm the VTAM status changes from "PCTD2" to "ACT".

	7) Logon to application eg IMSD (this is hardcoded on disk).

	8) Verify session initiation under VTAM.

	9) Disconnect HIF.  Polling from the TIF should cease.
	The 4700 should go off host.

	10) Reconnect HIF and reestablish session (this might require
	activation of the line).

	11) Using a "Break Out" box open the TD and RD lines at the HIF.
	Confirm the TIF stops polling the 4700 after a timeout period.


	12) Reconnect TD and RD lines at the HIF.

	13) During normal polling, RE-IPL the controller and verify
	session restart and system status notification.  VTAM status 
        should change to PCTD2 while the IPL is in progress.

	14) Check the timeout values at the HIF and TIF, This can be
	done by using the "Breakout Box" to open the line.

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14        PAGE 14 

	U14.5.4.1 POINT TO POINT WITH SECONDARY TARGETING
	-------------------------------------------------

	ACTION

	1) As with test 5.3.1 service type 3 is used.  Connect the HIF ports 
	to the required 3725 ports and the 4700 to the TIF port.

	2) Activate the 3725 port and IPL the 4700 controller.

	3) Verify establishment of session via the VTAM status and
	monitor polling at the TIF.

	4) Activate the secondary HIF 3725 port.  Confirm that no change
	occurs to the TIF polling or VTAM status (PRIMARY).

	5) Establish a session with an application (eg IMSD).

	6) Disconnect the primary HIF cable.

	7) Verify that both sessions partners are notified of the session 
	loss.  The 4700 should go off host.

	8) Confirm the circuit is restablished to the secondary HIF
	and an application session is initiated automatically
	(probably after a timeout of 60 seconds).

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14        PAGE 15

	U14.5.4.2 MULTIDROP WITHIN THE NETWORK WITH A HIGH SPEED I/F
	------------------------------------------------------------

	Test the ability to match the TIF controller addresses with
	individual poll addressed on the HIF.  As an example, four 
	controllers can be connected to TIF's as address C1 whereas
	the addresses on the HIF could be C1, C2, C3, C4.

	In addition to the ability to map between Host and terminal addresses,
	a higher speed link may be used for the HIF connection.

	ACTION

	1) As per service type 10, connect the HIF and TIF ports.

	2) IPL all controllers and activate the 3725 port (LINE) to VTAM.

	3) Activate the first controller and verify is is 
	operational by establishing a session with TSO.

	Under SPF set up a full screen of data and transmit.

	Confirm that no data is lost.

	4) Repeat Step 3 for each controller.

	5) Transmit data simutaneously from all controllers
	and confirm no loss of data.

	SOFTWARE ACCEPTANCE MANUAL - UNIT  14        PAGE 16

	U14.5.4.3 DIFFERENT HOST TARGETS FOR PUs ON THE SAME TIF
	--------------------------------------------------------

	Each address defined on a TIF port can be targeted to
	individual HIF ports and all addresses can be active concurrently.

	ACTION

	1) As per service type 9 connect the two 4700 controllers to
	the TIF and the two HIF ports to the 3725.

	2) IPL controllers and activate both 3725 ports.

	3) Confirm both controllers are active by checking the
	VTAM status of each controller - should be "ACT/S".

	4) Inact one of the active PU's.

	5) PU should become active on the other line.

	6) Verify that session was lost and restarted.



  hbSy