/*
Dump tokenized MBASIC-80 program
*/
package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
)

func twoNegPower32(exponent int) float32 {
	value := float32(2.0)
	f := float32(1.0)

	if exponent == 0 {
		return f
	}

	for exponent > 0 {
		f = value * f
		exponent -= 1
	}
	f = 1 / f

	return f
}

func twoNegPower64(exponent int) float64 {
	value := float64(2.0)
	f := float64(1.0)

	if exponent == 0 {
		return f
	}

	for exponent > 0 {
		f = value * f
		exponent -= 1
	}
	f = 1 / f

	return f
}

func dumpAscii(line_number int, data []byte, table map[int]string, table2 map[int]string, prefix byte) int {
	fmt.Printf("%d ", line_number)

	count := 0
	done := false

	for !done {
		b := data[count]
		b16 := int(b)

		handled := false

		// 0x0F - 1-byte integer as decimal
		if b == 0x0F {
			i := int(data[count+1])

			fmt.Printf("%d", i)

			count += 1
			handled = true
		}

		// 0x0E - 2-byte integer as decimal
		if b == 0x0E {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("%d", i)

			count += 2
			handled = true
		}

		// 0x0C - 2-byte integer as hexadecimal
		if b == 0x0C {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("&H%02X", i)

			count += 2
			handled = true
		}

		// 0x0B - 2-byte integer as octal
		if b == 0x0B {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("&O%03o", i)

			count += 2
			handled = true
		}

		// 0x1C - 2-byte integer as decimal
		// why duplicate 0x0E? Is something different?
		if b == 0x1C {
			i := int(data[count+2])*256 + int(data[count+1])

			fmt.Printf("%d", i)

			count += 2
			handled = true
		}

		// 0x1D - 4-byte float as decimal
		if b == 0x1D {
			bt1 := int(data[count+1])
			bt2 := int(data[count+2])
			bt3 := int(data[count+3])
			bt4 := int(data[count+4])

			f1a := float32(bt1) * twoNegPower32(23)
			f1b := float32(bt2) * twoNegPower32(15)
			f1c := float32(bt3) * twoNegPower32(7)
			f1 := f1a + f1b + f1c + float32(1.0)
			f2 := twoNegPower32(129 - bt4)
			f := f1 * f2

			fmt.Printf("%g", f)

			count += 4
			handled = true
		}

		// 0x1F - 8-byte float as decimal
		if b == 0x1F {
			bt1 := int(data[count+1])
			bt2 := int(data[count+2])
			bt3 := int(data[count+3])
			bt4 := int(data[count+4])
			bt5 := int(data[count+5])
			bt6 := int(data[count+6])
			bt7 := int(data[count+7])
			bt8 := int(data[count+8])

			f1a := float64(bt1) * twoNegPower64(55)
			f1b := float64(bt2) * twoNegPower64(47)
			f1c := float64(bt3) * twoNegPower64(39)
			f1d := float64(bt4) * twoNegPower64(31)
			f1e := float64(bt5) * twoNegPower64(23)
			f1f := float64(bt6) * twoNegPower64(15)
			f1g := float64(bt7) * twoNegPower64(7)
			f1 := f1a + f1b + f1c + f1d + f1e + f1f + f1g + 1.0
			f2 := twoNegPower64(129 - bt8)
			f := f1 * f2

			fmt.Printf("%g", f)

			count += 8
			handled = true
		}

		// 0xFF - 2-byte token
		if b == 0xFF {
			code := int(data[count+1])

			if s, ok := table2[code]; ok {
				fmt.Print(s)
			} else {
				fmt.Printf("[0xFF][%02X]", code)
			}

			count += 1
			handled = true
		}

		// 0x80 to 0xFE - 1-byte token
		if b16 >= 0x80 && b16 <= 0xFE {
			if s, ok := table[b16]; ok {
				fmt.Print(s)
			} else {
				fmt.Printf("[%02X]", b16)
			}

			handled = true
		}

		// 0x32 to 0x7F - plain character
		if b >= 0x20 && b <= 0x7F {
			fmt.Printf("%c", b16)

			handled = true
		}

		// byte of zero is end of line
		if b16 == 0 {
			done = true

			handled = true
		}

		// 0x01 to 0x31 - certain tokens or a 1-byte integer
		if b == 0x07 {
			// BEL
			fmt.Print("\\a")

			handled = true
		}

		if b == 0x08 {
			// BS
			fmt.Print("\\b")

			handled = true
		}

		if b == 0x09 {
			// TAB
			fmt.Print("\\t")

			handled = true
		}

		if b == 0x0A {
			// LF
			fmt.Print("\\n")

			handled = true
		}

		if b == 0x0D {
			// CR
			fmt.Print("\\r")

			handled = true
		}

		if !handled {
			if b16 >= 0x11 {
				// 1-byte numeric as decimal
				n := b16 - 0x11
				fmt.Printf("%d", n)
			} else {
				// 1-byte ASCII control character
				fmt.Printf("0x%02X", b16)
			}
		}

		count += 1
	}

	return count
}

