10 :REM  MENU.BAS  NAVPROGseven Air Navigation Menu                      06-Jan-82
20 :REM 
30 :REM  Developed by\tAlan Bose    (AOPA 642188)
40 :REM \t\t\tVice President, Taildragger Flyers
50 :REM \t\t\tRoss Field, Benton Harbor, MI
60 :REM \t\t\tUpdated 16-Mar-82 /JB/
70 CLEAR 1000:WIDTH 80:ON ERROR GOTO 540
80 DEF FN C$(C1,C2)=Y$+CHR$(C1+31)+CHR$(C2+31)
90 BL$=CHR$(7):E$=CHR$(27):ER$=E$+"E":L$=E$+"l":P$=E$+"p":Q$=E$+"q": \n   J1$=E$+"J":Y$=E$+"Y":PRINT ER$
100 :REM 
110 OPEN"I",1,"DISCID.DAT":LINE INPUT #1,ID$
120 CLOSE:IF ID$="172" THEN 150
130 PRINT ER$;"At tone place NAVPROGseven PROGRAM DISC on drive SY0:":PRINT: \n    RESET"SY0:":GOTO110
140 :REM 
150 OPEN"I",1,"SY1:DISCID.DAT":LINE INPUT#1,ID$
160 CLOSE:IF ID$="182" THEN 190
170 PRINT ER$;"Place NAVPROGseven DATA DISC on drive SY1:": \n    PRINT:RESET"SY1:":GOTO150
180 :REM 
190 PRINT E$+"x1";FN C$(25,1);ER$;FN C$(1,1);ER$
200 HD$="A I R   N A V I G A T I O N   M E N U"
210 PRINT FN C$(2,1);P$
220 PRINT TAB(40-LEN(HD$)/2);HD$;TAB(79);Q$
230 PRINT FN C$(6,20);"1  -  Directions & Guidance"
240 PRINT FN C$(8,20);"2  -  Input/revise Airport & Navaid Data"
250 PRINT FN C$(10,20);"3  -  Input/revise Aircraft Performance Data"
260 PRINT FN C$(12,20);"4  -  Automatic Route Preparation"
270 PRINT FN C$(14,20);"5  -  Air Navigation & Flight Planning"
280 PRINT FN C$(16,20);"6  -  Navigate Pre-planned Route"
290 PRINT FN C$(18,20);"7  -  Sort & list data on file"
300 PRINT FN C$(21,26);J1$;"Enter selection  <EXIT>  ";
310 X$=INPUT$(1):PRINT X$:X=VAL(X$)
320 IF X$=CHR$(13) THEN PRINT ER$;"...services terminated. Squawk 1200.": \n    PRINT"Frequency change approved. Have a good flight.":SYSTEM:END
330 IF X<1 OR X>7 THEN PRINT BL$:GOTO 300
340 :REM 
350 PRINT ER$;"Standby one..."
360 ON X GOTO 460,370,380,390,400,430,440
370 LOAD"AIRINPUT",R
380 LOAD"AIRCRAFT",R
390 LOAD"SY1:AUTONAV",R
400 OPEN"I",1,"SY1:FLIGHT.SEQ":CLOSE
410 LOAD"NAVPROG7",R
420 LOAD"AIRROUTE",R
430 LOAD"OLDROUTE",R
440 LOAD"SY1:AIRALPHA",R
450 :REM 
460 PRINT ER$;FNC$(25,11);"Press ";P$;"SCROLL";Q$;" for next line or ";P$; \n    "SHIFT/SCROLL";Q$;" for next page";E$+"H";ER$;E$+"["
470 OPEN"I",1,"SY1:NAVPROG.DOC"
480 LINE INPUT #1,A$
490 PRINT A$
500 GOTO 480
510 CLOSE:PRINT E$+"\";FNC$(25,25);L$;"Hit <RETURN> to continue...";
520 X$=INPUT$(1):GOTO10
530 END
540 :REM error trap
550 IF ERR=53 AND ERL=400 THEN RESUME 420
560 IF ERR=63 AND ERL=480 THEN RESUME 510
570 IF ERL=150 AND (ERR=53 OR ERR=65) THEN RESUME 170
580 IF ERL=110 AND ERR=53 THEN RESUME 130
590 ON ERROR GOTO 0
