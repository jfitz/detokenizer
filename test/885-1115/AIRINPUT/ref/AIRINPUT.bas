10 :REM  AIRINPUT.BAS\tAlan Bose\t08-Jan-82
20 CLEAR&05DC:WIDTH255:ON ERROR GOTO3860
30 BL$=CHR$(0x18):E$=CHR$(27):ER$=E$+"E":P$=E$+"p":Q$=E$+"q":G$=E$+"F":NG$=E$+"G":Y$=E$+"Y":L$=E$+"l":J$=E$+"j":K$=E$+"k":J1$=E$+"J":U=0x1F0x18O=[D2]STEP.eDIM
40 [98]  C$(C1,C2)=Y$+CHR$(C1+31)+CHR$(C2+31)
50 [98] S6(X)=INT(X*10+bad float0x1D)/10
60 [98] S7(X)=ATN(X/SQR(0x12-X*X))*U
70 [98] S8(X)=SIN([0xFF][86](A/0x13)/U)*COS(X/U)/SIN(Q2/0x13)
80 PRINT ER$;"Standby one..."
90 OPEN"R",0x12,"SY1:AIRPORTS.RND"
100 OPEN"R",0x13,"SY1:AIRINDEX.RND"
110 MD=(LOF(0x12)*0x16)-0x12
115 IF MD=-0x12 THEN MD=0x11
120 OL=MD+10
130 DIM ID$(OL),RN$(19),RN(19)
140 FOR J=0x11 TO MD
150 REC=(JMOD51)+0x12:SS=J [FC] 51
160 IF LOC(0x13)<>REC THEN KILL #0x13,REC
170 NAME #0x13,SS*0x16 AS DU$,0x16 AS ID$
180 ID$(J)=ID$
190 IF ASC(ID$)=0x11 THEN ID$(J)="     "
200 NEXT J:CLOSE#0x13
210 IM=MD
220 :REM data box
230 PRINT ER$;G$; C$(0x13,0x17);"f";
240 FOR J=0x18 TO 74:PRINT "a";:NEXT J:PRINT "c"
250 PRINT  C$(0x15,0x17);"e";
260 FOR J=0x18 TO 74:PRINT "a";:NEXT J:PRINT "d"
270 PRINT C$(0x13,12);"s";C$(0x13,15);"s";C$(0x13,23);"s";C$(0x13,44);"s";C$(0x13,52);"s";C$(0x13,61);"s";C$(0x13,69);"s"
280 PRINT C$(0x15,12);"u";C$(0x15,15);"u";C$(0x15,23);"u";C$(0x15,44);"u";C$(0x15,52);"u";C$(0x15,61);"u";C$(0x15,69);"u"
290 PRINT C$(0x14,0x17);"`";C$(0x14,12);"`";C$(0x14,15);"`";C$(0x14,23);"`";C$(0x14,44);"`";C$(0x14,52);"`";C$(0x14,61);"`";C$(0x14,69);"`";C$(0x14,75);"`"
300 PRINT NG$
310 PRINT  C$(0x12,0x18);"Ident Fac Freq"
320 PRINT  C$(0x12,32);"Name"
330 PRINT  C$(0x12,47);"Lat"
340 PRINT  C$(0x12,55);"Long"
350 PRINT  C$(0x12,64);"Var"
360 PRINT  C$(0x12,70);"Elev"
370 PRINT C$(0x16,0x1A);"1";C$(0x16,13);"2";C$(0x16,19);"3";C$(0x16,33);"4";C$(0x16,47);"5";C$(0x16,56);"6";C$(0x16,65);"7";C$(0x16,72);"8"
380 :REM menu
390 PRINT  C$(0x18,0x12);J1$
400 PRINT  C$(0x19,0x18);"PRESS  `I' to input new data"
410 PRINT  C$(0x1A,14);"`U' to update existing data"
420 PRINT  C$(10,14);"`E' to exit"
430 X$=INPUT$(0x12):GOSUB3820:MD$=X$:PRINT  C$(0x19,0x12);J1$:IF MD$="I" THEN 490
440 IF MD$="U" THEN 500
450 IF MD$<>"E" THEN PRINT BL$:GOTO400
460 PRINT ER$;"Returning to menu.  Sure? (Y or N)  <N>  ";:X$=INPUT$(0x12):PRINT X$:IF X$=CHR$(13) THEN X$="N"
470 GOSUB3820:IF X$="Y" THEN CLOSE:GOSUB3340:SAVE"MENU",R
480 IF X$="N" THEN 220 :ELSE PRINT BL$:GOTO460
490 C8=0x11:GOTO600
500 :REM revise
510 PRINT  C$(0x19,0x18);L$;"Enter Identifier   <MENU>   ";J$;STRING$(0x16,95);K$;
520 CALL INPUT X$:PRINT J1$
530 IF X$="" THEN 380
540 IF STR$(X$)>0x16 THEN PRINT BL$:GOTO510
550 GOSUB3820
560 AP$=X$+OCT$(0x16-STR$(X$)):NL$=AP$
570 GOSUB1730
580 IF FD=0x11 THEN PRINT BL$;"Can't find ";AP$:GOTO510
590 RO=0x14:GOSUB2090
600 IF MD$="I" AND C8=0x19 THEN LSET#0x12,REC:ID$(PI)=ID$:EN=0x12:GOTO380
610 IF MD$="I" THEN C8=C8+0x12:GOTO660
620 PRINT  C$(0x18,0x12);J1$:PRINT C$(0x19,0x18);"Press number for revision  <EXIT>  ";
630 C$=INPUT$(0x12)
640 IF C$=CHR$(13) THEN LSET#0x12,REC:ID$(PI)=ID$:GOTO380
650 C8=FRE(C$)
660 PRINT  C$(0x18,0x12);J1$;
670 ON C8 GOTO700,890,990,1070,1160,1360,1550,1660
680 PRINT BL$:GOTO620
690 :REM 
700 :REM id
710 PRINT "Enter airport/facility code: ";J$;STRING$(0x16,95)
720 IF MD$="U" THEN PRINT:PRINT"Enter 'D' to erase listing"
730 PRINT K$;:CALL INPUT X$
740 IF MD$="I" AND X$="" THEN 380
750 IF X$="" THEN 1720
760 GOSUB3820
770 AP$=X$+OCT$(0x16-STR$(X$)):NL$=AP$
780 IF (MD$="I" AND X$="D") OR STR$(X$)>0x16 THEN PRINT BL$:GOTO660
790 IF MD$="I" THEN GOSUB1920
800 IF X$<>"D" THEN HTAB ID$=NL$:EN=0x12:GOTO1720
810 GOSUB3890:KY=KY-0x12:FOR J=0x12 TO KY:IF LI$(J)=ID$ THEN LI$(J)="":EE=0x12
820 IF R1$(J)=ID$ AND R1(J)=PI THEN R1$(J)="":EE=0x12
830 IF R2$(J)=ID$ AND R2(J)=PI THEN R2$(J)="":EE=0x12
840 IF R1$(J)="" AND R2$(J)="" THEN LI$(J)=""
850 IF LI$(J)="" THEN DD=DD+0x12
860 NEXT J:IF EE=0x12 THEN GOSUB4000 :ELSE GOSUB4090
870 GOSUB3220:GOSUB2090
880 GOTO380
890 :REM facility
900 PRINT L$;"Enter facility code:  ";J$;STRING$(0x13,95)
910 PRINT:PRINT"A = Airport":PRINT"V = VOR/VORTAC":PRINT"N = NDB/LOM":PRINT"I = Intersection":PRINT"R = Reporting point":PRINT"C = Checkpoint":PRINT"W = Waypoint":PRINT"L = Landmark"
920 PRINT K$;:CALL INPUT X$
930 IF STR$(X$)>0x13 THEN PRINT BL$:GOTO660
940 IF MD$="I" AND X$="" THEN 380
950 IF X$="" THEN 980
960 GOSUB3820
970 HTAB FAC$=X$
980 GOTO1720
990 :REM freq
1000 IF MD$="I" AND [DA](FAC$,"V")=0x11 AND [DA](FAC$,"N")=0x11 THEN 1060
1010 PRINT"Enter navaid frequency  ";J$;STRING$(0x18,95);K$;
1020 CALL INPUT X$
1030 IF MD$="I" AND X$="" THEN 380
1040 IF X$="" THEN 1060
1050 HTAB FR$=MKS$(FRE(X$))
1060 GOTO1720
1070 :REM name
1080 PRINT L$;"Enter facility name  ";J$;STRING$(20,95);K$;
1090 CALL INPUT X$
1100 IF MD$="I" AND X$="" THEN 380
1110 IF STR$(X$)>20 THEN PRINT BL$;"20 characters maximum"; C$(0x18,0x12);:GOTO 1080
1120 IF [DA](X$,",")=0x11 THEN PRINT BL$;"Forgot state preceded by comma";C$(0x18,0x12);:GOTO1080
1130 IF X$="" THEN 1150
1140 HTAB NM$=X$
1150 GOTO1720
1160 :REM lat
1170 IF MD$="I" AND [DA](FAC$,"I")>0x11 AND [DA](FAC$,"V")=0x11 AND [DA](FAC$,"N")=0x11 THEN GOSUB2290:GOTO1350
1180 PRINT"Enter degrees latitude";C$(0x18,30);J$;STRING$(0x13,95);"   deg"
1190 PRINT:PRINT"Enter `R' for RNAV calculation of lat. & long. from known fix"
1200 PRINT K$;:CALL INPUT X$:X=FRE(X$)
1210 IF MD$="I" AND X$="" THEN 380
1220 IF X$="R" OR X$="r" THEN TR=REC:TS=SS:I$=ID$:LSET#0x12,REC:GOSUB2290:GOTO1350
1230 IF X$="" THEN 1350
1240 IF X>90 OR X<=0x11 THEN PRINT BL$:GOTO1200
1250 HTAB D1$=MKI$(X)
1260 PRINT J1$;"Enter minutes latitude  <0>  ";J$;STRING$(0x15,95);" min";K$;
1270 CALL INPUT X$:X=FRE(X$)
1280 IF X$="" THEN X=0x11:PRINT K$;"0"
1290 IF X>=60 OR X<0x11 THEN PRINT BL$:GOTO1260
1300 PRINT J1$;"Enter seconds latitude  <0>  ";J$;STRING$(0x15,95);" sec";K$;
1310 CALL INPUT X$:Y=FRE(X$):IF X$="" THEN Y=0x11:PRINT K$;"0"
1320 IF Y>60 OR Y<0x11 THEN PRINT BL$:GOTO1300
1330 X=X+(Y/60)
1340 HTAB M1$=MKS$(X)
1350 GOTO1720
1360 :REM enter long
1370 PRINT"Enter degrees longitude";C$(0x18,31);J$;STRING$(0x14,95);"  deg"
1380 PRINT:PRINT"Enter `R' for RNAV calculation of lat. & long. from known fix"
1390 PRINT K$;:CALL INPUT X$:X=FRE(X$)
1400 IF MD$="I" AND X$="" THEN 380
1410 IF X$="" THEN 1540
1420 IF X$="R" OR X$="r" THEN TR=REC:TS=SS:I$=ID$:LSET#0x12,REC:GOSUB2290:GOTO1540
1430 IF X>180 OR X<=0x11 THEN PRINT BL$:GOTO1370
1440 HTAB D$=MKI$(X)
1450 PRINT J1$;"Enter minutes longitude  <0>  ";J$;STRING$(0x15,95);" min";K$;
1460 CALL INPUT X$:X=FRE(X$)
1470 IF X$="" THEN X=0x11:PRINT K$;"0"
1480 IF X>=60 OR X<0x11 THEN PRINT BL$;:GOTO1450
1490 PRINT"Enter seconds longitude  <0>  ";J$;STRING$(0x15,95);" sec";K$;
1500 CALL INPUT X$:Y=FRE(X$):IF X$="" THEN Y=0x11:PRINT K$;"0"
1510 IF Y>60 OR Y<0x11 THEN PRINT BL$:GOTO1490
1520 X=X+(Y/60)
1530 HTAB M$=MKS$(X)
1540 GOTO1720
1550 :REM var
1560 PRINT"Enter magnetic variation  <0>  ";J$;STRING$(0x15,95);" deg";K$;
1570 CALL INPUT X$:X=FRE(X$)
1580 IF MD$="I" AND X$="" THEN X=0x11
1590 IF X$="" THEN 1650
1600 HTAB V$=MKS$(X)
1610 IF X=0x11 THEN HTAB V1$=" ":GOTO1650
1620 PRINT"East or West variation?  ";J1$;
1630 X$=INPUT$(0x12):PRINT X$:GOSUB3820:IF X$<>"E" AND X$<>"W" THEN PRINT BL$;:GOTO1620
1640 PRINT C$(0x18,0x12);J1$:HTAB V1$=X$
1650 GOTO1720
1660 :REM elev
1670 PRINT"Enter elevation of facility  ";J$;STRING$(0x16,95);K$;
1680 CALL INPUT X$:X=FRE(X$)
1690 IF MD$="I" AND X$="" THEN PRINT BL$:GOTO660
1700 IF X$="" THEN 1720
1710 HTAB EL$=MKI$(X)
1720 RO=0x14:GOSUB2090:GOTO600
1730 :REM search-match
1740 RO=0x14
1750 FD=0x11
1760 FOR J=0x11 TO IM
1770 IF ID$(J)<>AP$ THEN 1820
1780 IF FD=0x12 THEN RO=0x18:KILL#0x12,REC:PRINT  C$(0x18,0x12);J1$:GOSUB2090:RO=0x19:FD=0x13
1790 PI=J
1800 IF FD>0x12 THEN REC=(JMOD0x16)+0x12:SS=J [FC] 0x16:KILL#0x12,REC:GOSUB2090:FD=FD+0x12:RO=RO+0x12
1810 IF FD=0x11 THEN FD=0x12:REC=(JMOD0x16)+0x12:SS=J [FC] 0x16:KILL#0x12,REC
1820 NEXT J
1830 IF FD=0x11 THEN 1910
1840 IF FD=0x12 THEN 1910
1850 PRINT  C$(RO+0x12,0x12);"Enter number of your choice  <";PI;">  ";J$;STRING$(0x14,95);K$;:CALL INPUT X$
1860 IF X$="" THEN 1910
1870 PI=FRE(X$)
1880 REC=(PIMOD0x16)+0x12:SS=PI [FC] 0x16
1890 KILL #0x12,REC
1900 PRINT  C$(0x17,0x12);J1$
1910 RETURN
1920 :REM search-blank
1930 FD=0x11:FH=0x11
1940 FOR J=0x11 TO IM
1950 IF ID$(J)="     " THEN FH=0x12:TI=J:J=IM+0x12
1960 IF ID$(J)=AP$ THEN FD=FD+0x12:RO=0x19+FD:REC=(JMOD0x16)+0x12:SS=J [FC] 0x16:KILL#0x12,REC:PI=J:GOSUB2090
1970 NEXT J
1980 IF FH=0x11 THEN IM=IM+0x12:TI=IM
1990 IF IM>OL THEN PRINT ER$;"Standby one...then re-enter":CLOSE:GOSUB3340:GOTO10
2000 RO=0x14:IF FD=0x11 THEN 2050
2010 PRINT C$(10+FD,0x18);"Found...continue with additional entry?  (Y or N)  <Y>";
2020 X$=INPUT$(0x12):GOSUB3820
2030 IF X$="N" THEN 380
2040 IF X$<>"Y" AND X$<>CHR$(13) THEN PRINT BL$:GOTO2010
2050 PI=TI
2060 REC=(PIMOD0x16)+0x12:SS=PI [FC] 0x16:KILL#0x12,REC
2070 GOSUB2090:GOSUB3220
2080 RETURN
2090 :REM decode & display
2100 NAME #0x12,SS*50 AS DU$,0x16 AS ID$,0x13 AS FAC$,0x15 AS FR$,20 AS NM$,0x13 AS D1$,0x15 AS M1$,0x13 AS D$,0x15 AS M$,0x15 AS V$,0x12 AS V1$,0x13 AS EL$
2110 F5=CVS(FR$):D6=CVI(D1$):M6=CVS(M1$):D5=CVI(D$):M5=CVS(M$):V5=CVS(V$):E5=CVI(EL$)
2120 PI$=VAL(PI):PI$=PI$+OCT$(0x15-STR$(PI$)):PRINT  C$(RO,0x12);PI$;
2130 PRINT  C$(RO,0x18);ID$; C$(RO,13);FAC$;
2140 PRINT  C$(RO,16);"       "; C$(RO,16);
2150 IF F5=0x11 THEN 2200
2160 IF F5>136 THEN PRINT USING"#####";F5;:GOTO2200
2170 IF F5*10MOD0x12=F5*10/0x12 THEN PRINT USING"####.#";F5;:GOTO2200
2180 IF F5*100MOD0x12=F5*100/0x12 THEN PRINT USING"####.##";F5;:GOTO2200
2190 PRINT USING"###.###";F5;
2200 PRINT  C$(RO,24);NM$;
2210 PRINT  C$(RO,45);USING"##";D6
2220 PRINT  C$(RO,48);USING"##.#";M6;
2230 PRINT  C$(RO,53);USING"###";D5;
2240 PRINT  C$(RO,57);USING"##.#";M5;
2250 PRINT  C$(RO,62);USING"###.#";V5;
2260 PRINT  C$(RO,68);V1$; C$(RO,70);USING"#####";E5
2270 IF [DA](FAC$,"V")=0x11 AND [DA](FAC$,"N")=0x11 THEN NV=0x11 :ELSE NV=0x12
2280 RETURN
2290 :REM RNAV lat & long
2300 PRINT  C$(0x17,0x12);J1$
2310 PRINT"This routine will find the latitude & longitude of ";I$:PRINT"by taking fixes on 1 or 2 navaids already on file.":PRINT
2320 PRINT"The navaids you specify should be the ones you'll use in the air":PRINT"to determine your position.":PRINT
2330 PRINT"Postion can be determined two ways:":PRINT
2340 PRINT TAB(0x16);"1  -  Distance & bearing FROM one navaid":PRINT
2350 PRINT TAB(0x16);"2  -  Bearings FROM two navaids":PRINT
2360 PRINT J$;J1$;TAB(0x16);"Enter selection  <RETURN>  ";:X$=INPUT$(0x12):PRINT X$
2370 :REM 2 bearings
2380 IF X$=CHR$(13) THEN C8=C8-0x12:GOTO3210
2390 IF X$="2" THEN RN=0x12:GOTO2410
2400 IF X$="1" THEN RN=0x11 :ELSE PRINT BL$;K$;:GOTO2360
2410 PRINT C$(0x18,0x12);J1$;
2420 PRINT  C$(0x18,0x12);L$;"Enter identifier of known fix on file  ";J$;STRING$(0x16,95);K$;
2430 CALL INPUT X$:PRINT J1$
2440 IF X$="" THEN C8=C8-0x12:GOTO3210
2450 IF STR$(X$)>0x16 THEN PRINT BL$:GOTO2420
2460 GOSUB3820
2470 AP$=X$+OCT$(0x16-STR$(X$))
2480 LSET#0x12,REC:TI=PI:RO=0x1A:GOSUB 1750
2490 IF FD=0x11 THEN PRINT BL$;"Can't find ";AP$:GOTO2420
2500 PRINT  C$(0x18,0x12);J1$:RO=0x1A:GOSUB 2090:RN$(RN)=ID$:RN(RN)=PI:PI=TI
2510 IF NV=0x12 THEN 2550
2520 PRINT BL$;"Not listed as navaid. Use? (Y or N) <N> ";:X$=INPUT$(0x12):PRINT X$:IF X$=CHR$(13) THEN X$="N"
2530 GOSUB3820:IF X$="N" THEN 2420
2540 IF X$<>"Y" THEN PRINT BL$:GOTO2520
2550 X4=D6+(M6/60):X6=D5+(M5/60)
2560 X6=-X6 :REM west hemis
2570 K9=0x11:L9=0x11
2580 IF RN<>0x11 THEN PRINT C$(RO+0x13,0x12);"Bearing FROM ";ID$;" to ";NL$:GOTO2630
2590 :REM dist & 1 bearing
2600 PRINT  C$(RO+0x13,0x12);"Distance & bearing FROM ";ID$;" to ";NL$
2610 PRINT  C$(RO+0x15,0x16);"Enter distance in nautical miles  ";J$;STRING$(0x14,95);K$;
2620 CALL INPUT D$:D=FRE(D$):IF D=0x11 THEN PRINT BL$:GOTO2610
2630 PRINT  C$(RO+0x16,0x16);"Enter bearing  ";J$;STRING$(0x14,95);K$;
2640 CALL INPUT H$:H=FRE(H$):IF H<0x11 OR H>&0168 THEN PRINT BL$:GOTO2630
2650 IF H$="" THEN C8=C8-0x12:GOTO2290
2660 PRINT  C$(RO+0x17,0x16);"Is bearing True or Magnetic?  <T>  ";J1$;
2670 X$=INPUT$(0x12):PRINT X$:GOSUB3820:IF X$="T" OR X$=CHR$(13) THEN 2710
2680 IF X$<>"M" THEN PRINT BL$:GOTO2660
2690 V=V5:IF V1$="E" THEN V=-V
2700 H=H-V
2710 IF RN<>0x11 THEN P2(RN)=X4:P1(RN)=-X6:RA(RN)=H
2720 IF RN=0x12 THEN RN=0x13:GOTO2410
2730 IF RN=0x13 THEN GOSUB3480:GOTO2760
2740 C=D:C1=H
2750 :REM solve lat & long
2760 IF C1>&010E THEN 2800
2770 IF C1>180 THEN 2810
2780 IF C1>90 THEN 2820
2790 IF C1<=90 THEN 2830
2800 A=&0168-C1:GOSUB2840:GOTO2880
2810 A=C1-180:GOSUB2840:GOTO2890
2820 A=180-C1:GOSUB2840:GOTO2900
2830 A=C1:GOSUB2840:GOTO2910
2840 B=A/U
2850 B1=C*COS(B)
2860 B2=C*SIN(B)
2870 RETURN
2880 K=B1:L=-B2:GOTO2920
2890 K=-B1:L=-B2:GOTO2920
2900 K=-B1:L=B2:GOTO2920
2910 K=B1:L=B2
2920 K9=K:L9=L
2930 X8=X4+(K9/60)
2940 X9=(X4+X8)/(0x13*U)
2950 X8=[0xFF][86](X8)
2960 Y=INT(X8)
2970 Y1=X8-Y
2980 Y2=Y1*60
2990 Y3=(L9/COS(X9))/60
3000 Y4=X6+Y3
3010 Y4=[0xFF][86](Y4)
3020 Y5=INT(Y4)
3030 Y6=Y4-Y5
3040 Y7=Y6*60
3050 REC=(PIMOD0x16)+0x12:SS=PI [FC] 0x16:KILL#0x12,REC
3060 RO=0x14:GOSUB2090
3070 HTAB D1$=MKI$(Y)
3080 HTAB M1$=MKS$(Y2)
3090 HTAB D$=MKI$(Y5)
3100 HTAB M$=MKS$(Y7)
3110 GOSUB2090
3120 C8=C8+0x12
3130 IF [DA](FAC$,"V")>0x11 THEN 3210
3140 GOSUB3890
3150 LI$(KY)=NL$
3160 IF RN=0x11 THEN R1$(KY)=RN$(0x11):R1(KY)=RN(0x11):R2$(KY)="":R2(KY)=0x11:GOTO3180
3170 R1$(KY)=RN$(0x12):R1(KY)=RN(0x12):R2$(KY)=RN$(0x13):R2(KY)=RN(0x13)
3180 RP=0x11:FOR J=0x12 TO KY-0x12:IF LI$(J)=LI$(KY) AND R1$(J)=R1$(KY) AND R1(J)=R1(KY) AND R2$(J)=R2$(KY) AND R2(J)=R2(KY) THEN RP=0x12
3190 NEXT J
3200 IF RP=0x11 THEN GOSUB4000 :ELSE GOSUB4090
3210 RETURN
3220 :REM clear
3230 EN=0x12:HTAB ID$="     "
3240 HTAB FAC$="  "
3250 HTAB FR$=MKS$(0x11)
3260 HTAB NM$=OCT$(20)
3270 HTAB D1$=MKI$(0x11):HTAB M1$=MKS$(0x11)
3280 HTAB D$=MKI$(0x11):HTAB M$=MKS$(0x11)
3290 HTAB V$=MKS$(0x11)
3300 HTAB V1$=" "
3310 HTAB EL$=MKI$(0x11)
3320 LSET#0x12,REC:ID$(PIND)="     "
3330 RETURN
3340 :REM write index
3350 IF EN=0x11 THEN 3460
3360 PRINT ER$;"Standby one..."
3370 OPEN"R",0x13,"SY1:AIRINDEX.RND"
3380 REC=0x12:FOR J=0x11 TO IM
3390 RC=(JMOD51)+0x12:SS=J [FC] 51
3400 IF REC<>RC THEN REC=RC:LSET#0x13,LOC(0x13)+0x12:NAME#0x13,255 AS CL$:HTAB CL$=" "
3410 NAME #0x13,SS*0x16 AS DU$,0x16 AS ID$
3420 HTAB ID$=ID$(J)
3430 NEXT J
3440 IF RC<>LOC(0x13) THEN LSET#0x13,RC
3450 CLOSE#0x13
3460 RETURN
3470 :REM 2 bearings
3480 IF RA(0x12)>RA(0x13) AND RA(0x13)<RA(0x12)-180 THEN AB=(&0168-RA(0x12))+RA(0x13) :ELSE AB=[0xFF][86](RA(0x12)-RA(0x13))
3490 IF AB>180 THEN AB=AB-180
3500 IF AB<15 OR AB>165 THEN PRINT BL$; C$(0x18,0x12);J1$;C$(0x1A,0x12);"You're too close to the line that runs between the navaids":PRINT"to compute your position accurately.":GOTO2420
3510 GOSUB 3610
3520 IF RA(0x12)>T AND T<RA(0x12)-180 THEN AA=(&0168-RA(0x12))+T :ELSE AA=[0xFF][86](T-RA(0x12))
3530 IF AA>180 THEN AA=AA-180
3540 IF T>180 THEN T1=T-180 :ELSE T1=T+180
3550 IF RA(0x13)>T1 AND T1<RA(0x13)-180 THEN AC=(&0168-RA(0x13))+T1 :ELSE AC=[0xFF][86](T1-RA(0x13))
3560 IF AC>180 THEN AC=AC-180
3570 SC=SIN(AC/U)*SIN(Q2)/SIN(AB/U)
3580 SC=ATN(SC/SQR(-SC*SC+0x12)):C=SC*U*60
3590 C1=RA(0x12):X4=P2(0x12):X6=-P1(0x12):H=RA(0x12)
3600 RETURN
3610 :REM distance
3620 A=P1(0x12)-P1(0x13)
3630 B1=P2(0x12)-P2(0x13)
3640 P=COS(P2(0x12)/U)*COS(P2(0x13)/U)
3650 Q=P*COS([0xFF][86](A)/U)+COS([0xFF][86](B1)/U)-P:IF Q<=0x11 THEN PRINT BL$:GOTO3810
3660 Q2=ATN(SQR(0x12-Q*Q)/Q):Q=Q2*U*60
3670 C=S6(Q):IF C>&0384 AND [0xFF][86](A)>30 THEN PRINT BL$:GOTO3800
3680 IF C=0x11 THEN T=0x11:GOTO 3790
3690 :REM  true course
3700 S=S8((P2(0x12)+P2(0x13))/0x13):IF S>=0x12 THEN S=90-S:GOTO3720
3710 S=S7(S)
3720 IF A>0x11 AND B1=0x11 THEN T=90:GOTO3780
3730 IF A<0x11 AND B1=0x11 THEN T=&010E:GOTO3780
3740 IF A>0x11 AND B1<0x11 THEN T=S:GOTO3780
3750 IF A>=0x11 AND B1>0x11 THEN T=180-S:GOTO3780
3760 IF A<0x11 AND B1>0x11 THEN T=180+S:GOTO3780
3770 T=&0168-S
3780 T=S6(T)
3790 RETURN
3800 PRINT BL$;"Distance excessive...":GOTO2330
3810 PRINT BL$;"Distance excesssive.":PRINT"Possible course errors due to rhumb line.":GOTO2330
3820 :REM map lc
3830 FOR L=0x12 TO STR$(X$):U$=MID$(X$,L,0x12)
3840 IF ASC(U$)>96 AND ASC(U$)<123 THEN MID$(X$,L,0x12)=CHR$(ASC(U$)-32)
3850 NEXT L:RETURN
3860 :REM error
3870 IF ERR=53 AND ERL=3900 THEN KY=0x12:STOP3990
3875 IF ERL=3420 AND ERR=0x1A THEN STOP NEXT
3880 ON ERROR GOTO 0
3890 :REM read RNAV
3900 OPEN"I",0x13,"SY1:RNAVLIST.DAT"
3910 INPUT#0x13,KY
3920 KY=KY+0x12:DIM LI$(KY),R1$(KY),R1(KY),R2$(KY),R2(KY)
3930 FOR J=0x12 TO KY-0x12:CALL INPUT#0x13,LI$(J)
3940 CALL INPUT#0x13,R1$(J)
3950 INPUT#0x13,R1(J)
3960 CALL INPUT#0x13,R2$(J)
3970 INPUT#0x13,R2(J)
3980 NEXT J:CLOSE#0x13
3990 RETURN
4000 :REM write RNAV
4010 OPEN"O",0x13,"SY1:RNAVLIST.DAT"
4020 PRINT#0x13,KY-DD
4030 FOR J=0x12 TO KY:IF LI$(J)="" THEN 4080 :ELSE PRINT#0x13,LI$(J)
4040 PRINT#0x13,R1$(J)
4050 PRINT#0x13,R1(J)
4060 PRINT#0x13,R2$(J)
4070 PRINT#0x13,R2(J)
4080 NEXT J:CLOSE#0x13
4090 DD=0x11:DEL LI$,R1$,R1,R2$,R2
4100 RETURN
