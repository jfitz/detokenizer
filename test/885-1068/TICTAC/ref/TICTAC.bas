10 :REMARK \t\tTICTAC.BAS \n\t\tBy: Daniel Schlichtig \n\t\t    18832 W. Cabral Street \n\t\t    Canyon Country, California 91351
20 :REMARK \t\tAdapted to MBASIC by HUG 5/5/80
30 CLEAR 1000:DIM A(9),B(9):WIDTH 255
40 E$=CHR$(27):E1$=E$+"E":F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
50 X5$=E$+"x5":Y5$=E$+"y5":J$=E$+"J":K$=E$+"K"
60 PRINT E1$X5$:GOSUB 730
70 PRINT Y$"!+THIS IS A TIC-TAC-TOE GAME FOR TWO PLAYERS, X AND O."
80 PRINTY$"$+PLAYER X GETS THE FIRST CHOICE.  IT IS UP TO THE"
90 PRINT Y$"&+INDIVIDUALS TO  DECIDE  WHICH ONE WILL BE MR. X."
100 PRINT Y$"(5Press RETURN or ENTER to continue":A$=INPUT$(1)
110 PRINT E1$F$P$Y$"&Afaaasaaasaaac"
120 PRINT Y$"'A` 7 ` 8 ` 9 `"
130 PRINT Y$"(Avaaabaaabaaat"
140 PRINT Y$")A` 4 ` 5 ` 6 `"
150 PRINT Y$"*Avaaabaaabaaat"
160 PRINT Y$"+A` 1 ` 2 ` 3 `"
170 PRINT Y$",Aeaaauaaauaaad"G$Q$
180 IF H=1 THEN 230
190 PRINT Y$"/)Spaces are numbered to correspond to the layout of the"
200 PRINT Y$"1)number keypad.  Select the square you want by pressing"
210 PRINT Y$"3)the corresponding number key and the ENTER key."
220 PRINT Y$"53Press RETURN or ENTER to continue":A$=INPUT$(1)
230 H=1:PRINT Y$"/ "J$
240 IF F=0 THEN X$="X":GOTO 260
250 X$="O"
260 PRINT Y$"3+"K$"CHOOSE A SQUARE MR. "X$"  "Y5$;:S=VAL(INPUT$(1)):PRINT X5$;
270 IF A(S)=S THEN 710
280 A(S)=S
290 B(S)=F
300 T=T+1
310 IF F=0 THEN M$="w":GOTO 330
320 M$="^"
330 IF B(5)<>15 THEN 490
340 IF B(7)<>17 THEN 570
350 IF B(3)<>13 THEN 610
360 PRINT F$P$Y$;
370 IF S=1 THEN PRINT "+C";
380 IF S=2 THEN PRINT "+G";
390 IF S=3 THEN PRINT "+K";
400 IF S=4 THEN PRINT ")C";
410 IF S=5 THEN PRINT ")G";
420 IF S=6 THEN PRINT ")K";
430 IF S=7 THEN PRINT "'C";
440 IF S=8 THEN PRINT "'G";
450 IF S=9 THEN PRINT "'K";
460 PRINT M$Q$G$:IF T=9 THEN 660
470 IF F=0 THEN F=1:GOTO 240
480 F=0:GOTO 240
490 IF B(5)<>B(7) THEN 510
500 IF B(5)=B(3) THEN 740
510 IF B(5)<>B(9) THEN 530
520 IF B(5)=B(1) THEN 750
530 IF B(5)<>B(8) THEN 550
540 IF B(5)=B(2) THEN 760
550 IF B(5)<>B(4) THEN 340
560 IF B(5)=B(6) THEN 770
570 IF B(4)<>B(7) THEN 590
580 IF B(4)=B(1) THEN 780
590 IF B(8)<>B(9) THEN 350
600 IF B(8)=B(7) THEN 790
610 IF B(6)<>B(9) THEN 630
620 IF B(6)=B(3) THEN 800
630 IF B(2)<>B(1) THEN 650
640 IF B(2)=B(3) THEN 810
650 PRINT :GOTO 360
660 PRINT "  GAME OVER - DRAW  "
670 FOR I=1 TO 1000:NEXT I
680 PRINT Y$"5/PLAY IT AGAIN? <Y> "Y5$;:A$=INPUT$(1):PRINT X5$;
690 IF A$="N" OR A$="n" THEN PRINT E$"z":END
700 GOSUB 730:GOTO 110
710 PRINT Y$"3+"K$"SQUARE OCCUPIED - \aCHOOSE AGAIN "X$"  ";
720 S=VAL(INPUT$(1)):GOTO 270
730 FOR X=1 TO 9:A(X)=0:B(X)=X+10:NEXT X:F=0:T=0:RETURN
740 PRINT F$Y$"'C"M$Y$")G"M$Y$"+K"M$:GOTO 820
750 PRINT F$Y$"+C"M$Y$")G"M$Y$"'K"M$:GOTO 820
760 PRINT F$Y$"+G"M$Y$")G"M$Y$"'G"M$:GOTO 820
770 PRINT F$Y$")C"M$Y$")G"M$Y$")K"M$:GOTO 820
780 PRINT F$Y$"+C"M$Y$")C"M$Y$"'C"M$:GOTO 820
790 PRINT F$Y$"'C"M$Y$"'G"M$Y$"'K"M$:GOTO 820
800 PRINT F$Y$"+K"M$Y$")K"M$Y$"'K"M$:GOTO 820
810 PRINT F$Y$"+C"M$Y$"+G"M$Y$"+K"M$
820 PRINT P$Y$"3+MR. "M$" IS THE WINNER!!     "G$Q$:GOTO 680
