;;
;;      SET RELATIVE LINK NUMBER (0-31) IN THE FOLLOWING SYMBOL COMMAND.
;;
$A[CTLID:
((CTLID+2)/2)-1[CTRHW:
CTRHW*2[CTRHA:
((CTLID+$A16)/$A16)-1[CTRBH:
CTRBH*2[CTRBA:
CTLID-(CTRBH*$A16)[CTRBN:
CTLID#
CTRHW#
CTRHA#
CTRBA#
CTRBN#
CTRBH#
F128.F+CTRBA] HC 1^(($A16-CTRBN)-1)
P128.F+CTRBA] HC 1^(($A16-CTRBN)-1)
xsstat+CTRHA]       HC      0505
XSSTAT+CTRHA,2[
F128.F,4[
P128.F,4[
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
f128.f,4:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
p128.f,4:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
:w p128.f,0
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0303
xpstat+ctlid,1:w
;XF128RR.CMD
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
;;      THE FOLLOWING DONE WITH FRAME ADDRESSES REVERSED
PADRT+CTRHA]HC 0101
PADRT+CTLID,1:W
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
PADRT+CTRHA]HC 0303
PADRT+CTLID,1:W
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0202
xpstat+ctlid,1:w
;XF128FR.CMD
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
F128.F+CTRHA] WC 1^($A16-CTLID)
F128.F+CTLID,1:W
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
;XFRRREJ.CMD
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
:w f128.f,0
xsstat+ctlid,1:w
;XFRRREJ.CMD
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
;XFRRREJ.CMD
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
;XFRRREJ.CMD
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
;XF128FR.CMD
;XFRRREJ.CMD
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
;XFRRREJ.CMD
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
;XFRRREJ.CMD
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
;XFRRREJ.CMD
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0303
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0606
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0707
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0606
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA]       HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0404
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
xpstat+CTRHA] HC      0505
xpstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0505
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0202
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0808
xsstat+ctlid,1:w
xsstat+CTRHA]       HC      0404
xsstat+ctlid,1:w
;;      **** >>>> END OF TEST FL1ER0.CMD <<<< ****
