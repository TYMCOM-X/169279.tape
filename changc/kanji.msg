:this file is used to test kanji shift codes to CRT and LU3 printer

	GL	THRCV
THRCV	EQ	0		: TURN OFF GENRCV CODE FOR MEMORY SAVING
THOST	EQ	1		: TURN ON TEST HOST
NMX     EQ      0F1
MXX1	MACRO [
	HS	0
QQY	EQ	.
	HC	0
QY      EQ      .
	BC	27,EWCMD,0CB
	BC	SBA.,0E9,0C0
	BC	T.,H.,I.,S.,40,E.,N.,T.,I.,R.,E.,40,S.,C.,R.,E.,E.,N.,40
	BC	I.,S.,40,U.,N.,F.,O.,R.,M.,A.,T.,T.,E.,D.
	BC      RA.,0F3,0CF,58  :ROW7COL20
	bc      0a,42           :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC,0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6
	BC      0B7,0B0,0B7,0C7,0B6,0B8,0F1,0B9,0C1,0A5,0F6,0A6,0B0,0BC,0C5
	BC      0B1,0D1,0BF,0F4,0BB,0FA
	bc      0a,41           :KSI for Hit
	BC	K.,A.,T.,A.,K.,A.,N.,A.,40
	BC	9F,48,58,0AF,95,0BE	:katakana
:	BC	SBA.,0F3,0CF	:back to row7col20
:	BC	IC.,0F1		:ISRT CRSR ON THE 1ST HLF OF A KANJI CHAR
QX      EQ      .-QY
QQX     HS      0
	ORG     QQY
	HC      QX
	ORG     QQX
]
MXX2	MACRO [
	HS	0
QQY	EQ	.
	HC	0
QY      EQ      .
	BC      27,EWCMD,0CB
	BC      SBA.,0E0,0C0    :row1 col1
	BC      SF.,0C0,0C0     :field heading
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
	BC	40,40,I.,S.,40,T.,H.,I.,S.,40,E.,N.,G.,L.,I.,S.,H.,6F
	BC      SBA.,0F0,0C2    :row2 col2
	BC	SF.,0C1,0C1
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
	BC      SBA.,0E2,0C5    :row3 col3
	BC	SF.,0C2,0C2
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
	BC      SBA.,0F0,0C7    :row4 col4
	BC	SF.,0C3,0C3
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
	BC      SBA.,0E4,0CA    :row5 col5
	BC	SF.,0C4,0C4
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
	BC      SBA.,0F5,0CC    :row6 col6
	BC	SF.,0C5,0C5
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
	BC      SBA.,0E6,0CF    :row7 col7
	BC	SF.,0C6,0C6
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
	BC      SBA.,0F7,0D1    :row8 col8
	BC	SF.,0C7,0C7
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B2,0A1,0B9,0CC
	BC      0B4,0F7,0B5,0A6,0B5,0B7,0B4,0DE,0B6,0E4
	BC      0B7,0B0,0B7,0C7,0B6,0E4,0B8,0F1,0B9,0C1
	BC      0A5,0F6,0A6,0B0,0BC,0C5,0BB,0F8,0BB,0BB
	bc      0a,41              :KSI for Hit
QX      EQ      .-QY
QQX	HS	0
	ORG	QQY
	HC	QX
	ORG	QQX
]
MXX3	MACRO [
	HS	0
QQY	EQ	.
	HC	0
QY      EQ      .
	BC	27,EWCMD,0CB
	BC	SBA.,0E9,0C0
	BC	SF.,0C0,0C8 
	BC	T.,H.,I.,S.,40,E.,N.,T.,I.,R.,E.,40,S.,C.,R.,E.,E.,N.,40 
	BC	I.,S.,40,P.,R.,O.,T.,E.,C.,T.,E.,D.
	BC      RA.,0F3,0CF,58  :ROW7COL20,-
	bc      0a,42              :KSO for Hit
	BC      0B1,0D1,0BF,0F4,0BB,0FA
	bc      0a,41              :KSI for Hit
	BC	SF.,0C1,0C9 
	BC	T.,H.,I.,S.,40,E.,N.,T.,I.,R.,E.,40,S.,C.,R.,E.,E.,N.,40 
	BC	I.,S.,40,P.,R.,O.,T.,E.,C.,T.,E.,D.
	BC      RA.,0F0,0D6,40  :ROW10col1,space
	bc      0a,42              :KSO for Hit
	BC      0B1,0D1,0BF,0F4,0BB,0FA
	bc      0a,41              :KSI for Hit
	BC	SF.,0C2,0CA 
	BC	T.,H.,I.,S.,40,E.,N.,T.,I.,R.,E.,40,S.,C.,R.,E.,E.,N.,40 
	BC	I.,S.,40,P.,R.,O.,T.,E.,C.,T.,E.,D.
	BC      RA.,0E0,0E3,00  :ROW15col1,null
	bc      0a,42              :KSO for Hit
	BC      0B1,0D1,0BF,0F4,0BB,0FA
	bc      0a,41              :KSI for Hit
	BC	SF.,0C3,0CB 
	BC	T.,H.,I.,S.,40,E.,N.,T.,I.,R.,E.,40,S.,C.,R.,E.,E.,N.,40 
	BC	I.,S.,40,P.,R.,O.,T.,E.,C.,T.,E.,D.
	BC      RA.,0F0,0EF,5A  :ROW20col1,!
	bc      0a,42              :KSO for Hit
	BC      0B1,0D1,0BF,0F4,0BB,0FA
	bc      0a,41              :KSI for Hit
QX      EQ      .-QY
QQX     HS      0
	ORG     QQY
	HC      QX
	ORG     QQX
]
MXX4	MACRO [MXX2]

