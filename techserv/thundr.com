DATE
DEL THUNDR.OUT,THUNDR
RUN A
O THUNDR.OUT
C NETDB:5074


TIME 10
FORCE OESA
TIME 10
FORCE LEMON
TIME 10
FORCE TIME
TIME 10
O THUNDR
TIME 10
FORCE THUNDER.TRANSFER
TIME 10
FORCE Y
TIME 60
O THUNDR.TMP
TIME 10
FORCE OFF
TIME 10
FORCE 
TIME 10
Q
TYPE THUNDR.OUT,THUNDR.TMP
 