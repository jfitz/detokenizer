echo
TESTROOT=$1
TESTBED=$2
TESTGROUP=$3
TESTNAME=$4
OPTIONS=$5
echo Start test $TESTNAME

# create testbed
echo Creating testbed...
mkdir "$TESTBED/$TESTNAME"
cp "$TESTROOT/$TESTGROUP/$TESTNAME/data"/* "$TESTBED/$TESTNAME"
echo testbed ready

# execute program
ECODE=0

echo Detokenizing to ASCII...
go run detokenizer.go "$TESTBED/$TESTNAME/$TESTNAME.BAS" >"$TESTBED/$TESTNAME/$TESTNAME.bas" 2>&1
echo run finished

# compare results
echo Comparing bas...
diff "$TESTBED/$TESTNAME/$TESTNAME.bas" "$TESTROOT/$TESTGROUP/$TESTNAME/ref/$TESTNAME.bas"
((ECODE+=$?))

if [ $ECODE -ne 0 ]
then
    cp "$TESTBED/$TESTNAME/$TESTNAME.bas" "$TESTROOT/$TESTGROUP/$TESTNAME/ref/$TESTNAME.bas"
fi

echo Detokenizing to HEX...
go run detokenizer.go -hex "$TESTBED/$TESTNAME/$TESTNAME.BAS" >"$TESTBED/$TESTNAME/$TESTNAME.hex" 2>&1
echo run finished

# compare results
echo Comparing hex...
diff "$TESTBED/$TESTNAME/$TESTNAME.hex" "$TESTROOT/$TESTGROUP/$TESTNAME/ref/$TESTNAME.hex"
((ECODE+=$?))

if [ $ECODE -ne 0 ]
then
    cp "$TESTBED/$TESTNAME/$TESTNAME.hex" "$TESTROOT/$TESTGROUP/$TESTNAME/ref/$TESTNAME.hex"
fi

echo compare done

echo End test $TESTNAME
exit $ECODE
