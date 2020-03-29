10 :REM  AUTONAV.BAS\tAutomatic Route Selection Program     08-Jan-82
20 :REM  by Alan Bose
30 CLEAR2000:WIDTH255
40 BL$=CHR$(7):E$=CHR$(27):ER$=E$+"E":PG$=E$+"p":QG$=E$+"q":Y$=E$+"Y":L$=E$+"K":J$=E$+"j":K$=E$+"k":J1$=E$+"J":U=403
50 DEFFNC$(C1,C2)=Y$+CHR$(C1+31)+CHR$(C2+31):H$=FNC$(2,1)
60 DEFFNS6(X)=INT(X*10+0.5)/10
70 DEFFNS7(X)=ATN(X/SQR(1-X*X))*U
80 DEFFNS8(X)=SIN(ABS(A/2)/U)*COS(X/U)/SIN(Q2/2)
90 FOR I=8383 TO 8391:DT$=DT$+CHR$(PEEK(I)):NEXT I
100 PRINTFNC$(25,1);ER$;E$+"H";ER$;"Standby one..."
110 :REM 
120 OPEN"R",1,"SY1:AIRPORTS.RND"
130 MD=LOC(1)*5
140 DIM ID$(MD),FA$(MD),LT(MD),LN(MD),PR(MD),W(20),D(20),H(20)
150 FOR J=1 TO MD:REC=((J-1)MOD5)+1:SS=(J-1) [FC] 5
160 IF [0xFF][AF](1)<>REC THEN GET#1,REC
170 OPTION#1,SS*50 AS DU$,5 AS ID$,2 AS FAC$,24 AS DU$,2 AS D1$,4 AS M1$,2 AS D$,4 AS M$
180 ID$(J)=ID$:FA$(J)=FAC$:D6=[0xFF][AA](D1$):M6=CVI(M1$):D5=[0xFF][AA](D$):M5=CVI(M$)
190 IF ASC(ID$(J))=0 THEN ID$(J)="     "
200 IF ID$(J)="     " THEN PR(J)=3
210 M1=M6/60:LT(J)=D6+M1
220 M=M5/60:LN(J)=D5+M
230 NEXT J
240 :REM 
250 PRINTER$;FNC$(1,20);"NAVPROGseven Automatic Route Preparation"
260 PRINTFNC$(7,1);J1$;"Enter departure point  <MENU>  ";J$;STRING$(5,95);K$;:LINE INPUT X$
270 IF X$="" THEN CLOSE:LOAD"MENU",R
280 I=1:GOSUB1790:GOSUB1310:IF FD=0 THEN 260
290 P2=LT(W(1)):P1=LN(W(1)):PR(PI)=2:XT=P2:NT=P2:XN=P1:NN=P1
300 :REM 
310 PRINTFNC$(7,1);J1$;"Enter destination  <EXIT>  ";J$;STRING$(5,95);K$;:LINE INPUT X$
320 IF X$="" THEN 260
330 MC=3:I=3:GOSUB1790:GOSUB1310:IF FD=0 THEN 310
340 P4=LT(W(3)):P3=LN(W(3)):PR(PI)=2
350 GOSUB1600:PH=T:TD=C
360 IF TD<30 THEN PRINTFNC$(7,1);J1$;"That's a lot of work for a";INT(TD);"mile flight.  Continue? (Y or N) ";:X$=INPUT$(1):GOSUB1790:PRINTX$:IF X$="N" THEN 250 :ELSE IF X$<>"Y" THEN PRINTBL$;:GOTO360
370 :REM 
380 PRINTFNC$(7,1);J1$;"Enter specific checkpoint to overfly, if desired  <CONTINUE> ";J$;STRING$(5,95);K$;:LINE INPUT X$
390 IF X$="" THEN W(2)=W(3):W(3)=0:MC=2:NW=0:GOTO450
400 I=2:GOSUB1790:GOSUB1310:IF FD=0 THEN 380
410 PRINTFNC$(7,1);BL$;L$;"90 degree course change doubles time needed to calculate."
420 P2=LT(W(2)):P1=LN(W(2)):PR(PI)=2:NW=1
430 GOSUB1600:TD=C:DH=ABS(PH-T):IF DH>180 THEN DH=360-DH
440 P4=LT(W(1)):P3=LN(W(1)):GOSUB1600:TD=TD+C
450 MV=30+DH
460 I=5:PRINTFNC$(7,1);L$;
470 PRINTFNC$(I+2,1);J1$:PRINT"Enter checkpoint to be disregarded, if desired  <CONTINUE> ";J$;STRING$(5,95);K$;:LINE INPUT X$
480 IF X$="" THEN 510
490 GOSUB1790:GOSUB1310:IF FD=0 THEN 470
500 I=I+1:PR(PI)=3:PRINT"  WILL BE IGNORED":GOTO470
510 PRINTFNC$(I+3,1);J1$;"Correct? (Y or N) ";:X$=INPUT$(1):GOSUB1790:PRINTX$:IF X$="N" THEN 250 :ELSE IF X$<>"Y" THEN PRINTBL$:GOTO510
520 PRINTFNC$(7,1);J1$
530 :REM 
540 FOR J=1 TO MC:IF LT(W(J))>XT THEN XT=LT(W(J)):GOTO560
550 IF LT(W(J))<NT THEN NT=LT(W(J))
560 IF LN(W(J))>XN THEN XN=LN(W(J)):GOTO580
570 IF LN(W(J))<NN THEN NN=LN(W(J))
580 NEXT J:XT=XT+3:NT=NT-3:XN=XN+3:NN=NN-3
590 FOR J=1 TO MD:IF LT(J)>XT THEN 640
600 IF LT(J)<NT THEN 640
610 IF LN(J)>XN THEN 640
620 IF LN(J)<NN THEN 640
630 GOTO650
640 PR(J)=3
650 NEXT J
660 CLOSE:GOSUB1600
670 ML=INT(TD*0.5)
680 IF ML<30 THEN ML=30
690 OPEN"O",2,"LP:"
700 PRINT#2,"NAVPROGseven Automatic Route Preparation";TAB(60);DT$
710 PRINT#2,:PRINT#2,:PRINT#2,"Depart: ";ID$(W(1));"    Dest: ";ID$(W(MC))
720 PRINT#2,"Great circle dist: ";TD;"nm":PRINT#2,
730 PRINT#2,TAB(16);"nm";TAB(25);"TC"
740 PRINTH$;J1$
750 PRINT"Depart: ";ID$(W(1));"    Dest: ";ID$(W(MC))
760 PRINT"Great circle dist: ";TD;"nm"
770 PRINT"Test Segment:";ML;"nm"
780 FOR J=0 TO MD:IF PR(J)=1 THEN PR(J)=0:NEXT J :ELSE NEXT J
790 :REM 
800 CY=1:NE=0:FOR J=1 TO MC:PRINTFNC$(6+J,1);J;FNC$(6+J,5);ID$(W(J));" ";FA$(W(J)):NEXT J
810 P2=LT(W(CY)):P1=LN(W(CY)):P4=LT(W(CY+1)):P3=LN(W(CY+1)):IF PR(W(CY))=0 THEN PR(W(CY))=1
820 PRINTFNC$(6+CY,1);PG$;CY;QG$
830 GOSUB1600:PH=T:SH=T:PD=C:BD=C
840 BH=360:BP=0:DD=2*C
850 IF C<ML THEN D(CY)=BD:H(CY)=INT(SH):GOTO1120
860 :REM 
870 FOR J=1 TO MD
880 PRINTFNC$(1,1);ID$(J)
890 IF PR(J)>0 THEN 1090
900 P4=LT(J):P3=LN(J)
910 IF P1=P3 AND P2=P4 THEN 1090
920 GOSUB1600:IF C>TD THEN PR(J)=3:GOTO 1090
930 IF C>PD OR (ML>60 AND C>PD*120.25) THEN 1090
940 C1=C:T1=T:RD=C:DH=ABS(PH-T)
950 IF DH>180 THEN DH=360-DH
960 IF DH<=30 THEN 1000
970 IF DH<=MV THEN 1090
980 IF CY=1 OR DH<=90 THEN PR(J)=3:GOTO1090
990 PR(J)=1:GOTO1090
1000 P2=P4:P1=P3:P4=LT(W(CY+1)):P3=LN(W(CY+1))
1010 GOSUB1600:T2=T:C2=C:RD=RD+C:P2=LT(W(CY)):P1=LN(W(CY))
1020 IF RD>DD THEN 1090
1030 DH=ABS(PH-T):IF DH>180 THEN DH=360-DH
1040 IF DH<30 THEN 1070
1050 IF ML<30 AND CY+1=MC AND DH<45 AND C<14 THEN 1070
1060 IF ML>=30 OR CY+1<>MC OR DH>60 OR C>7 THEN 1090
1070 BP=J:DD=RD:NE=1
1080 SH=T1:BD=C1:S2=T2:B2=C2::BP$=ID$(BP):PRINTFNC$(7+CY,1);CY+1;FNC$(7+CY,5);PG$;BP$;QG$;" ";FA$(BP):FOR K=CY+1 TO MC:PRINTFNC$(7+K,1);K+1;FNC$(7+K,5)ID$(W(K));" ";FA$(W(K)):NEXT K
1090 NEXT J:PRINTFNC$(1,1);SPACE$(9)
1100 :REM 
1110 IF BP>0 THEN FOR J=MC TO CY+1 STEP -1:W(J+1)=W(J):D(J+1)=D(J):H(J+1)=H(J):NEXT J:W(CY+1)=BP:PR(BP)=2:D(CY)=BD:D(CY+1)=B2:H(CY)=INT(SH):H(CY+1)=INT(S2):MC=MC+1:GOTO1130
1120 IF BP=0 THEN D(CY)=BD:H(CY)=INT(SH):GOTO1140
1130 P2=LT(BP):P1=LN(BP)
1140 PRINTFNC$(6+CY,1);CY
1150 IF BP>0 THEN CY=CY+2 :ELSE CY=CY+1:GOTO1190
1160 IF BD<ML*240.5 THEN CY=CY-1
1170 IF B2<ML*240.5 THEN CY=CY-2
1180 IF BP>0 THEN FOR J=1 TO MC:PRINTFNC$(6+J,1);J;FNC$(6+J,5);ID$(W(J));" ";FA$(W(J)):NEXT J
1190 IF CY<MC THEN 810
1200 IF NE=0 AND NW>3 AND ML>60 THEN 1280
1210 IF NE=0 AND NW>1 THEN 1260
1220 TM=0:PRINT#2,:PRINT#2,:FOR J=1 TO MC:PRINT#2,J;TAB(5);ID$(W(J));" ";FA$(W(J));:IF J=MC THEN 1240 :ELSE PRINT#2,TAB(14);USING"####.#";D(J);
1230 PRINT#2,TAB(24);USING"###";H(J)
1240 TM=TM+D(J):NEXT J:PRINT#2,:PRINT#2,TAB(14);STRING$(6,45):PRINT #2,TAB(14);USING"####.#";TM
1250 IF MC>10 THEN PRINT#2,"Select up to 10 checkpoints for navigation"
1260 ML=INT(ML*0.5)
1270 IF ML>=5 THEN GOSUB1860:IF MD>MC THEN 740
1280 CLOSE:PRINTFNC$(3,1);J1$;"Return to menu? (Y or N) ";:X$=INPUT$(1):GOSUB1790:PRINTX$:IF X$="Y" THEN LOAD"MENU",R
1290 IF X$="N" THEN 10 :ELSE PRINTBL$:GOTO1280
1300 :REM 
1310 :REM search index for match & get
1320 P$=X$+SPACE$(5-LEN(X$))
1330 RO=I+2
1340 FD=0
1350 FOR J=1 TO MD
1360 IF ID$(J)<>P$ THEN 1410
1370 IF FD=1 THEN RO=15:GET#1,REC:PRINTFNC$(15,1);J1$:GOSUB1540:RO=16:FD=2
1380 PI=J
1390 IF FD>1 THEN REC=((J-1)MOD5)+1:SS=(J-1) [FC] 5:GET#1,REC:GOSUB1540:FD=FD+1:RO=RO+1
1400 IF FD=0 THEN FD=1:REC=((J-1)MOD5)+1:SS=(J-1) [FC] 5:GET#1,REC
1410 NEXT J
1420 IF FD=0 THEN PRINTBL$;"Can't find ";P$:PRINT"Return to menu and input data? (Y or N) ";:X$=INPUT$(1):GOSUB1790:PRINTX$:IF X$="Y" THEN CLOSE:LOAD"MENU",R :ELSE 1520
1430 IF FD=1 THEN 1490
1440 PRINTFNC$(RO+1,1);"Enter number of your choice <";PI;"> ";J$;STRING$(3,95);K$;:LINE INPUT X$
1450 IF X$="" THEN 1490
1460 PI=VAL(X$)
1470 REC=((PI-1)MOD5)+1:SS=(PI-1) [FC] 5
1480 GET#1,REC
1490 PRINTFNC$(15,1);J1$
1500 RO=I+2:GOSUB1540
1510 IF I<4 THEN W(I)=PI
1520 RETURN
1530 :REM 
1540 :REM decode & display
1550 OPTION#1,SS*50 AS DU$,5 AS ID$,2 AS FAC$,4 AS DU$,20 AS NM$
1560 PRINTFNC$(RO,1);L$;:IF RO>14 THEN PRINT PI;
1570 PRINTFNC$(RO,7);ID$;FNC$(RO,13);FAC$;
1580 PRINTFNC$(RO,24);NM$;
1590 RETURN
1600 :REM distance
1610 A=P1-P3
1620 B1=P2-P4
1630 P=COS(P2/U)*COS(P4/U)
1640 Q=P*COS(ABS(A)/U)+COS(ABS(B1)/U)-P:IF Q<=0 THEN PRINT BL$:GOTO 1830
1650 Q2=ATN(SQR(1-Q*Q)/Q):Q=Q2*U*60
1660 C=FNS6(Q):IF C>900 AND ABS(A)>30 THEN PRINT BL$:GOTO1840
1670 IF C=0 THEN T=0:GOTO1780
1680 :REM true course
1690 S=FNS8((P2+P4)/2):IF S>=1 THEN S=90-S:GOTO 1710
1700 S=FNS7(S)
1710 IF A>0 AND B1=0 THEN T=90:GOTO 1770
1720 IF A<0 AND B1=0 THEN T=270:GOTO 1770
1730 IF A>0 AND B1<0 THEN T=S:GOTO 1770
1740 IF A>=0 AND B1>0 THEN T=180-S:GOTO 1770
1750 IF A<0 AND B1>0 THEN T=180+S:GOTO 1770
1760 T=360-S
1770 T=FNS6(T)
1780 RETURN
1790 :REM map lc
1800 FOR L=1 TO LEN(X$):U$=MID$(X$,L,1)
1810 IF ASC(U$)>96 AND ASC(U$)<123 THEN MID$(X$,L,1)=CHR$(ASC(U$)-32)
1820 NEXT L:RETURN
1830 PRINTFNC$(MC+6,1);E$+"y4";BL$;"Distance excessive...":PRINT"Hit <RETURN> to continue...";:X$=INPUT$(1):GOTO10
1840 PRINTFNC$(MC+6,1);E$+"y4";BL$;"Distance excessive."
1850 PRINT"Possible course errors due to rhumb line.":PRINT"Hit <RETURN> to continue...";:X$=INPUT$(1):GOTO10
1860 :REM condense
1870 IF MV>90 THEN 1970
1880 PRINTFNC$(1,1);"Condensing files":PRINTMD
1890 NW=NW+1:OS=0:FOR J=1 TO MD
1900 IF PR(J)<3 THEN 1960
1910 IF PR(J)=3 THEN OS=OS+1:PRINTFNC$(2,1);MD-OS;L$
1920 IF J+OS>MD THEN J=MD+1:GOTO1960
1930 ID$(J)=ID$(J+OS):FA$(J)=FA$(J+OS):LT(J)=LT(J+OS):LN(J)=LN(J+OS):PR(J)=PR(J+OS):PR(J+OS)=4
1940 FOR K=1 TO MC:IF J+OS=W(K) THEN W(K)=J
1950 NEXT K:GOTO1900
1960 NEXT J:MD=MD-OS:PRINTFNC$(1,1);SPACE$(16):PRINTL$
1970 RETURN
