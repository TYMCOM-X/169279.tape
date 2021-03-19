\:IN
\\
\:ERASE
                                                                 April 13, 1987

















             HQ TECHNICAL SERVICE'S SOFTWARE ESCALATION PROCEDURES

                                 REVISION 6.0




































                                                          *** HQTECH.ESCAL/PROC
                                                                 April 13, 1987







                                   TABLE OF CONTENTS

        Section                                                            Page



        1.   PURPOSE OF PROCEDURES                                            1


        2.   ESCALATION TO HEADQUARTERS SUPPORT GROUPS                        2
          2.1   EXCEPTIONS TO FORMAL PROCEDURES CONCERNING "HOT" ESCALATIONS  4


        3.   ASSIGNING ESCALATIONS A PRIORITY                                 5
          3.1   SOFTWARE TIME LIMITS                                          6


        4.   TECHNICAL SERVICES ESCALATION TO NTD                             7


        5.   TECHNICAL SERVICES ESCALATION TO HTS                             8


        6.   ESCALATION RESPONSIBILITIES                                      9
          6.1   MANAGEMENT OF ESCALATIONS                                     9
          6.2   REPORTING AND DE-ESCALATING                                  10


        7.   OFF-HOURS SOFTWARE SUPPORT PROCEDURES                           12




















                                                          *** HQTECH.ESCAL/PROC
        PURPOSE OF PROCEDURES                                    April 13, 1987






                              1 -  PURPOSE OF PROCEDURES







        The purpose of TECHNICAL SERVICE'S Escalation Procedures is  to provide
        the field organization  with 24-hour per  day/7-day per week  access to
        software support resources at headquarters.


        Normal business-hour communications with Technical Servies will  be via
        OnTyme  and  telephone,  with  off-hours  and  'emergency'  access made
        through Network Control (see OFF-HOURS Support procedures, section 7)


        This procedure outlines how to escalate a problem to  the headquarter's
        technical suport  group.  It  describes the format  and content  of the
        formal escalation,  and the method  used to report  status on  all open
        escalations.   This  procedure  also  defines  how  de-escalations will
        occur.



























                                           1
        ESCALATION TO HEADQUARTERS SUPPORT GROUPS                April 13, 1987






                    2 -  ESCALATION TO HEADQUARTERS SUPPORT GROUPS


        All  software  problems  that have  existed  within  the  field support
        organization  for  48  hours,  and  have  not  been  resolved,  MUST be
        escalated to Technical Services.


        A network problem  is to be escalated  to Technical Services  by Tymnet
        field personnel (this  includes a field Communication  Specialist (CS),
        RTC, or project manager).


        An  OnTyme  "EXEC" program  has  been  created to  prompt  you  for the
        required information.  This Exec can be invoked by entering:

                              ":EXEC *** FORMS.RFI/ESCAL"


        A generic username has been set-up for anyone who does not  have access
        to  our Exec  file  through their  OnTyme  host.  Simply  login  to the
        following ID:

                        please log in:  EMSNSS
                                   ID?  NSS.ESCALATIONS
                                  KEY?  FIELD.ESC

        A  problem is  considered 'ESCALATED',  only after  this form  has been
        FULLY filled  out, completely  describing the nature  and scope  of the
        problem  and  sent  via  OnTyme  to  the  appropriate  persons  in  the
        headquarter's  technical  support  group.   [Incomplete  forms  will be
        rejected.]


        The distribution list, that an escalation will be directed  to, depends
        upon the software type involved.   The files listed below will  be used
        for  escalation  to  the  individual  responsible  for  supporting that
        product, as well  as the appropriate  unit manager.  In  addition, your
        ontyme will  be copied to  the appropriate Network  Technology Division
        (NTD)  personnel,  responsible  for development,  and  to  the Hardware
        Technical Support (HTS) personnel, responsible for hardware.  This will
        enable  all three  divisions the  ability to  exchange  information and
        problem history tracking between organizations.







                                           2
        ESCALATION TO HEADQUARTERS SUPPORT GROUPS                April 13, 1987


                                DISTRIBUTION FILE NAMES

        *** ALC              ALC 2946
        *** ALLXPC           X.PC Interfaces
        *** ATC              Aschronous Terminal Concentrator
        *** BSC              3270, 2770 Host & Terminal Interfaces
        *** CMT              3270 CMT Interface Product
        *** CONSAT           ISIS Consats
        *** ELF              Engine Load Facilities
        *** ISIS             ISIS Operating System
        *** LOADII           LOADII
        *** MENUSERVICE      Menu Service
        *** MERLIN           Merge and Link
        *** NAD              NAD Assembler
        *** NETALERT         NetAlert
        *** NETMESSAGE       NetMessage
        *** NETVAL           Network Validations
        *** NETWORK          Network-wide problems
        *** NETWORK/CONSOLE  Network Console
        *** NODECODE         Node Code
        *** PUB/NETV         Public Network Netval
        *** PUB/RAM          Public Network Ram
        *** RAM              Raw Accounting Merger
        *** RJE              2780, 3780, HASP, RSCS & DOS/MLI
        *** SAS              Scandinavian Airline Protocol
        *** SNA              SNA, SDLC & QLLC Interfaces
        *** SOLOCONSAT       Solo Consats
        *** SUP              Supervisor
        *** TMCS/NEM         Tymnet Monitor & Ctrl Sys and Ntwk Event Monitor
        *** TYMCOM           Async & Bisync Tymcoms (Host Interface)
        *** TYMSTAR          Tymstar
        *** UTS              UTS 4000 Terminal/Host Interface
        *** VAL              Validations
        *** VIP              VIP 7700 Extension Cord Service
        *** X25/X75          X.25 & X.75 Host Interfaces
        *** XPAD             Consat Pad



        The OnTyme sender sould always  use the ":SEND CC" option, so  that all
        receipients can verify that the appropriate people were copied.  If the
        originator would like  to include other  individuals in the  routing of
        the  OnTyme,  they are  free  to do  so.   It is  recommended  that the
        originator, as well as  their manager, account representative,  and the
        sales representative for the account, be copied on the escalation also.


        If a problem reaches Technical Services, which requires  the assistance
        of HTS, then Technical Services will immediately forward the escalation
        to the appropriate HTS personnel.




                                           3
        ESCALATION TO HEADQUARTERS SUPPORT GROUPS                April 13, 1987


        The original  Ontyme message  number will  be the  escalation reference
        number for further correspondence.  And, again,  whenever corresponding
        in  ragards  to  the  escalation,  be  sure  to  use   the  appropriate
        distribution file.






           2.1  EXCEPTIONS TO FORMAL PROCEDURES CONCERNING "HOT" ESCALATIONS


        A  problem  often requires  a  more timely  response  than  the OnTyme-
        required   communication   may   permit.    For    expediency,   verbal
        communications are  accepted, but  MUST be  documented by  the "formal"
        procedures as outlined.


        In  the event  of  an Off-hour  escalation, Technical  Services  can be
        accessed through a call  to Network Control, who will  dispatch through
        an on-call paging system (to be discussed in section 7).
































                                           4
        ASSIGNING ESCALATIONS A PRIORITY                         April 13, 1987






                         3 -  ASSIGNING ESCALATIONS A PRIORITY


        The  priority  of  escalations,  within  Technical  Services,  will  be
        established on a first-in/first-out  basis for each of  the established
        priority levels.   All escalations  must be  assigned a  priority.  The
        priority  will indicate  the severity  of the  problem  being reported.
        This  priority  number  is  to  be  assigned  by  the  Field  CS,  with
        concurrence of the customer.  This process establishes responsibilities
        for  both  parties and  commits  the customer  to  certain  actions and
        responsibilities.   This  allows  us  to  focus  on  the  most critical
        problems  and manage  the  escalation and  its resolution  in  the most
        efficient manner.

                            SOFTWARE ESCALATION PRIORITIES



        PRIORITY    LEVEL    DEFINITION/REQUIREMENTS
        --------    -----    --------------------------------------------------
           
           1       Highest   - Severe impact on customer's business
                             - Immediate escalation to highest support levels
                             - Tymnet access to customer network/CPE/interface,
                               etc, for testing etc. . .is unlimited (ie.
                               available for testing during prime time hours)
                             - Scheduling of customer personnel off-hours to
                               assist in testing and/or information gathering
                               will be assured
                             - Customer and Tymnet in consatant communication

           2      Very High  - Impact to business high, or potentially high
                             - Access to Network/CPE/Interface, etc., limited
                               only by the testing impact on production
                             - Escalation to Technical Service within 24 hours
                             - Regular, frequent communiation of status/
                               progress

           3        High     - Serious problem, not affecting production, or
                               a less serious problem that is affecting
                               production.
                             - Standard escalation proceduress with progress-
                               reporting at least weekly.
                             - Customer and Tymnet will both give best effort
                               for testing and/or information gathering on or
                               off-hours.

           4       Medium    - Low impact on production or can be conveniently
                               circumvented.

                                           5
        ASSIGNING ESCALATIONS A PRIORITY                         April 13, 1987


                             - Standard escalation procedures
                             - Activities to be scheduled during normal working
                               hours when possible.
                             - Possible "next baseline release" resolution
                             - Remains on escalation report until resolved.

           5        Low      - No impact on production now, or forseen in the
                               near future
                             - PIR's, etc.
                             - Policy, procedure questions.
                             - Report as required.
                             - Hardware escalations forwarded to HTS for 
                               resolution.
                             - Can also be considered Request For Information
                               (RFI).






                               3.1  SOFTWARE TIME LIMITS

        -----------------------------------------------------------------------
                                                                 MAXIMUM TIME
        PRIORITY      FROM                TO                        LIMITS 
        -----------------------------------------------------------------------
           1       FIELD             TO: HQ TECH SVCS               6 HOURS
                   HQ TECH SVCS      TO: NTD                       12 HOURS
        -----------------------------------------------------------------------
           2       FIELD             TO: HQ TECH SVCS              24 HOURS
                   HQ TECH SVCS      TO: NTD                       48 HOURS
        -----------------------------------------------------------------------
           3       FIELD             TO: HQ TECH SVCS              48 HOURS
                   HQ TECH SVCS      TO: NTD                       72 HOURS
        -----------------------------------------------------------------------
           4       FIELD             TO: HQ TECH SVCS              48 HOURS
                   HQ TECH SVCS      TO: NTD                       72 HOURS
        -----------------------------------------------------------------------
           5       FIELD             TO: HQ TECH SVCS              72 HOURS
                   HQ TECH SVCS      TO: NTD                       AS NECESSARY
        -----------------------------------------------------------------------












                                           6
        TECHNICAL SERVICES ESCALATION TO NTD                     April 13, 1987






                       4 -  TECHNICAL SERVICES ESCALATION TO NTD


        With  regard to  problems  escalated to  Technical  Services, Technical
        Services will  become the focal  point for all  communication regarding
        the  problem  escalation.   Technical  Services  will  also  assume the
        function of problem management.   Technical Services may draw  upon the
        resources of  (NTD), as  well as  other technical  groups, to  effect a
        final solution to a problem escalation.


        Problems  submitted to  Technical Services  for resolution  may  not be
        solvable  by the  assigned  support person.   This  may be  due  to the
        complexity of  the problem,  or to time  constraints.  In  these cases,
        Technical  Services  will draw  upon  the resources  of  NTD  for final
        resolution.  In all cases,  software problems that have  existed within
        Technical Services  for more than  72 hours WILL  BE escalated  to NTD.
        Depending on priorities, escalations may be forwarded to NTD as soon as
        12 hours.  The  means of escalation will  be an OnTyme message  sent by
        Technical Services to the triple-star product file, which  includes the
        developer,  the  developer's  manager,  the  Technical  Service's  Unit
        Manager,  and the  submittor of  the original  escalation.   The OnTyme
        message  will  contain  all  information  provided  with  the  original
        escalation,  as  well  as  any  information  gathered  while  technical
        services was working to resolve the problem.

























                                           7
        TECHNICAL SERVICES ESCALATION TO HTS                     April 13, 1987






                       5 -  TECHNICAL SERVICES ESCALATION TO HTS


        In the event a  software escalation submitted to Technical  Services is
        subsequently determined  to invovle a  hardware anomaly,  the following
        steps are taken:

        1.  The HQ Network Consultant must inform the initiator of the 
            escalation, via Ontyme, of the following:

            a.  Escalation number and customer name.
            b.  Findings relating to the escalation.
            c.  Instructions for the CS to contact the local FE to take 
                appropriate action.
            d.  Statement that the escalation is being forwarded to HTS for
                follow-up on the hardware problem.

            The HQ Network Consultant will copy the appropriate (***) distri-
            bution file, in addition to the field CS.

        2.  The HQ Technical Administrator, upon receipt of the above OnTyme, 
            will formally escalate to HTS.  For administrative purposes, the
            priority of the escalation will be reduced to a level '5' during
            the time the escalation is with HTS.  Information to be included 
            will be the following:

            a.  Original escalation number, customer name, and related informa-
                tion.
            b.  All subsequent findings of the field and HQ Tech Svc's staff.

            This escalation to HTS should be copied to the appropriate (***)
            file and the field CS, who originated the escalation.

        3.  An acknowledgement via Ontyme will be made by HTS within 24 hours
            to the field CS and the approprite (***) file.  This OnTyme will
            contain the following information:

            a.  escalation number and customer name.
            b.  The name of the HTS person assigned to resolve the escalation.
            c.  The action which will be taken towared resolution.

        4.  HTS will follow-up with OnTymes sent to field CS and appripriate
            (***) file as to the progress/findings/resolution.


        NOTE:   THIS  PROEDURE ONLY  APPLIES  WHEN A  "SOFTWARE"  ESCALATION IS
        SUBSEQUENTLY DENED, BY TECHNICAL SERVICES, TO INVOVLE A 'HARDWARE'
        ANOMALY.  PROBLEMS "KNOWN"  TO BE HARDWARE ANOMALIES,  EXCLUSIVELY, ARE
        TO FOLLOW NORMAL 'HARDWARE ESCALATION PROCEDURES'.

                                           8
        ESCALATION RESPONSIBILITIES                              April 13, 1987






                           6 -  ESCALATION RESPONSIBILITIES


        A problem escalated to Technical services or NTD in no way releases the
        CS, originating the escalation,  from the responsibility to aid  in the
        problem  resolution.   The  CS must  maintain  daily  contact  with the
        customer, keepig the customer  informed of the progress of  the problem
        investigation.  Information or assistance to Technical  Services should
        be provided in a timely fashion.  Technical Services is responsible for
        keeping the CS informed of progress.  If it is necessary  for Technical
        Services to speak directly  to the customer, the responsible  CS should
        be included in that  conversation.  If this is not  possible, Technical
        Services  will report  via OnTyme  any customer  contact that  was made
        without the knowledge of the responsible CS.


        If  the problem  is escalated  to NTD,  the Technical  Services support
        person  still  maintains problem  management  responsiblity.  Technical
        Services continues to be  responsible for keeping all  parties informed
        on the progress of the problem resolution.






                            6.1  MANAGEMENT OF ESCALATIONS


        If, according to the escalation's initiator, a problem is not receiving
        the attention that  will result in a  resolution timely enough  for the
        customer, the assigned priority  may be changed by the  TSM responsible
        for  the  account,   assuming  the  criteria  listed   under  "Software
        Escalation Priorityes" is met.   This is not a subject  for negotiation
        between the CS  and the Technical  Services support person.   The sales
        group will not  have direct access to  the support person working  on a
        problem.  The sales staff should  check with the TSM for  status, since
        it is  ultimately the TSM's  responsibility to know  the status  of all
        problems escalated to Technical Services.  If Technical Services is not
        keeping  the field  informed  of progress,  that  is a  matter  for the
        manager of Technical Services and not the individual support persons.


        Technical Services can reduce the priority of a problem for one  of the
        following reasons:

        1) The responsible CS requests the priority level be reduced.

        2) The criteria outlined under "Software Escalation Priorities" is not 

                                           9
        ESCALATION RESPONSIBILITIES                              April 13, 1987


           being met by the customer and/or field CS.






                           6.2  REPORTING AND DE-ESCALATING


        Technical Services will publish an "Escalation Summary"  report, daily,
        which summarizes the status on progress made toward de-escalation; see:
        (TECHSERV:56,70)ESCSUM.LST .   This summary also  outlines the  area of
        current  responsibility for  each escalation,  (Tech Support,  NTD, CS,
        HTS, etc.).   Field personnel  are responsible  for verifying  that all
        problems  that have  been escalated  to Technical  Services are  in the
        report.


        Technical Services can de-escalate  a problem for one of  the following
        reasons:


        1) Both the CS, who  escalated the problem, and the  customer reporting
        the  problem, agree  that  the problem  has  been resolved  or  that an
        alternative solution has been reached.


        2) The problem has not reoccured for seven (7) days.


        3)  A  fix  has  been  provided  and  there  is  no  response  from the
        responsible CS after a seven (7) day period.


        The CS is responsible for filling out the de-escalation form,  by using
        the Ontyme Exec file.  The  exec is initiated by entering  the command:
        ":EXEC *** FORMS.DEESCAL".   This form must be  sent via OnTyme  to all
        interested  parties,  using  the  (***)  distribution  file.   The  de-
        escalation notice will include  the location of the new  backed-up slot
        code.  If, in the case of numbers 2) and 3) above, the CS does  not de-
        escalate the problem, Technical Services  will do it for the  CS.  When
        Project Implementation  informs Technical Services  that the  backup is
        completed, the problem will be de-escalated.


        If the problem was caused by a bug in the software,  Technical Services
        must document the software problem  with an NSR before the  problem can
        be de-escalated.  If a problem is caused by the software not supporting
        a new feature, the problem may be de-escalated after submitting  an PIR
        to document the requested feature.  In these cases,  Technical Services
        will inform Tymnet Product  Marketing of the requested new  feature, so


                                          10
        ESCALATION RESPONSIBILITIES                              April 13, 1987


        that they can set the priority for the development effort  necessary to
        install this feature.




















































                                          11
        OFF-HOURS SOFTWARE SUPPORT PROCEDURES                    April 13, 1987






                      7 -  OFF-HOURS SOFTWARE SUPPORT PROCEDURES

             
             
             NETCON/NSSC PROCEDURES FOR OFF-HOURS SOFTWARE SUPPORT  
             =====================================================

                          NSSC               (215) 251-6820
                                             (800) 345-6090

                          NETCON             (408) 942-5195 OR
                                             (408) 942-5200       
             
             
             

        The following, describes the call procedures for software assistance on
        any  products supported  by  HQ Technical  Services,  on public/private
        networks.
           Part I - Support for Products by HQ Technical Services
                    ---------------------------------------------

        Calls to NSSC or NETCON will proceed as follows:

           A.  NSSC or NETCON will dial "289-6403" to IRT (Intrastate Radio 
               Technology of San Francisco).  Wait for 3 short tones, then 
               press the phone number that the callee should return the call 
               to, for messages (usually this will be Network Control's phone 
               number).  Wait for another 3 short tones, and hang up the
               handset.

               It will take approximate 4 minutes for the call to reach the 
               designated pager.  If originator of page receives no response 
               within 10 minutes, Netcon should try the process again.

           B.  If no response within a total of 30 minutes, originator should 
               call:
                        
                           1. Carl Langdon    (408) 257-4183 OR
                           2. Shirley Chiang  (415) 657-0590 OR
                           3. Doug Ellenberg  (415) 783-3926 OR
                           4. Gary Walker     (408) 354-4735 








                                          12



NOW LEAVING ONTYME II
28 JUL 87 16:38:19  
   a BÅ