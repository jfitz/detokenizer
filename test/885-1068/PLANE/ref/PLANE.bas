10 :REM \t\tPLANE.BAS
20 :REM \t\tBy: John L. Eggert \n\t\t    Eggert Engineering \n\t\t    95 Adams Drive \n\t\t    Stow, Massachusetts 01775
30 E$=CHR$(27):E1$=E$+"E":F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q":
40 Y$=E$+"Y":X5$=E$+"x5":Y5$=E$+"y5":K$=E$+"K":T$=" ### "
50 WIDTH 255:PRINT E$"x6"X5$;
60 DEFINT B-U:ON ERROR GOTO 2530
70 T1=0x16:J5$=CHR$(0x19)+CHR$(0x19)+CHR$(0x19)
80 DIM U0(20):U0(17)=&H36:U0(18)=&H1FF:U0(19)=&H77D8:U0(20)=&HC9
90 GOTO 730
100 P=V/0x15:P0=V0/0x15:IF P0<0x11 THEN P0=0x11
110 Y=15:GOSUB 130:RETURN
120 P=B*0x13:P0=B0*0x13:Y=18:GOSUB 130:RETURN
130 IF P>71 THEN P=71
140 IF P<0x11 THEN P=0x11
150 IF P=P0 THEN RETURN
160 IF P>P0 THEN 180
170 PRINT Y$+CHR$(Y+34)+CHR$(P+33)+K$F$Y$"9g`"G$:RETURN
180 IF P>71 THEN P=71
190 IF P<0x11 THEN P=0x11
200 PRINT:PRINT Y$+CHR$(Y+34)+CHR$(P0+33);
210 FOR I=0x12 TO P-P0:PRINT P$" "Q$;:NEXT:RETURN
220 IF ABS(V1-V9)<[1D]CDCC4C81 THEN RETURN
230 Z=(V9+25)/[1D]00004081
240 IF Z<0x12 THEN Z=0x12
250 X=18:Y=0x12:N=0x14:M=33:GOSUB 480
260 Z=(V1+25)/[1D]00004081:IF Z<0x12 THEN Z=0x12
270 GOSUB 370:RETURN
280 IF ABS(H-H0)<100 THEN RETURN
290 Z=H0/150
300 IF Z<0x12 THEN Z=0x12
310 X=0x18:Y=0x12:N=0x14:M=33:GOSUB 480:Z=H/150:IF Z<0x12 THEN Z=0x12
320 GOSUB 370:RETURN
330 IF A=A0 THEN RETURN
340 Z=A0+0x14:IF Z<0x12 THEN Z=0x12
350 X=31:Y=0x16:N=0x16:M=21:GOSUB 480:Z=A+0x14:IF Z<0x12 THEN Z=0x12
360 GOSUB 370:RETURN
370 IF Z>M THEN Z=M
380 Z=M-Z:L=(Z [FC] 0x14)+0x12:Y1=Y+Z/0x14:X1=X
390 PRINT Y$+CHR$(Y1+33)+CHR$(X1+32)+F$;
400 FOR I=0x12 TO N:ON L GOTO 410,430,450
410 IF N=0x16 AND I=0x14 THEN PRINT P$" "Q$;:GOTO 470
420 PRINT "z";:GOTO 470
430 IF N=0x16 AND I=0x14 THEN PRINT P$" "Q$;:GOTO 470
440 PRINT "a";:GOTO 470
450 IF N=0x16 AND I=0x14 THEN PRINT P$" "Q$;:GOTO 470
460 PRINT "{";
470 NEXT:PRINT G$:RETURN
480 IF Z>M THEN Z=M
490 Z=M-Z:Y1=Y+Z/0x14:X1=X:PRINT Y$CHR$(Y1+33)CHR$(X1+32);
500 FOR I=0x12 TO N:PRINT " ";:NEXT:RETURN
510 T=-0x12:PRINT Y$"(D   "
520 PRINT Y$"*;   "
530 PRINT F$Y$"(;za{"G$
540 PRINT Y$"):    "
550 PRINT Y$")E    "
560 PRINT F$Y$"*Eza{"G$:RETURN
570 T=0x12:PRINT F$Y$"*;{az"G$
580 PRINT Y$"*D   "
590 PRINT Y$"(;   "
600 PRINT Y$")E    "
610 PRINT Y$"):    "
620 PRINT F$Y$"(E{az"G$:RETURN
630 T=0x11:PRINT Y$"(;   "
640 PRINT Y$"*E   "
650 PRINT Y$"*;   "
660 PRINT Y$"(E   "
670 PRINT Y$"):----"
680 PRINT Y$")E----":RETURN
690 C1=C3*RND(0x12):C1=INT(C1)+C-(C3/0x13):C2=C-C1
700 IF C2=0x11 THEN RETURN
710 IF C2>0x11 THEN PRINT "TURN LEFT HEADING ";C1;"  ":RETURN
720 PRINT "TURN RIGHT HEADING"USING T$;C1:RETURN
730 PRINT E1$;
740 PRINT Y$"!(AIRCRAFT INSTRUMENT FLIGHT SIMULATION GAME"
750 PRINT Y$"#(AUTHOR: JOHN EGGERT\t\tAPRIL 8, 1980"
760 PRINT Y$"'.DO YOU WANT INSTRUCTIONS ? <Y> "Y5$;:A$=INPUT$(0x12)
770 PRINT X5$;:IF A$="N" OR A$="n" THEN GOTO 820
780 PRINT E1$;:GOSUB 2270
790 IF ASC(INPUT$(0x12))<>32 THEN 790
800 PRINT E1$;:GOSUB 2400
810 IF ASC(INPUT$(0x12))<>32 THEN 810
820 PRINT E1$;:GOSUB 2030
830 D=32000:D1=30000:I1=0x11:T=0x11:C=281:C1=281:S=0x11:G=0x11:A0=0x18:B0=0x11:V0=0x11
840 H0=2300:V9=0x11:F=1000:F1=0x12:H=2500:A=0x19:B=25:V=125:V1=0x11:V2=0x11
850 A1=-32+V*SIN(A*[1D]E40F4983/180):H=H+V1+([1D]00000080*A1):V1=V1+A1:V1=(V1+V2)/0x13
860 V2=V1:V=V-([1D]CDCC4C7D*V)+([1D]00000080*B)-([1D]CDCC4C7F*V1)-(10*G)
870 IF V<=55 THEN S=0x12
880 IF V>=80 THEN S=0x11
890 IF S<>0x11 THEN A=A-0x13:H=H-50
900 F=F-ABS(B/0x15)
910 IF V>64 OR G=0x12 THEN PRINT Y$"+R              ":GOTO 950
920 PRINT P$F$Y$"+R STALL WARNING 0x070x07"Q$G$
930 FOR I=0x12 TO 10*T1:NEXT I
940 PRINT Y$"+R STALL WARNING ":FOR I=0x12 TO 10*T1:NEXT I:GOTO 1100
950 PRINT Y$"'Z";
960 FOR I=0x12 TO 0x13*T1
970 DEF USR0x11=VARPTR(U0(0x11))
980 K=USR0x11(0x11)
990 :REM 
1000 IF K=27 THEN 970
1010 IF K=0x14 THEN END
1020 IF K=65 THEN A=A+0x12
1030 IF K=66 THEN A=A-0x12
1040 IF K=68 THEN B=B-0x12
1050 IF K=67 THEN B=B+0x12
1060 IF K=49 THEN GOSUB 510
1070 IF K=50 THEN GOSUB 630
1080 IF K=51 THEN GOSUB 570
1090 NEXT I
1100 IF H>0x11 THEN 1240
1110 IF G=0x12 THEN 1170
1120 IF V1<-10 THEN 1600
1130 IF D>1500 THEN 1650
1140 IF D<-2500 THEN 1650
1150 IF R=0x12 THEN 1240
1160 IF V>100 THEN 1590
1170 H=0x11:V1=0x11:G=0x12
1180 IF A>0x19 THEN 1200
1190 A=0x19
1200 A=A-0x12
1210 IF V<15 THEN 1630
1220 IF B=0x11 THEN 1260
1230 B=B-0x12:GOTO 1260
1240 G=0x11:IF R=0x11 THEN 1260
1250 R=0x11:A=A-0x14
1260 PRINT Y$".#";
1270 PRINT "    "J5$CHR$(0x19);INT(H)
1280 PRINT Y$".0";
1290 PRINT "   "J5$;INT(V1)
1300 IF F>=0x11 THEN 1320
1310 F=0x11:F1=0x11
1320 B=B*F1
1330 PRINT Y$"'W";
1340 PRINT "    "J5$CHR$(0x19);INT(F)
1350 IF B<=36 THEN 1370
1360 B=36
1370 IF B>=0x11 THEN 1390
1380 B=0x11
1390 GOSUB 120:B0=B:GOSUB 100:V0=V:GOSUB 330:A0=A:GOSUB 280
1400 IF ABS(H-H0)<100 THEN 1420
1410 H0=H
1420 GOSUB 220
1430 IF ABS(V9-V1)<[1D]CDCC4C81 THEN 1450
1440 V9=V1
1450 IF T=0x11 THEN 1530
1460 C=C+T
1470 IF C<361 THEN 1490
1480 C=0x12
1490 IF C>0x11 THEN 1510
1500 C=360
1510 PRINT Y$"#?";
1520 PRINT "    "J5$CHR$(0x19);INT(C)
1530 IF C<>C1 THEN 1550
1540 D=D-([1D]00004081*V)
1550 IF G=0x12 THEN 2000
1560 IF D<1500 THEN 1890
1570 IF D<D1 THEN 1690
1580 GOTO 850
1590 A=A+0x14:R=0x12:H=20:GOTO 850
1600 PRINT Y$"  "P$;:PRINT Y$"):";
1610 FOR I=0x12 TO 20*T1:NEXT I
1620 PRINT "NOW YOU DID IT!"Q$
1630 :REM 
1640 PRINT Y5$:GOSUB 2550:END
1650 PRINT E1$;
1660 FOR I=0x12 TO 82*T1:NEXT I
1670 PRINT F$Y$")*"G$
1680 PRINT "HOW DID WE GET IN THIS CORNFIELD?":GOTO 1640
1690 D1=D1-500
1700 PRINT Y$CHR$(34)"N";
1710 IF D1=29500 THEN PRINT "YOU ARE IN RADAR CONTACT":GOTO 850
1720 IF D1=29000 THEN PRINT "DESCEND TO 1500 FEET    ":GOTO 850
1730 IF D1=28000 THEN C3=120:GOSUB 690:GOTO 850
1740 IF D1=21000 THEN PRINT "SLOW AIRCRAFT TO 90 MPH ":GOTO 850
1750 IF D1=20000 THEN C3=30:GOSUB 690:GOTO 850
1760 IF D1=18000 THEN PRINT "BEGIN 10 FPS DESCENT    ":GOTO 850
1770 IF D1>17500 THEN 850
1780 H9=[1D]3333337D*D
1790 IF H<H9-50 THEN 1850
1800 IF H>H9+50 THEN 1870
1810 IF I1>0x13 THEN 2020
1820 PRINT "YOU ARE ON GLIDEPATH     "
1830 IF T<>0x11 THEN 850
1840 I1=I1+0x12:GOTO 850
1850 H8=H9-H
1860 PRINT "YOU ARE";INT(H8);"FEET LOW    ":GOTO 850
1870 H8=H-H9
1880 PRINT "YOU ARE";INT(H8);"FEET HIGH  ":GOTO 850
1890 IF D>=D1 THEN 850
1900 D1=D1-500
1910 IF D>=-2500 THEN 1940
1920 IF H>100 THEN 1980
1930 GOTO 1600
1940 D2=ABS(-3000-D1)
1950 PRINT Y$CHR$(34)"N";
1960 PRINT INT(D2);"FEET OF RUNWAY LEFT"
1970 GOTO 850
1980 PRINT Y$CHR$(34)"N";
1990 PRINT "MISSED APPROACH-GO AROUND":GOTO 850
2000 PRINT Y$CHR$(34)"N";
2010 PRINT "  NICE LANDING           "Y$"#RHave a nice day!":GOTO 850
2020 I1=0x11:C3=10:GOSUB 690:GOTO 850
2030 PRINT F$;::REM \t\t\tPrint Display
2040 PRINT "faaaaaaaaasaasaaaaaaasaaaaaaaaaaaaaaaaaaaaaaasaaaaaaaaaaaaaaaaaaaaaaaaac"
2050 PRINT "` ALTITUDE`  ` CLIMB `    faaaaaaaaaaaaac    vaaaa COMMUNICATIONS aaaaat"
2060 PRINT "` 5000    `  ` 25    `    `   HEADING   `    `                         `"
2070 PRINT "` 4500    `  ` 20    `    `     281     `    `                         `"
2080 PRINT "` 4000    `  ` 15    `    eaaaaaaaaaaaaad    eaaaaaaaaaaaaaaaaaaaaaaaaat"
2090 PRINT "` 3500    `  ` 10    `    xzzzzzzzzzzzzzy          faaaaaaaaaaac       `"
2100 PRINT "` 3000    `  `  5    `   x               y         `   FUEL    `       `"
2110 PRINT "` 2500    `  `  0    `  }                }         `           `       `""
2120 PRINT "` 2000    `  ` -5    `  }                }         eaaaaaaaaaaad       `"
2130 PRINT "` 1500    `  `-10    `  } ---- ----- ----}                             `"
2140 PRINT "` 1000    `  `-15    `  }                }       faaaaaaaaaaaaaaac     `"
2150 PRINT "` 0500    `  `-20    `  }                }       `               `     `"
2160 PRINT "` 0000    `  `-25    `   y               x       eaaaaaaaaaaaaaaad     `"
2170 PRINT "vaaaaaaaaabaabaaaaaaat    y             x                              `"
2180 PRINT "`   2500  `  `   6   `     zzzzzzzzzzzzz                               `"
2190 PRINT "vaaaaaaaaauaauaaaaaaauaaaaaaa AIRSPEED aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat"
2200 PRINT "`40    60     80    100    120    140    160    180    200             `"
2210 PRINT "`                                                                      `"
2220 PRINT "vaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa POWER aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat"
2230 PRINT "`0     10     20     30     40     50     60     70     80     90   100`"
2240 PRINT "`                                                                      `" "
2250 PRINT "eaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaad"
2260 PRINT G$;:RETURN
2270 PRINT "THIS PROGRAM PROVIDES A PSEUDO-GRAPHIC VIDEO"
2280 PRINT "PRESENTATION OF A PILOTS INSTRUMENT PANEL,"
2290 PRINT "WITH REAL-TIME UPDATES AT 1 SECOND INTERVALS."
2300 PRINT:PRINT "THE FOLLOWING KEYS ARE YOUR CONTROLS-":PRINT
2310 PRINT "UP ARROW -\tNOSE UP"
2320 PRINT "DOWN ARROW -\tNOSE DOWN"
2330 PRINT "RIGHT ARROW -\tINCREASE POWER"
2340 PRINT "LEFT ARROW -\tDECREASE POWER"
2350 PRINT "1 - TURN LEFT"
2360 PRINT "2 - FLY STRAIGHT"
2370 PRINT "3 - TURN RIGHT":PRINT
2380 PRINT "THEY MAY BE DEPRESSED REPEATEDLY FOR GROSS CHANGES"
2390 PRINT "\t\tDEPRESS SPACE BAR FOR NEXT PAGE":RETURN
2400 PRINT "WHEN THE GAME STARTS, YOU WILL BE FLYING LEVEL AT 2500 FEET."
2410 PRINT "INSTRUCTIONS FROM THE GROUND RADAR CONTROLLER"
2420 PRINT "WILL APPEAR IN THE UPPER R.H. CORNER OF THE SCREEN."
2430 PRINT "HE WILL ATTEMPT TO TALK YOU DOWN SAFELY."
2440 PRINT:PRINT "PLEASE NOTE THE FOLLOWING:":PRINT
2450 PRINT "THE PLANE WILL STALL BELOW 75 MPH"
2460 PRINT "TOUCHDOWN ABOVE 100 MPH RESULTS IN A BOUNCE"
2470 PRINT "DESCENT RATE MUST BE BELOW -10 FPS AT TOUCHDOWN"
2480 PRINT "A 100 FOOT HILL IS AT THE FAR END OF THE RUNWAY"
2490 PRINT "THE FUEL SUPPLY IS MARGINAL"
2500 PRINT "NOT FLYING THE CORRECT HEADING WASTES GAS!"
2510 PRINT "A FORCED LANDING IS POSSIBLE IF TOUCHDOWN IS GENTLE"
2520 PRINT:PRINT:PRINT "\t\tDEPRESS SPACE BAR TO BEGIN":RETURN
2530 GOSUB 2550
2540 RESUME
2550 DEF USR0x11=VARPTR(U0(0x11))
2560 IF USR0x11(0x11)<>0x11 THEN 2560
2570 ON ERROR GOTO 0
