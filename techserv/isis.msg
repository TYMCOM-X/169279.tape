
                                  2.1  Message Format


             Each message header has the format:

        --------.-------.-------.-------.-------.-------.--
        |     RPORT     |M. TYPE| additional string dependent on MESSAGE TYPE
        ---------------------------------------------------

                Where:

        RPORT   halfword        relative port number for this process.  NOTE!!!
                                RPORT = 0 is ALWAYS used for intra-node commun-
                                ications.
        M. TYPE byte            MESSAGE TYPE






                                  2.2  Message Types


             The following message types are defined (for individual circuits):

        TYPE    length  usage
        (hex)   (total)

        00      var.    Needle:  (Originates in Slot 0,  and is interpreted by
                        the Dispatcher, thence passed to slot)

                format:

                --------.-------.-------.--------
                |    RPORT      |   0   | length|
                |-------.-------.-------.-------|
                |        INVOICE NUMBER         |
                |-------.-------.-------.-------|
                | Dest. Host #  | Orig. Node #  |
                |-------.-------.-------.-------|
                | Orig. Host #  | Orig. Port #  |
                |-------.-------.-------.-------|
                |   Extra I.N.  |  XXX  | TPC   |
                |-------.-------.-------.-------|
                |I Dest. Node # |  CCT  | size  |
                |-------.-------.-------.-------.---
                |   USER NAME ("size" bytes long)
                -------------------------------------

           RPORT:  The port number assigned to this circuit.
           length:   The 4th  byte is  additional length  of needle  (in BYTES,
               exclusive of the  length-byte; this MAY include  "padding" bytes
               following the USER NAME field).
           Destination Host:  This field is used by the dispatcher to determine
               which slot is being addressed.
           Orig.  Node  #:   This  field  specifies  the  node  originating the
               circuit.
           Orig. Host #:  This MAY specify which host originated a  circuit.  A
               zero in  this field  indicates that it  may be  ignored;  either
               there is no origination  host, or that it is  unknown.  However,
               if known, it is made available to the slot for any specific slot
               requirements, such as limiting access, etc.
           Orig. Port #:  This field specifies the originating port  number (on
               the origination node).

               NOTE:   if a  circuit originates  on another  slot within
                       this machine, then  the high-order bit  in "Orig.
                       port no." will be set, and the rest of  the field
                       is the originating  Slot 0 port  which originated
                       the circuit.
           Extra I.N.: Extension Invoice Number (for ACCT2).  If this  field is
               non-zero, it contains the high-order 16 bits of the ACCT2 48-bit
               Invoice Number.
           XXX:  This field is unused, and provided for future expansion.
           TPC:   (circuit ThroughPut Class, also known as the "gouging level")
               has the high-order bit set (to distinguish from unused TPC), and
               the low 6  bits specify the  level (currently 0-3).   The second
               bit (corresponding to x40), if set, designates a Collect Call.
           I:   The High-order  bit of  this field  is set  if the  circuit can
               support IIX (Intelligent Interface) protocol.
           Dest. Node #: This field (previously 0) MAY contain  the destination
               node number.
           CCT:  The Circuit Characteristic Type;  usage as defined  in TYMNET.
               (The two high-order bits may be set, and should be ignored.)
           USER NAME is several chars long, terminated by C/R or ";".   If this
               is a transparant logon,  the first character of username  is "?"
               [0BF].  If  this is  an override logon,  the first  character of
               username is  "!" [0A1].  "Normal"  username characters  will all
               have the high-order bit off.  The USERNAME field MAY  contain an
               optional  Sub-host  field,   following  the  semi-colon   or  CR
               terminating the user-name.   Proxy Key, if present,  will follow
               the semi-colon or CR, and  will itself be terminated by  a semi-
               colon or CR.


        01-9D   4-A0    data text string

                format:

                --------.-------.-------.-------.-------.-------
                |    RPORT      |   n   |   n characters of data
                ------------------------------------------------



        9E      3       detach (originate yellow ball, zap or O.B. or timeout)
        9F      3       disconnect (ZAP circuit)
        A0      3       apply backpressure
        A1      3       release backpressure
        A2      3       flush output (in direction of this message) [GOBBLER]
        A3      3       flush input (in opposite direction to this message)
        A4      3       data lost in this direction [Black Ball]
        A5      3       data lost in opposite direction [Gray Ball]
        A6      3       enter 'DEM'
        A7      3       leave 'DEM'
        A8      3       enter 'Transparency'
        A9      3       leave 'Transparency'
        AA      3       Green Ball
        AB      3       Red Ball
        AC      3       Yellow Ball
        AD      3       Orange Ball
        AE      3       'break' begin
        AF      3       'hang up'
        B0      4       query terminal parameter N, N in byte 4
        B1      5       set terminal parameter N, N in byte 4, value in byte 5

                format:

                --------.-------.-------.--------
                |    RPORT      |  B1   |   N   |
                --------.------------------------
                | value |
                ---------

                        where "value" may be 1 to 4 significant bits (right
                                justified), and:

                N       length  USAGE
                0       1       ECHO CONTROL
                1       1       ECHO CONTROL-I
                2       1       ECHO CR/Rubout on LF
                3       1       ECHO LF on CR
                4       1       CR DELAY
                5       4       INPUT BAUD RATE
                6       4       OUTPUT BAUD RATE
                7       1       PARITY
                8       1       HALF-DUPLEX
                9       4       PARAMETER A
                10      4       PARAMETER B
                11      4       PARAMETER C
                12      1       X-ENABLE
                13      1       ECHO CONTROL-H
                14      1       REVERSE X-ENABLE
                15      4       PARAMETER D
                16      1       KATAKANA
                17      1       TERMINATE OUTPUT on BREAK
                18      1       ECHO-ESC
                19      1       Q-MODE


        B2      6       Pseudo-needle (from Slot 0)

                format:

                --------.-------.-------.--------
                |    RPORT      |  B2   |  key  |
                --------.-------.-------.--------
                |   local key   |
                --------.-------.

             This specifies circuit is built to slot 0.  No messages other than
        B3's or 9F's may  be sent until until  the slot receives a  B6 message.
        Other messages are illegal until the B6 is received.

        B3      4       normal logon character (to Slot 0)

                format:

                --------.-------.-------.--------
                |    RPORT      |  B3   | CHAR  |
                ---------------------------------

             (NOTE...the  high-order  bit of  CHAR  had better  be  on,  or the
        supervisor may ignore the characters.)

        B4      4       normal logon status  (from Slot 0)

                format:

                --------.-------.-------.--------
                |    RPORT      |  B4   | STAT  |
                ---------------------------------

             STAT has the format:

                X X X 0 0 S S S
                | | |     |
                | | |     Status message code:
                | | |     0 - continue
                | | |     1 - "please log in"
                | | |     2 - "error, type username"
                | | |     3 - "error, type password"
                | | |     4 - "username"
                | | |     5 - "password"
                | | empty output buffer
                | echo on
                empty input buffer




             If extended  login-status has  been requested,  then STAT  has the
        format:

                X X X S S S S S
                ----- ---------
                  |       |
                  |       Status message code:
                  |       0-5 - as before
                  |       8 - "please see your rep..."
                  |       9 - "bad mud"
                  |       0A - "circuits busy"
                  |       0B - "host not avail..."
                  |       0C - "host out of ports"
                  |       0D - "host down"
                  |       0E - "host shut"
                  |       0F - "try again in 2 minutes"
                  |       10 - "access not permitted"
                  |       11 - "no host specified"
                  |       12 - "bad host number"
                  |       13 - "mud error"
                as before

        B5      4       Logon failure (from Slot 0)

                format:

                --------.-------.-------.--------
                |    RPORT      |  B5   |  err  |
                ---------------------------------

             where "err" means:
                0       ISIS unable to complete request
                1       format error
                2       bad user name
                3       bad mud
                4       system unavailable
                5       down-line load or dial-out failure
                6       timeout
                7       access not permitted
                8       out of origination ports
                9       try again later
                0A      bad requesting-host number
                0B      requesting-host not up on requesting node




        B6      10d     successful logon from this port (from Slot 0)

                format:

                --------.-------.-------.--------
                |    RPORT      |  B6   |  IIX  |
                |-------.-------.-------.-------|
                |          invoice #            |
                |-------.-------.----------------
                |  Orig. Host.  |
                -----------------

               IIX has the  high-order bit set for  internal (slot-slot)
                       circuits;

               The  low-order 7-bits  of IIX  = 1  indicates IIX-capable
                       circuit, else 0.

        B7      8       addendum to accounting

                format:

                --------.-------.-------.--------
                |     RPORT     |  B7   | ignore|
                |-------.-------.-------.-------|
                | 0E|msg|         value         |
                ---------------------------------

                        See "TYMNET-I" document for format of values.

        B8      3       super-'hang up' (for half-duplex terminals)

        B9      4       set transmit limit

                format:

                --------.-------.-------.--------
                |    RPORT      |  B9   | limit |
                ---------------------------------

             Limit  is the  maximum  number of  characters the  source  of data
        should send before dismissing  and allowing the destination to  look at
        the data, and apply back-pressure, if necessary.  (A number  >9D should
        be treated as 9D.)

        BA      3       'break' end

        BB      3       Zap Acknowledge

             Zap  acknowledge  is returned  by  the dispatcher  to  a  slot, to
        acknowledge that  the dispatcher has  serviced the zapper  (or detach),
        and the port is now free.  This message is dependent upon a CTA control
        bit.  It is ignored if received by the dispatcher.



        BC      3       Enter 'Alternate Output Device Mode'

        BD      3       Leave 'Alternate Output Device Mode'

        BE      4       Zap with reason: sent by slot.

                Format:

                --------.-------.-------.--------
                |    RPORT      |  BE   |reason |
                ---------------------------------

             Message BE is just like message 9F, except that there is  an extra
        byte which may specify the reason.  Currently the only valid  reason is
        "0", signifying host-out-of-ports.

        BF      3       SIIX command

        C0      3       TIIX command

        C1      8       UUN Message

                Format:

                --------.-------.-------.--------
                |     RPORT     |  C1   |unused |
                --------.-------.-------.--------
                |             UUN               |
                ---------------------------------

             Message C1  will be delivered  only on circuits  for which  it has
        been requested in the Request for Normal Pseudo-needle.

        C2-FF   ?       to be defined as the need arises






                            2.3  Intra-ISIS Communications


             RPORT  = 0  has special  significance and  formats.   Each message
        header has the format:

        --------.-------.-------.-------.-------.-------.----
        |       0       |SUBTYPE| additional string dependent on subtype
        -----------------------------------------------------

             In the descriptions below, "key", where used, is 4 times  the slot
        number, since it's most common usage is indexing into word tables.

             Certain of these messages  are dependent upon bits in  the Control
        Table Area (CTA) "CNTRL" bits.  These are identified by  the appearance
        of an "*" next to the message type.

                intra-node subtypes:

        SUB-    LENGTH  USAGE
        TYPE    (BYTES)

        00 *    3       restart-request.   The originating slot will wait for a
                        response!


        01 *    3       restart-response.   Slot originates this in response to
                        an observed type 00,  AFTER resetting the ring indices,
                        and zapping all circuits!


        02 *    4       node has been taken over (originates at slot 0, goes to
                                all interested slots)

                Format:

                --------.-------.-------.--------
                |       0       |  02   |Sup No.|
                ---------------------------------


        03      9       report to supervisor's log  (originate at slot, goes to
                                slot 0)

                format:

                --------.-------.-------.--------
                |       0       |   03  |  key  |
                |-------.-------+-------+-------|
                |     DATA2     | R TYP | DATA1 |
                |-------.-------+-------+--------
                |PROD ID|
                ---------

             R TYP:  Report Type

             PROD ID:  Product ID




        04      12d     report host status (originates in slot, or Dispatcher
                                in response to a 0F request, goes to slot 0)

                format:

                --------.-------.-------.--------
                |       0       |   4   |  key  |
                |-------.-------.-------.-------|
                |  Host number  | number/ports  |
                |-------.-------.-------.-------|
                |      RH#      |status | H key |
                ---------------------------------

           Key is set by the dispatcher.
           "RH#"  is Relative-Host-number.   It is  the number  of the  host in
               question; ie, host  0, host 1, etc.  (of the slot).  It  MUST be
               less than the number of hosts on the slot.
           Status byte currently specifies three distinct parameters:
                    The low 2 bits specify one of 4 host states:

                        0       host answered;
                        1       host down;
                        2       host shut (but up);
                        3       host gone.

                    The next bit (mask 04) specifies if "H key" is meaningful.

                    The next pair of bits (mask x18) specify Collect-call
                        Capability:
                        0       Never accept collect calls;
                        1       Only accept collect calls;
                        2       leave the decision to the destination host;
                        3       unused

           H key is host key:  This  may be provided by certain hosts,  such as
               TYMSHARE's  370's.

               NOTE:   This  message type  is considered  obsolete.  See
                       message  type  10  (extended  Host   status)  for
                       details on interactions.


        05      8       report accounting  (originates in Dispatcher, goes to
                                Slot 0)

                format:

                --------.-------.-------.-------
                |       0       |   5   |unused|
                |-------.-------+-------+------|
                |      accounting message                    --------------------------------



        06 *    8       tell host time (originates in Slot 0, goes to all
                                interested slots)

                format:

                --------.-------.-------.--------
                |       0       |   6   |unused |
                |-------.-------+-------+-------|
                |            GMT                |
                ---------------------------------

                NOTE:###GMT time is in seconds elapsed since 1/JAN/1974.


        07      11d     Pseudo-needle request (originates in slot, goes to
                                Slot 0)

                format:

                --------.-------.-------.--------
                |       0       |   7   |  key  |
                --------.-------+.------+---.---|
                |   local key   |IEU        | P |
                |---------------+-------.-------|
                |  Orig. Host   |  CCT  |
                -------------------------


               Key     Used between  the dispatcher and  Slot 0  to keep
                       track  of the  slot  making the  request,  and is
                       meaningless at the slot level.

               Local Key   Used for the slot to identify a response to a
                       request.   All requests  outstanding  should have
                       unique local keys.

               I       Indicates intelligent interface (IIX-capable).

               E       Request extended login-status (to be  returned in
                       B4 message).

               U       Request UUN (to be returned in C1 message).

               P       4-bit field specifying password format:
                    0:  cleartext password
                    1:  proxy ciphered password
                 2-15:  reserved

               Orig. Host   The origination host number.

               CCT     The  Circuit  Characteristic  Type,   as  defined
                       within  TYMNET.  (Note,  the two  high-order bits
                       should be set -- "or"ed with x'C0.)



        08      11+var  auxiliary circuit request (originates in slot, goes to
                                Slot 0)

                format:

                --------.-------.-------.--------
                |       0       |   8   | key   |
                --------.-------+.------+-------|
                |   local key   |I              |
                --------.-------+-------+------------
                |  Orig. Host   | size  |   string
                -------------------------------------

             Usage is exactly like the 0:07 request, except that the "CCT" byte
        is replaced by a size byte and username string (this should contain the
        username, a ":", and the decimal string denoting the  destination host;
        it is also desirable to terminate the string with either C/R or ";").


        09      7       Unable to provide pseudo-needle (originates in Slot 0
                                OR Dispatcher, goes to slot)

                format:

                --------.-------.-------.--------
                |       0       |   9   |  key  |
                |-------.-------+-------+--------
                |   local key   |  err  |
                -------------------------

                where "err" is:

                0       Slot 0 will not honor request at this time...try later
                1       Format error;
                2       Bad User Name;
                3       Bad Mud;
                4       System Unavailable;
                5       Down-line load or dial-out request failure;
                6       Timeout;
                7       Access not permitted;
                8       Out of origination ports;
                9       Sup will not honor request at this time...try later.



        0A      10d     report host port availability (originates in Slot, goes
                                to Slot 0)

                format:

                --------.-------.-------.--------
                |       0       |   0A  |  key  |
                |-------.-------+-------+-------|
                |  Host number  | number/ports  |
                |-------.-------+---------------|
                |      RH#      |
                -----------------

             Key is set by the dispatcher.

             Number/ports is the number of ADDITIONAL (remaining) circuits that
        can be accepted on this host.   FOR NOW, 0 is translated into  a "soft-
        shut", and non-0 specifies "soft-answer".

               NOTE:   This  message  interacts with  the  ISIS Control-
                       Table.  In particular, "Host number" is forced to
                       the assembled-in values,  and thus may be  left 0
                       for this case.

               ALSO:   See message  type 10  (extended host  status) for
                       additional constraints.


        0B      7       Host unacceptable (From Slot 0)

                format:

                --------.-------.-------.--------
                |       0       |   0B  |  key  |
                |-------.-------+-------+--------
                |  Host number  | err   |
                -------------------------

                Where "err" has the values:
                        0       host table full (in node code)
                        1       impostor, rejected by Sup
                        2       imposter, rejected by node
                        3       illegal host on restricted node

             If slot 0 has no more host table space, and an attempt was made to
        bring a NEW host to a  state other than "GONE", then slot 0  will issue
        this diagnostic  message (with  err = 0)  back to  the slot  making the
        request.

             If the  new host  number already  exists, either  on the  node, or
        elsewhere within the network, this host is classed as an  imposter, and
        rejected.  The dispatcher will set the host "gone".



        0C      10d     report host cost (originates in slot, goes to Slot 0)

                format:

                --------.-------.-------.--------
                |       0       |   0C  |  key  |
                |-------.-------+-------+-------|
                |  Host number  |     cost      |
                |-------.-------+---------------|
                |      RH#      |
                -----------------

               NOTE:   This  message  interacts with  the  ISIS Control-
                       Table.  In particular, "Host number" is forced to
                       the assembled-in values,  and thus may be  left 0
                       for this case.

               ALSO:   See message  type 10  (extended host  status) for
                       additional constraints.


        0D *    3       no supervisor (originates at slot 0, goes to all
                                interested slots)


        0E *    6+var   "1-DOWN" text   (originates at Slot 0,  goes to one or
                                all slots)

                format:

                --------.-------.-------.--------
                |       0       |   0E  |  key  |
                |-------+-------+-------+--------
                | Stype | Size  | Text String . . .
                ----------------------------------

             This message is used to  introduce a text string into one  or more
        slots in  order to provide  the capability of  updating messages  to be
        originated subsequently  by the slot,  which may be  time-critical:  an
        example might  be an  indication of  unavailability at  some particular
        time and date.

               Key     If  the key  is  = 0,  this  is assumed  to  be a
                       broadcast message, and is delivered to  ALL slots
                       (NOTE...A slot will not be presented this message
                       UNLESS it has the "1-DOWN" [bit 400x] bit enabled
                       in the CTA status word).

               Stype   Used to distinguish between (potential) different
                       messages.

               Size    Specifies the length of the text string;  0  is a
                       valid value, and is used to cancel an outstanding
                       message.


        0F      3       Report all hosts   (originates at Slot 0,  goes to the
                                dispatcher,  who  responds  with  current host
                                status)

             This message originates in  slot 0, causes a series  of intra-node
        subtype 4 "Report Host Status" to be returned by the  dispatcher.  Used
        by slot 0 to recover states of all hosts.


        10      14d     EXTENDED report host status  originates in slot,  goes
                                to slot 0)

                format:

                --------.-------.-------.--------
                |       0       |  10   |  key  |
                |-------.-------.-------.-------|
                |  Host number  | number/ports  |
                |-------.-------.-------.-------|
                |    RH No.     |status | H key |
                |.------.-------.----------------
                |IP  0  |  PID  |
                -----------------

               Key     set by the dispatcher.

               RH No.  Relative-Host-number.   It is  the number  of the
                       host in  question; ie, host  0, host 1,  etc. (of
                       the slot).   It MUST be  less than the  number of
                       hosts on the slot.

               Status  currently specifies three distinct parameters:

                    The low 2 bits specify one of 4 host states:
                        0       host answered;
                        1       host down;
                        2       host shut (but up);
                        3       host gone.

                    The next bit (mask x04) specifies if "H key" is meaningful.

                    The next pair of bits (mask x18) specify Collect-call
                        Capability:
                        0       Never accept collect calls;
                        1       Only accept collect calls;
                        2       leave the decision to the destination host;
                        3       unused


               H key   host key:  This may be provided by certain hosts,
                       such as TYMSHARE's  370's.

               I       Host I/Q  is specified by  the high-order  bit of
                       this field.

               P       Proxy Host is specified by the second bit of this
                       field.

               PID     Product ID.

             The Type 10 message is  like the type 04, except for  the addition
        of additional fields for IIX.

               NOTE:   This  message  interacts with  the  ISIS Control-
                       Table.  In particular, unless the CTA permits the
                       number-of-ports  and host-number  to  be changed,
                       these  fields  are  forced  to  the  assembled-in
                       values, and thus may be left 0 for this case.

               ALSO:   This   message  interacts   with  the   0A  (Host
                       availability)  and 0C  (Host cost)  messages.  In
                       particular, the occurance of the type 10 (or type
                       4) message cancels any outstanding type 0A  or 0C
                       messages;  they must be issued again  to continue
                       in effect.






                                     2.4  Circuits


             An interface may originate or terminate circuits, or both.





                    2.4.1  Circuit terminating on a port

             The  first indication  that an  interface has  of a  circuit being
        built TO  the interface, is  the appearance of  a NEEDLE in  the input.
        When the NEEDLE  arrives, the circuit  is already constructed,  and the
        NEEDLE may be followed immediately by messages for that port.
   i@"d