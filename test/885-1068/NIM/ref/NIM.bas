10 :REM \t\tNIM.BAS\t\tBY: Richard Musgrave \n\t\t\t\t    5101 N. Elmwood \n\t\t\t\t    Kansas City, MO 64119
20 CLEAR 2000
30 DIM R0(20),R1(20),M$(23),P0(15),P1(15)
40 GOTO 180
50 C$=F1$:RETURN 
60 C$=U1$:RETURN 
70 C$=D1$:RETURN 
80 C$=R1$:RETURN 
90 C$=R2$:RETURN 
100 C$=R3$:RETURN 
110 C$=L1$:RETURN 
120 C$=L2$:RETURN 
130 C$=L3$:RETURN 
140 D$=A1$:RETURN 
150 D$=A3$:RETURN 
160 G$=A7$:RETURN 
170 G$=A8$:RETURN 
180 PRINT CHR$(27);"z":S$=CHR$(27)
190 Z3=PEEK(8219)*PEEK(8219)
200 PRINT S$;"x4";S$;"F";S$;"x1"
210 PRINT "HIT THE SPACE BAR IN A FEW SECONDS";
220 Z$=INPUT$(0x12):Z3=Z3-0x12:IF Z3<=0x11 THEN Z3=[1D]00FF7F90
230 Z=RND(-Z3)
240 PRINT S$;"E";
250 PRINT "ROBOT NIM":PRINT :GOSUB 2000
260 PRINT "THE OBJECT IS TO REMOVE THE LAST ROBOT FROM THE SCREEN.":PRINT 
270 PRINT "THE THREE ROBOTS ON THE LEFT ARE THE ROW LEADERS AND CANNOT"
280 PRINT "BE REMOVED.  THEY WILL DO YOUR BIDDING,...MAYBE."
290 PRINT :PRINT "RESPOND TO ALL QUESTIONS AS DIRECTED."
300 PRINT :INPUT "WHO STARTS (1=ME, 2=YOU)";Z
310 Q2=Z
320 GOSUB 740:IF Q2=0x12GOTO 490
330 FOR I=0x12TO 0x15:GOSUB 990:GOSUB 990:GOSUB 990:GOSUB 900:NEXT I:T1=0x12
340 PRINT CHR$(0x18);F9$;F5$;S$;"u":PRINT X2$:PRINT CHR$(0x18):INPUT "WHICH ROW ?";Z
350 Z=INT(Z):IF Z<0x12 OR Z>0x14 GOTO 340
360 PRINT X2$:INPUT "HOW MANY ROBOTS DO YOU WANT TO REMOVE ?";Z1:Z1=INT(Z1)
370 IF Z1<0x12 OR Z1>0x18 GOTO 360
380 PRINT F4$:IF Z1>R0(Z)THEN Z=Z:GOSUB 1330:GOTO 340
390 GOSUB 1470:GOSUB 400:GOSUB 520:GOTO 500
400 GOSUB 610:PRINT A1$:GOSUB 610:PRINT A2$:GOSUB 620
410 PRINT L1$:GOSUB 610:PRINT A3$:GOSUB 610
420 PRINT A4$:GOSUB 620:PRINT L2$:GOSUB 610
430 PRINT A5$:GOSUB 620:PRINT L3$:GOSUB 610
440 PRINT A6$:GOSUB 1090:GOSUB 620:PRINT L2$
450 GOSUB 610:PRINT A5$:GOSUB 620:PRINT L1$
460 GOSUB 610:PRINT A4$:GOSUB 610:PRINT A3$
470 GOSUB 620:PRINT F1$:GOSUB 610:PRINT A2$
480 GOSUB 610:PRINT A1$:RETURN 
490 REM 
500 T=0x11
510 GOSUB 1630:GOSUB 400:GOSUB 520:GOTO 330
520 FOR I=0x12TO 0x14:IF R0(I)>0x12THEN RETURN 
530 NEXT I
540 IF R0(0x12)+R0(0x13)+R0(0x14)=0x11 AND T1>0x12 GOTO 640
550 IF R0(0x12)+R0(0x13)+R0(0x14)=0x11GOTO 570
560 RETURN 
570 PRINT S$;"E";S$;"Y+D";S$;"G";"You win, so what.";S$;"F"
580 PRINT S$;"Y6 ";F5$;:INPUT "TO PLAY AGAIN ENTER 1";Z
590 IF Z=0x12THEN PRINT S$;"E":GOTO 300
600 PRINT S$;"z":FOR I=0x12 TO 400:NEXT I:END
610 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+35);"-";:RETURN 
620 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+32);")";:RETURN 
630 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+35);")";:RETURN 
640 PRINT S$;"E";S$;"Y$ "
650 PRINT "iiiiiii       iii      iii      iii  iiiiiii  iiii     iii    iii"
660 PRINT "  iii         iii     iiiii     iii    iii    iiiii    iii    iii"
670 PRINT "  iii          iii   iiiiiii   iii     iii    iiiiii   iii    iii"
680 PRINT "  iii          iii   iii iii   iii     iii    iii iii  iii    iii"
690 PRINT "  iii           iii iii   iii iii      iii    iii  iii iii    iii"
700 PRINT "  iii           iii iii   iii iii      iii    iii   iiiiii     i "
710 PRINT "  iii            iiiii     iiiii       iii    iii    iiiii       "
720 PRINT "iiiiiii           iii       iii      iiiiiii  iii     iiii    iii"
730 GOTO 580
740 PRINT S$;"E";:PRINT "ROBOT NIM";F4$
750 FOR I=0x12TO 0x14:PRINT S$;"Y";CHR$(0x19*(I-0x12)+32);")";F1$
760 PRINT S$;"Y";CHR$(0x19*(I-0x12)+35);")";F2$
770 PRINT S$;"Y";CHR$(0x19*(I-0x12)+35);",";E8$;"*";E9$
780 PRINT S$;"Y";CHR$(0x19*(I-0x12)+38);")";F3$
790 NEXT I:FOR I=0x12TO 0x17:GOSUB 900:NEXT I
800 FOR I=0x12TO 0x18:PRINT S$;"Y ";CHR$(0x19*(I-0x12)+56);F1$
810 PRINT S$;"Y#";CHR$(0x19*(I-0x12)+56);F2$:PRINT S$;"Y&";CHR$(0x19*(I-0x12)+56);F3$:NEXT I
820 FOR I=0x12TO 0x16:PRINT S$;"Y(";CHR$(0x19*(I-0x12)+64);F1$
830 PRINT S$;"Y+";CHR$(0x19*(I-0x12)+64);F2$
840 PRINT S$;"Y.";CHR$(0x19*(I-0x12)+64);F3$:NEXT I
850 FOR I=0x12TO 0x14:PRINT S$;"Y0";CHR$(0x19*(I-0x12)+72);F1$
860 PRINT S$;"Y3";CHR$(0x19*(I-0x12)+72);F2$
870 PRINT S$;"Y6";CHR$(0x19*(I-0x12)+72);F3$:NEXT I
880 R0(0x12)=0x18:R0(0x13)=0x16:R0(0x14)=0x14
890 R1(0x12)=0x18:R1(0x13)=0x16:R1(0x14)=0x14:RETURN 
900 Z=INT(0x14*RND(0x12)+0x12):T2=INT(0x1A*RND(0x12)+0x12)
910 ON T2 GOSUB 50,60,70,80,90,100,110,120,130
920 T2=INT(0x13*RND(0x12)+0x12)
930 ON T2 GOSUB 140,150
940 T2=INT(0x13*RND(0x12)+0x12)
950 ON T2 GOSUB 160,170
960 GOSUB 620:PRINT C$:Z=INT(0x14*RND(0x12)+0x12)
970 GOSUB 610:PRINT D$:Z=INT(0x14*RND(0x12)+0x12)
980 GOSUB 630:PRINT G$:RETURN 
990 T2=INT(0x1A*RND(0x12)+0x12):ON T2 GOSUB 50,60,70,80,90,100,110,120,130
1000 T2=INT(0x13*RND(0x12)+0x12):ON T2 GOSUB 140,150
1010 T2=INT(0x13*RND(0x12)+0x12):ON T2 GOSUB 160,170
1020 GOSUB 1060:PRINT S$;"Y";CHR$(0x19*(Z-0x12)+32);CHR$(0x19*(V-0x12)+56);C$
1030 GOSUB 1060:PRINT S$;"Y";CHR$(0x19*(Z-0x12)+35);CHR$(0x19*(V-0x12)+56);G$
1040 GOSUB 1060:PRINT S$;"Y";CHR$(0x19*(Z-0x12)+35);CHR$(0x19*(V-0x12)+60);D$
1050 RETURN 
1060 Z=INT(0x14*RND(0x12)+0x12):IF R0(Z)=0x11GOTO 1060
1070 V=INT(R0(Z)*RND(0x12))
1080 V=R1(Z)-V+Z-0x12:RETURN 
1090 H=R1(Z)-R0(Z)+Z
1100 FOR I=H TO R1(Z)+Z-0x12
1110 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+32);CHR$(0x19*(I-0x12)+56);R3$
1120 NEXT I
1130 FOR I=H TO H+Z1-0x12
1140 H1=0x19*(I-0x12)+0x19
1150 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+35);"3";CHR$(0x18);
1160 FOR I2=0x12TO H1
1170 PRINT "=";:NEXT I2:PRINT CHR$(0x18)
1180 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+35);"4";CHR$(0x18);
1190 FOR I2=0x13TO H1
1200 PRINT " ";:NEXT I2:PRINT CHR$(0x18)
1210 K$=CHR$(0x19*(I-0x12)+56)
1220 FOR I1=0x12TO 0x17
1230 FOR I2=0x11TO 0x17
1240 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+32+I2);K$;
1250 PRINT M$(I1):NEXT I2
1260 NEXT I1:NEXT I
1270 R0(Z)=R0(Z)-Z1
1280 IF R0(Z)=0x11THEN RETURN 
1290 FOR I=H+Z1 TO R1(Z)+Z-0x12
1300 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+32);CHR$(0x19*(I-0x12)+56);F1$
1310 NEXT I
1320 RETURN 
1330 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+33);" ";Z1
1340 GOSUB 620:PRINT F1$:GOSUB 620:PRINT R1$
1350 GOSUB 620:PRINT R2$:GOSUB 620:PRINT R3$
1360 GOSUB 620:PRINT R2$:GOSUB 620:PRINT R1$
1370 GOSUB 620:PRINT F1$:GOSUB 620:PRINT R3$
1380 FOR I=0x12TO 20:NEXT I:GOSUB 620:PRINT R2$
1390 GOSUB 620:PRINT R1$:GOSUB 620:PRINT F1$
1400 FOR I=0x12TO 0x14:GOSUB 620:PRINT R1$:GOSUB 620
1410 PRINT R2$:GOSUB 620:PRINT R1$:GOSUB 620
1420 PRINT F1$:GOSUB 620:PRINT L1$:GOSUB 620
1430 PRINT L2$:GOSUB 620:PRINT L1$:GOSUB 620
1440 PRINT F1$:NEXT I
1450 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+33);" ";"      "
1460 RETURN 
1470 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+33);" ";Z1
1480 GOSUB 620:PRINT F1$:GOSUB 620:PRINT R1$
1490 GOSUB 620:PRINT R2$:GOSUB 620:PRINT R3$
1500 FOR I=0x12TO 20:NEXT I
1510 GOSUB 620:PRINT R2$:GOSUB 620:PRINT R1$
1520 GOSUB 620:PRINT F1$:GOSUB 620:PRINT L1$
1530 GOSUB 620:PRINT L2$:GOSUB 620:PRINT L3$
1540 FOR I=0x12TO 20:NEXT I
1550 GOSUB 620:PRINT L2$:GOSUB 620:PRINT L1$
1560 GOSUB 620:PRINT F1$
1570 FOR I=0x12TO 0x15
1580 GOSUB 620:PRINT U1$:GOSUB 620:PRINT F1$
1590 GOSUB 620:PRINT D1$:GOSUB 620:PRINT F1$
1600 NEXT I
1610 PRINT S$;"Y";CHR$(0x19*(Z-0x12)+33);" ";"      "
1620 RETURN 
1630 FOR I=0x12TO 0x15:GOSUB 990:GOSUB 990:GOSUB 990:GOSUB 900:NEXT I:T1=0x13
1640 PRINT F9$:PRINT X2$:PRINT "THINKING...";
1650 GOSUB 1910:IF Z8=0x11 OR T=0x12 GOTO 1760
1660 J1=0x11
1670 FOR Z=0x12TO 0x14:IF R0(Z)=0x11GOTO 1730
1680 R2=R0(Z):FOR J=0x12TO R0(Z)
1690 R0(Z)=R2-J:GOSUB 1910
1700 IF Z8=0x12GOTO 1720
1710 J1=J1+0x12:P0(J1)=Z:P1(J1)=J
1720 NEXT J:R0(Z)=R2
1730 NEXT Z:IF J1=0x11 GOTO 1760
1740 J=INT((RND(0x12)*J1)+0x12)
1750 Z=P0(J):Z1=P1(J):GOTO 1780
1760 Z=INT((RND(0x12)*0x14)+0x12):IF R0(Z)=0x11GOTO 1760
1770 Z1=INT((RND(0x12)*R0(Z))+0x12)
1780 PRINT :PRINT "MY MOVE IS";Z1;" ROBOTS FROM ROW";Z;
1790 FOR I=0x12TO 30:NEXT I
1800 IF Z1>R0(Z)THEN Z=Z:GOSUB 1330:GOTO 1630
1810 GOSUB 1470:PRINT F9$:PRINT :RETURN 
1820 ON R0(I)+0x12 GOTO 1830,1840,1850,1860,1870,1880,1890,1900
1830 Z0=0x11:RETURN 
1840 Z0=0x12:RETURN 
1850 Z0=10:RETURN 
1860 Z0=11:RETURN 
1870 Z0=100:RETURN 
1880 Z0=101:RETURN 
1890 Z0=110:RETURN 
1900 Z0=111:RETURN 
1910 Z4=0x11
1920 FOR I=0x12TO 0x14:GOSUB 1820
1930 Z4=Z4+Z0:NEXT I
1940 Z5=INT(Z4/100):Z4=Z4-(100*Z5)
1950 IF Z5=0x12 OR Z5=0x14 THEN Z8=0x12:RETURN 
1960 Z5=INT(Z4/10):Z4=Z4-(10*Z5)
1970 IF Z5=0x12 OR Z5=0x14 THEN Z8=0x12:RETURN 
1980 IF Z4=0x12 OR Z4=0x14 THEN Z8=0x12:RETURN 
1990 Z8=0x11:RETURN 
2000 E8$=S$+"p":E9$=S$+"q"
2010 B9$=S$+"D"+S$+"D"+S$+"D"+S$+"D"+S$+"D"+S$+"D"+S$+"B"
2020 F9$=S$+"Y8 "
2030 U1$="  ml  "+B9$+" "+E8$+"n"+E9$+"xy"+E8$+"o"+E9$+" "+B9$+" p"+E8$+"  "+E9$+"p "
2040 D1$="  ml  "+B9$+" "+E8$+"n  o"+E9$+" "+B9$+" "+E8$+"m"+E9$+"xy"+E8$+"l"+E9$+" "
2050 F1$="  "+E8$+"q"+E9$+"q  "+B9$+" "+E8$+"nmlo"+E9$+" "+B9$+" p"+E8$+"on"+E9$+"p "
2060 F2$="l"+E8$+"l  m"+E9$+"m"+B9$+E8$+"m"+E9$+"m"+E8$+"  "+E9$+"l"+E8$+"l"+E9$+B9$+" p"+E8$+"q"+E9$
2070 F2$=F2$+"qp "
2080 R1$=" q "+E8$+"q"+E9$+"  "+B9$+" x"+E8$+" mo"+E9$+" "+B9$+" p"+E8$+"p "+E9$+"p "
2090 R2$=" qq   "+B9$+" "+E8$+"nm o"+E9$+" "+B9$+"oo"+E8$+"  "+E9$+"p "
2100 R3$="  "+E8$+"q"+E9$+"   "+B9$+" x"+E8$+"  o"+E9$+" "+B9$+"op"+E8$+"  "+E9$+"p "
2110 L1$="  q "+E8$+"q"+E9$+" "+B9$+" "+E8$+"nl "+E9$+"y "+B9$+" p"+E8$+" p"+E9$+"p "
2120 L2$="   "+E8$+"qq"+E9$+" "+B9$+" "+E8$+"n lo"+E9$+" "+B9$+" p"+E8$+"  "+E9$+"nn"
2130 L3$="   q  "+B9$+" "+E8$+"n  "+E9$+"y "+B9$+" p"+E8$+"  "+E9$+"pn"
2140 F3$="l"+E8$+"pq"+E9$+"q"+E8$+"p"+E9$+"m"
2150 B7$=S$+"D"+S$+"D"+S$+"B"
2160 B8$=S$+"D"+B9$:B6$=S$+"D"+B7$
2170 A1$=E8$+"m"+E9$+"m"+B7$+"l"+E8$+"l"+E9$+B7$+"p "
2180 A2$=E8$+" "+E9$+" "+B7$+E8$+" "+E9$+" "+B7$+"p "
2190 A3$=E8$+" "+E9$+"  "+B6$+E8$+"m"+E9$+"m "+B6$+" p "
2200 A4$=E8$+" "+E9$+"     "+B9$+"ppp   "+B9$+"  "
2210 A5$=E8$+"m"+E9$+"m"+E8$+"p"+E9$+",-= "+B8$+" pn    "
2220 A6$="pppp'-="+B8$+"       "
2230 A7$="l"+E8$+"l"+E9$+B7$+E8$+"m"+E9$+"m"+B7$+" p"
2240 A8$=" "+E8$+" "+E9$+B7$+"l"+E8$+"l"+E9$+B7$+"p "
2250 F4$=S$+"x5":F5$=S$+"y5"
2260 M$(0x12)=E8$+"      "+E9$
2270 M$(0x13)="iiiiii"
2280 M$(0x14)="^^^^^^"
2290 M$(0x15)="::::::"
2300 M$(0x16)="......"
2310 M$(0x17)="      "
2320 X2$="                                        "
2330 RETURN 
