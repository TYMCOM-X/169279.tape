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


PIR NAME:  REMOTE I/O BREAKOUT MODULE
PIR REQUEST DATE:  29-JAN-1990
DESIRED PIR RESPONSE DATE (not ASAP):  16-FEB-1990
DESIRED PIR IMPLEMENTATION DATE (not ASAP):  03-AUGUST-1990
PRODUCT(S) AFFECTED/PRODUCT NAME:  

TYMNET ENGINE FAMILY (MXL, CXL, PXL, APSS)
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

This PIR is to implement a solution to the I/O breakout problems
inherent in the entire Tymnet Engine and Turbo product lines. It
also satisfies the client requirements for redundancy as it will
incorporate the current APSS on the Engine bucket into a  remote
I/O breakout module.  The current scheme of dropping I/O ribbon-
cables from I/O cards to a card-cage within an Engine  at  which
point the I/O is distributed to EIA and/or CCITT signals out the
back of the cardcage and the current scheme of dropping hundreds
of pounds of copper I/O cable from paddle cards off the back  of
the Turbo will be replaced with a Fiber-Optic scheme.  I/O level
shifting and translation drivers will be replaced with the newer
technology opto-isolators. The opto-isolation eliminates many of
the problems inherent in the exisitng schemes.  As the CXL is to
replace the MXL and the CXL has no PSM bucket clients can not be
provided the redundancy they now depend  on  through the  bucket
forcing them out of the market from Tymnet's perspective and  on
to alternate venders with their own redundancy schemes.  The new
remote module will incorporate a heartbeat mechanism  driven  by
the existing software such as Hong Kong ShangHai Bank subscribes
to.  Medium grade fibers will be selected allowing the break-out
to be relocated up to a full mile away from the node footprint.

PIR PURPOSE:

The revised scheme is required at this moment in time  to  replace
the PSM bucket which will no longer be available as the CXL breaks
out I/O via ribbon cables directly to a rear panel module.  One of
the critical functions lost with the bucket is the APSS redundancy
which CXL can not support at this time.  Properly constructed  the
RIO (remote I/O) module will provide this feature.    Port density
constraints are also a problem with the CXL product.  Utilizing an
RIO permits greater flexibility of port modes presented to clients.
Tymnet is also quite limited by signal  driving  capacities  which
often requires the added expense of  using  modem  eliminators  or
line drivers.  The RIO reduces the need  for  such  added expenses.
In the case of Turbo we are faced with a problem  of  breaking  out
in excess of 100 - 140 cables for a VA upgrade today which presents
itself as a most imposing task both in the initial upgrade  and  in
subsequent support efforts. As Turbo is fast approaching deployment
in the PDN the significance of this PIR becomes readily obvious. It
further provides marketing/sales a nice feature to present  to  the
field.  The prospect of installing a node in a  computer  room  and
then dropping off a fiber-optic breakout box remotely with  minimal
cable/driving/grounding problems is most attractive.


REVENUE OR COST IMPACT:

Fiber-optical drivers, cables and alignment tools are now economical
reliable and readily sourced. Failure to act on this request at this
time will send Tymnet down the path of sustaining archaic technology
in an industry of competitors racing into the 21st century. NTD will
have to provide the development estimates specific to the Engine and
the Turbo as they will not be exactly one to one.Proper construction
of the RIO should increase product reliability while decreasing  the
costs associated with copper I/O cables.  Basic machine maintainence
costs should be reduced as well as the hardware will be more  easily
accessed.

PIR IMPACT:

This PIR impacts nearly every customer of Tymnet at this time as NSC
customers are seeking CPU and MAC upgrades and are being forced onto
CXL type machines with less I/O breakout capacity than the  MXL  and 
absolutely no possibility of redundancy.

MARKETING COMMENTS:

ADDENDA (Optional):

:send d/johnson t/kochmann nscms.r/sparrow nscms.m/darnaud nscms.nspirs
RIO PIR

:log

