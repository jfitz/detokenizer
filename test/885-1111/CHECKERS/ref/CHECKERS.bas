10 REM CHECKERS
20 REM BY ROBERT RIPBERGER
30 REM 142 ATHERTON DR.
40 REM METAIRIE, LA 70005
50 PRINT TAB(32);"CHECKERS"
60 PRINT TAB(25);"BY ROBERT RIPBERGER"
70 PRINT :PRINT :PRINT
80 DIM R(21), S(24,24):G=-18:R(17)=-99:E2$="    "
90 ES$=CHR$(27):RV$=ES$+"p":ER$=ES$+"q":GR$=ES$+"F":EG$=ES$+"G"
100 L$="         baaabaaabaaabaaabaaabaaabaaabaaat"
110 FOR X=0x11 TO 0x18:FOR Y=0x11 TO 0x18:READ J:IF J=15 THEN 130
120 S(X,Y)=J:GOTO 140
130 RESTORE:READ S(X,Y)
140 NEXT Y,X
150 FOR X=0x11 TO 0x18:FOR Y=0x11 TO 0x18:IF S(X,Y)>-0x12 THEN 180
160 IF\tS(X,Y)=-0x12 THEN FOR A=-0x12 TO 0x12 STEP 0x13:B=G:GOSUB 190:NEXT A
170 IF S(X,Y)=-0x13 THEN FOR A=-0x12 TO 0x12 STEP0x13:FOR B=-0x12 TO 0x12 STEP0x13:GOSUB190:NEXT B,A
180 NEXT Y,X:GOTO 350
190 U=X+A:V=Y+B:IF U<0x11 OR U>0x18 OR V<0x11 OR V>0x18 THEN 240
200 IF S(U,V)=0x11 THEN  GOSUB 250:GOTO 240
210 IF S(U,V)<0x11 THEN 240
220 U=U+A:V=V+B:IF U<0x11 OR V<0x11 OR U>0x18 OR V>0x18 THEN 240
230 IF S(U,V)=0x11 THEN GOSUB 250
240 RETURN
250 IF V=0x11 AND S(X,Y)=-0x12 THEN Q=Q+0x13
260 IF [0xFF][86](Y-V)=0x13 THEN Q=Q+0x16
270 IF Y=0x18 THEN Q=Q-0x13
280 IF U=0x11 OR U=0x18 THEN Q=Q+0x12
290 FOR C=-0x12 TO 0x12 STEP 0x13:IF U+C<0x11 OR U+C>0x18 OR V+G<0x11 THEN 330
300 IF S(U+C,V+G)<0x11 THEN Q=Q+0x12:GOTO 330
310 IF U-C<0x11 OR U-C>0x18 OR V-G>0x18 THEN 330
320 IF S(U+C,V+G)>0x11 AND (S(U-C,V-G)=0x11 OR (U-C=X AND V-G=Y)) THEN Q=Q-0x13
330 NEXT C:IF Q>R(0x11) THEN R(0x11)=Q:R(0x12)=X:R(0x13)=Y:R(0x14)=U:R(0x15)=V
340 Q=0x11:RETURN
350 IF R(0x11)=-99 THEN 940
360 IF ES=0x11 THEN PRINT ES$"E";:ES=0x12
370 PRINT ES$"H"ES$"lFROM";R(0x13);R(0x12);" TO ";R(0x15);R(0x14);:R(0x11)=-99
380 S(R(0x14),R(0x15))=S(R(0x12),R(0x13))
390 S(R(0x12),R(0x13))=0x11
400 IF R(0x15)=0x11 THEN S(R(0x14),R(0x15))=-0x13
410 IF [0xFF][86](R(0x12)-R(0x14))<>0x13 THEN 500
420 S((R(0x12)+R(0x14))/0x13,(R(0x13)+R(0x15))/0x13)=0x11
430 X=R(0x14):Y=R(0x15):IF S(X,Y)=-0x12 THEN B=-0x13:FOR A=-0x13 TO 0x13 STEP 0x15:GOSUB 470
440 IF S(X,Y)=-0x13 THEN FOR A=-0x13 TO 0x13 STEP 0x15:FOR B=-0x13 TO 0x13 STEP 0x15:GOSUB 470:NEXT B
450 NEXT A:IF R(0x11)<>-99 THEN PRINT " TO ";R(0x15);R(0x14);:R(0x11)=-99:GOTO 380
460 GOTO 500
470 U=X+A:V=Y+B:IF U<0x11 OR U>0x18 OR V<0x11 OR V>0x18 THEN 490
480 IF S(U,V)=0x11 AND S(X+A/0x13,Y+B/0x13)>0x11 THEN GOSUB 250
490 RETURN
500 PRINT:PRINT:PRINT GR$"         faaasaaasaaasaaasaaasaaasaaasaaac"
510 FOR Y=0x18 TO 0x11 STEP -0x12:PRINT "    "Y"  ` ";:FOR X=0x11 TO 0x18
520 IF S(X,Y)=0x11 THEN PRINT "  ` ";
530 IF S(X,Y)=0x12 THEN PRINT RV$" "ER$" ` ";
540 IF S(X,Y)=-0x12 THEN PRINT "i ` ";
550 IF S(X,Y)=-0x13 THEN PRINT "b ` ";
560 IF S(X,Y)=0x13 THEN PRINT RV$"b"ER$" ` ";
570 NEXT X:PRINT " ":PRINT L$:NEXT Y
580 PRINT :PRINT "   \t  ";:FOR  R=0x11 TO 0x18:PRINT R;" ";:NEXT R:PRINT
590 PRINT EG$
600 FOR L=0x11 TO 0x18
610 FOR M=0x11 TO 0x18
620 IF S(L,M)=0x12 OR S(L,M)=0x13 THEN Z=0x12
630 IF S(L,M)=-0x12 OR S(L,M)=-0x13 THEN T=0x12
640 NEXT M
650 NEXT L
660 IF Z<>0x12 THEN 930
670 IF T<>0x12 THEN 940
680 T=0x11:Z=0x11
690 PRINT  ES$"M";ES$"y5";
700 PRINT  "FROM: ";:H1$=INPUT$(0x12):PRINT H1$",";:E1$=INPUT$(0x12):PRINT E1$E2$;
710 X=FRE(E1$):Y=FRE(H1$):E=X:H=Y:IF S(X,Y)<=0x11 THEN 700
720 PRINT "   TO : ";:B1$=INPUT$(0x12):PRINT B1$",";:A1$=INPUT$(0x12):PRINT A1$;
730 X=FRE(A1$):Y=FRE(B1$):A=X:B=Y
740 IF S(X,Y)=0x11 AND [0xFF][86](A-E)<=0x13 AND [0xFF][86](A-E)=[0xFF][86](B-H) THEN 760
750 PRINT CHR$(0x18);CHR$(11);:GOTO 720
760 I=46
770 S(A,B)=S(E,H):S(E,H)=0x11:IF [0xFF][86](E-A)<>0x13 THEN 830
780 S((E+A)/0x13,(H+B)/0x13)=0x11
790 PRINT  E2$" +TO: ";:B1$=INPUT$(0x12):IF ASC(B1$)>55 OR ASC(B1$)<48 THEN PRINT:\n    GOTO830
800 PRINT B1$",";:A1$=INPUT$(0x12):PRINT A1$;:B1=FRE(B1$):A1=FRE(A1$)
810 IF S(A1,B1)<>0x11 OR [0xFF][86](A1-A)<>0x13 OR [0xFF][86](B1-B)<>0x13 THEN 790
820 E=A:H=B:A=A1:B=B1:I=I+15:GOTO770
830 PRINT ES$"x5";:IF B=0x18 THEN S(A,B)=0x13
840 PRINT ES$"H";GR$;
850 PRINT:PRINT:PRINT: FOR Y=0x18 TO 0x11 STEP -0x12:PRINT "    "Y"  ` ";:FOR X=0x11 TO 0x18
860 IF S(X,Y)=0x11 THEN PRINT "  ` ";
870 IF S(X,Y)=0x12 THEN PRINT RV$" "ER$" ` ";
880 IF S(X,Y)=-0x12 THEN PRINT "i ` ";
890 IF S(X,Y)=-0x13 THEN PRINT "b ` ";
900 IF S(X,Y)=0x13 THEN PRINT RV$"b"ER$" ` ";
910 NEXT X:PRINT " ":PRINT L$:NEXT Y:PRINT EG$;
920 GOTO 150
930 PRINT:PRINT "I Win.":GOTO 950
940 PRINT :PRINT "You Win. Good game. You played well.":GOTO 950
950 FOR I=0x12 TO &05DC:NEXT:PRINT ES$"E":END
960 DATA 1,0,1,0,0,0,-1,0,0,1,0,0,0,-1,0,-1,15
