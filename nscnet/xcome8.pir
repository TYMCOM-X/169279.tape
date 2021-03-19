==============================================
==                                          ==
==    NIS Japan, PIR description            ==
==                                          ==
==    for Extended 8bit support on XCOM     ==
==                                          ==
==                         19 DEC 1987      ==
==                         by Yuki Furuta   ==
==                                          ==
==============================================

This is a description of our PIR for future XCOM version.
These functions are supported by James Wang's patch files
on XCOM3.01.

1)OUTLINE
  To support common Japanese KANJI code sets which are described
  by 2byte codes including 80x to 9Fx.
  ACOM 3.xx are already supported these functions by SOPT(E8BTM).
  This PIR requests to have similar and extended function on XCOM.

2)KANJI code sets
  KANJI characters are defined about 8000 sets in Japan, and they
  are described with 16bits (2bytes). The mixed data stream with
  ASCII and KANJI (in addition of that we have KATAKANA on them)
  requires some rules to destinguish one byte or two byte code sets.
  There are several common rules for that, and most popular rules
  on PC comunications are called SHIFT-JIS KANJI.

  SHIFT-JIS KANJI code sets use the code range from 80x to 9Fx for
  1st KANJI code. So 8D,8A,91 and 93 are not control characters
  but just user's data streams.

3)ETM/LTM
  CONSAT 6.xx and E8BTM can support above codes. Host interface
  sends ETM just after the establishment of a circuit.
  CONSAT 6.xx and TID-O (or TID-I with KANA EQ 1) changes its
  own mode into extended 8bit mode, if it receives ETM from
  destination interface.

  In this CONSAT mode, CONSAT handle all 80x-FFx data from terminal
  as data, it means 8D,8A,91 and 93 is handled as data and sent
  to host interface with DEM command. The host interface also should
  handle them as data, in other words, do not insert LF or CR for
  8D and 8A.

  And if the circuit is cleared by host (including investment of
  clear PAD x.29), XCOM should send LTM to originator. This is a
  requirement if originator is MSV.

4)LF/CR parity   
  XCOM should insert 0Ax or 0Dx for 0Dx or 0Ax, should not insert
  8Ax or 8Dx for them. And be sure to do not insert any characters
  for 8Dx and 8Ax.

5)Messages which are generated by XCOM.
  This is not supported by ACOM, but (QSATS)XCOM03.PDE and PDF 
  already support  it.

  In these 8bit terminals all characters which have parity bit on
  are not ASCII characters. And unfortunately , all ASCII messages
  which are assembled by NAD have mark parity on them. Thus user
  cannot read these messages such as 'call cleared..'.

  The above two patch reset parity bit on these own messages, not
  user data.


6)Message output in transparent mode
  The current XCOM's transparent mode is designed for non-ASCII
  terminals, in that case it is no sense to send XCOM's message
  to terminal. But in our case, this is ASCII based extended
  code sets, all ASCII characters are readable on the same terminal.
  So the patch sends all messages even if it is in transparent
  state.

7)ECHOAB
  Current patch echoes all data if it has high bit on in DEM.
  But it will be more frexible if ECHOAB can describe from
  01 to FF code in it. ACOM is designed with that way.

We very appreciate James Wang's many times works, and hope to
support them by some new MACRO statement on specific link.

e.o.f.
