10 :REM \t\tCOMPUTER DORNBACK\t\tMay, 1980
20 CLEAR 2000:WIDTH 255
30 E$=CHR$(27):E1$=E$+"E":F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
40 K$=E$+"K":X5$=E$+"x5":Y5$=E$+"y5":E25$=E$+"x1"+P$+Y$+"8&"
50 C$="     ":C1$=X5$+Y$+"3L"+K$+Y$+"4L"+K$+Y$+"5L"+K$+Y$+"6L"+K$
60 Q1$=CHR$(34):F1$="?"+F$+" aa"+G$:O$=P$+F$:N$=Q$+G$
70 A1$(1)=O$+"     "+N$:A2$(1)=O$+"  ^  "+N$:A3$(1)=O$+"     "+N$
80 A1$(2)=O$+"    ^"+N$:A2$(2)=O$+"     "+N$:A3$(2)=O$+"^    "+N$
90 A1$(3)=O$+"    ^"+N$:A2$(3)=O$+"  ^  "+N$:A3$(3)=O$+"^    "+N$
100 A1$(4)=O$+"^   ^"+N$:A2$(4)=O$+"     "+N$:A3$(4)=O$+"^   ^"+N$
110 A1$(5)=O$+"^   ^"+N$:A2$(5)=O$+"  ^  "+N$:A3$(5)=O$+"^   ^"+N$
120 A1$(6)=O$+"^   ^"+N$:A2$(6)=O$+"^   ^"+N$:A3$(6)=O$+"^   ^"+N$
130 PRINT E1$Y$" 9Computer Dornback A Game of Dice"
140 PRINT Y$"#0This program uses the FUNCTION keys across the top"
150 PRINT Y$"$0of the  H89/H19  keyboard.   Each of the NINE keys"
160 PRINT Y$"%0has its own function.
170 PRINT Y$"&7f1 = Throw Dice #1
180 PRINT Y$"'7f2 = Throw Dice #2"
190 PRINT Y$"(7f3 = Throw Dice #3"
200 PRINT Y$")7f4 = Throw Dice #4"
210 PRINT Y$"*7f5 = Throw Dice #5)"
220 PRINT Y$"+4ERASE = Throw ALL Dice (ALL)"
230 PRINT Y$",5BLUE = Throw NO Dice (NONE)"
240 PRINT Y$"-6RED = No More Dice To Be Thrown (DONE)"
250 PRINT Y$".5GRAY = Restore Dice To Before Pickup (RESTORE)"
260 PRINT Y$"00When asked for a  location to place your score type"
270 PRINT Y$"10the  TWO  digit  code for the  location you wish to"
280 PRINT Y$"20place your score.  (Example: ONES goto `A1').   Hit"
290 PRINT Y$"30RETURN after selecting the position."
300 PRINT Y$"50Hit the RETURN key to start the game.";:A$=INPUT$(1):PRINT E1$
310 :REM \t\tRoutine to determine the name of each player
320 PRINTY$"##Using FIRST Names ONLY,"
330 INPUT "Enter the name of the first player ";N1$
340 INPUT "Enter the name of the second player ";N2$
350 GOSUB 700:IF R1=R2 THEN 350
360 IF R2>R1 THEN P=2:N3$=N2$:N4$=N1$
370 IF R2<R1 THEN P=1:N3$=N1$:N4$=N2$
380 PRINT E1$Y$"++I have decided that you will goto first "N3$
390 PRINT Y$".1and you will go second "N4$"."
400 PRINT Y$"2+I am ready to start the game.  Are both of you ready?"
410 PRINT Y$"4+If so, press the  'RETURN' key.";:A$=INPUT$(1)
420 PRINT E1$X5$;:GOSUB 2270:GOTO 1300
430 IF A1=99 THEN PRINT Y$"!"F1$:GOTO 450
440 PRINT Y$"!?"A1
450 IF A2=99 THEN PRINT Y$Q1$F1$:GOTO 470
460 PRINT Y$Q1$"?"A2
470 IF A3=99 THEN PRINT Y$"#"F1$:GOTO 490
480 PRINT Y$"#?"A3
490 IF A4=99 THEN PRINT Y$"$"F1$:GOTO 510
500 PRINT Y$"$?"A4
510 IF A5=99 THEN PRINT Y$"%"F1$:GOTO 530
520 PRINT Y$"%?"A5
530 IF A6=99 THEN PRINT Y$"&"F1$:GOTO 550
540 PRINT Y$"&?"A6
550 PRINT Y$"(?"A7;Y$")?"A8;Y$"*?";(A7+A8):IF B1=99 THEN PRINT Y$","F1$:GOTO 570
560 PRINT Y$",?"B1
570 IF B2=99 THEN PRINT Y$"-"F1$:GOTO 590
580 PRINT Y$"-?"B2
590 IF B3=99 THEN PRINT Y$"."F1$:GOTO 610
600 PRINT Y$".?"B3
610 IF B4=99 THEN PRINT Y$"/"F1$:GOTO 630
620 PRINT Y$"/?"B4
630 IF B5=99 THEN PRINT Y$"0"F1$:GOTO 650
640 PRINT Y$"0?"B5
650 IF B6=99 THEN PRINT Y$"1"F1$:GOTO 670
660 PRINT Y$"1?"B6
670 IF B7=99 THEN PRINT Y$"2"F1$:GOTO 690
680 PRINT Y$"2?"B7
690 PRINT Y$"4?"G1;Y$"5?"G2;Y$"6?"G3:RETURN
700 GOSUB 720:R1=R:GOSUB 720:R2=R:GOSUB 720:R3=R:GOSUB 720:R4=R
710 GOSUB 720:R5=R:RETURN
720 R=RND(1):R=100*R:R=R/10:R=INT(R):IF R=0 OR R>6 THEN 720 :ELSE RETURN
730 :REM \t\tRoutine to show dice
740 IF P=2 THEN PRINT Y$"2VRoll #"T"for "N2$:GOTO 760
750 PRINT Y$"2VRoll #"T"for "N1$
760 PRINT Y$" L"A1$(R1)Y$"!L"A2$(R1)"  #1"Y$CHR$(34)"L"A3$(R1)
770 PRINT Y$"$L"A1$(R2)Y$"%L"A2$(R2)"  #2"Y$"&L"A3$(R2)
780 PRINT Y$"(L"A1$(R3)Y$")L"A2$(R3)"  #3"Y$"*L"A3$(R3)
790 PRINT Y$",L"A1$(R4)Y$"-L"A2$(R4)"  #4"Y$".L"A3$(R4)
800 PRINT Y$"0L"A1$(R5)Y$"1L"A2$(R5)"  #5"Y$"2L"A3$(R5)C1$:RETURN
810 :REM \t\tRoutine to check if scratch is to be posted
820 PRINTC1$Y$"4LWhat score would you like"Y$"5Lme to scratch? "Y5$;:LINE INPUT X1$
830 IF LEFT$(X1$,1)="a" THEN X1$="A"+RIGHT$(X1$,1)
840 IF LEFT$(X1$,1)="b" THEN X1$="B"+RIGHT$(X1$,1)
850 IF X1$="A1" AND A1=0 THEN A1=99:GOSUB 2020:GOTO 1300
860 IF X1$="A2" AND A2=0 THEN A2=99:GOSUB 2020:GOTO 1300
870 IF X1$="A3" AND A3=0 THEN A3=99:GOSUB 2020:GOTO 1300
880 IF X1$="A4" AND A4=0 THEN A4=99:GOSUB 2020:GOTO 1300
890 IF X1$="A5" AND A5=0 THEN A5=99:GOSUB 2020:GOTO 1300
900 IF X1$="A6" AND A6=0 THEN A6=99:GOSUB 2020:GOTO 1300
910 IF X1$="B1" AND B1=0 THEN B1=99:GOSUB 2020:GOTO 1300
920 IF X1$="B2" AND B2=0 THEN B2=99:GOSUB 2020:GOTO 1300
930 IF X1$="B3" AND B3=0 THEN B3=99:GOSUB 2020:GOTO 1300
940 IF X1$="B4" AND B4=0 THEN B4=99:GOSUB 2020:GOTO 1300
950 IF X1$="B5" AND B5=0 THEN B5=99:GOSUB 2020:GOTO 1300
960 IF X1$="B6" AND B6=0 THEN B6=99:GOSUB 2020:GOTO 1300
970 IF X1$="B7" AND B7=0 THEN B7=99:GOSUB 2020:GOTO 1300
980 PRINT Y$"3L-10-10-10-10TRY AGAIN--? ":GOTO 820
990 :REM \t\tRoutine to select dice to be thrown again
1000 GOSUB 430:S1$="Y":S2$="Y":S3$="Y":S4$="Y":S5$="Y"
1010 PRINT E25$" #1     #2     #3     #4     #5    All   None  Done Restore ";
1020 PRINT Q$Y$"  "
1030 S1=R1:S2=R2:S3=R3:S4=R4:S5=R5:IF S$="R" THEN GOSUB 760
1040 PRINT Y$"7&Select all dice to be thrown again "Y5$;:S$=INPUT$(1)
1050 IF S$<>CHR$(27) THEN 1040
1060 S$=INPUT$(1)
1070 PRINT Y$"7 "K$X5$;:IF S$="S"THEN S1=0:PRINT Y$" L"C$Y$"!L"C$Y$Q1$"L"C$
1080 IF S$="T" THEN S2=0:PRINT Y$"$L"C$Y$"%L"C$Y$"&L"C$
1090 IF S$="U" THEN S3=0:PRINT Y$"(L"C$Y$")L"C$Y$"*L"C$
1100 IF S$="V" THEN S4=0:PRINTY$",L"C$Y$"-L"C$Y$".L"C$
1110 IF S$="W" THEN S5=0:PRINT Y$"0L"C$Y$"1L"C$Y$"2L"C$
1120 IF S$="P" THEN S1=R1:S2=R2:S3=R3:S4=R4:S5=R5:GOTO 1360
1130 IF S$="J" THEN X3$="N"\n\t:GOSUB 700:GOSUB 740:S1=R1:S2=R2:S3=R3:S4=R4:S5=R5:RETURN
1140 IF S$="Q" THEN X3$="N":RETURN
1150 IF S$="R" THEN 1030
1160 GOTO 1040
1170 :REM \t\tROUTINE TO RESTORE SAVED DICE
1180 IF S1=0 THEN 1200
1190 R1=S1
1200 IF S2=0 THEN 1220
1210 R2=S2
1220 IF S3=0 THEN 1240
1230 R3=S3
1240 IF S4=0 THEN 1260
1250 R4=S4
1260 IF S5=0 THEN 1280
1270 R5=S5
1280 S1=0:S2=0:S3=0:S4=0:S5=0:RETURN
1290 :REM \t\tMainline routine after startup
1300 T=1:E=E+1:IF E=27 THEN 2180
1310 IF E=27 THEN 2180
1320 GOSUB 700:GOSUB 740:GOSUB 990
1330 IF X3$="S" OR X3$="s" THEN 1360
1340 T=T+1:GOSUB 700:GOSUB 1180:GOSUB 740:GOSUB 990
1350 T=T+1:GOSUB 700:GOSUB 1180
1360 GOSUB 760
1370 PRINT Y$"2V"K$Y$"3LYour FINAL Dice ";:IF P=1 THEN PRINT N1$ :ELSE PRINT N2$
1380 PRINT Y$"4LWhere should I place your score?"Y$"5L(Type S to Scratch) "Y5$;
1390 LINE INPUT X1$:PRINT X5$:IF X1$="S" OR X1$="s" THEN 820
1400 IF LEFT$(X1$,1)="A" OR LEFT$(X1$,1)="a" THEN X1$=RIGHT$(X1$,1):GOTO 1430
1410 IF LEFT$(X1$,1)="B" OR LEFT$(X1$,1)="b" THEN X1$=RIGHT$(X1$,1):GOTO 1570
1420 PRINTY$"4L"K$"Can't do-10!"Y$"5L"K$"Try Another ! "Y5$;:GOTO 1390
1430 IF X1$="1" AND A1=0 THEN U=1:GOSUB 1500:A1=V:A7=A7+A1:GOTO 1960
1440 IF X1$="2" AND A2=0 THEN U=2:GOSUB 1500:A2=V:A7=A7+A2:GOTO 1960
1450 IF X1$="3" AND A3=0 THEN U=3:GOSUB 1500:A3=V:A7=A7+A3:GOTO 1960
1460 IF X1$="4" AND A4=0 THEN U=4:GOSUB 1500:A4=V:A7=A7+A4:GOTO 1960
1470 IF X1$="5" AND A5=0 THEN U=5:GOSUB 1500:A5=V:A7=A7+A5:GOTO 1960
1480 IF X1$="6" AND A6=0 THEN U=6:GOSUB 1500:A6=V:A7=A7+A6:GOTO 1960
1490 GOTO 1420
1500 IF R1=U THEN V=U
1510 IF R2=U THEN V=V+U
1520 IF R3=U THEN V=V+U
1530 IF R4=U THEN V=V+U
1540 IF R5=U THEN V=V+U
1550 IF V=0 THEN 1420 :ELSE RETURN
1560 :REM \t\tStart of the B's
1570 IF X1$="1" OR X1$="2" OR X1$="3" OR X1$="6" THEN 1620
1580 IF X1$="7" AND B7=0 THEN B7=R1+R2+R3+R4+R5:G1=G1+B7:GOTO 1960
1590 IF X1$="4" AND B4=0 THEN 1780
1600 IF X1$="5" AND B5=0 THEN 1780
1610 GOTO 1420
1620 R(1)=R1:R(2)=R2:R(3)=R3:R(4)=R4:R(5)=R5
1630 FOR U=1 TO 6:FOR I=1 TO 5
1640 IF R(I)=U THEN X=X+1
1650 IF X=5 AND B3=0 AND X1$="3" THEN B3=25:G1=G1+25:GOTO 1960
1660 NEXT I
1670 IF X=5 AND B6=0 AND X1$="6" THEN B6=50:G1=G1+50:GOTO 1960
1680 IF X>=4 AND B2=0 AND X1$="2" THEN B2=R1+R2+R3+R4+R5:G1=G1+B2:GOTO 1960
1690 IF X>=3 AND B1=0 AND X1$="1" THEN B1=R1+R2+R3+R4+R5:G1=G1+B1:GOTO 1960
1700 IF X=3 AND B3=0 AND X1$="3" THEN U1=U:X=0:GOTO 1720
1710 X=0:NEXT U
1720 FOR U=1 TO 6:IF U=U1 THEN NEXT U
1730 FOR I=1 TO 5:IF R(I)=U THEN X=X+1
1740 NEXT I:NEXT U
1750 IF X=2 AND U<>0 THEN B3=25:G1=G1+25:X=0:U=0:U1=0:GOTO 1960
1760 GOTO 1940
1770 :REM \t\tCheck for straights
1780 R(1)=R1:R(2)=R2:R(3)=R3:R(4)=R4:R(5)=R5
1790 FOR I=1 TO 5
1800 IF R(I)=1 THEN T1=1
1810 IF R(I)=2 THEN T2=1
1820 IF R(I)=3 THEN T3=1
1830 IF R(I)=4 THEN T4=1
1840 IF R(I)=5 THEN T5=1
1850 IF R(I)=6 THEN T6=1
1860 NEXT I
1870 IF T3=0 OR T4=0 THEN 1940
1880 IF X1$="4" AND T1=1 AND T2=1 THEN B4=30:G1=G1+30:GOTO 1960
1890 IF X1$="4" AND T2=1 AND T5=1 THEN B4=30:G1=G1+30:GOTO 1960
1900 IF X1$="4" AND T5=1 AND T6=1 THEN B4=30:G1=G1+30:GOTO 1960
1910 IF T2=0 OR T5=0 THEN 1940
1920 IF X1$="5" AND T1=1 THEN B5=40:G1=G1+40:GOTO 1960
1930 IF X1$="5" AND T6=1 THEN B5=40:G1=G1+40:GOTO 1960
1940 T1=0:T2=0:T3=0:T4=0:T5=0:T6=0:I=0:X=0:V=0:U1=0:U=0:
1950 V=0:GOTO 1410
1960 GOSUB 2000:IF A7>=63 THEN G2=A7+35:A8=35:A9=G2
1970 G2=A7
1980 G3=G1+G2
1990 GOSUB 2020:GOTO 1300
2000 T1=0:T2=0:T3=0:T4=0:T5=0:T6=0:I=0:X=0:V=0:U=0:U1=0:RETURN
2010 :REM \t\tRoutine to show results after posting score
2020 GOSUB 430:T=1:IF P<>1 THEN 2110
2030 PRINT C1$Y$"4LI have posted your score"
2040 :REM \t\tSAVE PLAYER 1 SCORES
2050 H1=A1:H2=A2:H3=A3:H4=A4:H5=A5:H6=A6:H7=A7:H8=A8:H9=A9
2060 I1=B1:I2=B2:I3=B3:I4=B4:I5=B5:I6=B6:I7=B7:J1=G1:J2=G2:J3=G3
2070 P=2:A1=K1:A2=K2:A3=K3:A4=K4:A5=K5:A6=K6:A7=K7:A8=K8:A9=K9
2080 B1=L1:B2=L2:B3=L3:B4=L4:B5=L5:B6=L6:B7=L7:G1=M1:G2=M2:G3=M3
2090 PRINT Y$"6LPress any key to continue"Y5$;:A$=INPUT$(1):PRINT C1$:RETURN
2100 :REM \t\tROUTINE FOR PLAYER 2
2110 PRINT C1$Y$"5LI have posted your score"
2120 :REM \t\tSAVE PLAYER 2 SCORES
2130 K1=A1:K2=A2:K3=A3:K4=A4:K5=A5:K6=A6:K7=A7:K8=A8:K9=A9
2140 L1=B1:L2=B2:L3=B3:L4=B4:L5=B5:L6=B6:L7=B7:M1=G1:M2=G2:M3=G3:P=1
2150 :REM \t\tRESTORE PLAYER 1 SCORES
2160 A1=H1:A2=H2:A3=H3:A4=H4:A5=H5:A6=H6:A7=H7:A8=H8:A9=H9
2170 B1=I1:B2=I2:B3=I3:B4=I4:B5=I5:B6=I6:B7=I7:G1=J1:G2=J2:G3=J3:GOTO 2090
2180 PRINTY$"+V"K$"Your final score "N1$Y$",V"K$"is "J3
2190 PRINT Y$"/V"K$"Your Final Score "N2$Y$"0V"K$"is "M3
2200 IF M3=J3 THEN PRINT Y$"3L"K$"Tie Game! Hard to believe, but true":GOTO 2240
2210 IF M3>J3 THEN PRINT Y$"3L"K$"CONGRATULATIONS "N2$:GOTO 2230
2220 PRINT Y$"3L"K$"CONGRATULATIONS "N1$
2230 PRINT Y$"4LYou played a great game!"
2240 PRINT Y$"5LDo you want to start"Y$"6La new game? <Y> "Y5$;:X4$=INPUT$(1)
2250 IF X4$="N" OR X4$="n" THEN PRINT E$"z":FOR I=1 TO 300:NEXT I:END
2260 CLEAR :GOTO 10
2270 PRINT Y$" %Dornback Dice Game"
2280 PRINT Y$"! Aces     (Count Aces ONLY)--A1="
2290 PRINT Y$Q1$" Twos     (Count Twos ONLY)--A2="
2300 PRINT Y$"# Threes (Count Threes ONLY)--A3="
2310 PRINT Y$"$ Fours   (Count Fours ONLY)--A4="
2320 PRINT Y$"% Fives   (Count Fives ONLY)--A5="
2330 PRINT Y$"& Sixes   (Count Sixes ONLY)--A6="
2340 PRINT Y$"'>"F$"aaaaaaa"G$Y$"(4Sub Total ="
2350 PRINT Y$") Add 35 if total >= 63   Bonus ="
2360 PRINT Y$"**Upper section Total ="
2370 PRINT Y$"+ "F$STRING$(37,"a")G$
2380 PRINT Y$", 3 of a kind (Add all dice)--B1="
2390 PRINT Y$"- 4 of a kind (Add all dice)--B2="
2400 PRINT Y$". Full House      (Score 25)--B3="
2410 PRINT Y$"/ Sm Strght-4 is series (30)--B4="
2420 PRINT Y$"0 Lg Strght-5 is series (40)--B5="
2430 PRINT Y$"1 DORNBACK-5 of kind    (50)--B6="
2440 PRINT Y$"2 Chance   (Total of 5 dice)--B7="
2450 PRINT Y$"3>"F$"aaaaaaa"G$
2460 PRINT Y$"4(Total of lower section="
2470 PRINT Y$"5(Total of upper section="Y$"63GRAND TOTAL=":RETURN
