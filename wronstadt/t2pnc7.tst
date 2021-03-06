:****************************************************************
: Patch name:  t2pnc7.tst	Product and Version:  TIIG 5.22
:     Author:  scott wedel  	       Organization:  STS
:   Customer:  DEC   		       Date Written:  08/01/88
: Reason for patch:  Special stuff for DEC as described below:
:               3 1 0 6 7 0 4 H H H H S S S             (CALLED ADDRESS)
:               ------- ----- ------- -----
:               |       |     |       |
:               |       |     |       SUB-ADDRESS
:               |       |     HOST #
:               |       PNIC
:               DNIC
:
:               OUTPUT TO PUBLIC NETWORK SUP (BEFORE GATEWAY MODIFICATION)
:               ----------------------------------------------------------
:               7 0 4 : . H H H H S S S
:
:               OUTPUT TO DEC PRIVATE NETWORK SUP (AFTER GATEWAY MODIFICATION)
:               --------------------------------------------------------------
:               7 0 4 H H H H : . S S S
:
:               PUBLIC NETWORK VALIDATIONS
:               --------------------------
:               704
:
:               DEC PRIVATE NETWORK VALIDATIONS
:               -------------------------------
:               7040000 - 7049999
:
:       Also: username 704 is a transparent username and if username 704
:       is not followed by a subhost then drop back to nontransparent
:       login prompt.
:
:       Define switch T2PNIC wchi enables the patch and says macro
:       T2PNCM [ SC /username/] is defined.  The 'username' should not
:       include any control characters or be followed by a CR, colon or
:       semicolon.

:       Internals:  When receive needle with transparent username from
:       the HNET (and only the HNET) then see if it matches the pnic
:       username.  If not, just return to existing logic.  If a match then
:       continue searching for the colon, semicolon or CR.  If colon then
:       ship up the username to INEt supe then go back and find the dot (or
:       CR or semi and ship these if found and exit) and move the four digits
:       after the dot (if less then just terminate it with a CR) then insert
:       a colon, insert a dot and ship everything left including the same
:       termination character (Cr or semi) that was originally used.
:     If the username matches but is followed with a CR or semi (no host stuff)
:       then reset the transparent bit and jump to nontransparent logic.
:*********************************************************************

        if      t2gate                  :only for gateways
        if      t2pnic                  :option selected
        org     pa1ptr
q       eq      .
        T2PNCM                          :invoke the username macro
        hs      0
qxlen   eq      .-q                     :length of username data
        org pa1ptr ; re qxlen ; bc 0 ; er :clear macro stuff
        patch(880801,1300,sdw.T2PNIC,GDB210+0e,,6)
        j       pnc000,,
        conpatch(pa0ptr,,14)
pncsv0  bs      10                      :storage for real host number
pncsv1  hs      2                       :save of where to put subhost
        conpatch(pa1ptr,,qxlen+0d6)
pncnum  t2pncm                          :invoke macro with SC /uname/
        hs      0                       :off of byte booundary
pnc000  ar      r1,r0                   :existing
        jal     r8,dirmes,,             :existing
        l       r3,bb,r2,               :start of username in needle
        lis     r7,0                    :index while doing match
pnc001  jal     r8,pci,,                :get character
        ohi     r1,80
        clb     r1,pncnum+1,r7          :does it match?
        jn      pnc900                  :exit (no username match)
        ais     r7,1
        clb     r7,pncnum               :end of stored username?
        jnbs    pnc001                  :no, next char
        lb      r1,0,r3                 :peek at next char
        nhi     r1,7f
        shi     r1,3a                   :colon
        jefs    pnc003
        sis     r1,3b-3a                :followed by a semi colon?
        jefs    pnc002
        ahi     r1,3b-0d                :or followed by a cr
        jn      pnc900                  :username only starts with 704
pnc002  rbt     chn,gttrns              :uname is 704 and has no subhost
        j       gdb216,,                :so revert to nontransparent logon

pnc003  st      r3,pncsv1,,             :save position of colon
        lis     r7,0                    :index within save table
pnc004  jal     r8,pci,,                :get char
        ohi     r1,80
        stb     r1,pncsv0,r7,           :save it
        ais     r7,1
        shi     r1,8d                   :Cr (end without subhost)
        je      pnc900
        shi     r1,0bb-8d               :semi colon? (end without subhost)
        je      pnc900
        ais     r1,0bb-0ae              :or the '.'?
        jn      pnc004                  :no, do another char

        l       r4,pncsv1,,             :now move the hhhh field to where colon
        lis     r6,4                    :four characters to move
pnc008  jal     r8,pci,,                :get byte of 'h'
        lr      r0,r3
        lr      r3,r4
        stb     r1,0,r3                 :move onto colon field
        jal     r8,nci,,                :move to next char in buffer
        lr      r4,r3
        lr      r3,r0                   :restore r3 for pci
        nhi     r1,7f                   :early end of this field?
        clhi    r1,0d                   :CR?
        jefs    pnc010                  :exit since no more hhhh field
        clhi    r1,3b                   :semi?
        jefs    pnc010
        sis     r6,1                    :moved our four chars?
        jg      pnc008                  :move another h

pnc010  lr      r3,r4                   :now to put colon, real host then dot
        lis     r6,0
pnc011  lb      r1,pncsv0,r6,
        stb     r1,0,r3
        jal     r8,nci,,                :update buffer pointer
        ais     r6,1
        clhi    r1,0ae                  :our dot?
        jnbs    pnc011
pnc900  j       gdb210+14,,             :exit
 endpatch(Have Gateway handle X.25 pnic 7 feature)
        ei
        ei
   