NMX	EQ	0F1
MYY1     MACRO [
	HS	0
QQY	EQ	.
	HC	0
QY	EQ      .
        BC      ESC.,0F5,0CB
	bc      0a,42              :KSO for Hit
	BC      0B1,0B3,0B1,0B4,0B1,0B5,0B1,0B6,0B1,0B7,0B1,0B8,0B1,0B9
	bc      0a,41              :KSI for Hit
        BC      H.,E.,L.,L.,O.,SP.,D.,O.,L.,L.,SP.,P.,R.,T.,SP.
        BC      NMX
NMX	EQ	NMX+1
QX      EQ      .-QY

QQX	HS	0
	ORG	QQY
	HC	QX
	ORG	QQX
]
MYY2     MACRO [
	HS	0
QQY	EQ	.
	HC	0
QY	EQ      .
        BC      ESC.,0F5,0CB
	bc      0a,42              :KSO for Hit
	re	30
	BC      0B1,0B3,0B1,0B4,0B1,0B5,0B1,0B6,0B1,0B7,0B1,0B8,0B1,0B9
	er
	bc      0a,41              :KSI for Hit
        BC      H.,E.,L.,L.,O.,SP.,D.,O.,L.,L.,SP.,P.,R.,T.,SP.
        BC      NMX
NMX	EQ	NMX+1
QX      EQ      .-QY

QQX	HS	0
	ORG	QQY
	HC	QX
	ORG	QQX
]
MYY3     MACRO [MYY1]
MYY4     MACRO [MYY2]
:
: TEST MESSAGE FOR THOST
: FOR THOST
:

NMX     EQ      0F1
MX1     MACRO [
	HS	0
IQQY	EQ	.
	HC	0
IQY	EQ	.
        BC      ESC.,EWCMD,0C2	 	:esc,E/W,keyboard
	BC      SBA.,40,40
	BC      U.,N.,F.,O.,R.,M.,A.,T.,T.,E.,D.,40,S.,C.,R.,E.,E.,N.,N1.
	BC      RA.,0C5,0C9,60  :ROW5COL10
	bc      0e              :KSO for IBM i.e. start of Kanji
	BC      45,0EE,46,0CC,48,0F2,45,0BB,49,7C,47,0E5,4E,55
	bc      0f              :KSI for IBM i.e. end of Kanji
	BC      RA.,0D8,0C3,4E  :ROW5COL10 w/ +
	bc      0e              :
	BC      45,0EE,46,0CC,48,0F2,45,0BB,49,7C,47,0E5,4E,55,40,40
	bc      0f              :
	BC	K.,A.,T.,A.,K.,A.,N.,A.,40,40
	BC	9F,48,58,0AF,95,0BE
	BC      I.,S.,40,T.,H.,I.,S.,40,E.,N.,G.,L.,I.,S.,H.
IQX	EQ	.-IQY
IQQX	HS	0
	ORG	IQQY
	HC	IQX
	ORG	IQQX
]
MX2     MACRO [
	HS	0
IQQY	EQ	.
	HC	0
IQY	EQ	.
        BC      ESC.,EWCMD,0C2	 	:esc,E/W,keyboard
	BC      SBA.,40,40
	BC	SF.,41
	BC      T.,H.,I.,S.,40,E.,N.,T.,I.,R.,E.,40,S.,C.,R.,E.,E.,N.,40
	BC      I.,S.,40,F.,O.,R.,M.,A.,T.,T.,E.,D.
	BC      RA.,0C5,0C9,60  :ROW5COL10
	BC	SF.,40
	bc      0e              :KSO for IBM i.e. start of Kanji
	BC      45,0EE,46,0CC,48,0F2,45,0BB,49,7C,47,0E5,4E,55
	bc      0f              :KSI for IBM i.e. end of Kanji
	BC	SF.,0E8
	BC	0F1,0F2,0F3,0F4,0F5,0F6,0F7,0F8,0F9
	BC      SBA.,4B,0D4     :row10col5
	BC      SF.,6C
	bc      0e              :
	BC      45,0EE,46,0CC,48,0F2,45,0BB,49,7C,47,0E5,4E,55
	bc      0f              :
	BC	SF.,0E8
	BC      I.,S.,40,T.,H.,I.,S.,40,E.,N.,G.,L.,I.,S.,H.
IQX	EQ	.-IQY
IQQX	HS	0
	ORG	IQQY
	HC	IQX
	ORG	IQQX
]

