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


PIR NAME:  NRZI SUPPORT
PIR REQUEST DATE:  30-JAN-1990
DESIRED PIR RESPONSE DATE (not ASAP):  16-FEB-1990
DESIRED PIR IMPLEMENTATION DATE (not ASAP):  04-MAY-1990
PRODUCT(S) AFFECTED/PRODUCT NAME:  

TYMNET ENGINE FAMILY (CXL, PXL)
TYMNET TURBO FAMILY (T-80, T-40, T-20)

REQUESTOR NAME:  T.C.KOCHMANN
REQUESTOR PHONE NUMBER:  408/922-7493
REQUESTOR ONTYME NAME:  NSC.T/KOCHMANN
REQUESTING DIVISION NAME:  NTD
REQUESTING DEPT. NAME:  NTS
REQUESTING DEPT. COST CODE:  2603

PRODUCT MANAGER NAME:  RON SPARROW (ENGINES), MICHEL DARNAUD (TURBOS)
PRODUCT MANAGER PHONE:  SPARROW (408/922-7881), DARNAUD (408/922-6603)
PRODUCT MANAGER ONTYME NAME:  NSCMS.R/SPARROW, NSCMS.M/DARNAUD

CLIENT NAME (TYMNET if no other):  TYMNET

PIR DESCRIPTION:

This PIR is to implement Non-Return to Zero Inverted (NRZI) encoding
on the SIO II/III boards used with the engine XL product line and on
the IOC4/8 cards used with the Turbo product line.  The PIR will add
inverters and drivers to the SIO II/III boards to invert the signals
for the engine line.     Turbo will be properly implemented with the
firmware modified to permit access to the Z8530 SCC's Write Register
10 where Data bits D5 and D6 can be controlled at the ISIS level for
either the standard NRZ encoding or NRZI.


PIR PURPOSE:

At this time Tymnet offers no solution to  the users with an IBM
interface who use NRZI data encoding.     There is an unreleased
ECO for the PSM V.24 daughter-card rework to convert NRZ to NRZI
encoding but as the PSM bucket will be twilighted with the mini-
engine as it fades into the sunset pursuing a release of the ECO
is pointless.  The rework must be ported onto the  now  released
SIO II board and should be incorporated as an option on the  SIO 
III board at this time before it becomes a released product.  As
the Turbo SCCs are capable of performing  the  conversion  under
program control the firmware should be modified at this time  as
Turbo will soon be deployed into the PDN where firmware upgrades
will not be easily performed.


REVENUE OR COST IMPACT:

The rework logic for the SIO II/III and testing requires an estimated
2-3 man-weeks. Revising silkscreens, artwork, bills of materials  and
logics time estimates will have to be sourced from NTD. The revisions
for the Turbo firmware and ISIS codes should require an estimated 2 -
3 weeks to implement and test but again these estimates  should  come
from NTD.  Actual hardware revisions may or may not be required.  Not
implementing this PIR requires Tymnet users and potential  users  who
today run their IBM equipment with NRZI encoding to  either  purchase
NRZ to NRZI converters or revise their equipment to conform to Tymnet.

PIR IMPACT:

This PIR impacts the Florida Information Resources Network at  this
time.  FIRN had been looking to purchase MXL type nodes but is  now
being redirected to CXL machines.  Without this PIR Tymnet may well
have the pick up the expense of NRZI converters at $300.00+ per box.
FIRN has also expressed an interest in Turbo but of course the same
constraint exist there as well.      This PIR could have a positive 
impact on Tymnet UK clients as NRZI through Britan is quit popular.

MARKETING COMMENTS:

ADDENDA (Optional):

:send d/johnson t/kochmann nscms.r/sparrow nscms.m/darnaud nscms.nspirs
RIO PIR

:log

