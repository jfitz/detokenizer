10 REM CHECKERS
20 REM BY ROBERT RIPBERGER
30 REM 142 ATHERTON DR.
40 REM METAIRIE, LA 70005
50 PRINT TAB(32);"CHECKERS"
60 PRINT TAB(25);"BY ROBERT RIPBERGER"
70 PRINT :PRINT :PRINT
80 DIM R(4), S(7,7):G=-1:R(0)=-99:E2$="    "
90 ES$=CHR$(27):RV$=ES$+"p":ER$=ES$+"q":GR$=ES$+"F":EG$=ES$+"G"
100 L$="         baaabaaabaaabaaabaaabaaabaaabaaat"
110 FOR X=0 TO 7:FOR Y=0 TO 7:READ J:IF J=15 THEN 130
120 S(X,Y)=J:GOTO 140
130 RESTORE:READ S(X,Y)
140 NEXT Y,X
150 FOR X=0 TO 7:FOR Y=0 TO 7:IF S(X,Y)>-1 THEN 180
160 IF\tS(X,Y)=-1 THEN FOR A=-1 TO 1 STEP 2:B=G:GOSUB 190:NEXT A
170 IF S(X,Y)=-2 THEN FOR A=-1 TO 1 STEP2:FOR B=-1 TO 1 STEP2:GOSUB190:NEXT B,A
180 NEXT Y,X:GOTO 350
190 U=X+A:V=Y+B:IF U<0 OR U>7 OR V<0 OR V>7 THEN 240
200 IF S(U,V)=0 THEN  GOSUB 250:GOTO 240
210 IF S(U,V)<0 THEN 240
220 U=U+A:V=V+B:IF U<0 OR V<0 OR U>7 OR V>7 THEN 240
230 IF S(U,V)=0 THEN GOSUB 250
240 RETURN
250 IF V=0 AND S(X,Y)=-1 THEN Q=Q+2
260 IF ABS(Y-V)=2 THEN Q=Q+5
270 IF Y=7 THEN Q=Q-2
280 IF U=0 OR U=7 THEN Q=Q+1
290 FOR C=-1 TO 1 STEP 2:IF U+C<0 OR U+C>7 OR V+G<0 THEN 330
300 IF S(U+C,V+G)<0 THEN Q=Q+1:GOTO 330
310 IF U-C<0 OR U-C>7 OR V-G>7 THEN 330
320 IF S(U+C,V+G)>0 AND (S(U-C,V-G)=0 OR (U-C=X AND V-G=Y)) THEN Q=Q-2
330 NEXT C:IF Q>R(0) THEN R(0)=Q:R(1)=X:R(2)=Y:R(3)=U:R(4)=V
340 Q=0:RETURN
350 IF R(0)=-99 THEN 940
360 IF ES=0 THEN PRINT ES$"E";:ES=1
370 PRINT ES$"H"ES$"lFROM";R(2);R(1);" TO ";R(4);R(3);:R(0)=-99
380 S(R(3),R(4))=S(R(1),R(2))
390 S(R(1),R(2))=0
400 IF R(4)=0 THEN S(R(3),R(4))=-2
410 IF ABS(R(1)-R(3))<>2 THEN 500
420 S((R(1)+R(3))/2,(R(2)+R(4))/2)=0
430 X=R(3):Y=R(4):IF S(X,Y)=-1 THEN B=-2:FOR A=-2 TO 2 STEP 4:GOSUB 470
440 IF S(X,Y)=-2 THEN FOR A=-2 TO 2 STEP 4:FOR B=-2 TO 2 STEP 4:GOSUB 470:NEXT B
450 NEXT A:IF R(0)<>-99 THEN PRINT " TO ";R(4);R(3);:R(0)=-99:GOTO 380
460 GOTO 500
470 U=X+A:V=Y+B:IF U<0 OR U>7 OR V<0 OR V>7 THEN 490
480 IF S(U,V)=0 AND S(X+A/2,Y+B/2)>0 THEN GOSUB 250
490 RETURN
500 PRINT:PRINT:PRINT GR$"         faaasaaasaaasaaasaaasaaasaaasaaac"
510 FOR Y=7 TO 0 STEP -1:PRINT "    "Y"  ` ";:FOR X=0 TO 7
520 IF S(X,Y)=0 THEN PRINT "  ` ";
530 IF S(X,Y)=1 THEN PRINT RV$" "ER$" ` ";
540 IF S(X,Y)=-1 THEN PRINT "i ` ";
550 IF S(X,Y)=-2 THEN PRINT "b ` ";
560 IF S(X,Y)=2 THEN PRINT RV$"b"ER$" ` ";
570 NEXT X:PRINT " ":PRINT L$:NEXT Y
580 PRINT :PRINT "   \t  ";:FOR  R=0 TO 7:PRINT R;" ";:NEXT R:PRINT
590 PRINT EG$
600 FOR L=0 TO 7
610 FOR M=0 TO 7
620 IF S(L,M)=1 OR S(L,M)=2 THEN Z=1
630 IF S(L,M)=-1 OR S(L,M)=-2 THEN T=1
640 NEXT M
650 NEXT L
660 IF Z<>1 THEN 930
670 IF T<>1 THEN 940
680 T=0:Z=0
690 PRINT  ES$"M";ES$"y5";
700 PRINT  "FROM: ";:H1$=INPUT$(1):PRINT H1$",";:E1$=INPUT$(1):PRINT E1$E2$;
710 X=VAL(E1$):Y=VAL(H1$):E=X:H=Y:IF S(X,Y)<=0 THEN 700
720 PRINT "   TO : ";:B1$=INPUT$(1):PRINT B1$",";:A1$=INPUT$(1):PRINT A1$;
730 X=VAL(A1$):Y=VAL(B1$):A=X:B=Y
740 IF S(X,Y)=0 AND ABS(A-E)<=2 AND ABS(A-E)=ABS(B-H) THEN 760
750 PRINT CHR$(7);CHR$(11);:GOTO 720
760 I=46
770 S(A,B)=S(E,H):S(E,H)=0:IF ABS(E-A)<>2 THEN 830
780 S((E+A)/2,(H+B)/2)=0
790 PRINT  E2$" +TO: ";:B1$=INPUT$(1):IF ASC(B1$)>55 OR ASC(B1$)<48 THEN PRINT:\n    GOTO830
800 PRINT B1$",";:A1$=INPUT$(1):PRINT A1$;:B1=VAL(B1$):A1=VAL(A1$)
810 IF S(A1,B1)<>0 OR ABS(A1-A)<>2 OR ABS(B1-B)<>2 THEN 790
820 E=A:H=B:A=A1:B=B1:I=I+15:GOTO770
830 PRINT ES$"x5";:IF B=7 THEN S(A,B)=2
840 PRINT ES$"H";GR$;
850 PRINT:PRINT:PRINT: FOR Y=7 TO 0 STEP -1:PRINT "    "Y"  ` ";:FOR X=0 TO 7
860 IF S(X,Y)=0 THEN PRINT "  ` ";
870 IF S(X,Y)=1 THEN PRINT RV$" "ER$" ` ";
880 IF S(X,Y)=-1 THEN PRINT "i ` ";
890 IF S(X,Y)=-2 THEN PRINT "b ` ";
900 IF S(X,Y)=2 THEN PRINT RV$"b"ER$" ` ";
910 NEXT X:PRINT " ":PRINT L$:NEXT Y:PRINT EG$;
920 GOTO 150
930 PRINT:PRINT "I Win.":GOTO 950
940 PRINT :PRINT "You Win. Good game. You played well.":GOTO 950
950 FOR I=1 TO 1500:NEXT:PRINT ES$"E":END
960 DATA 1,0,1,0,0,0,-1,0,0,1,0,0,0,-1,0,-1,15
