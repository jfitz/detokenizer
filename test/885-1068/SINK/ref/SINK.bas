10 :REMARK \t\tSINK.BAS \n\t\tBy: William C. Zurney
20 CLEAR 500
30 DEFINT A-Z
40 E$=CHR$(27):E1$=E$+"E":Y$=E$+"Y"
50 PRINT E1$Y$" 9SINK  By: William C. Zurney"
60 PRINT Y$"#0The object is to sink the ship as it crosses the"
70 PRINT Y$"$0sreen of the torpedoes scope."
80 PRINT Y$"&0Use the keypad at the right for your controls."
90 PRINT Y$"'94 = Turn Gun Left"
100 PRINT Y$"(95 = Shot Torpedoes"
110 PRINT Y$")96 = Turn Gun Right"
120 PRINT Y$"00Hit RETURN to start the game.";:A$=INPUT$(1)
130 ON ERROR GOTO 960
140 PRINT CHR$(27);"y6";CHR$(27);"x2";
150 T4=9 : T9=100
160 DIM T1(T4),T2(T4),T3(T4),U0(3)
170 U0(0)=&H36 : U0(1)=&H1FF : U0(2)=&H77D8 : U0(3)=&HC9
180 PRINT Y$"30SKILL LEVEL (1, 2, 3, 4, OR 5)";:L=VAL(INPUT$(1))
190 IF L<=0 THEN L=1
200 IF L>5 THEN L=5
210 IF L<>5 THEN L=9-2*L :ELSE L=0
220 PRINT CHR$(27);"x5";
230 PRINT CHR$(27);"w";
240 T0=T9
250 FOR I9=0 TO T4 : T3(I9)=99 : NEXT I9
260 E4=E4+1 : IF E4>25 THEN 960
270 PRINT CHR$(27);"E";
280 T5=0 : P=INT(RND(1)*30)+25
290 PRINT CHR$(27);"Y7";CHR$(28+P);CHR$(27);"F 0 l`m 0";
300 W$=""
310 FOR J=0 TO 79
320 IF RND(1)<0.5 THEN W$=W$+"^" :ELSE W$=W$+" "
330 NEXT J
340 F=INT(RND(1)*10) : PRINT CHR$(27);"Y";CHR$(32+F);" ";CHR$(27);"j";
350 D0=INT(RND(1)*2)
360 E3=0
370 E5=3
380 IF F>3 THEN E5=2
390 IF F>7 THEN E5=1
400 E2=INT(E5*RND(1))
410 E5=RND(1)*10
420 ON D0+1 GOSUB 1090,1320
430 PRINT CHR$(27);"G";W$;CHR$(27);"F"
440 I=0
450 DEF USR0=VARPTR(U0(0))
460 IF USR0(0)<>0 THEN 460
470 E3=E3+1 : IF E3<=E2 THEN 530
480 E3=0 : I=I+1
490 E1=E1+D
500 PRINT CHR$(27);"k";D$
510 PRINT D$
520 PRINT D$
530 FOR I9=0 TO T4
540 IF T3(I9)=99 THEN 820
550 IF T1(I9)<>23 THEN PRINT CHR$(27);"Y";CHR$(32+T1(I9));CHR$(32+T2(I9));" ";
560 T1(I9)=T1(I9)-1
570 T2(I9)=T2(I9)+T3(I9)
580 IF T2(I9)<0 OR T2(I9)>79 THEN T3(I9)=99 : GOTO 820
590 IF T1(I9)<>F+2 THEN 810
600 T3(I9)=99
610 T0=T0-1
620 IF T2(I9)>=E1-L AND T2(I9)<=E1+L THEN 720
630 PRINT CHR$(27);"Y";CHR$(32+T1(I9));CHR$(32+T2(I9));CHR$(7);
640 FOR J=1 TO 3
650 PRINT "^";CHR$(27);"D";
660 FOR J1=1 TO 25
670 NEXT J1
680 PRINT CHR$(27);"p^";CHR$(27);"q";CHR$(27);"D";
690 NEXT J
700 IF T2(I9)<E1-7 OR T2(I9)>E1+7 THEN PRINT " ";
710 GOTO 790
720 S=S+1
730 GOSUB 1450
740 IF T0=0 THEN 960
750 FOR I9=0 TO T4
760 T3(I9)=99
770 NEXT I9
780 GOTO 260
790 IF T0=0 THEN 960
800 GOTO 820
810 PRINT CHR$(27);"Y";CHR$(32+T1(I9));CHR$(32+T2(I9));"^";
820 NEXT I9
830 DEF USR0=VARPTR(U0(0)) : X=USR0(0)
840 IF X=32 THEN GOSUB 1180
850 IF X=53 THEN GOSUB 1180
860 IF X=52 THEN GOSUB 1220
870 IF X=54 THEN GOSUB 1250
880 IF X=10 THEN 960
890 IF I<=80 THEN 470
900 FOR I9=0 TO T4
910 IF T3(I9)=99 THEN 940
920 T3(I9)=99
930 PRINT CHR$(27);"Y";CHR$(32+T1(I9));CHR$(32+T2(I9));" ";
940 NEXT I9
950 GOTO 260
960 GOSUB 1050
970 ON ERROR GOTO 0
980 PRINT "SHIPS SUNK =";S
990 PRINT "SHELLS LEFT =";T0
1000 PRINT "RATING = ";
1010 IF T0<>T9 THEN PRINT USING "###";S/(T9-T0)*100;
1020 IF T0=T9 THEN PRINT "0";
1030 PRINT "%"
1040 END
1050 PRINT CHR$(27);"z";STRING$(10,0);
1060 DEF USR0=VARPTR(U0(0))
1070 IF USR0(0)<>0 THEN 1070
1080 RETURN
1090 PRINT "         ";CHR$(27);"pf"
1100 N1$=CHR$(INT(RND(1)*26)+65)
1110 N2$=RIGHT$(STR$(E5),1)
1120 PRINT CHR$(27);"q       ";CHR$(27);"p ";N1$;
1130 PRINT N2$;" ";CHR$(95)
1140 PRINT STRING$(7-L,32);STRING$(2*L+1,105);STRING$(7-L,32);
1150 PRINT CHR$(27);"qr"
1160 D$=CHR$(27)+CHR$(64)+" "+CHR$(27)+"O" : D=1 : E1=7
1170 RETURN
1180 FOR I9=0 TO T4
1190 IF T3(I9)=99 THEN T1(I9)=23 : T2(I9)=P : T3(I9)=T5 : \n\tPRINT CHR$(7); : RETURN
1200 NEXT I9
1210 RETURN
1220 IF T5=-3 THEN RETURN
1230 T5=T5-1
1240 GOTO 1270
1250 IF T5=+3 THEN RETURN
1260 T5=T5+1
1270 PRINT CHR$(27);"Y7";CHR$(28+P);
1280 IF T5<0 THEN PRINT ABS(T5);"l\l 0";
1290 IF T5=0 THEN PRINT " 0 l`m 0";
1300 IF T5>0 THEN PRINT " 0 m/m";T5;
1310 RETURN
1320 PRINT CHR$(27);"Y";CHR$(32+F);CHR$(96);
1330 PRINT "      ";CHR$(27);"pc"
1340 PRINT CHR$(27);"Y";CHR$(33+F);CHR$(96);
1350 N1$=CHR$(INT(RND(1)*26)+65)
1360 N2$=RIGHT$(STR$(E5),1)
1370 PRINT CHR$(27);"q    ";CHR$(27);"pr ";N1$;
1380 PRINT N2$;" "
1390 PRINT CHR$(27);"Y";CHR$(34+F);CHR$(96);
1400 PRINT CHR$(27);"q";CHR$(95);CHR$(27);"p";
1410 PRINT STRING$(7-L,32);STRING$(2*L+1,105);STRING$(7-L,32);
1420 PRINT CHR$(27);"q"
1430 D$=CHR$(27)+"N" : D=-1 : E1=72
1440 RETURN
1450 IF D0=1 THEN 1640
1460 IF E1>71 THEN E1=71
1470 FOR I=1 TO 6
1480 PRINT CHR$(27);"Y";CHR$(32+F);CHR$(25+E1);
1490 PRINT CHR$(7);CHR$(27);"p";"         f      "
1500 PRINT CHR$(27);"Y";CHR$(33+F);CHR$(25+E1);
1510 PRINT CHR$(27);"p       ";CHR$(27);"q ";N1$;N2$;" ";CHR$(95);
1520 PRINT CHR$(27);"p    ";CHR$(27);"q"
1530 PRINT CHR$(27);"Y";CHR$(34+F);CHR$(25+E1);
1540 PRINT STRING$(15,32);CHR$(27);"pr"
1550 PRINT CHR$(27);"Y";CHR$(32+F);CHR$(25+E1);
1560 PRINT CHR$(7);CHR$(27);"q         ";CHR$(27);"pf";CHR$(27);"q      "
1570 PRINT CHR$(27);"Y";CHR$(33+F);CHR$(25+E1);
1580 PRINT "       ";CHR$(27);"p ";N1$;N2$;" ";CHR$(95);
1590 PRINT CHR$(27);"q    "
1600 PRINT CHR$(27);"Y";CHR$(34+F);CHR$(25+E1);CHR$(27);"p";
1610 PRINT STRING$(15,32);CHR$(27);"qr"
1620 NEXT I
1630 RETURN
1640 IF E1<8 THEN E1=8
1650 FOR I=1 TO 6
1660 PRINT CHR$(27);"Y";CHR$(32+F);CHR$(24+E1);
1670 PRINT CHR$(7);CHR$(27);"p      c         "
1680 PRINT CHR$(27);"Y";CHR$(33+F);CHR$(24+E1);
1690 PRINT "    ";CHR$(27);"qr ";N1$;N2$;" ";CHR$(27);"p       "
1700 PRINT CHR$(27);"Y";CHR$(34+F);CHR$(24+E1);
1710 PRINT CHR$(95);CHR$(27);"q";STRING$(15,32)
1720 PRINT CHR$(27);"Y";CHR$(32+F);CHR$(24+E1);
1730 PRINT CHR$(7);"      ";CHR$(27);"pc";CHR$(27);"q         "
1740 PRINT CHR$(27);"Y";CHR$(33+F);CHR$(24+E1);
1750 PRINT "    ";CHR$(27);"pr ";N1$;N2$;" ";CHR$(27);"q       "
1760 PRINT CHR$(27);"Y";CHR$(34+F);CHR$(24+E1);
1770 PRINT CHR$(95);CHR$(27);"p";STRING$(15,32)
1780 NEXT I
1790 PRINT CHR$(27);"q";
1800 RETURN