func main() {
	include_bytes_ptr := flag.Bool("hex", false, "Include hex bytes")

	flag.Parse()
	args := flag.Args()

	if len(args) == 0 {
		fmt.Println("No file specified")
		os.Exit(1)
	}

	include_bytes := *include_bytes_ptr

	// get file name
	fileName := args[0]

	data, _ := ioutil.ReadFile(fileName)

	// build decode tables
	table := map[int]string{}

	table[0x81] = "END"
	table[0x82] = "FOR"
	table[0x83] = "NEXT"
	table[0x84] = "DATA"
	table[0x85] = "INPUT"
	table[0x86] = "DIM"
	table[0x87] = "READ"
	table[0x88] = "LET"
	table[0x89] = "GOTO"
	table[0x8A] = "RUN"
	table[0x8B] = "IF"
	table[0x8C] = "RESTORE"
	table[0x8D] = "GOSUB"
	table[0x8E] = "RETURN"
	table[0x8F] = "REM"
	table[0x90] = "STOP"
	table[0x91] = "PRINT"
	table[0x92] = "CLEAR"
	table[0x93] = "LIST"
	table[0x94] = "NEW"
	table[0x95] = "ON"
	table[0x96] = "NULL"
	table[0x97] = "WAIT"
	table[0x98] = "DEF"
	table[0x99] = "POKE"
	table[0x9A] = "CONT"
	table[0x9B] = "LPRINT"
	table[0x9D] = "OUT"
	table[0x9F] = "LLIST"
	table[0xA0] = "NOTRACE"
	table[0xA1] = "WIDTH"
	table[0xA2] = "ELSE"
	table[0xA3] = "TRON"
	table[0xA4] = "TROFF"
	table[0xA5] = "SWAP"
	table[0xA6] = "ERASE"
	table[0xA7] = "EDIT"
	table[0xA8] = "ERROR"
	table[0xA9] = "RESUME"
	table[0xAA] = "DELETE"
	table[0xAB] = "AUTO"
	table[0xAC] = "RENUM"
	table[0xAD] = "DEFSTR"
	table[0xAE] = "DEFINT"
	table[0xAF] = "DEFSNG"
	table[0xB0] = "DEFDBL"
	table[0xB1] = "LINE"
	table[0xB2] = "WRITE"
	table[0xB3] = "COMMON"
	table[0xB4] = "WHILE"
	table[0xB5] = "WEND"
	table[0xB6] = "CALL"
	table[0xB7] = "WRITE"
	table[0xB8] = "COMMON"
	table[0xB9] = "CHAIN"
	table[0xBA] = "OPTION"
	table[0xBB] = "RANDOMIZE"
	table[0xBC] = "CLOSE"
	table[0xBD] = "SYSTEM"
	table[0xBE] = "MERGE"
	table[0xBF] = "OPEN"
	table[0xC0] = "OPTION"
	table[0xC1] = "GET"
	table[0xC2] = "PUT"
	table[0xC3] = "CLOSE"
	table[0xC4] = "LOAD"
	table[0xC5] = "MERGE"
	table[0xC6] = "FILES"
	table[0xC7] = "NAME"
	table[0xC8] = "KILL"
	table[0xC9] = "LSET"
	table[0xCA] = "RSET"
	table[0xCB] = "SAVE"
	table[0xCC] = "RESET"
	table[0xCE] = "TO"
	table[0xCF] = "THEN"
	table[0xD0] = "TAB("
	table[0xD1] = "STEP"
	table[0xD2] = "USR"
	table[0xD3] = "FN"
	table[0xD4] = "SPC("
	table[0xD5] = "NOT"
	table[0xD6] = "ERL"
	table[0xD7] = "ERR"
	table[0xD8] = "STRING$"
	table[0xD9] = "USING"
	table[0xDA] = "INSTR"
	table[0xDB] = " "
	table[0xDC] = "VARPTR"
	table[0xDD] = "INKEY$"
	table[0xE0] = "STEP"
	table[0xE1] = "USR"
	table[0xE2] = "FN"
	table[0xE3] = "SPC("
	table[0xE4] = "NOT"
	table[0xE5] = "ERL"
	table[0xE6] = "RENUM"
	table[0xE7] = "STRING$"
	table[0xE8] = "USING"
	table[0xE9] = "INSTR"
	table[0xEB] = "VARPTR"
	table[0xEE] = "INKEY$"
	table[0xEF] = ">"
	table[0xF0] = "="
	table[0xF1] = "<"
	table[0xF2] = "+"
	table[0xF3] = "-"
	table[0xF4] = "*"
	table[0xF5] = "/"
	table[0xF6] = "^"
	table[0xF7] = "AND"
	table[0xF8] = "OR"
	table[0xF9] = "XOR"
	table[0xFA] = "EQV"
	table[0xFB] = "IMP"
	table[0xFD] = "MOD"
	table[0xFF] = ""

	table2 := map[int]string{}

	table2[0x81] = "LEFT$"
	table2[0x82] = "RIGHT$"
	table2[0x83] = "MID$"
	table2[0x84] = "SGN"
	table2[0x85] = "INT"
	table2[0x86] = "ABS"
	table2[0x87] = "SQR"
	table2[0x88] = "RND"
	table2[0x89] = "SIN"
	table2[0x8A] = "LOG"
	table2[0x8B] = "EXP"
	table2[0x8C] = "COS"
	table2[0x8D] = "TAN"
	table2[0x8E] = "ATN"
	table2[0x8F] = "FRE"
	table2[0x90] = "INP"
	table2[0x91] = "POS"
	table2[0x92] = "LEN"
	table2[0x93] = "STR$"
	table2[0x94] = "VAL"
	table2[0x95] = "ASC"
	table2[0x96] = "CHR$"
	table2[0x97] = "PEEK"
	table2[0x98] = "SPACE$"
	table2[0x99] = "OCT$"
	table2[0x9A] = "HEX$"
	table2[0x9B] = "LPOS"
	table2[0x9C] = "CINT"
	table2[0x9D] = "CSNG"
	table2[0x9E] = "CDBL"
	table2[0x9F] = "FIX"
	table2[0xAB] = "CVI"
	table2[0xAC] = "CVS"
	table2[0xAD] = "CVD"
	table2[0xAE] = "EOF"
	table2[0xB0] = "LOC"
	table2[0xB1] = "LOF"
	table2[0xB2] = "MKI$"
	table2[0xB3] = "MKS$"
	table2[0xB4] = "MKD$"

	contents := data[1:]

	// for all bytes
	done := false

	for !done {
		// 2 bytes for line number
		line_number := int(contents[3])*256 + int(contents[2])

		if line_number == 0 {
			done = true
		} else {
			payload := contents[4:]

			// print the untokenized line
			count := dumpAscii(line_number, payload, table, table2, 0xff)
			fmt.Println()

			if include_bytes {
				// dump bytes (including NULL) as hex and ascii
				line_count := count + 4
				line := contents[:line_count]
				fmt.Printf("% 02X", line)
				fmt.Println()

				fmt.Println()
			}

			contents = payload[count:]

			if len(contents) < 5 {
				done = true
			}
		}
	}
}
