            MDISC PROJECT INITIATION REQUEST

**************** FOR MARKETING USE ONLY ******************
*                                                        *
*  MKTG TRKG #____________    PIR     ______             *
*                             NSR     ______             *
*       PIR #____________     SPECIAL ______             *
*                             REJECT  ______ (if reject, *
*                                             attach     *
*                                             comments). *
* __________________________________                     *
* (Product Mgr. Sign.)       (date)      Page ___ of ___ *
*                                                        *
**********************************************************







Marketing will respond to all PIRs within 30 days.


PIR NAME:  SYNC-SLOT EXERCISER
PIR REQUEST DATE:  22-FEB-1990
DESIRED PIR RESPONSE DATE (not ASAP):  05-MARCH-1990
DESIRED PIR IMPLEMENTATION DATE (not ASAP):  01-JUNE-1990
PRODUCT(S) AFFECTED/PRODUCT NAME:  

TYMNET ENGINE FAMILY (MXL, CXL, PXL, MICRO IV, PICO, TSI)
TYMNET TURBO FAMILY (T-80, T-40, T-20)

REQUESTOR NAME:  T.C.KOCHMANN
REQUESTOR PHONE NUMBER:  408/922-7493
REQUESTOR ONTYME NAME:  NSC.T/KOCHMANN
REQUESTING DIVISION NAME:  NTD
REQUESTING DEPT. NAME:  NTS
REQUESTING DEPT. COST CODE:  2603

PRODUCT MANAGER NAME:  RON SPARROW (ENGINES), MICHEL DARNAUD (TURBOS)
PRODUCT MANAGER PHONE:  SULLIVAN (408/922-71470), DARNAUD (408/922-6603)
PRODUCT MANAGER ONTYME NAME:  NSCMS.R/SPARROW, NSCMS.M/DARNAUD

CLIENT NAME (TYMNET if no other):  TYMNET

PIR DESCRIPTION:

This PIR is to implement a revised  ISIS  slot  exerciser  for use
on Turbo and Engine products.   This exerciser will  be  under the
control of ISIS-DDT  (Engine)  or ISOM  (Turbo)  and will  perform
emulated sync testing.Concurrent multiple channel testing  will be
provided for up to  16 channels.  The extended DDT user  interface
will  prompt  the  user  to  select either individual  channels or
ranges of channels to test with either canned random test patterns
or user-supplied full-word  patterns  in selectable  packet  sizes
from 0 bytes to 128 bytes.Control signal testing will be available
for DTR, DSR, RTS, CTS.   The slot will crash and halt on SVC zero
return failures whereas data compare  errors  and  control  signal
exchange   failures  will be reported to an error logger while the
test continues.

PIR PURPOSE:

The slot exerciser is required  now to  exercise and / or test SYNC
RS-232C logical units. This is critical to the Turbo environment as
there are up  to 64  channels/chassis and up to 4 chassis/footprint
for  a  total of 256 ports any number of which may be designated as
emulated sync ports.   The SYNC slot tester at this time  does  not
perform control signal assertion or sampling and it  only tests one
logical unit at any one time which requires a  user to individually
select,  configure, start and monitor up to  256 ports in the Turbo
environment which requires hours of operator time to perform.  This
is unacceptable and is a high priority task  as Turbo is soon to be
deployed with byte sync interfaces installed.  


REVENUE OR COST IMPACT:

This  PIR will require an estimated 10 man weeks of development and
testing.  The value of this project is indeterminate as it is not a
product designed to generate  revenue  but  it  will  significantly
reduce Q.A. testing, field fault isolation, manufacturing and stag-
ing times which do translate to readily  obvious  revenue  factors.
There is the risk that  without  the  PIR  approval testing will be
reduced to consist of using  user  interface  slot code to actually
test  the  emulated  sync configurations and often those can not be
load tested without acquiring access to an enduser terminal cluster
controller or host front end processor.     The  end result is that
without this PIR implementation, emulated sync testing, fault detec-
tion and fault resoltuion will be performed in the field in customer
environments.


PIR IMPACT:

This PIR will directly impact the conventional Tymnet products as well
as the Turbo.   This will provide a tool to test the XL family  boards
being deployed throughout 1990,91  with RS-232C sync interfaces  along
with the Turbo.


MARKETING COMMENTS:
Describe the PIR's effect on the product's positioning.  Include
any relevant competitive information.  Add any other customers
that are interested in this feature.  Describe the scope and size
of the market.  Identify any related requests, if known.  Add any
other comments relevant to this request.

:send d/johnson t/kochmann nscms.nspirs j/schmidt nscms.r/sparrow nscms.m/darnaud
SLOT SYNC EXERCISER
:ERASE
:LOG

