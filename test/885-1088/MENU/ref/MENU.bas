10 :REM \t\tMENU.BAS\tVersion 05.02.81
20 WIDTH 255:E$=CHR$(27):C$=E$+"E":P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
30 PRINT E$"x5"C$;
40 FOR R=1 TO 6:READ P$(R):NEXT R
50 DATA "TANKS","SURROUND","BLAST","SCENECAR","DOODLE","PLANES"
60 PRINT C$P$Y$"$3"STRING$(40,32)Y$"33"STRING$(40,32)H$;
70 FOR P=37 TO 51:PRINT Y$CHR$(P)"3 "Y$CHR$(P)"Z ";:NEXT P
80 PRINT Q$Y$"&A* GAME MENU *"
90 PRINT Y$"(A1. TANKS"Y$")A2. SURROUND"Y$"*A3. BLAST"
100 PRINT Y$"+A4. SCENIC DRIVE"Y$",A5. DOODLE"Y$"-A6. PLANES"
110 PRINT Y$"1=Selection (1-6): <END> "E$"y5"E$"x4";
120 A$=INPUT$(1):IF A$=CHR$(13) OR A$="E" OR A$="e" THEN 150
130 A=VAL(A$):IF A<1 OR A>6 THEN 120
140 PRINT E$"x5"C$:RUN P$(A)
150 PRINT E$"y5"E$"y4"C$"You are in HDOS"
160 SYSTEM
