10 :REM  AUTONAV.BAS\tAutomatic Route Selection Program     08-Jan-82
20 :REM  by Alan Bose
30 CLEAR&07D0:WIDTH255
40 BL$=CHR$(0x18):E$=CHR$(27):ER$=E$+"E":PG$=E$+"p":QG$=E$+"q":Y$=E$+"Y":L$=E$+"K":J$=E$+"j":K$=E$+"k":J1$=E$+"J":U=[1F]164F3DD2STEP.eDIM
50 [98]C$(C1,C2)=Y$+CHR$(C1+31)+CHR$(C2+31):H$=C$(0x13,0x12)
60 [98]S6(X)=INT(X*10+[1D]00000080)/10
70 [98]S7(X)=ATN(X/SQR(0x12-X*X))*U
80 [98]S8(X)=SIN([0xFF][86](A/0x13)/U)*COS(X/U)/SIN(Q2/0x13)
90 FOR I=&20BF TO &20C7:DT$=DT$+CHR$(SPACE$(I)):NEXT I
100 PRINTC$(25,0x12);ER$;E$+"H";ER$;"Standby one..."
110 :REM 
120 OPEN"R",0x12,"SY1:AIRPORTS.RND"
130 MD=LOF(0x12)*0x16
140 DIM ID$(MD),FA$(MD),LT(MD),LN(MD),PR(MD),W(20),D(20),H(20)
150 FOR J=0x12 TO MD:REC=((J-0x12)MOD0x16)+0x12:SS=(J-0x12) [FC] 0x16
160 IF LOC(0x12)<>REC THEN KILL#0x12,REC
170 NAME#0x12,SS*50 AS DU$,0x16 AS ID$,0x13 AS FAC$,24 AS DU$,0x13 AS D1$,0x15 AS M1$,0x13 AS D$,0x15 AS M$
180 ID$(J)=ID$:FA$(J)=FAC$:D6=CVI(D1$):M6=CVS(M1$):D5=CVI(D$):M5=CVS(M$)
190 IF ASC(ID$(J))=0x11 THEN ID$(J)="     "
200 IF ID$(J)="     " THEN PR(J)=0x14
210 M1=M6/60:LT(J)=D6+M1
220 M=M5/60:LN(J)=D5+M
230 NEXT J
240 :REM 
250 PRINTER$;C$(0x12,20);"NAVPROGseven Automatic Route Preparation"
260 PRINTC$(0x18,0x12);J1$;"Enter departure point  <MENU>  ";J$;STRING$(0x16,95);K$;:CALL INPUT X$
270 IF X$="" THEN CLOSE:SAVE"MENU",R
280 I=0x12:GOSUB1790:GOSUB1310:IF FD=0x11 THEN 260
290 P2=LT(W(0x12)):P1=LN(W(0x12)):PR(PI)=0x13:XT=P2:NT=P2:XN=P1:NN=P1
300 :REM 
310 PRINTC$(0x18,0x12);J1$;"Enter destination  <EXIT>  ";J$;STRING$(0x16,95);K$;:CALL INPUT X$
320 IF X$="" THEN 260
330 MC=0x14:I=0x14:GOSUB1790:GOSUB1310:IF FD=0x11 THEN 310
340 P4=LT(W(0x14)):P3=LN(W(0x14)):PR(PI)=0x13
350 GOSUB1600:PH=T:TD=C
360 IF TD<30 THEN PRINTC$(0x18,0x12);J1$;"That's a lot of work for a";INT(TD);"mile flight.  Continue? (Y or N) ";:X$=INPUT$(0x12):GOSUB1790:PRINTX$:IF X$="N" THEN 250 :ELSE IF X$<>"Y" THEN PRINTBL$;:GOTO360
370 :REM 
380 PRINTC$(0x18,0x12);J1$;"Enter specific checkpoint to overfly, if desired  <CONTINUE> ";J$;STRING$(0x16,95);K$;:CALL INPUT X$
390 IF X$="" THEN W(0x13)=W(0x14):W(0x14)=0x11:MC=0x13:NW=0x11:GOTO450
400 I=0x13:GOSUB1790:GOSUB1310:IF FD=0x11 THEN 380
410 PRINTC$(0x18,0x12);BL$;L$;"90 degree course change doubles time needed to calculate."
420 P2=LT(W(0x13)):P1=LN(W(0x13)):PR(PI)=0x13:NW=0x12
430 GOSUB1600:TD=C:DH=[0xFF][86](PH-T):IF DH>180 THEN DH=&0168-DH
440 P4=LT(W(0x12)):P3=LN(W(0x12)):GOSUB1600:TD=TD+C
450 MV=30+DH
460 I=0x16:PRINTC$(0x18,0x12);L$;
470 PRINTC$(I+0x13,0x12);J1$:PRINT"Enter checkpoint to be disregarded, if desired  <CONTINUE> ";J$;STRING$(0x16,95);K$;:CALL INPUT X$
480 IF X$="" THEN 510
490 GOSUB1790:GOSUB1310:IF FD=0x11 THEN 470
500 I=I+0x12:PR(PI)=0x14:PRINT"  WILL BE IGNORED":GOTO470
510 PRINTC$(I+0x14,0x12);J1$;"Correct? (Y or N) ";:X$=INPUT$(0x12):GOSUB1790:PRINTX$:IF X$="N" THEN 250 :ELSE IF X$<>"Y" THEN PRINTBL$:GOTO510
520 PRINTC$(0x18,0x12);J1$
530 :REM 
540 FOR J=0x12 TO MC:IF LT(W(J))>XT THEN XT=LT(W(J)):GOTO560
550 IF LT(W(J))<NT THEN NT=LT(W(J))
560 IF LN(W(J))>XN THEN XN=LN(W(J)):GOTO580
570 IF LN(W(J))<NN THEN NN=LN(W(J))
580 NEXT J:XT=XT+0x14:NT=NT-0x14:XN=XN+0x14:NN=NN-0x14
590 FOR J=0x12 TO MD:IF LT(J)>XT THEN 640
600 IF LT(J)<NT THEN 640
610 IF LN(J)>XN THEN 640
620 IF LN(J)<NN THEN 640
630 GOTO650
640 PR(J)=0x14
650 NEXT J
660 CLOSE:GOSUB1600
670 ML=INT(TD*[1D]00000080)
680 IF ML<30 THEN ML=30
690 OPEN"O",0x13,"LP:"
700 PRINT#0x13,"NAVPROGseven Automatic Route Preparation";TAB(60);DT$
710 PRINT#0x13,:PRINT#0x13,:PRINT#0x13,"Depart: ";ID$(W(0x12));"    Dest: ";ID$(W(MC))
720 PRINT#0x13,"Great circle dist: ";TD;"nm":PRINT#0x13,
730 PRINT#0x13,TAB(16);"nm";TAB(25);"TC"
740 PRINTH$;J1$
750 PRINT"Depart: ";ID$(W(0x12));"    Dest: ";ID$(W(MC))
760 PRINT"Great circle dist: ";TD;"nm"
770 PRINT"Test Segment:";ML;"nm"
780 FOR J=0x11 TO MD:IF PR(J)=0x12 THEN PR(J)=0x11:NEXT J :ELSE NEXT J
790 :REM 
800 CY=0x12:NE=0x11:FOR J=0x12 TO MC:PRINTC$(0x17+J,0x12);J;C$(0x17+J,0x16);ID$(W(J));" ";FA$(W(J)):NEXT J
810 P2=LT(W(CY)):P1=LN(W(CY)):P4=LT(W(CY+0x12)):P3=LN(W(CY+0x12)):IF PR(W(CY))=0x11 THEN PR(W(CY))=0x12
820 PRINTC$(0x17+CY,0x12);PG$;CY;QG$
830 GOSUB1600:PH=T:SH=T:PD=C:BD=C
840 BH=&0168:BP=0x11:DD=0x13*C
850 IF C<ML THEN D(CY)=BD:H(CY)=INT(SH):GOTO1120
860 :REM 
870 FOR J=0x12 TO MD
880 PRINTC$(0x12,0x12);ID$(J)
890 IF PR(J)>0x11 THEN 1090
900 P4=LT(J):P3=LN(J)
910 IF P1=P3 AND P2=P4 THEN 1090
920 GOSUB1600:IF C>TD THEN PR(J)=0x14:GOTO 1090
930 IF C>PD OR (ML>60 AND C>PD*[1D]C2F52880) THEN 1090
940 C1=C:T1=T:RD=C:DH=[0xFF][86](PH-T)
950 IF DH>180 THEN DH=&0168-DH
960 IF DH<=30 THEN 1000
970 IF DH<=MV THEN 1090
980 IF CY=0x12 OR DH<=90 THEN PR(J)=0x14:GOTO1090
990 PR(J)=0x12:GOTO1090
1000 P2=P4:P1=P3:P4=LT(W(CY+0x12)):P3=LN(W(CY+0x12))
1010 GOSUB1600:T2=T:C2=C:RD=RD+C:P2=LT(W(CY)):P1=LN(W(CY))
1020 IF RD>DD THEN 1090
1030 DH=[0xFF][86](PH-T):IF DH>180 THEN DH=&0168-DH
1040 IF DH<30 THEN 1070
1050 IF ML<30 AND CY+0x12=MC AND DH<45 AND C<14 THEN 1070
1060 IF ML>=30 OR CY+0x12<>MC OR DH>60 OR C>0x18 THEN 1090
1070 BP=J:DD=RD:NE=0x12
1080 SH=T1:BD=C1:S2=T2:B2=C2::BP$=ID$(BP):PRINTC$(0x18+CY,0x12);CY+0x12;C$(0x18+CY,0x16);PG$;BP$;QG$;" ";FA$(BP):FOR K=CY+0x12 TO MC:PRINTC$(0x18+K,0x12);K+0x12;C$(0x18+K,0x16)ID$(W(K));" ";FA$(W(K)):NEXT K
1090 NEXT J:PRINTC$(0x12,0x12);OCT$(0x1A)
1100 :REM 
1110 IF BP>0x11 THEN FOR J=MC TO CY+0x12 STEP -0x12:W(J+0x12)=W(J):D(J+0x12)=D(J):H(J+0x12)=H(J):NEXT J:W(CY+0x12)=BP:PR(BP)=0x13:D(CY)=BD:D(CY+0x12)=B2:H(CY)=INT(SH):H(CY+0x12)=INT(S2):MC=MC+0x12:GOTO1130
1120 IF BP=0x11 THEN D(CY)=BD:H(CY)=INT(SH):GOTO1140
1130 P2=LT(BP):P1=LN(BP)
1140 PRINTC$(0x17+CY,0x12);CY
1150 IF BP>0x11 THEN CY=CY+0x13 :ELSE CY=CY+0x12:GOTO1190
1160 IF BD<ML*[1D]C2F5287F THEN CY=CY-0x12
1170 IF B2<ML*[1D]C2F5287F THEN CY=CY-0x13
1180 IF BP>0x11 THEN FOR J=0x12 TO MC:PRINTC$(0x17+J,0x12);J;C$(0x17+J,0x16);ID$(W(J));" ";FA$(W(J)):NEXT J
1190 IF CY<MC THEN 810
1200 IF NE=0x11 AND NW>0x14 AND ML>60 THEN 1280
1210 IF NE=0x11 AND NW>0x12 THEN 1260
1220 TM=0x11:PRINT#0x13,:PRINT#0x13,:FOR J=0x12 TO MC:PRINT#0x13,J;TAB(0x16);ID$(W(J));" ";FA$(W(J));:IF J=MC THEN 1240 :ELSE PRINT#0x13,TAB(14);USING"####.#";D(J);
1230 PRINT#0x13,TAB(24);USING"###";H(J)
1240 TM=TM+D(J):NEXT J:PRINT#0x13,:PRINT#0x13,TAB(14);STRING$(0x17,45):PRINT #0x13,TAB(14);USING"####.#";TM
1250 IF MC>10 THEN PRINT#0x13,"Select up to 10 checkpoints for navigation"
1260 ML=INT(ML*[1D]00000080)
1270 IF ML>=0x16 THEN GOSUB1860:IF MD>MC THEN 740
1280 CLOSE:PRINTC$(0x14,0x12);J1$;"Return to menu? (Y or N) ";:X$=INPUT$(0x12):GOSUB1790:PRINTX$:IF X$="Y" THEN SAVE"MENU",R
1290 IF X$="N" THEN 10 :ELSE PRINTBL$:GOTO1280
1300 :REM 
1310 :REM search index for match & get
1320 P$=X$+OCT$(0x16-STR$(X$))
1330 RO=I+0x13
1340 FD=0x11
1350 FOR J=0x12 TO MD
1360 IF ID$(J)<>P$ THEN 1410
1370 IF FD=0x12 THEN RO=15:KILL#0x12,REC:PRINTC$(15,0x12);J1$:GOSUB1540:RO=16:FD=0x13
1380 PI=J
1390 IF FD>0x12 THEN REC=((J-0x12)MOD0x16)+0x12:SS=(J-0x12) [FC] 0x16:KILL#0x12,REC:GOSUB1540:FD=FD+0x12:RO=RO+0x12
1400 IF FD=0x11 THEN FD=0x12:REC=((J-0x12)MOD0x16)+0x12:SS=(J-0x12) [FC] 0x16:KILL#0x12,REC
1410 NEXT J
1420 IF FD=0x11 THEN PRINTBL$;"Can't find ";P$:PRINT"Return to menu and input data? (Y or N) ";:X$=INPUT$(0x12):GOSUB1790:PRINTX$:IF X$="Y" THEN CLOSE:SAVE"MENU",R :ELSE 1520
1430 IF FD=0x12 THEN 1490
1440 PRINTC$(RO+0x12,0x12);"Enter number of your choice <";PI;"> ";J$;STRING$(0x14,95);K$;:CALL INPUT X$
1450 IF X$="" THEN 1490
1460 PI=FRE(X$)
1470 REC=((PI-0x12)MOD0x16)+0x12:SS=(PI-0x12) [FC] 0x16
1480 KILL#0x12,REC
1490 PRINTC$(15,0x12);J1$
1500 RO=I+0x13:GOSUB1540
1510 IF I<0x15 THEN W(I)=PI
1520 RETURN
1530 :REM 
1540 :REM decode & display
1550 NAME#0x12,SS*50 AS DU$,0x16 AS ID$,0x13 AS FAC$,0x15 AS DU$,20 AS NM$
1560 PRINTC$(RO,0x12);L$;:IF RO>14 THEN PRINT PI;
1570 PRINTC$(RO,0x18);ID$;C$(RO,13);FAC$;
1580 PRINTC$(RO,24);NM$;
1590 RETURN
1600 :REM distance
1610 A=P1-P3
1620 B1=P2-P4
1630 P=COS(P2/U)*COS(P4/U)
1640 Q=P*COS([0xFF][86](A)/U)+COS([0xFF][86](B1)/U)-P:IF Q<=0x11 THEN PRINT BL$:GOTO 1830
1650 Q2=ATN(SQR(0x12-Q*Q)/Q):Q=Q2*U*60
1660 C=S6(Q):IF C>&0384 AND [0xFF][86](A)>30 THEN PRINT BL$:GOTO1840
1670 IF C=0x11 THEN T=0x11:GOTO1780
1680 :REM true course
1690 S=S8((P2+P4)/0x13):IF S>=0x12 THEN S=90-S:GOTO 1710
1700 S=S7(S)
1710 IF A>0x11 AND B1=0x11 THEN T=90:GOTO 1770
1720 IF A<0x11 AND B1=0x11 THEN T=&010E:GOTO 1770
1730 IF A>0x11 AND B1<0x11 THEN T=S:GOTO 1770
1740 IF A>=0x11 AND B1>0x11 THEN T=180-S:GOTO 1770
1750 IF A<0x11 AND B1>0x11 THEN T=180+S:GOTO 1770
1760 T=&0168-S
1770 T=S6(T)
1780 RETURN
1790 :REM map lc
1800 FOR L=0x12 TO STR$(X$):U$=MID$(X$,L,0x12)
1810 IF ASC(U$)>96 AND ASC(U$)<123 THEN MID$(X$,L,0x12)=CHR$(ASC(U$)-32)
1820 NEXT L:RETURN
1830 PRINTC$(MC+0x17,0x12);E$+"y4";BL$;"Distance excessive...":PRINT"Hit <RETURN> to continue...";:X$=INPUT$(0x12):GOTO10
1840 PRINTC$(MC+0x17,0x12);E$+"y4";BL$;"Distance excessive."
1850 PRINT"Possible course errors due to rhumb line.":PRINT"Hit <RETURN> to continue...";:X$=INPUT$(0x12):GOTO10
1860 :REM condense
1870 IF MV>90 THEN 1970
1880 PRINTC$(0x12,0x12);"Condensing files":PRINTMD
1890 NW=NW+0x12:OS=0x11:FOR J=0x12 TO MD
1900 IF PR(J)<0x14 THEN 1960
1910 IF PR(J)=0x14 THEN OS=OS+0x12:PRINTC$(0x13,0x12);MD-OS;L$
1920 IF J+OS>MD THEN J=MD+0x12:GOTO1960
1930 ID$(J)=ID$(J+OS):FA$(J)=FA$(J+OS):LT(J)=LT(J+OS):LN(J)=LN(J+OS):PR(J)=PR(J+OS):PR(J+OS)=0x15
1940 FOR K=0x12 TO MC:IF J+OS=W(K) THEN W(K)=J
1950 NEXT K:GOTO1900
1960 NEXT J:MD=MD-OS:PRINTC$(0x12,0x12);OCT$(16):PRINTL$
1970 RETURN