MX3     MACRO [
	HS	0
IQQY	EQ	.
	HC	0
IQY	EQ	.
        BC      ESC.,EWCMD,0C2	 	:esc,E/W,keyboard
	BC      SBA.,40,40
	BC	SF.,41
	BC      T.,H.,I.,S.,40,E.,N.,T.,I.,R.,E.,40,S.,C.,R.,E.,E.,N.,40
	BC      I.,S.,40,F.,O.,R.,M.,A.,T.,T.,E.,D.,40,I.,B.,M.,61
	BC	K.,A.,N.,J.,I.,40

	BC      RA.,0C5,40,5C   :ROW5COL1   *********
	BC	SF.,40		:case 1 attABCsiK K soDEFatt
	BC	A.,B.,C.	:       attABCXsiK soDEFnulatt
	bc      0e              :KSI for IBM i.e. start of Kanji
	BC      45,0EE,46,0CC
	bc      0f              :KSO for IBM i.e. end of Kanji
	BC	D.,E.,F.
	BC	SF.,40

	BC	RA.,0C7,60,6C  :ROW7COL1  %%%%
	BC	SF.,0C8		:case 2 attABCsiK soDEFatt
	BC	A.,B.,C.	:       attABCXDEFnulnulnulatt
	bc      0e              :KSI for IBM i.e. start of Kanji
	BC      45,0EE
	bc      0f              :KSO for IBM i.e. end of Kanji
	BC	D.,E.,F.
	BC	SF.,0C8

	BC      RA.,4A,40,50   :row9COL1 &&&&
        BC      SF.,40          :case 3 attABCsiK K K K soDEFatt   
	BC      A.,B.,C.        :       attABCsiK K soXDEFnulatt 
	bc      0e              :KSI for IBM i.e. start of Kanji
	BC      45,0EE,46,0CC
	bc      0f              :KSO for IBM i.e. end of Kanji
	BC      D.,E.,F. 
	BC      SF.,40

	BC	RA.,4C,60,4E	:ROW11COL1 +++
	BC      SF.,0C8		:case 4 attABCsiK K K soDEFatt
	BC      A.,B.,C.        :       attABCsiK soXDEFnulnulnulatt
	bc      0e 
	BC      45,0EE,46,0CC,48,0F2
	bc      0f              :
	BC	D.,E.,F.
	BC	SF.,0C8

        BC      RA.,4F,40,5B  :ROW13COL1 $$$$$
	BC      SF.,40          :case 5 attABCsiK K K K soDEFatt  
	BC      A.,B.,C.        :       attABCsiK soXsiK soDEFnulatt 
	bc      0e              :KSI for IBM i.e. start of Kanji
	BC      45,0EE,46,0CC,48,0F2,45,0BB
	bc      0f              :KSO for IBM i.e. end of Kanji
	BC      D.,E.,F. 
	BC      SF.,40 
								 
	BC	SBA.,0D1,6E	:ROW15COL15
	BC	SF.,0E8
	BC      I.,S.,40,T.,H.,I.,S.,40,E.,N.,G.,L.,I.,S.,H.
IQX	EQ	.-IQY
IQQX	HS	0
	ORG	IQQY
	HC	IQX
	ORG	IQQX
]

MX4	MACRO [MX2]

NMX	EQ	0F1
MY1     MACRO [
	HS	0
IQQY	EQ	.
	HC	0
IQY     EQ      .
        BC      ESC.,0F5,0C8
	bc      0e
	BC      45,0EE,46,0CC,48,0F2,45,0BB,49,7C,47,0E5,4E,55
	bc	0f
	BC	I.,S.,40,T.,H.,I.,S.,40,E.,N.,G.,L.,I.,S.,H.,40
	BC	NMX
NMX	EQ	NMX+1
IQX	EQ	.-IQY
IQQX	HS	0
	ORG	IQQY
	HC	IQX
	ORG	IQQX
]
MY2     MACRO [MY1]
MY3     MACRO [MY1]
MY4     MACRO [MY1]

MR1	MACRO[
	HS	0
	HC	7
	BC	7D,40,40
	BC	T.,E.,S.,T.
	]
RCVM1	MACRO [MR1]
