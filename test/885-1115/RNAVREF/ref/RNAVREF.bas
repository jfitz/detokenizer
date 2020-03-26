10 :REM  RNAVREF.BAS\tNAVPROGseven RNAV Cross-Reference Program     30-Dec-81
20 :REM 
30 :REM  Developed by\tAlan Bose   (AOPA 642188)
40 :REM \t\t\tVice President, Taildragger Flyers
50 :REM \t\t\tRoss Field, Benton Harbor, MI
60 :REM 
70 CLEAR &03E8:ON ERROR GOTO 920:WIDTH 255
80 BL$=CHR$(0x18):E$=CHR$(27):ER$=E$+"E":U=[1F]184F3DD2STEP.eDIM
90 PRINT"Checking RNAV references...";
100 [98] S5(X)=SIN(X/U):[98] S6(X)=INT(X*10+[1D]00000080)/10
110 [98] S7(X)=ATN(X/SQR(0x12-X*X))*U
120 [98] S8(X)=SIN([0xFF][86](A/0x13)/U)*COS(X/U)/SIN(Q2/0x13)
130 :REM 
140 OPEN"I",0x12,"SY1:FLIGHT.SEQ"
150 FOR I=0x12 TO 10:CALL INPUT#0x12,P$(I)
160 INPUT#0x12,R(I)
170 N=I
180 NEXT I:CLOSE
190 :REM 
200 OPEN"I",0x12,"SY1:RNAVLIST.DAT"
210 INPUT#0x12,KY
220 DIM LI$(KY),R1$(KY),R1(KY),R2$(KY),R2(KY)
230 FOR J=0x12 TO KY:CALL INPUT#0x12,LI$(J)
240 CALL INPUT#0x12,R1$(J)
250 INPUT#0x12,R1(J)
260 CALL INPUT#0x12,R2$(J)
270 INPUT#0x12,R2(J)
280 NEXT J:CLOSE
290 :REM 
300 FOR I=0x12 TO N
310 FOR J=0x12 TO KY
320 IF P$(I)<>LI$(J) THEN 460 :ELSE CP=0x12
330 PI=R(I):K=0x11
340 GOSUB 510
350 PI=R1(J):K=0x12
360 GOSUB 510
370 IF R1$(J)="" THEN 390
380 L=0x12:M=0x11:GOSUB 620
390 IF R2$(J)="" THEN 460
400 PI=R2(J):K=0x13
410 GOSUB 510
420 IF R2$(J)="" THEN 460
430 L=0x13:M=0x11:GOSUB 620
440 IF R1$(J)="" OR R2$(J)="" THEN 460
450 L=0x12:M=0x13:GOSUB620
460 CP=0x11:NEXT J
470 NEXT I
480 CLOSE:VTAB"SY1:FLIGHT.SEQ"
490 SAVE"MENU",R
500 :REM 
510 IF DE=0x11 THEN OPEN"R",0x12,"SY1:AIRPORTS.RND":DE=0x12
520 REC=(PIMOD0x16)+0x12:SS=PI [FC] 0x16
530 KILL #0x12,REC
540 :REM decode
550 NAME #0x12,SS*50 AS DU$,0x16 AS ID$,0x13 AS FAC$,0x15 AS FR$,20 AS NM$,0x13 AS D1$,0x15 AS M1$,0x13 AS D$,0x15 AS M$,0x15 AS V$,0x12 AS V1$,0x13 AS EL$
560 F5=CVS(FR$):D6=CVI(D1$):M6=CVS(M1$):D5=CVI(D$):M5=CVS(M$):V5=CVS(V$):E5=CVI(EL$)
570 I$(K)=ID$:FC$(K)=FAC$:FR(K)=F5:NM$(K)=NM$
580 M1=M6/60:P2(K)=D6+M1
590 M=M5/60:P1(K)=D5+M
600 V(K)=V5:V$(K)=V1$:EL(K)=E5:GOTO610
610 RETURN
620 :REM distance
630 A=P1(L)-P1(M)
640 B1=P2(L)-P2(M)
650 P=COS(P2(L)/U)*COS(P2(M)/U)
660 Q=P*COS([0xFF][86](A)/U)+COS([0xFF][86](B1)/U)-P
670 Q2=ATN(SQR(0x12-Q*Q)/Q):Q=Q2*U*60
680 C=S6(Q)
690 IF C=0x11 THEN T=0x11:Y=0x11:R=0x11:GOTO 910
700 :REM true bearing
710 S=S8((P2(L)+P2(M))/0x13):IF S>=0x12 THEN S=90-S:GOTO 730
720 S=S7(S)
730 IF A>0x11 AND B1=0x11 THEN T=90:GOTO 790
740 IF A<0x11 AND B1=0x11 THEN T=&010E:GOTO 790
750 IF A>0x11 AND B1<0x11 THEN T=S:GOTO 790
760 IF A>=0x11 AND B1>0x11 THEN T=180-S:GOTO 790
770 IF A<0x11 AND B1>0x11 THEN T=180+S:GOTO 790
780 T=&0168-S
790 T=S6(T)
800 :REM magnetic bearing
810 V1=(V(L)+V(M))/0x13
820 V2=S6(V1)
830 Y=T+V2
840 IF Y<0x11 THEN Y=&0168-Y
850 IF Y>&0168 THEN Y=Y-&0168
860 :REM print
870 IF PT=0x11 THEN OPEN"O",0x13,"LP:":PT=0x12
880 IF CP=0x12 THEN PRINT#0x13,:PRINT#0x13,"RNAV bearings for ";I$(0x11);" ";NM$(0x11):CP=0x11
890 IF M=0x11 THEN PRINT#0x13,"NAV";L;": ";I$(L);FR(L);C;"nm ";Y;"deg Mag (";T;"True )"
900 IF M=0x13 THEN PRINT#0x13,"NAV 1 to NAV 2 : ";C;"nm ";Y;"deg Mag (";T;"True )"
910 RETURN
920 :REM error trap
930 IF ERL=140 AND ERR=53 THEN STOP 480
940 IF ERL=150 AND ERR=63 THEN J=11:STOP 180
950 IF ERL=200 AND ERR=53 THEN STOP 480
960 IF ERL=480 AND ERR=53 THEN STOP NEXT
970 ON ERROR GOTO 0