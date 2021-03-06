
   DESIGN OBJECT

  KANJI code translate support MENU server

  This document will discuss the major consideration for implementing for
 KANJI code translate support in the menu server product. This product will
 be used in the Japanese market and support to translate JIS7 host code to
 SFTJIS host code.


 1. Function summary

 1) This problem runs as an tymnet engine and fuctions as a middle of problem.
    Following belows calls as "KANJI SERVER" (KSV).


                     o------------------------------o
                    (                                )
                   (          T Y M N E T             )
   JIS7           (                                    )    JIS8
   JIS KANJI      |                                    |    SFTJIS KANJI
                  |------+  +----------------+  +------|
  +----------+    |      |  |  KANJI SERVER  |  |      |    +----------+
  | HOST     |----| X.25 |\ |                | /| X.25 |----| HOST     |
  +----------+    |------+ \|  (EXCHANGE)    |/ +------|    +----------+
                  |         |                |         |
  +----------+    |------+ /|  NO PACKET     |\ +------|    +----------+
  | TERMINAL |----| ASYNC|/ |  INTERFACE     | \| ASYNC|----| TERMINAL |
  +----------+    |------+  |                |  +------|    +----------+
                  (         +----------------+         )
                   (                                  )
                    (                                )
                     o------------------------------o

 2) KANJI server run as an non-packet interface in the network. For instance,
    in case of use to connect X.25 to X.25, KANJI server branches two indepe-
    ndent call of PT(X.25)-NPT(KSV) and NPT(KSV)-PT(X.25).
    That is, KSV don't pass the packet with transparent such as X.29 packet
    except for data.



 3) KANJI menu server displays a selection menu of host for terminal user
    like as tymnet menu server, and enable to select of multiple host, and
    to connect to single destination host in automatically without invention
    in menu. When we designen server, we must decide which sequence we support.
    