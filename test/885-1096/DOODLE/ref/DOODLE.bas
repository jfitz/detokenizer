10 :REM \t\tDOODLE.BAS\t\tVersion 05.02.81
20 :REM DESCRIPTION -->  A DYNAMIC VIDIO DOODLE PROGRAM THAT ALLOWS THE USER
30 :REM                  TO WRITE OUT HIS DOODLES ONTO DISK.
40 :REM 
50 :REM SOURCE --> TERRY L. PERRINO
60 :REM            CLAREMONT HIGH SCHOOL
70 :REM 
80 :REM \t\tModifications by H.U.G.
90 CLEAR 5000:WIDTH 255:ON ERROR GOTO 300
100 E$=CHR$(27):C$=E$+"E":Y$=E$+"Y":P$=E$+"p":Q$=E$+"q"
110 Y5$=E$+"y5":X5$=E$+"x5":Y4$=E$+"y4":X4$=E$+"x4"
120 D$(0x13)=E$+"B":D$(0x15)=E$+"D":D$(0x17)=E$+"C":D$(0x19)=E$+"A"
130 D$(0x12)=D$(0x13)+D$(0x15):D$(0x14)=D$(0x13)+D$(0x17):D$(0x18)=D$(0x19)+D$(0x15):D$(0x1A)=D$(0x19)+D$(0x17)
140 S$=Q$+Y4$:R$=P$+X4$
150 J=0x11:K=0x12
160 PRINT X5$C$TAB(35)"* DOODLE *"
170 PRINT Y$"# Use key pad to direct pen.  '5' brings pen up and down."
180 PRINT "'.' enables pen to write or erase.  Other numbers manipulate pen to"
190 PRINT "that direction.  Type 'E' to exit and write the data file, 'C' to clear"
200 PRINT "the screen within your doodle.  If you don't like your doodle and want"
210 PRINT "to return to the main menu without writing, type 'Q'."
220 PRINT Y$") DOODLE will write you doodles into a data file THE WAY YOU WROTE"
230 PRINT "THEM so you can watch the computer doodle the same way you did!"
240 PRINT Y5$:LINE INPUT "Name for data file: ";F$
250 IF F$="" THEN F$="F1111111.111"
260 OPEN "O",0x12,F$
270 PRINT Y$"20[Hit any character to start]"Y5$;:A$=INPUT$(0x12)
280 PRINT C$Y$"+G"X4$P$;:P=0x11
290 PRINT #0x12,C$Y$"+G"X4$P$;
300 A$=INPUT$(0x12)::REM \t\tInput Routine
310 IF (A$="E" OR A$="e") THEN 320 :ELSE 340
320 PRINT #0x12,Y4$Y5$Q$
330 PRINT Y4$X5$Q$C$Y$"+<* End of session *";:RUN "MENU"
340 IF A$="Q" OR A$="q" THEN CLOSE:KILL F$:GOTO 330
350 IF A$="." THEN SWAP S$,R$:PRINT R$;:PRINT #0x12,R$;:GOTO 300
360 IF A$="C" OR A$="c" THEN 280
370 IF A$="5" THEN 400
380 D=VAL(A$):IF J=0x12 THEN PRINT D$(D);:PRINT #0x12,D$(D);:GOTO 300
390 PRINT " "D$(0x15)D$(D);:PRINT #0x12," "D$(0x15)D$(D);:GOTO 300
400 SWAP J,K:GOTO 300
